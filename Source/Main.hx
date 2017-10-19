package;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.system.System;
import openfl.display.StageScaleMode;

import utils.Button;


import openfl.events.Event;


class Main extends Sprite {
	private var _scenes:Scenes = new Scenes();

	private var _menuScreen:MenuScreen;
	private var _benchmark:Benchmark;
	private var _background:Bitmap;
	private var _resultsScreen:ResultsScreen;

	private var _runList:Array<String>;
	private var _results:Array<Result>;

	public function new() {
		super();
		if (stage != null) start();
		else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Dynamic) {
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		start();
	}

	private function start() {

		showMainMenu();
	}

	public function onMenuButton(runList:Array<String>) {
		hideMainMenu();

		_runList = runList;
		_results = [];
		var name = _runList.shift();
		showBenchmark(name);
	}

	public function onAll() {
		hideMainMenu();
	}

	public function onBenchmarkStop() {
		hideBenchmark();
		showMainMenu();
	}
	
	public function onBenchmarkComplete(r:Result) {
		hideBenchmark();

		_results.push(r);

		if(_runList.length > 0) {
			// Take next benchmark
			var name = _runList.shift();
			showBenchmark(name);
		} else {
			showResultsScreen(_results);
		}
	}

	public function onResultsClose(event:Event) {
		hideResultsScreen();
		showMainMenu();
	}

	private function showMainMenu() {
		// now would be a good time for a clean-up
		System.gc();
		
		if (_menuScreen == null)
			_menuScreen = new MenuScreen(this, _scenes);
		
		addChild(_menuScreen);
	}

	private function hideMainMenu() {
		removeChild(_menuScreen);
		_menuScreen = null;
	}

	private function showBenchmark(name:String) {
		_benchmark = new Benchmark(this, _scenes);
		addChild(_benchmark);
		_benchmark.showScene(name);
	}

	private function hideBenchmark() {
		removeChild(_benchmark);
		_benchmark = null;
	}

	private function showResultsScreen(r:Array<Result>) {
		_resultsScreen = new ResultsScreen(this, r);
		addChild(_resultsScreen);
	}

	private function hideResultsScreen() {
		removeChild(_resultsScreen);
		_resultsScreen = null;
	}
}