import scenes.Benchmarkable;

import scenes.BunnyScene;
import scenes.StarlingImagesScene;
import scenes.DisplayListUIScene;
import scenes.StarlingUIScene;
import scenes.FilterScene;

class Scenes {
	public var _scenes:Array<Array<Dynamic>> = [
		["Bunny", BunnyScene],
		["Filter", FilterScene],
		["DisplayList UI", DisplayListUIScene],
		["Starling UI", StarlingUIScene],
		["Starling Images", StarlingImagesScene]
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
		for(scene in _scenes) {
			var sceneClass:Class<Dynamic> = scene[1];
			classNames.push(Type.getClassName(sceneClass));
		}
		return classNames;
	}


}