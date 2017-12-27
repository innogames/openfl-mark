package scenes;

import openfl.display.Stage;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.text.TextField;

import openfl.events.Event;
import openfl.Assets;



class BigSprite extends Sprite {
	public function new() {
		super();

		addEventListener (Event.ENTER_FRAME, onEnterFrame);
	}

	public function onEnterFrame(e:Event) {
		// Shake 2nd child
		getChildAt(1).x += (Math.random()-0.5)*4;
		getChildAt(1).y += (Math.random()-0.5)*4;
	}
}

/**
	Display a scene consisting of different UI Elements where some of them are animated
**/
class DisplayListUIScene extends Sprite implements Benchmarkable {
	
	private var bigSprites:Array<Sprite>;
	private var _wabbitData:BitmapData;

	static inline var WABBITS = 5;
	static inline var OBJECTS_PER_BIG_SPRITE = 1+10*(4+WABBITS);
	
	public function new (stage: Stage) {
		
		super ();

		_wabbitData = Assets.getBitmapData ("assets/wabbit_alpha.png");
		
		addTestObjects(1000);

	}

	public function disposeScene(stage:Stage):Void {
	}

	public function addTestObjects(count:Int) {
		count = Math.round(count / OBJECTS_PER_BIG_SPRITE);

		for (i in 0...count) {
			var bigSprite = createBigSprite(10);
			bigSprite.x = Std.random(750);
			bigSprite.y = Std.random(550);
			addChild(bigSprite);
		}
	}

	public function getTestObjectCount():Int {
		return numChildren * OBJECTS_PER_BIG_SPRITE;
	}

	private function createBigSprite(count:Int):Sprite {
		var bigSprite = new BigSprite();
		//bigSprite.width = 120;
		//bigSprite.height = 60;
		
		for (i in 0...count) {
			var mediumSprite = createMediumSprite();
			mediumSprite.x = Std.random(100);
			mediumSprite.y = Std.random(50);
			bigSprite.addChild(mediumSprite);
		}

		return bigSprite;
	}

	private function createMediumSprite():Sprite {
		var mediumSprite = new Sprite();
		//mediumSprite.width = 50;
		//mediumSprite.height = 30;

		var shape = new Shape();
		shape.graphics.beginFill(0x800000);
		shape.graphics.drawRect(0, 0, 40, 40);
		shape.graphics.endFill();
		mediumSprite.addChild(shape);

		var text = new utils.Text(50, 10, "Hello");
		mediumSprite.addChild(text);

		var smallSprite = createSmallSprite();
		smallSprite.y = 20;
		mediumSprite.addChild(smallSprite);

		mediumSprite.cacheAsBitmap = true;

		return mediumSprite;
	}

	private function createSmallSprite():Sprite {
		var smallSprite = new Sprite();
		//smallSprite.width = 50;
		//smallSprite.height = 30;

		for(i in 0...WABBITS) {
			var bitmap = new Bitmap(_wabbitData);
			bitmap.x = i*7;
			smallSprite.addChild(bitmap);
		}

		return smallSprite;
	}



}