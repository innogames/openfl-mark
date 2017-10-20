package scenes;

import openfl.display.Stage;
import openfl.display.Sprite;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.events.Event;
import openfl.Assets;


class Bunny extends Tile {
	
	
	public var speedX:Float;
	public var speedY:Float;
	
	
	public function new () {
		
		super (0);
		
	}
	
	
}

/**
	Whabbits rendered via Tilemap
**/
class BunnyScene extends Sprite implements Benchmarkable {
	
	
	private var bunnies:Array<Bunny>;
	private var gravity:Float;
	private var minX:Int;
	private var minY:Int;
	private var maxX:Int;
	private var maxY:Int;
	private var tilemap:Tilemap;
	private var tileset:Tileset;
	
	
	public function new (stage: Stage) {
		
		super ();
		
		bunnies = new Array ();
		
		minX = 0;
		maxX = Constants.BenchmarkWidth;
		minY = 0;
		maxY = Constants.SceneHeight;
		gravity = 0.5;
		
		var bitmapData = Assets.getBitmapData ("assets/wabbit_alpha.png");
		tileset = new Tileset (bitmapData);
		tileset.addRect (bitmapData.rect);
		
		tilemap = new Tilemap (stage.stageWidth, stage.stageHeight, tileset);
		addChild (tilemap);
		
		stage.addEventListener (Event.ENTER_FRAME, onEnterFrame);
		
		addTestObjects(10000);
		
	}

	public function addTestObjects(count:Int) {
		for (i in 0...count) {
			
			addBunny ();
			
		}
	}

	public function getTestObjectCount():Int {
		return bunnies.length;
	}
	
	
	private function addBunny () {
		
		var bunny = new Bunny ();
		bunny.x = 0;
		bunny.y = 0;
		bunny.speedX = Math.random () * 5;
		bunny.speedY = (Math.random () * 5) - 2.5;
		bunnies.push (bunny);
		tilemap.addTile (bunny);
		
	}
	
	// Event Handlers
	private function onEnterFrame (event:Event) {
		
		for (bunny in bunnies) {
			
			bunny.x += bunny.speedX;
			bunny.y += bunny.speedY;
			bunny.speedY += gravity;
			
			if (bunny.x > maxX) {
				
				bunny.speedX *= -1;
				bunny.x = maxX;
				
			} else if (bunny.x < minX) {
				
				bunny.speedX *= -1;
				bunny.x = minX;
				
			}
			
			if (bunny.y > maxY) {
				
				bunny.speedY *= -0.8;
				bunny.y = maxY;
				
				if (Math.random () > 0.5) {
					
					bunny.speedY -= 3 + Math.random () * 4;
					
				}
				
			} else if (bunny.y < minY) {
				
				bunny.speedY = 0;
				bunny.y = minY;
				
			}
			
		}
		
	}
	
}