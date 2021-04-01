package com.isartdigital.nabokos.game.model;
import com.isartdigital.nabokos.ui.Hud;

/**
 * Gère le score du joueur dans et entre les niveaux
 * @author Hugo CHARTIER
 */
class ScoreManager {
	
	/**
	 * score du niveau actuellement joué
	 */
	public static var score : Int = 0;
	
	/**
	 * Tableau des score par Niveau
	 */
	public static var levelScore : Array<Int> = new Array<Int>();
	/**
	 * Score total du joueur
	 */
	public static var endScore :Int = 0;

	/**
	 * Met à jour l'affichage du score
	 */
	public static function updateScore():Void {
		Hud.txtScore.text = "Coup : " + score;
	}
	
	/**
	 * Init le Highscore
	 */
	public static function initHighscore():Void
	{
		for (i in 0... LevelManager.levels.length - 1) 
		{
			levelScore[i] = 0;
		}
	}
	
	/**
	 * Met à jour le Highscore
	 */
	public static function updateHighScore():Void
	{
		var lHigscore : Int = 0;
		
		for (i in 0... levelScore.length) 
		{
			lHigscore = lHigscore + levelScore[i];
		}
		
		endScore = lHigscore;
	}
}