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

	private var actuateX : Float = 2300;
	private var actuateVar: Float = 1.1;

	//private var textScoreList : Array<TextField>;// = new Array<TextField>();
	//public var textPseudoScoreList : Array<String>;// = new Array<String>();
	//public var highscorelist : Array<Int>;// = new Array<Int>();

	private static var textScoreList : Array<TextField>;// = new Array<TextField>();
	public static var textPseudoScoreList : Array<String>;// = new Array<String>();
	public static var textPseudoList : Array<String>;// = new Array<String>();
	public static var highscorelist : Array<Int>;// = new Array<Int>();

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

		initTextFields();
		initTextScore();

		jutosity();
		
		textScoreList[10].visible = false;

		Actuate.tween (highscoresTitle,	0.5, {x:-1215, y:-1100}, false).reverse().ease(Cubic.easeIn);
		Actuate.tween (buttonBack,	 	0.5, {x:0, y:850}, false).reverse().ease(Cubic.easeIn);

	}

	public function initTextScore():Void
	{
		if (textPseudoScoreList == null && highscorelist == null)
		{
			highscorelist = new Array<Int>();
			textPseudoScoreList = new Array<String>();
			textPseudoList = new Array<String>();

			for (i in 0... NB_TEXT_HIGHSCORE)
			{
				var lIndex : String = "score" + (i + 1);

				highscorelist.push(MAX_SCORE);
				textPseudoList.push("Pseudo");

				textPseudoScoreList.push((i + 1) + ") "+ textPseudoList[i] + " " + highscorelist[i] + " coups");
				textScoreList[i].text = textPseudoScoreList[i];
			}
		}
		else{
			for (i in 0... NB_TEXT_HIGHSCORE)
			{
				textScoreList[i].text = textPseudoScoreList[i];
			}
		}

		updateHighscores();
	}

	public function initTextFields():Void
	{
		textScoreList = new Array<TextField>();

		for (i in 0... NB_TEXT_HIGHSCORE)
		{
			var lIndex : String = "score" + (i + 1);

			textScoreList.push(cast(content.getChildByName(lIndex), TextField));
		}
	}

	private function jutosity():Void
	{
		for (i in 0... textScoreList.length)
		{
			if (i < 5)
			{
				Actuate.tween (textScoreList[i], 	actuateVar, {x: -actuateX}, false).reverse();
				//trace ("actuate < 5");
			}
			else
			{
				Actuate.tween (textScoreList[i], 	actuateVar, {x: actuateX}, false).reverse();
				//trace ("autre");
			}

			actuateVar -= 0.1;
		}
	}

	private function updateHigscoreText():Void
	{
		for (i in 0...textPseudoScoreList.length){
			textPseudoScoreList[i] = (i + 1) + ") " + textPseudoList[i] + " : " + highscorelist[i] + " coups";
			textScoreList[i].text = textPseudoScoreList[i];
		}
		
		
	}

	public function updateHighscores():Void
	{
		for (k in 0...highscorelist.length)
		{
			if (SaveStorage.getInstance().pseudo == textPseudoList[k]){
				highscorelist[k] = ScoreManager.endScore;
				updateHigscoreText();
			}
			
			if (ScoreManager.endScore == highscorelist[k])
			{
				return;
			}
		}
		
		reorderScores();
	}

	private function reorderScores():Void
	{
		if (LevelScreen.levelCompleteCheck)
		{
			if (ScoreManager.endScore < highscorelist[highscorelist.length - 1])
			{
				highscorelist[highscorelist.length - 1] = ScoreManager.endScore;
				textPseudoList[textPseudoList.length - 1] = SaveStorage.getInstance().pseudo;
			}

			var lPreviousScore: Int = 0;
			var lOtherPrevious: Int = 0;
			
			var lPreviousPseudo: String;
			var lOtherPreviousPseudo: String;

			for (i in 0...highscorelist.length)
			{
				if (highscorelist[highscorelist.length - 1] < highscorelist[i])
				{
					var l: Int = highscorelist.length - 1;
					
					while (l >= 0){
						if (highscorelist[l] < highscorelist[l - 1]){
							lPreviousScore = highscorelist[l];
							lOtherPrevious = highscorelist[l - 1];
							
							highscorelist[l] = lOtherPrevious;
							highscorelist[l - 1] = lPreviousScore;
							
							lPreviousPseudo = textPseudoList[l];
							lOtherPreviousPseudo = textPseudoList[l - 1];
							
							textPseudoList[l] = lOtherPreviousPseudo;
							textPseudoList[l - 1] = lPreviousPseudo;
						}
						l--;
					}
					
					updateHigscoreText();
					SaveStorage.getInstance().updateHighScoreStorage();
					return;
				}
			}
		}
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