package;

import openfl.display.Sprite;

import starling.display.Sprite in StarlingSprite;
import openfl.display.Sprite in OpenFLSprite;
import openfl.display3D.Context3DRenderMode;
import openfl.system.Capabilities;

import openfl.events.Event;

import openfl.geom.Rectangle;

import haxe.Timer;

import scenes.Benchmarkable;
import starling.core.Starling;
import starling.utils.RectangleUtil;
import openfl.errors.Error;


enum BenchmarkState {
	Tuning;
	Benchmarking;
}

/**
	Runs one benchmark
**/
class Benchmark extends Sprite {
	private var _currentScene:Benchmarkable;
	private var _controller:Controller;
	private var _starling:Starling;
	private var _main:Main;
	private var _timer:Timer;
	private var _state:BenchmarkState;
	private var _stateStart:Float;

	
	public function new(main:Main) {
		super();

		this._main = main;

		_controller = new Controller(this);
		addChild(_controller);
	}

	public function onStop(event:Event) {
		closeScene();

		_main.onBenchmarkStop();
	}

	public function closeScene() {
		if (Std.is(_currentScene, StarlingSprite)) {
			var scene = cast(_currentScene, StarlingSprite);
			scene.removeFromParent(true);

			_starling.dispose();
		}
		else if (Std.is(_currentScene, OpenFLSprite)) {
			var scene = cast(_currentScene, OpenFLSprite);
			removeChild(scene);
		}

		_currentScene = null;
		_timer.stop();
	}
	
	public function showScene(name:String) {
		var sceneClass:Class<Dynamic> = Type.resolveClass(name);
		var scene = Type.createInstance(sceneClass, [stage]);
		if (Std.is(scene, StarlingSprite)) {


			_starling = new Starling(sceneClass, _main.stage, null, null, Context3DRenderMode.AUTO, "auto");
			_starling.stage.stageWidth = Constants.GameWidth;
			_starling.stage.stageHeight = Constants.GameHeight;
			_starling.enableErrorChecking = Capabilities.isDebugger;
			//_starling.skipUnchangedFrames = true;
			//_starling.simulateMultitouch = true;
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, function() {
				cast(_starling.root, scenes.BenchmarkableStarling).start();
				startScene(cast(_starling.root, Benchmarkable));
			});
			
			//main.stage.addEventListener(Event.RESIZE, onResize, false, Max.INT_MAX_VALUE, true);

			_starling.start();
		}
		else {
			var openfl = cast(scene, OpenFLSprite);
			openfl.y = 30;
			addChild(openfl);

			startScene(cast(scene, Benchmarkable));
		}
	}

	private function startScene(scene: Benchmarkable) {
		_currentScene = cast(scene, Benchmarkable);

		_controller.setTestObjectCount(_currentScene.getTestObjectCount());
		_controller.setStatus("tuning object count");
		_controller.setScene(Type.getClassName(Type.getClass(_currentScene)));

		_timer = new Timer(100);
		_timer.run = function() { onTimer(); }

		_state = Tuning;
		_stateStart = Timer.stamp();
	}

	private function onTimer() {
		var stateTime = Timer.stamp()-_stateStart;
		if (_state == Tuning) {
			if (stateTime >= 3) {
				onTuningComplete();
				_state == Benchmarking;
				_stateStart = Timer.stamp();
			}
		}
		else if (_state == Benchmarking) {
			if (stateTime >= 5) {
				onBenchmarkComplete();
			}
			_controller.setStatus("benchmarking: " + Math.ceil(5-stateTime));
		}
	}

	private function onTuningComplete() {
		var fps = _controller.getFPS();
		if (fps > 25) {
			// Double test objects to reduce fps
			_currentScene.addTestObjects(_currentScene.getTestObjectCount());
			
			_controller.setTestObjectCount(_currentScene.getTestObjectCount());
		}
		else {
			_controller.setStatus("benchmarking");
			_state = Benchmarking;
			_stateStart = Timer.stamp();
		}
	}



	private function onBenchmarkComplete() {
		var className = Type.getClassName(Type.getClass(_currentScene));
		var r = new Result(className);
		r.fps = _controller.getFPS();
		r.objectCount = _currentScene.getTestObjectCount();

		closeScene();

		_main.onBenchmarkComplete(r);
	}

	private function onResize(e:openfl.events.Event) {
		var viewPort:Rectangle = RectangleUtil.fit(new Rectangle(0, 0, Constants.GameWidth, Constants.GameHeight), new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
		try {
			this._starling.viewPort = viewPort;
		}
		catch (error:Error) {}
	}

}