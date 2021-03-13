package com.isartdigital.nabokos.game.model;
import com.isartdigital.nabokos.game.model.Blocks;
import com.isartdigital.nabokos.game.model.PlayerActions;
import com.isartdigital.utils.loader.GameLoader;
import haxe.Json;
import openfl.geom.Point;

/**
 * Classe côté model
 * Gère le niveau et le résultat des actions du joueur sur celui-ci
 * @author Anthony TIREL--TARTUFFE
 */

typedef Level =
{
	var par: Int;
	var locked: Bool;
	var map: Array<String>;
}

class LevelManager
{

	private static var FULL_WALL: Array<Array<Blocks>> = [[Blocks.WALL], [Blocks.WALL], [Blocks.WALL], [Blocks.WALL], [Blocks.WALL], [Blocks.WALL], [Blocks.WALL], [Blocks.WALL], [Blocks.WALL], [Blocks.WALL], [Blocks.WALL]];

	public static var currentLevel(null, null): Array<Array<Array<Blocks>>>;

	private static var levels(default, null): Array<Array<Array<Array<Blocks>>>>;

	public static var levelNum: Int = 1;

	private function new() {}

	/**
	 * Initialise le tableau levels, contenant l'entièreté des niveaux du jeu.
	 */
	public static function init(): Void
	{
		var levelData: String = GameLoader.getText("assets/levels/leveldesign.json");

		var levelObject: Dynamic = Json.parse(levelData);

		var levelDesign: Array<Level> = Reflect.field(levelObject, "levelDesign");

		currentLevel = new Array<Array<Array<Blocks>>>();
		
		levels = new Array<Array<Array<Array<Blocks>>>>();

		for (level in levelDesign)
		{

			levels.push(new Array<Array<Array<Blocks>>>());

			for (row in level.map)
			{
				var currentRow: Array<Array<Blocks>> = new Array<Array<Blocks>>();

				for (char in row.split(""))
				{
					switch (char)
					{
						case " ": currentRow.push([Blocks.GROUND]);
						case "#": currentRow.push([Blocks.WALL]);
						case ".": currentRow.push([Blocks.TARGET]);
						case "$": currentRow.push([Blocks.BOX, Blocks.GROUND]);
						case "@": currentRow.push([Blocks.PLAYER, Blocks.GROUND]);
						case "M": currentRow.push([Blocks.MIRROR]);
						case "+": currentRow.push([Blocks.PLAYER, Blocks.TARGET]);
						case "*": currentRow.push([Blocks.BOX, Blocks.TARGET]);
					}
				}

				if (level.locked)
				{
					currentRow.push([Blocks.WALL]);
					currentRow.unshift([Blocks.WALL]);
				}

				levels[levels.length - 1].push(currentRow);
			}

			if (level.locked)
			{
				levels[levels.length - 1].push(FULL_WALL.copy());
				levels[levels.length - 1].unshift(FULL_WALL.copy());
			}
		}

		for (i in 0...levels.length)
		{
			trace(levels[i] + "\n");
		}
	}

	/**
	 * Permet de sélectionner le niveau qui doit-être joué
	 * @param	pLevel 	Le numéro du niveau à sélectionner
	 * @return	Bool définissant si la sélection du niveau a réussi ou non
	 */
	public static function selectLevel(pLevel: Int): Bool
	{
		if (pLevel < 0 || pLevel >= levels.length) return false;

		currentLevel = copyLevel(levels[pLevel]);
		
		levelNum = pLevel;
		
		MoveHistory.getInstance().resetTab();
		MoveHistory.getInstance().newMove(copyLevel(currentLevel));

		return true;
	}

