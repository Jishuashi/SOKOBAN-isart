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
	
	public static var boxList: Array<Blocks>;
	public static var boxPosition: Array<Point>;
	
	public static var mirrorList: Array<Blocks>;
	public static var mirrorPosition: Array<Point>;

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

		selectLevel(1);
	}

	/**
	 * Permet de sélectionner le niveau qui doit-être joué
	 * @param	pLevel 	Le numéro du niveau à sélectionner
	 * @return	Bool définissant si la sélection du niveau a réussi ou non
	 */
	public static function selectLevel(pLevel: Int): Bool
	{
		if (pLevel < 0 || pLevel >= levels.length) return false;

		currentLevel = levels[pLevel].copy();

		for (y in 0...currentLevel.length)
		{
			currentLevel[y] = levels[pLevel][y].copy();

			for (x in 0...currentLevel[y].length)
			{
				currentLevel[y][x] = levels[pLevel][y][x].copy();
			}
		}

		trace(currentLevel);
		trace(levels[pLevel]);

		levelNum = pLevel;

		return true;
	}

	/**
	 * Simule les conséquences de l'action du joueur sur le plateau de jeu, puis effectue cette action si elle est valide
	 * @param	pPlayerPosition
	 * @param	pMove
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
	 * responsable de refléter les boites
	 */
	private function reflectBoxes(): Void
	{
		for (t in 0...mirrorList.length){
			for (q in 0...boxList.length){
				if (mirrorPosition[t].x == boxPosition[q].x || mirrorPosition[t].y == boxPosition[q].y){
					trace ("pipi");
				}
			}
		}
	}

	/**
	 * Getter du level actuel, qui place le player là où il est censé être
	 */
	public static function getCurrentLevel(): Array<Array<Array<Blocks>>>
	{
		return currentLevel.copy();
	}

}