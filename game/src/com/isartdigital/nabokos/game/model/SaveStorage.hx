package com.isartdigital.nabokos.game.model;
import com.isartdigital.nabokos.ui.screen.LevelScreen;
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
	private var prefix : String = "SEL";

	private var storageObject : Dynamic;
	private var pseudo : String;

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

		storageObject = {complete : LevelScreen.levelCompleteList, score : ScoreManager.levelScore};
		saveStorage = SharedObject.getLocal(lName, lPath);

		if (Reflect.hasField(saveStorage.data, lName))
		{
			storageObject = Reflect.field(saveStorage.data, lName);
			
			trace(storageObject.score);
			
			ScoreManager.levelScore = storageObject.score;
			LevelScreen.levelCompleteList = storageObject.complete;
			
			ScoreManager.updateHighScore();
		}
		else
		{
			saveStorage.setProperty(lName, storageObject);
			saveStorage.setDirty(lName);
		}
		
		saveStorage.flush(0);
	}

	/**
	 * update la sauvegarde actuelle
	 */
	public function updateStorage()
	{
		var lName: String = prefix + pseudo;
		var lPath : String = prefix + "/nabokos/saves";

		storageObject = { complete : LevelScreen.levelCompleteList, score : ScoreManager.levelScore};

		saveStorage.setProperty(lName, storageObject);
		saveStorage.setDirty(lName);
		
		saveStorage.flush(0);
	}

	/**
	 * détruit l'instance unique et met sa référence interne à null
	*/
	public function destroy (): Void
	{
		instance = null;
	}

}