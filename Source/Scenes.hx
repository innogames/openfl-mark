import scenes.Benchmarkable;

import scenes.BunnyScene;
import scenes.StarlingImagesScene;
import scenes.DisplayListUIScene;
import scenes.StarlingUIScene;
import scenes.FilterScene;

class Scenes {
	public var _scenesToCreate:Array<Array<Dynamic>> = [
		["Bunny", BunnyScene],
		["Filter", FilterScene],
		["DisplayList UI", DisplayListUIScene],
		["Starling UI", StarlingUIScene],
		["Starling Images", StarlingImagesScene],
	];
	public var _scenesClassNames = ["scenes.BunnyScene", "scenes.FilterScene", "scenes.DisplayListUIScene", "scenes.StarlingUIScene", "scenes.StarlingImagesScene"];


	public function new() {

	}

	public function getName(scene: Benchmarkable):String {
		return Type.getClassName(Type.getClass(scene));
	}


}