package;

/**
	This class represents one benchmark result
**/
class Result {
	public var name:String;
	public var fps:Float;
	public var objectCount:Int;

	public function new(name:String) {
		this.name = name;
	}

	public function calcScore():Int {
		return Math.round(objectCount * fps / 1000);
	}
}