	/**
	 * Simule les conséquences de l'action du joueur sur le plateau de jeu, puis effectue cette action si elle est valide
	 * @param	pMove action du joueur
	 * @return	Bool indiquant si l'action que le joueur veut effectuer est faisable, ou non
	 */
	public static function playerAction(pMove: PlayerActions): Bool
	{
		var lPlayerPos: Point = new Point();

		for (y in 0...currentLevel.length)
		{
			for (x in 0...currentLevel[y].length)
			{
				if (currentLevel[y][x].contains(Blocks.PLAYER))
					lPlayerPos.setTo(x, y);
			}
		}

		var lPlayerNextPos: Point = new Point(lPlayerPos.x, lPlayerPos.y);

		switch (pMove)
		{
			case PlayerActions.LEFT:
				lPlayerNextPos.x--;

			case PlayerActions.RIGHT:
				lPlayerNextPos.x++;

			case PlayerActions.DOWN:
				lPlayerNextPos.y++;

			case PlayerActions.UP:
				lPlayerNextPos.y--;

			default:
				return false;
		}

		var lTargetTile: Array<Blocks> = currentLevel[Std.int(lPlayerNextPos.y)][Std.int(lPlayerNextPos.x)];

		if (lTargetTile[0] == Blocks.GROUND || lTargetTile[0] == Blocks.TARGET)
		{
			lTargetTile.unshift(Blocks.PLAYER);
			currentLevel[Std.int(lPlayerPos.y)][Std.int(lPlayerPos.x)].shift();

			return true;
		}

		if (lTargetTile.contains(Blocks.BOX))
		{
			var lNextPosBox: Point = new Point(lPlayerNextPos.x, lPlayerNextPos.y);

			lNextPosBox.x += lPlayerNextPos.x - lPlayerPos.x;
			lNextPosBox.y += lPlayerNextPos.y - lPlayerPos.y;

			lTargetTile = currentLevel[Std.int(lNextPosBox.y)][Std.int(lNextPosBox.x)];

			if (lTargetTile[0] == Blocks.GROUND || lTargetTile[0] == Blocks.TARGET)
			{
				lTargetTile.unshift(Blocks.BOX);

				currentLevel[Std.int(lPlayerNextPos.y)][Std.int(lPlayerNextPos.x)].shift();

				currentLevel[Std.int(lPlayerNextPos.y)][Std.int(lPlayerNextPos.x)].unshift(Blocks.PLAYER);

				currentLevel[Std.int(lPlayerPos.y)][Std.int(lPlayerPos.x)].shift();

				return true;
			}
		}

		if (lTargetTile.contains(Blocks.WALL) || lTargetTile.contains(Blocks.MIRROR) || lTargetTile.contains(Blocks.BOX)) return false;

		return false;
	}
	
	/**
	 * Permet de modifier depuis l'extérieur le niveau actuellement joué (surtout pour le MoveHistory)
	 * @param	pLevel level a mettre en currentLevel
	 */
	public static function editCurrentLevel(pLevel : Array<Array<Array<Blocks>>>): Void {
		if (pLevel != null)
			currentLevel = copyLevel(pLevel);
	}
	
	/**
	 * Getter du level actuel, qui place le player là où il est censé être
	 */
	public static function getCurrentLevel(): Array<Array<Array<Blocks>>>
	{
		return copyLevel(currentLevel);
	}
	
	/**
	 * La fonction .copy() d'une array crée une seconde instance de tableau, mais avec les mêmes objets.
	 * Ainsi, afin d'éviter de modifier tous les tableaux en même temps, on doit copier tous les éléments du tableau à la main
	 * @param	pLevel level à copier
	 * @return level copié
	 */
	private static function copyLevel(pLevel: Array<Array<Array<Blocks>>>): Array<Array<Array<Blocks>>> {
		var lReturnedLevel: Array<Array<Array<Blocks>>> = new Array<Array<Array<Blocks>>>();
		
		for (y in 0...pLevel.length) {
			
			lReturnedLevel[y] = new Array<Array<Blocks>>();
			
			for (x in 0...pLevel[y].length) {
				
				lReturnedLevel[y][x] = new Array<Blocks>();
				
				for (z in 0...pLevel[y][x].length) {
					
					lReturnedLevel[y][x][z] = pLevel[y][x][z];
				}
			}
		}
		
		return lReturnedLevel;
	}
}