package scenes;

import openfl.display.Stage;
import openfl.display.Sprite;

import openfl.display.Shape;
import openfl.text.TextField;

import openfl.events.Event;

import openfl.filters.GlowFilter;
import openfl.filters.ColorMatrixFilter;


/**
	Try out different filters
**/
class FilterScene extends Sprite implements Benchmarkable {
	
	private var bigSprites:Array<Sprite>;

	static inline var OBJECTS_PER_BIG_SPRITE = 1+10*(2);
	
	public function new (stage: Stage) {
		
		super ();

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
		var bigSprite = new Sprite();
		
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
		var colorFilter = new ColorMatrixFilter([0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0, 0, 0, 1, 0]);
		var innerFilter = new GlowFilter(0xFFFFFF, 0.3, 12, 12, 2, 1, true);
		var outerFilter = new GlowFilter(0xFFFF00, 0.7, 8, 8);
		mediumSprite.filters = [ colorFilter, innerFilter, outerFilter ];

		var shape = new Shape();
		shape.graphics.beginFill(0xC00000);
		shape.graphics.drawRect(0, 0, 40, 40);
		shape.graphics.endFill();
		mediumSprite.addChild(shape);

		return mediumSprite;
	}
}