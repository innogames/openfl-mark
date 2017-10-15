package scenes;

import openfl.display.Stage;

import starling.display.Sprite;
import starling.display.Quad;
import starling.text.TextField;


import openfl.events.Event;
import openfl.Assets;


class BigStarlingSprite extends Sprite {
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
	Same as DisplayListUIScene, but with Starling

	First results show that TextRendering is relatively slow compared to pure Quads
**/
class StarlingUIScene extends Sprite implements BenchmarkableStarling {
	
	private var bigSprites:Array<Sprite>;

	static inline var OBJECTS_PER_BIG_SPRITE = 31;
	
	public function new (stage: Stage) {
		
		super ();
		
	}

	public function start() {
		addTestObjects(1000);
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
		var bigSprite = new BigStarlingSprite();
		//bigSprite.width = 120;
		//bigSprite.height = 60;
		
		for (i in 0...count) {
			var smallSprite = createSmallSprite(10);
			smallSprite.x = Std.random(100);
			smallSprite.y = Std.random(50);
			bigSprite.addChild(smallSprite);
		}

		return bigSprite;
	}

	private function createSmallSprite(count:Int):Sprite {
		var smallSprite = new Sprite();
		//smallSprite.width = 50;
		//smallSprite.height = 30;

		var shape = new Quad(40, 40, 0x800000);
		smallSprite.addChild(shape);

        var text = new TextField(50, 10, "Hello");
		smallSprite.addChild(text);

		return smallSprite;
	}



}