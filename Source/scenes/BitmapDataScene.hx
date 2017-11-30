package scenes;

import openfl.display.Stage;
import openfl.display.Sprite;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.events.Event;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;


/**
	Operating on bitmap data
**/
class BitmapDataScene extends Sprite implements Benchmarkable {
	
	private var bitmaps:Array<Bitmap>;

	private var openflData:BitmapData;
	
	public function new (stage: Stage) {
		
		super ();
		
		bitmaps = new Array ();
		
		openflData = Assets.getBitmapData ("assets/wabbit_alpha.png");

		stage.addEventListener (Event.ENTER_FRAME, onEnterFrame);
		
		addTestObjects(1000);
		
	}

	public function disposeScene(stage:Stage):Void {
		stage.removeEventListener (Event.ENTER_FRAME, onEnterFrame);
	}

	public function addTestObjects(count:Int) {
		for (i in 0...count) {
			
			addBitmap ();
			
		}
	}

	public function getTestObjectCount():Int {
		return bitmaps.length;
	}
	
	
	private function addBitmap () {
		var bitmapData = new BitmapData(40, 40, true, 0xFF0000FF);
		
		var bitmap = new Bitmap (bitmapData);
		var perRow = 40;
		bitmap.x = Math.random() * Constants.BenchmarkWidth;
		bitmap.y = Math.random() * Constants.SceneHeight;
		
		bitmaps.push(bitmap);
		addChild(bitmap);
	}
	
	// Event Handlers
	private function onEnterFrame (event:Event) {
		
		for (bitmap in bitmaps) {
			
			bitmap.bitmapData.fillRect(new Rectangle(4, 4, 52, 52), 0x80FF0080);

			for (i in 0...10) {
				bitmap.bitmapData.copyPixels(openflData, openflData.rect, new openfl.geom.Point(10, 10), null, null, true);
			}
		}
		
	}
	
}