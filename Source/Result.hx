package;

class Result {
	public var name:String;
	public var fps:Float;
	public var objectCount:Int;

	public function new(name:String) {
		this.name = name;
	}

	public function calcScore():Int {
		return cast(objectCount * fps / 1000, Int);
	}
}