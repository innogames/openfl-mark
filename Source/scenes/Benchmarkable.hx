package scenes;

import openfl.display.Stage;

interface Benchmarkable {
	public function addTestObjects(count:Int):Void;

	public function getTestObjectCount():Int;

	public function disposeScene(stage:Stage):Void;
}