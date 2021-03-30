package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.model.SaveStorage;
import com.isartdigital.nabokos.game.model.ScoreManager;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import motion.Actuate;
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

		buttonBack.addEventListener(MouseEvent.CLICK, onClickBack);

		var lPositionnable:UIPositionable = { item:backgroundHighscores, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:highscoresTitle, align:AlignType.TOP};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBack, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);

		highscoresTitle .alpha = 0;
		buttonBack.alpha = 0;

		Actuate.tween (highscoresTitle,	1, {alpha:1});
		Actuate.tween (buttonBack,		1, {alpha:1});
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