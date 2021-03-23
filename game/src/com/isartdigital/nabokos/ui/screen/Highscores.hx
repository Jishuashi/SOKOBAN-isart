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