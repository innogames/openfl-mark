[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.md)




OpenFLMark
============

OpenFLMark provides different benchmarks for the [OpenFL Framework](http://www.openfl.org/).

The goal is to compare the performance between different implementations, platforms and versions of OpenFL and associated libraries. The User Interface is not that nice, but has no external library dependencies other than OpenFL & Lime. This makes it easier to switch different library versions, e.g. to compare Starling 1.8 vs. Starling 2.0.

All tests increase the amount of test objects until FPS is below 25. This makes sure that benchmark results are not capped at 30 or 60fps. The final score for each benchmark is defined as:
	Score = FPS * ObjectCount / 1000

OpenFLMark can run tests individually or all tests automtically.

Results can be copied to clipboard and easily inserted e.g. in Excel.





Installation
============

Make sure that lime, OpenFL and starling are installed:
	haxelib install lime
	haxelib install openfl
	haxelib install starling

Usage
=====

Just start it:
	openfl test html5