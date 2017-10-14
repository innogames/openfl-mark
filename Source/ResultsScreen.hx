package;

import openfl.display.Sprite;

import utils.Button;
import utils.Text;
import openfl.events.MouseEvent;


class ResultsScreen extends Sprite {
	public function new(main:Main, result:Result) {
		super();

		var closeButton = new Button(100, 22, "Close");
		closeButton.x = 50;
		closeButton.y = 300;
		closeButton.addEventListener(MouseEvent.CLICK, main.onResultsClose);
		addChild(closeButton);

		var headerFPS = new Text(100, 20, "FPS");
		headerFPS.x = 250;
		headerFPS.y = 20;
		addChild(headerFPS);

		var headerObjectCount = new Text(100, 20, "Object count");
		headerObjectCount.x = 350;
		headerObjectCount.y = 20;
		addChild(headerObjectCount);

		var headerScore = new Text(100, 20, "Score");
		headerScore.x = 450;
		headerScore.y = 20;
		addChild(headerScore);

		for (i in 0...1) {
			var row = new Sprite();
			row.y = 40+i*20;

			var name = new Text(200, 20, Std.string(result.name));
			name.x = 50;
			row.addChild(name);

			var fps = new Text(100, 20, Std.string(result.fps));
			fps.x = 250;
			row.addChild(fps);

			var objectCount = new Text(100, 20, Std.string(result.objectCount));
			objectCount.x = 350;
			row.addChild(objectCount);

			var score = new Text(100, 20, Std.string(result.calcScore()));
			score.x = 450;
			row.addChild(score);

			addChild(row);
		}


		
		// show information about rendering method (hardware/software)
		
		/*var driverInfo:String = "TODO";//Starling.current.context.driverInfo;
		var infoText:TextField = new Text(400, 64, driverInfo);
		infoText.x = 5;
		infoText.y = 475 - infoText.height;
		//infoText.addEventListener(TouchEvent.TOUCH, onInfoTextTouched);
		addChildAt(infoText, 0);*/
	}
	
	private function init(main:Main) {

	}
}