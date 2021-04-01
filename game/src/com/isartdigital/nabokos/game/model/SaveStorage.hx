package com.isartdigital.nabokos.game.model;
import com.isartdigital.nabokos.ui.screen.LevelScreen;
import com.isartdigital.nabokos.ui.screen.Highscores;
import com.isartdigital.nabokos.ui.screen.LoginScreen;
import openfl.net.SharedObject;

/**
 * ...
 * @author Hugo CHARTIER
 */
class SaveStorage extends SharedObject
{

	/**
	 * instance unique de la classe Storage
	 */
	private static var instance: SaveStorage;

	public var saveStorage : SharedObject;
	public var saveAllStorage : SharedObject;
	private var prefix : String = "SEL";

	public var storageObject : Dynamic;
	public var storageHighScoreObject : Dynamic;
	public var pseudo : String;

	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance(): SaveStorage
	{
		if (instance == null) instance = new SaveStorage();
		return instance;
	}

	public function new ()
	{
		super();

		if (instance!=null) trace ("Tentative de création d'un autre singleton.");
		else instance = this;
	}

	/**
	 * init la sauvegarde de la progression
	 */
	public function initStorage(pName : String)
	{
		pseudo = pName;
		var lName: String = prefix + pseudo;
		var lPath : String = prefix + "/nabokos/saves";

		storageObject = {complete : LevelScreen.levelCompleteList, score : ScoreManager.levelScore, levelComplete: false, stars : LevelManager.allStars};

		saveStorage = SharedObject.getLocal(lName, lPath);

		if (Reflect.hasField(saveStorage.data, lName))
		{
			storageObject = Reflect.field(saveStorage.data, lName);

			ScoreManager.levelScore = storageObject.score;
			LevelScreen.levelCompleteList = storageObject.complete;
			LevelScreen.levelCompleteCheck = storageObject.levelComplete;
			LevelManager.allStars = storageObject.stars;

			LevelScreen.allLevelComplete();
			LevelScreen.getInstance().unlockLevelSave();

			ScoreManager.updateHighScore();
		}
		else
		{
			ScoreManager.initHighscore();
			LevelScreen.initCompleteListAndLock();
			saveStorage.setProperty(lName, storageObject);
			saveStorage.setDirty(lName);
		}

		trace (storageObject);

		//LevelManager.updateAllStars();
		saveStorage.flush(0);
	}

	public function initHighScoreStorage():Void
	{
		var lPath : String = prefix + "/nabokos/saves";
		var lHighScoreName: String = prefix + "SELNotAllowed";

		saveAllStorage = SharedObject.getLocal(lHighScoreName, lPath);

		if (Reflect.hasField(saveAllStorage.data, lHighScoreName))
		{
			storageHighScoreObject = Reflect.field(saveAllStorage.data, lHighScoreName);

			//Highscores.getInstance().highscorelist = storageHighScoreObject.highscores;
			//Highscores.getInstance().textPseudoScoreList = storageHighScoreObject.text;
			
			Highscores.highscorelist = storageHighScoreObject.highscores;
			Highscores.textPseudoScoreList = storageHighScoreObject.text;
			Highscores.textPseudoList = storageHighScoreObject.pseudo;

			Highscores.getInstance().updateHighscores();
		}
		else
		{
			//Highscores.getInstance().initTextScore();

			//storageHighScoreObject = {highscores : Highscores.getInstance().highscorelist, text : Highscores.getInstance().textPseudoScoreList};
			storageHighScoreObject = {highscores : Highscores.highscorelist, text : Highscores.textPseudoScoreList , pseudo : Highscores.textPseudoList};

			saveAllStorage.setProperty(lHighScoreName, storageHighScoreObject);
			saveAllStorage.setDirty(lHighScoreName);
		}

		trace(saveAllStorage.data);
		saveAllStorage.flush(0);
		Highscores.getInstance().initTextScore();
	}

	/**
	 * update la sauvegarde actuelle
	 */
	public function updateStorage()
	{
		var lName: String = prefix + pseudo;
		var lPath : String = prefix + "/nabokos/saves";

		storageObject = {complete : LevelScreen.levelCompleteList, score : ScoreManager.levelScore, levelComplete : LevelScreen.allLevelComplete(), stars : LevelManager.allStars};

		saveStorage.setProperty(lName, storageObject);
		saveStorage.setDirty(lName);

		saveStorage.flush(0);
	}

	public function updateHighScoreStorage():Void
	{
		var lPath : String = prefix + "/nabokos/saves";
		var lHighScoreName: String = prefix + "SELNotAllowed";

		//storageHighScoreObject = {highscores : Highscores.getInstance().highscorelist, text : Highscores.getInstance().textPseudoScoreList};
		storageHighScoreObject = {highscores : Highscores.highscorelist, text : Highscores.textPseudoScoreList , pseudo : Highscores.textPseudoList};

		saveAllStorage.setProperty(lHighScoreName, storageHighScoreObject);
		saveAllStorage.setDirty(lHighScoreName);

		saveAllStorage.flush(0);
	}

	/**
	 * détruit l'instance unique et met sa référence interne à null
	*/
	public function destroy (): Void
	{
		instance = null;
	}

}