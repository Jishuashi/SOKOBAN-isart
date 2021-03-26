package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import motion.Actuate;
import motion.easing.Elastic;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;

	
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
		
		highscoresTitle .alpha = 0;
		buttonBack.alpha = 0;
		score1 .alpha = 0;
		score2 .alpha = 0;
		score3 .alpha = 0;
		score4 .alpha = 0;
		score5 .alpha = 0;
		score6 .alpha = 0;
		score7 .alpha = 0;
		score8 .alpha = 0;
		score9 .alpha = 0;
		score10 .alpha = 0;
		score11 .alpha = 0;
		
		Actuate.tween (highscoresTitle,	1, {alpha:1});
		Actuate.tween (buttonBack,		1, {alpha:1});
		Actuate.tween (score1,			1, {alpha:1});
		Actuate.tween (score2,			1, {alpha:1});
		Actuate.tween (score3,			1, {alpha:1});
		Actuate.tween (score4,			1, {alpha:1});
		Actuate.tween (score5,			1, {alpha:1});
		Actuate.tween (score6,			1, {alpha:1});
		Actuate.tween (score7,			1, {alpha:1});
		Actuate.tween (score8,			1, {alpha:1});
		Actuate.tween (score9,			1, {alpha:1});
		Actuate.tween (score10,			1, {alpha:1});
		Actuate.tween (score11,			1, {alpha:1});
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