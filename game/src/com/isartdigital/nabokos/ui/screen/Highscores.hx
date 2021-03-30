package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.model.SaveStorage;
import com.isartdigital.nabokos.game.model.ScoreManager;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import motion.Actuate;
import motion.easing.Cubic;
import motion.easing.Elastic;
import com.isartdigital.nabokos.ui.screen.LevelScreen;
import com.isartdigital.nabokos.ui.screen.LoginScreen;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;
import openfl.text.TextField;

/**
 * ...
 * @author Blanco
 */
class Highscores extends Screen
{
	private static var instance: Highscores;
	private var backgroundHighscores:DisplayObject;
	private var highscoresTitle:DisplayObject;
	private var buttonBack:DisplayObject;
	private var score1:DisplayObject;
	private var score2:DisplayObject;
	private var score3:DisplayObject;
	private var score4:DisplayObject;
	private var score5:DisplayObject;
	private var score6:DisplayObject;
	private var score7:DisplayObject;
	private var score8:DisplayObject;
	private var score9:DisplayObject;
	private var score10:DisplayObject;
	private var score11:DisplayObject;

	private static var textScoreList : Array<TextField> = new Array<TextField>();
	public static var textPseudoScoreList : Array<String> = new Array<String>();
	public static var highscorelist : Array<Int> = new Array<Int>();
	static inline var MAX_SCORE:Int = 1000000;
	static inline var NB_TEXT_HIGHSCORE :Int = 11;

	private function new()
	{
		super();

		backgroundHighscores	= content.getChildByName("backgroundHighscores");
		highscoresTitle			= content.getChildByName("highscoresTitle");
		buttonBack				= content.getChildByName("btnBack");
		score1					= content.getChildByName("score1");
		score2					= content.getChildByName("score2");
		score3					= content.getChildByName("score3");
		score4					= content.getChildByName("score4");
		score5					= content.getChildByName("score5");
		score6					= content.getChildByName("score6");
		score7					= content.getChildByName("score7");
		score8					= content.getChildByName("score8");
		score9					= content.getChildByName("score9");
		score10					= content.getChildByName("score10");
		score11					= content.getChildByName("score11");

		buttonBack.addEventListener(MouseEvent.CLICK, onClickBack);

		var lPositionnable:UIPositionable = { item:backgroundHighscores, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:highscoresTitle, align:AlignType.TOP};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBack, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);

		Actuate.tween (highscoresTitle,	0.5, {x:-1215, y:-1100}, false).reverse().ease(Cubic.easeIn);
		Actuate.tween (buttonBack,	 	0.5, {x:0, y:850}, false).reverse().ease(Cubic.easeIn);
		Actuate.tween (score11, 0.1, {x: 2300}, false).reverse();
		Actuate.tween (score10, 0.2, {x: 2300}, false).reverse();
		Actuate.tween (score9, 	0.3, {x: 2300}, false).reverse();
		Actuate.tween (score8, 	0.4, {x: 2300}, false).reverse();
		Actuate.tween (score7, 	0.5, {x: 2300}, false).reverse();
		Actuate.tween (score6, 	0.6, {x: 2300}, false).reverse();
		Actuate.tween (score5, 	0.7, {x: -2300}, false).reverse();
		Actuate.tween (score4, 	0.8, {x: -2300}, false).reverse();
		Actuate.tween (score3, 	0.9, {x: -2300}, false).reverse();
		Actuate.tween (score2, 	1,   {x: -2300}, false).reverse();
		Actuate.tween (score1, 	1.1, {x: -2300}, false).reverse();
	}

	public function initTextScore():Void
	{
		for (i in 0... NB_TEXT_HIGHSCORE)
		{
			var lIndex : String = "score" + (i + 1);

			textScoreList.push(cast(content.getChildByName(lIndex), TextField));
			highscorelist.push(MAX_SCORE);
			textScoreList[i].alpha = 0;
			Actuate.tween (textScoreList[i], 1, {alpha:1});

			textPseudoScoreList.push((i + 1) + ") Pseudo : " + highscorelist[i] + " coups");
			textScoreList[i].text = textPseudoScoreList[i];
		}

		textScoreList[10].visible = false;
		
		updateHigscoreList();
		//trace(highscorelist, textPseudoScoreList, "bizou");
	}

	public function updateHigscoreList():Void
	{
		//trace ("update highscore");
		//trace (LevelScreen.allLevelComplete());
		
		if (LevelScreen.levelCompleteCheck)
		{
			for (i in 0... textScoreList.length)
			{
				if (highscorelist[i] > ScoreManager.endScore)
				{
					highscorelist[i] = ScoreManager.endScore;

					textPseudoScoreList[i] = (i + 1) + ") " + SaveStorage.getInstance().pseudo + " : " + highscorelist[i] + " coups";
					textScoreList[i].text = textPseudoScoreList[i];
					//trace (highscorelist);
					return;
				}
			}
		}
		//reorderScores();
	}
	
	private function reorderScores():Void
	{
		highscorelist.sort(Reflect.compare);
		//trace(highscorelist);
	}

	public static function getInstance (): Highscores
	{
		if (instance == null) instance = new Highscores();
		return instance;
	}

	private function onClickBack(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(TitleCard.getInstance());
		SoundManager.clickSound();
	}

	override public function destroy (): Void
	{
		instance = null;
		buttonBack.removeEventListener(MouseEvent.CLICK, onClickBack);
		super.destroy();
	}
}