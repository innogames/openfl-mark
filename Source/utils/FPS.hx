package utils;


import haxe.Timer;
import openfl.events.Event;


class FPS extends Text {
	
	
	public var currentFPS (default, null):Int;
	
	private var cacheCount:Int;
	private var times:Array <Float>;
	
	
	public function new (width:Int, height:Int) {
		
		super (width, height, "");
		
		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		text = "FPS: ";
		
		cacheCount = 0;
		times = [];
		
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
		
	}
	
	
	
	
	// Event Handlers
	@:noCompletion private function onEnterFrame (event:Event) {
		
		var currentTime = Timer.stamp ();
		times.push (currentTime);
		
		while (times[0] < currentTime - 1) {
			
			times.shift ();
			
		}
		
		var currentCount = times.length;
		currentFPS = Math.round ((currentCount + cacheCount) / 2);
		
		if (currentCount != cacheCount /*&& visible*/) {
			
			text = "FPS: " + currentFPS;
			
		}
		
		cacheCount = currentCount;
		
	}
	
	
}
