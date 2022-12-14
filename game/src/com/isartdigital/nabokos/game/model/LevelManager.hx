package com.isartdigital.nabokos.game.model;
import com.isartdigital.nabokos.game.model.Blocks;
import com.isartdigital.nabokos.game.model.PlayerActions;
import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.ui.UIManager;
import com.isartdigital.nabokos.ui.screen.FinalWin;
import com.isartdigital.nabokos.ui.screen.LevelScreen;
import com.isartdigital.nabokos.ui.screen.Highscores;
import com.isartdigital.nabokos.ui.screen.WinScreen;
import com.isartdigital.utils.loader.GameLoader;
import haxe.Json;
import openfl.geom.Point;

/**
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

	public static var levels(default, null): Array<Array<Array<Array<Blocks>>>>;

	public static var levelNum: Int = 0;

	public static var bigWallOn : Bool = true;

	private static var boxList: Array<Array<Blocks>>;
	public static var boxCurrentPosition: Array<Array<Point>>;
	private static var boxPreviousPosition: Array<Array<Point>>;

	private static var mirrorList: Array<Blocks>;
	private static var mirrorPosition: Array<Point>;

	private static var targetList : Array<Blocks>;
	private static var targetPosition : Array<Point>;

	public static var initLevelCheck: Int = 0;
	
	public static var starNumber: Int = 0;
	public static var allStars: Array<Int>;
	private static var levelDesign: Array<Level>;

	public static var everyStar: Int = 0;

	private function new() {}

	/**
	 * Initialise le tableau levels, contenant l'entièreté des niveaux du jeu.
	 */
	public static function init(): Void
	{
		levelDesign = new Array<Level>();
		allStars = new Array<Int>();
		
		var levelData: String = GameLoader.getText("assets/levels/leveldesign.json");

		var levelObject: Dynamic = Json.parse(levelData);

		var lLevelDesign: Array<Level> = Reflect.field(levelObject, "levelDesign");

		levelDesign = lLevelDesign;

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
						case "V": currentRow.push([Blocks.EMPTY]);
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

		initBlocksArrays();
		reflectBoxes(); //reflète les boîtes pour la première fois dans le niveau

		MoveHistory.getInstance().resetTab();
		MoveHistory.getInstance().newMove(copyLevel(currentLevel), copyArray2D(boxCurrentPosition));

		return true;
	}

	/**
	 * Simule les conséquences de l'action du joueur sur le plateau de jeu, puis effectue cette action si elle est valide
	 * @param	pMove action du joueur
	 * @return	Bool indiquant si l'action que le joueur veut effectuer est faisable, ou non
	 */
	public static function playerAction(pMove: PlayerActions): Bool
	{
		initLevelCheck++;

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

			ScoreManager.score++;
			ScoreManager.updateScore();

			return true;
		}

		if (lTargetTile.contains(Blocks.BOX))
		{
			var lNextPosBox: Point = new Point(lPlayerNextPos.x, lPlayerNextPos.y);

			ScoreManager.score++;
			ScoreManager.updateScore();

			lNextPosBox.x += lPlayerNextPos.x - lPlayerPos.x;
			lNextPosBox.y += lPlayerNextPos.y - lPlayerPos.y;

			lTargetTile = currentLevel[Std.int(lNextPosBox.y)][Std.int(lNextPosBox.x)];

			if (lTargetTile[0] == Blocks.GROUND || lTargetTile[0] == Blocks.TARGET)
			{
				lTargetTile.unshift(Blocks.BOX);

				currentLevel[Std.int(lPlayerNextPos.y)][Std.int(lPlayerNextPos.x)].shift();

				currentLevel[Std.int(lPlayerNextPos.y)][Std.int(lPlayerNextPos.x)].unshift(Blocks.PLAYER);

				currentLevel[Std.int(lPlayerPos.y)][Std.int(lPlayerPos.x)].shift();

				updateBoxArrays(lNextPosBox, lPlayerNextPos);
				removeReflections();
				reflectBoxes();

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
	public static function editCurrentLevel(pLevel : Array<Array<Array<Blocks>>>): Void
	{
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

	public static function getBoxPosisition(): Array<Array<Point>>
	{
		return copyArray2D(boxCurrentPosition);
	}

	/**
	 * La fonction .copy() d'une array crée une seconde instance de tableau, mais avec les mêmes objets.
	 * Ainsi, afin d'éviter de modifier tous les tableaux en même temps, on doit copier tous les éléments du tableau à la main
	 * @param	pLevel level à copier
	 * @return level copié
	 */
	private static function copyLevel(pLevel: Array<Array<Array<Blocks>>>): Array<Array<Array<Blocks>>>
	{
		var lReturnedLevel: Array<Array<Array<Blocks>>> = new Array<Array<Array<Blocks>>>();

		for (y in 0...pLevel.length)
		{
			lReturnedLevel[y] = new Array<Array<Blocks>>();

			for (x in 0...pLevel[y].length)
			{
				lReturnedLevel[y][x] = new Array<Blocks>();

				for (z in 0...pLevel[y][x].length)
				{
					lReturnedLevel[y][x][z] = pLevel[y][x][z];
				}
			}
		}

		return lReturnedLevel;
	}

	/**
	 * fonctionne de la même façon que pour copyLevel mais pour un tableau à 2 dimensions
	 * @param	pArray tableau a recopier
	 * @return	le tableau
	 */
	public static function copyArray2D(pArray: Array<Array<Point>>): Array<Array<Point>>
	{
		var lReturnedArray: Array<Array<Point>> = new Array<Array<Point>>();
		var lPos:Point = new Point();

		for (y in 0...pArray.length)
		{
			lReturnedArray[y] = new Array<Point>();

			for (x in 0...pArray[y].length)
			{
				lPos.x = pArray[y][x].x;
				lPos.y = pArray[y][x].y;

				lReturnedArray[y].push(new Point(lPos.x, lPos.y));
			}
		}

		return lReturnedArray;
	}

	/**
	 * responsable de refléter les boites
	 */
	public static function reflectBoxes(): Void
	{
		var lMirrorPosition: Point = new Point();
		var lBoxPosition:Point = new Point();
		var lTargetTilePosition: Point;
		var lTargetTile: Array<Blocks> = new Array<Blocks>();

		//la boucle for vérifie si pour chaque miroir il y a des boites sur le même ligne que lui. Si oui, une boite apparait de l'autre côté
		for (t in 0...mirrorList.length)
		{
			lMirrorPosition.x = mirrorPosition[t].x;
			lMirrorPosition.y = mirrorPosition[t].y;

			for (q in 0...boxList.length)
			{
				for (v in 0...boxList[q].length)
				{
					lBoxPosition.x = boxCurrentPosition[q][v].x;
					lBoxPosition.y = boxCurrentPosition[q][v].y;

					if (lMirrorPosition.x == lBoxPosition.x || lMirrorPosition.y == lBoxPosition.y)
					{
						lTargetTilePosition = calculateSymetricPoint(lMirrorPosition, lBoxPosition);

						if (lTargetTilePosition.x < currentLevel[0].length && lTargetTilePosition.y < currentLevel.length && lTargetTilePosition.x > 0 && lTargetTilePosition.y > 0)
						{
							lTargetTile = currentLevel[Std.int(lTargetTilePosition.y)][Std.int(lTargetTilePosition.x)];

							if (!lTargetTile.contains(Blocks.WALL) && !lTargetTile.contains(Blocks.MIRROR) && !lTargetTile.contains(Blocks.BOX) && !lTargetTile.contains(Blocks.PLAYER) && !lTargetTile.contains(Blocks.EMPTY))
							{
								lTargetTile.unshift(Blocks.BOX); // on pourra mettre une méthode ici pour faire apparaitre le bloc (feedback)
								boxList[q].push(Blocks.BOX);
								boxCurrentPosition[q].push(lTargetTilePosition);
								boxPreviousPosition[q].push(new Point());
								reflectBoxes();
							}
						}
					}
				}
			}
		}
	}

	/**
	 * retire les reflets
	 */
	private static function removeReflections():Void
	{
		var lCurrentPosition: Point;
		var lPreviousPosition: Point;
		var lTargetTile: Array<Blocks> = new Array<Blocks>();
		var lCheck:Int = 0;
		var lRemovedBoxedCoords: Array<Point> = new Array<Point>();
		
		
		for (h in 0...boxList.length)
		{
			if (lCheck != 0)
				break;

			for (k in 0...boxList[h].length)
			{
				lCurrentPosition = boxCurrentPosition[h][k];
				lPreviousPosition = boxPreviousPosition[h][k];

				if (lCurrentPosition.x != lPreviousPosition.x || lCurrentPosition.y != lPreviousPosition.y)
				{
					for (l in 0...boxList[h].length)
					{
						if (l != k)
						{
							lCheck++;
							lTargetTile = currentLevel[Std.int(boxCurrentPosition[h][l].y)][Std.int(boxCurrentPosition[h][l].x)];
							if (lTargetTile[0] == Blocks.BOX) {
								lTargetTile.shift();
								lRemovedBoxedCoords.push(new Point(boxCurrentPosition[h][l].x, boxCurrentPosition[h][l].y));
							}
						}
					}

					for (m in 0...boxList[h].length)
					{
						if (m != k)
						{
							boxList[h].splice(m, 1);
							boxCurrentPosition[h].splice(m, 1);
							boxPreviousPosition[h].splice(m, 1);
							removeReflections();
						}
					}
					break;
				}
			}
		}
		
		IsoView.getInstance().removeReflections(lRemovedBoxedCoords);
	}

	public static function reInitBoxesForUndo(pCurrentBoxesPosition: Array<Array<Point>>):Void
	{
		boxList = new Array<Array<Blocks>>();
		boxCurrentPosition = new Array<Array<Point>>();
		boxPreviousPosition = new Array<Array<Point>>();

		for (i in 0...pCurrentBoxesPosition.length)
		{
			boxList.insert(i, new Array<Blocks>());
			boxCurrentPosition.insert(i, new Array<Point>());
			boxPreviousPosition.insert(i, new Array<Point>());

			for (j in 0...pCurrentBoxesPosition[i].length)
			{
				boxList[i].push(Blocks.BOX);
				boxCurrentPosition[i].push(new Point(pCurrentBoxesPosition[i][j].x, pCurrentBoxesPosition[i][j].y));
				boxPreviousPosition[i].push(new Point());
			}
		}
	}

	/**
	 * initialise le tableau de box, de positions de box, de mirroirs, de position de mirroirs, de target et de position de target
	 */
	private static function initBlocksArrays():Void
	{
		boxList = new Array<Array<Blocks>>();
		boxCurrentPosition = new Array<Array<Point>>();
		boxPreviousPosition = new Array<Array<Point>>();

		mirrorList = new Array<Blocks>();
		mirrorPosition = new Array<Point>();

		targetList = new Array<Blocks>();
		targetPosition = new Array<Point>();

		var lTile:Array<Blocks> = new Array<Blocks>();

		// parcours le currentLevel et sauvegarde le nombre de target, miroirs et de boîtes, ainsi que leurs positions sur la grille
		for (y in 0...currentLevel.length)
		{
			for (x in 0...currentLevel[y].length)
			{
				lTile = currentLevel[y][x];

				if (lTile.contains(Blocks.MIRROR))
				{
					mirrorList.push(Blocks.MIRROR);
					mirrorPosition.push(new Point(x, y));
				}
				else if (lTile.contains(Blocks.BOX))
				{
					boxList.push([Blocks.BOX]);
					boxCurrentPosition.push([new Point(x, y)]);
					boxPreviousPosition.push([new Point()]);
				}
				else if (lTile.contains(Blocks.TARGET))
				{
					targetList.push(Blocks.TARGET);
					targetPosition.push(new Point(x, y));
				}
			}
		}
	}

	/**
	 * update les tableaux de boite
	 * @param	pNewBoxTile: les nouvelles coordonnés de la boîte qui a bougé
	 * @param	pOldBoxPosition: les anciennes coordonnés de la boîte qui a bougé
	 */
	private static function updateBoxArrays(pNewBoxPosition:Point, pOldBoxPosition:Point):Void
	{
		var lCurrentPosition: Point;
		var lPreviousPosition: Point;

		for (i in 0...boxCurrentPosition.length)
		{
			for (j in 0...boxCurrentPosition[i].length)
			{
				lCurrentPosition = boxCurrentPosition[i][j];
				lPreviousPosition = boxPreviousPosition[i][j];

				lPreviousPosition.x = lCurrentPosition.x;
				lPreviousPosition.y = lCurrentPosition.y;

				if (lCurrentPosition.equals(pOldBoxPosition))
				{
					lCurrentPosition.x = pNewBoxPosition.x;
					lCurrentPosition.y = pNewBoxPosition.y;
				}
			}
		}
	}

	private static function calculateSymetricPoint(pMirrorPosition:Point, pBoxPosition:Point):Point
	{
		return new Point(pMirrorPosition.x + (pMirrorPosition.x - pBoxPosition.x), pMirrorPosition.y + (pMirrorPosition.y - pBoxPosition.y));
	}

	/**
	 * vérifie si il y a une boite sur toutes les targets
	 */
	public static function winCondition(): Void
	{
		var lTargetPosition:Point = new Point();
		var lBoxPosition:Point = new Point();
		var lSucces:Int = targetList.length;
		var lCurrentSucces:Int = 0;

		for (t in 0...targetList.length)
		{
			lTargetPosition.x = targetPosition[t].x;
			lTargetPosition.y = targetPosition[t].y;

			for (q in 0...boxList.length)
			{
				for (v in 0...boxList[q].length)
				{
					lBoxPosition.x = boxCurrentPosition[q][v].x;
					lBoxPosition.y = boxCurrentPosition[q][v].y;

					if (lTargetPosition.x == lBoxPosition.x && lTargetPosition.y == lBoxPosition.y) lCurrentSucces++;
				}
			}
		}

		if (lSucces == lCurrentSucces) {
			GameManager.pauseGame();
			IsoView.getInstance().winAnimation();
		}
	}
	
	public static function win(): Void {
		starNumber = 1;

		if (levelDesign[LevelManager.levelNum].par >= ScoreManager.score)
		{
			starNumber = 2;
			trace(starNumber);
		}

		allStars[LevelManager.levelNum] = starNumber;

		trace (allStars);
		
		if (ScoreManager.levelScore[levelNum] > ScoreManager.score && LevelScreen.levelCompleteList[levelNum])
		{

			ScoreManager.levelScore[levelNum] = ScoreManager.score;
			ScoreManager.updateHighScore();
			SaveStorage.getInstance().updateStorage();
		}
		else if (!LevelScreen.levelCompleteList[levelNum])
		{
			ScoreManager.levelScore[levelNum] = ScoreManager.score;
			ScoreManager.updateHighScore();
			LevelScreen.levelCompleteList[levelNum] = true;
			SaveStorage.getInstance().updateStorage();
		}
		
		
		
		
		if (levelNum == 12){
			UIManager.addScreen(FinalWin.getInstance());
		}else{
			WinScreen.getInstance().displayStars();			
			UIManager.addScreen(WinScreen.getInstance());
		}
		
		UIManager.closeHud();
		
		LevelScreen.getInstance().unlockLevel();
		LevelScreen.levelCompleteCheck = LevelScreen.allLevelComplete();
		
		Highscores.getInstance().updateHighscores();
		SaveStorage.getInstance().updateHighScoreStorage();
		
		ScoreManager.score = 0;
		ScoreManager.updateScore();
	}
	
	//public static function updateAllStars():Void
	//{
		//for (i in 0...levels.length)
		//{
			//if (ScoreManager.levelScore[i] != 0)
			//{
				//starNumber = 1;
				//
				//if (ScoreManager.levelScore[i] <= levelDesign[LevelManager.levelNum].par)
				//{
					//starNumber = 2;
				//}
			//}
			//
			//allStars[LevelManager.levelNum] = starNumber;
		//}
		//
		//sumallStars();
		//trace(allStars);
	//}
	
	public static function sumallStars():Int
	{
		var lStarNum: Int = 0;
		
		for (j in 0...levels.length){
			if (allStars[j] != null){
				lStarNum = allStars[j] + lStarNum;
			}
		}
		
		return lStarNum;
	}

	public static function getPlayerPosition(): Point
	{
		for (y in 0...currentLevel.length)
		{

			for (x in 0...currentLevel[y].length)
			{

				if (currentLevel[y][x].contains(Blocks.PLAYER))
				{
					return new Point(x, y);
				}
			}
		}

		return null;
	}
}