package scenes;

import openfl.display.Stage;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;
import openfl.ui.Keyboard;
import openfl.system.Capabilities;
import openfl.Assets;

import starling.textures.Texture;


@:keep class StarlingImagesScene extends Sprite implements BenchmarkableStarling {
	private static inline var FRAME_TIME_WINDOW_SIZE:Int = 10;

	private var _container:Sprite;
	private var _objectPool:Array<DisplayObject>;
	private var _objectTexture:Texture;


	public function new(stage: Stage) {
		super();

		// the container will hold all test objects
		_container = new Sprite();
		_container.x = Constants.CenterX;
		_container.y = Constants.CenterY;
		_container.touchable = false; // we do not need touch events on the test objects --
									  // thus, it is more efficient to disable them.
		addChildAt(_container, 0);

		_objectPool = [];

		addEventListener(Event.ENTER_FRAME, onEnterFrame);
        addEventListener(KeyboardEvent.KEY_DOWN, onKey);
	}

	public function start() {
		var assets = loadAssets();
		_objectTexture = assets.getTexture("benchmark_object");

		addTestObjects(10000);
	}

	public function addTestObjects(count:Int) {
		for (i in 0...count) {
			var scale:Float = Math.random();

			var egg:DisplayObject = getObjectFromPool();
			var distance:Float = (100 + Math.random() * 100) * scale;
			var angle:Float = Math.random() * Math.PI * 2.0;

			egg.x = Math.cos(angle) * distance;
			egg.y = Math.sin(angle) * distance;
			egg.rotation = angle + Math.PI / 2.0;
			egg.scale = scale;

			_container.addChild(egg);
		}
	}

	public function getTestObjectCount():Int {
		return _container.numChildren;
	}

	public override function dispose() {
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);

		for (object in _objectPool)
			object.dispose();

		super.dispose();
	}


	private function onEnterFrame(event:EnterFrameEvent, passedTime:Float) {
		_container.rotation += event.passedTime * 0.5;
	}
	
	private function removeTestObjects(count:Int) {
		var numChildren:Int = _container.numChildren;

		if (count >= numChildren)
			count  = numChildren;

		for (i in 0...count)
			putObjectToPool(_container.removeChildAt(_container.numChildren-1));
	}

	private function getObjectFromPool():DisplayObject {
		// we pool mainly to avoid any garbage collection while the benchmark is running

		if (_objectPool.length == 0) {
			var image:Image = new Image(_objectTexture);
			image.alignPivot();
			//TODOimage.pixelSnapping = false; // slightly faster (and doesn't work here, anyway)
			return image;
		}
		else
			return _objectPool.pop();
	}

	private function putObjectToPool(object:DisplayObject) {
		_objectPool[_objectPool.length] = object;
	}


    private function loadAssets():AssetManager {
        var assets:AssetManager = new AssetManager();

        assets.verbose = Capabilities.isDebugger;

        var atlasTexture:Texture = Texture.fromBitmapData(Assets.getBitmapData("assets/textures/1x/atlas.png"), false);
        var atlasXml:Xml = Xml.parse(Assets.getText("assets/textures/1x/atlas.xml")).firstElement();
        assets.addTexture("atlas", atlasTexture);
        assets.addTextureAtlas("atlas", new TextureAtlas(atlasTexture, atlasXml));

        return assets;
    }

    private function onKey(event:KeyboardEvent) {
        if (event.keyCode == Keyboard.SPACE)
            Starling.current.showStats = !Starling.current.showStats;
        else if (event.keyCode == Keyboard.X)
            Starling.current.context.dispose();
    }
}