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

	public static var currentLevel(default, null): Array<Array<Blocks>>;
	
	private function new() {}
	
	public static function init(): Void {
		var levelData: String = GameLoader.getText("assets/levels/leveldesign.json");
		
		var levelObject: Dynamic = Json.parse(levelData);

		var levelDesign: Array<Level> = Reflect.field(levelObject, "levelDesign");
        
        currentLevel = new Array<Array<Blocks>>();
		
		for (level in levelDesign) {
			
			for (row in level.map) {
				
				currentLevel.push(new Array<Blocks>());
				
				for (char in row.split("")) {
					switch (char) {
						case " ": currentLevel[currentLevel.length - 1].push(Blocks.GROUND);
						case "#": currentLevel[currentLevel.length - 1].push(Blocks.WALL);
						case ".": currentLevel[currentLevel.length - 1].push(Blocks.TARGET);
						case "$": currentLevel[currentLevel.length - 1].push(Blocks.BOX);
						case "@": currentLevel[currentLevel.length - 1].push(Blocks.PLAYER);
						case "M": currentLevel[currentLevel.length - 1].push(Blocks.MIRROR);
					}
				}
			}
			
			trace(currentLevel);
			return;
		}
	}
	
}