package com.isartdigital.nabokos.game;
import com.isartdigital.utils.loader.GameLoader;
import haxe.Json;

/**
 * ...
 * @author Anthony TIREL--TARTUFFE
 */

typedef Level = {
    var par: Int;
    var locked: Bool;
    var map: Array<String>;
}

class LevelManager {
	
	private static var FULL_WALL: Array<Blocks> = [Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL];

	public static var currentLevel(default, null): Array<Array<Blocks>>;
	
	private static var levels(default, null): Array<Array<Array<Blocks>>>;
	
	private function new() {}
	
	public static function init(): Void {
		var levelData: String = GameLoader.getText("assets/levels/leveldesign.json");
		
		var levelObject: Dynamic = Json.parse(levelData);
		
		var levelDesign: Array<Level> = Reflect.field(levelObject, "levelDesign");
        
        currentLevel = new Array<Array<Blocks>>();
		levels = new Array<Array<Array<Blocks>>>();
		
		for (level in levelDesign) {
			
			levels.push(new Array<Array<Blocks>>());
			
			for (row in level.map) {
				var currentRow: Array<Blocks> = new Array<Blocks>();
				
				for (char in row.split("")) {
					switch (char) {
						case " ": currentRow.push(Blocks.GROUND);
						case "#": currentRow.push(Blocks.WALL);
						case ".": currentRow.push(Blocks.TARGET);
						case "$": currentRow.push(Blocks.BOX);
						case "@": currentRow.push(Blocks.PLAYER);
						case "M": currentRow.push(Blocks.MIRROR);
					}
				}
				
				if (level.locked) {
					currentRow.push(Blocks.WALL);
					currentRow.unshift(Blocks.WALL);
				}
				
				levels[levels.length - 1].push(currentRow);
			}
			
			if (level.locked) {
				levels[levels.length - 1].push(FULL_WALL.copy());
				levels[levels.length - 1].unshift(FULL_WALL.copy());
			}
		}
		
		for (i in 0...levels.length) {
			trace(levels[i] + "\n");
		}
	}
	
}