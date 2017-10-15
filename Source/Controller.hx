package;

import openfl.display.Sprite;
import openfl.events.MouseEvent;

import utils.Button;
import utils.Text;
import utils.FPS;

/**
	The Controller is displayed above the benchmark area
**/
class Controller extends Sprite {
	private var _backButton:Button;
	private var _fps:FPS;
	private var _testObjectCount:Text;
	private var _status:Text;
	
	public function new(benchmark:Benchmark) {
		super();

		_fps = new FPS(100, 20);
		_fps.x = 10;
		_fps.y = 4;
		addChild(_fps);
		
		_testObjectCount = new Text(100, 20, "Objects: ");
		_testObjectCount.x = 100;
		_testObjectCount.y = 4;
		addChild(_testObjectCount);

		_status = new Text(200, 20, "tuning");
		_status.x = 300;
		_status.y = 4;
		addChild(_status);
		
		_backButton = new Button(100, 22, "Stop");
		_backButton.x = 500;
		_backButton.y = 4;
		_backButton.name = "backButton";
		_backButton.addEventListener(MouseEvent.CLICK, benchmark.onStop);
		addChild(_backButton);
	}

	public function getFPS():Float {
		return _fps.currentFPS;
	}

	public function setTestObjectCount(count:Int) {
		_testObjectCount.text = "Objects: "+count;
	}

	public function setStatus(status:String) {
		_status.text = status;
	}
}