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

	private var storageObject : Dynamic;
	private var storageHighScoreObject : Dynamic;
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

		storageObject = {complete : LevelScreen.levelCompleteList, score : ScoreManager.levelScore, levelComplete: false};

		saveStorage = SharedObject.getLocal(lName, lPath);

		if (Reflect.hasField(saveStorage.data, lName))
		{
			storageObject = Reflect.field(saveStorage.data, lName);

			//trace(storageObject.score);

			ScoreManager.levelScore = storageObject.score;
			LevelScreen.levelCompleteList = storageObject.complete;
			LevelScreen.levelCompleteCheck = storageObject.levelComplete;

			//trace (storageObject.levelComplete, "save");

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

		saveStorage.flush(0);
	}

	public function initHighScoreStorage():Void
	{
		var lPath : String = prefix + "/nabokos/saves";
		var lHighScoreName: String = prefix + "SELNotAllowed";

		storageHighScoreObject = {highscores : Highscores.highscorelist, text : Highscores.textPseudoScoreList};
		saveAllStorage = SharedObject.getLocal(lHighScoreName, lPath);

		if (Reflect.hasField(saveAllStorage.data, lHighScoreName))
		{
			storageHighScoreObject = Reflect.field(saveAllStorage.data, lHighScoreName);

			Highscores.highscorelist = storageHighScoreObject.highscores;
			Highscores.textPseudoScoreList = storageHighScoreObject.text;
			
			Highscores.getInstance().updateHigscoreList();
		}
		else
		{
			Highscores.getInstance().initTextScore();
			saveAllStorage.setProperty(lHighScoreName, storageHighScoreObject);
			saveAllStorage.setDirty(lHighScoreName);
		}

		//trace(saveAllStorage.data.SELSELNotAllowed);
		trace (storageHighScoreObject);
		saveAllStorage.flush(0);
	}

	/**
	 * update la sauvegarde actuelle
	 */
	public function updateStorage()
	{
		var lName: String = prefix + pseudo;
		var lPath : String = prefix + "/nabokos/saves";

		storageObject = {complete : LevelScreen.levelCompleteList, score : ScoreManager.levelScore, levelComplete : LevelScreen.allLevelComplete()};

		saveStorage.setProperty(lName, storageObject);
		saveStorage.setDirty(lName);

		saveStorage.flush(0);
	}

	public function updateHighScoreStorage():Void
	{
		var lHighScoreName: String = prefix + "SELNotAllowed";
		var lPath : String = prefix + "/nabokos/saves";

		storageHighScoreObject = {highscores : Highscores.highscorelist, text : Highscores.textPseudoScoreList};
		
		//trace(storageHighScoreObject , "CC");
		
		saveStorage.setProperty(lHighScoreName, storageHighScoreObject);
		saveStorage.setDirty(lHighScoreName);

		//trace(saveAllStorage.data, "bizou");

	}

	/**
	 * détruit l'instance unique et met sa référence interne à null
	*/
	public function destroy (): Void
	{
		instance = null;
	}

}