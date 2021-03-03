package com.isartdigital.nabokos.game;
import com.isartdigital.nabokos.game.sprites.PlayerActions;
import com.isartdigital.utils.loader.GameLoader;
import haxe.Json;
import openfl.geom.Point;


/**
 * Classe côté model
 * Gère le niveau et le résultat des actions du joueur sur celui-ci
 * @author Anthony TIREL--TARTUFFE
 */

typedef Level = {
    var par: Int;
    var locked: Bool;
    var map: Array<String>;
}

class LevelManager {
	
	private static var FULL_WALL: Array<Blocks> = [Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL, Blocks.WALL];

	public static var currentLevel(get, null): Array<Array<Blocks>>;
	
	private static var levels(default, null): Array<Array<Array<Blocks>>>;
	
	private static var playerPos: Point = new Point();
	
	private function new() {}
	
	/**
	 * Initialise le tableau levels, contenant l'entièreté des niveaux du jeu.
	 */
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
		
		selectLevel(0);
		
		for (i in 0...levels.length) {
			trace(levels[i] + "\n");
		}
	}
	
	/**
	 * Permet de sélectionner le niveau qui doit-être joué
	 * @param	pLevel 	Le numéro du niveau à sélectionner
	 * @return	Bool définissant si la sélection du niveau a réussi ou non
	 */
	public static function selectLevel(pLevel: Int): Bool{
		if (pLevel < 0 || pLevel >= levels.length) return false;
		
		currentLevel = levels[pLevel].copy();
		
		playerPos = new Point();
		
		for (y in 0...currentLevel.length) {
			for (x in 0...currentLevel[y].length) {
				if (currentLevel[y][x] == Blocks.PLAYER) {
					currentLevel[y][x] = Blocks.GROUND;
					
					playerPos.x = x;
					playerPos.y = y;
					break;
				}
			}
			
			if (playerPos.x != 0 || playerPos.y != 0) break;
		}
		
		return true;
	}

	/**
	 * Simule les conséquences de l'action du joueur sur le plateau de jeu, puis effectue cette action si elle est valide
	 * @param	pPlayerPosition
	 * @param	pMove
	 * @return	Bool indiquant si l'action que le joueur veut effectuer est faisable, ou non
	 */
	public static function playerAction(pMove: PlayerActions): Bool {
		var lNextPosPlayer: Point = new Point(playerPos.x, playerPos.y);
		
		switch (pMove) {
			case PlayerActions.LEFT:
				lNextPosPlayer.x--;
			
			case PlayerActions.RIGHT:
				lNextPosPlayer.x++;
			
			case PlayerActions.DOWN:
				lNextPosPlayer.y++;
			
			case PlayerActions.UP:
				lNextPosPlayer.y--;
			
			default:
				return false;
		}
		
		var lTargetTile: Blocks = currentLevel[Std.int(lNextPosPlayer.y)][Std.int(lNextPosPlayer.x)];
		
		if (lTargetTile == Blocks.GROUND || lTargetTile == Blocks.TARGET) {
			playerPos = lNextPosPlayer;
			
			return true;
		}
		
		if (lTargetTile == Blocks.BOX) {
			var lNextPosBox: Point = new Point(lNextPosPlayer.x, lNextPosPlayer.y);
			
			lNextPosBox.x += lNextPosPlayer.x - playerPos.x;
			lNextPosBox.y += lNextPosPlayer.y - playerPos.y;
			
			lTargetTile = currentLevel[Std.int(lNextPosPlayer.y)][Std.int(lNextPosPlayer.x)];
			
			if (lTargetTile == Blocks.GROUND || lTargetTile == Blocks.TARGET) {
				currentLevel[Std.int(lNextPosBox.y)][Std.int(lNextPosBox.x)] = Blocks.BOX;
				currentLevel[Std.int(lNextPosPlayer.y)][Std.int(lNextPosPlayer.x)] = levels[levels.indexOf(currentLevel)][Std.int(lNextPosPlayer.y)][Std.int(lNextPosPlayer.x)];
				
				playerPos.x = lNextPosPlayer.x;
				playerPos.y = lNextPosPlayer.y;
				
				return true;
			}
		}
		
		if (lTargetTile == Blocks.WALL || lTargetTile == Blocks.MIRROR || lTargetTile == Blocks.BOX) return false;
		
		return false;
	}
	
	/**
	 * Getter du level actuel, qui place le player là où il est censé être
	 */
	static function get_currentLevel(){
		var lReturnedLevel: Array<Array<Blocks>> = currentLevel.copy();
		
		lReturnedLevel[Std.int(playerPos.y)][Std.int(playerPos.x)] = Blocks.PLAYER;
		
		return lReturnedLevel;
	}

}