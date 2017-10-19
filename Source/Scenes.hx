import scenes.Benchmarkable;

import scenes.BunnyScene;
import scenes.StarlingImagesScene;
import scenes.DisplayListUIScene;
import scenes.StarlingUIScene;
import scenes.FilterScene;

class Scenes {
	public var _scenes:Map<String, Array<Dynamic>> = [
		"scenes.BunnyScene" => ["Bunny", BunnyScene],
		"scenes.FilterScene" => ["Filter", FilterScene],
		"scenes.DisplayListUIScene" => ["DisplayList UI", DisplayListUIScene],
		"scenes.StarlingUIScene" => ["Starling UI", StarlingUIScene],
		"scenes.StarlingImagesScene" => ["Starling Images", StarlingImagesScene]
	];

	public function new() {

	}

	//public function

	public function getName(scene: Benchmarkable):String {
		var className = Type.getClassName(Type.getClass(scene));
		return  className.split(".")[1];
	}

	public function getAllClassNames():Array<String> {
		var classNames:Array<String> = [];
		for(key in _scenes.keys()) {
			classNames.push(key);
		}
		return classNames;
	}


}