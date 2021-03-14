package com.isartdigital.nabokos.game.model;
import com.isartdigital.nabokos.ui.Hud;

/**
 * ...
 * @author ...
 */
class ScoreManager 
{
	private static var _score : Int = 0;
	private static var _endScore :Int = 0;
	
	public static function updateScore():Void
	{
		Hud.txtScore.text = "Coup : " + get_score();
	}
	
	public static function get_score():Int
	{
		return _score;
	}
	
	public static function set_score(pX : Int):Int
	{
		return _score = pX;
	}
	
	public static function get_endScore():Int
	{
		return _endScore;
	}
	
	public static function set_endScore(pX : Int):Int
	{
		return _endScore = pX;
	}
}