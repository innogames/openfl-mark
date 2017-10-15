package;

import openfl.display.Sprite;

import utils.Button;
import utils.Text;
import openfl.events.MouseEvent;


class ResultsScreen extends Sprite {
	public function new(main:Main, results:Array<Result>) {
		super();

		var titleResults = new Text(100, 20, "Results");
		titleResults.x = 50;
		titleResults.y = 15;
		addChild(titleResults);

		var headerFPS = new Text(100, 20, "FPS");
		headerFPS.x = 250;
		headerFPS.y = 40;
		addChild(headerFPS);

		var headerObjectCount = new Text(100, 20, "Object count");
		headerObjectCount.x = 350;
		headerObjectCount.y = 40;
		addChild(headerObjectCount);

		var headerScore = new Text(100, 20, "Score");
		headerScore.x = 450;
		headerScore.y = 40;
		addChild(headerScore);

		for (i in 0...results.length) {
			var result = results[i];

			var row = new Sprite();
			row.y = 60+i*20;

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


		var copyButton = new Button(200, 22, "Copy to Clipboard");
		copyButton.x = 50;
		copyButton.y = 500;
		copyButton.addEventListener(MouseEvent.CLICK, function(e) {
			this.onCopy(results);
		});
		addChild(copyButton);

		var closeButton = new Button(100, 22, "Close");
		closeButton.x = 650;
		closeButton.y = 500;
		closeButton.addEventListener(MouseEvent.CLICK, main.onResultsClose);
		addChild(closeButton);
	}
	
	private function init(main:Main) {

	}

	private function onCopy(results:Array<Result>) {
		var text = "";
		for (result in results) {
			text += '${result.name}\t${result.fps}\t${result.objectCount}\t${result.calcScore()}';
		}
		openfl.system.System.setClipboard(text);
	}
}