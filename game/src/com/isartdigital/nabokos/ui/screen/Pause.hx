package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Blanco
 */
class Pause extends Screen 
{
	private static var instance: Pause;
	private var backgroundPause:DisplayObject;
	private var pauseTitle:DisplayObject;
	private var buttonContinue:DisplayObject;
	private var buttonQuit:DisplayObject;

	private function new()
	{
		super();
		
		backgroundPause		= content.getChildByName("backgroundPause");
		pauseTitle			= content.getChildByName("pauseTitle");
		buttonContinue		= content.getChildByName("btnContinue");
		buttonQuit			= content.getChildByName("btnQuit");
		
		buttonContinue.addEventListener(MouseEvent.CLICK, onClickContinue);
		buttonQuit.addEventListener(MouseEvent.CLICK, onClickQuit);
		
		var lPositionnable:UIPositionable = { item:backgroundPause, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:pauseTitle, align:AlignType.TOP, offsetY:100};
		positionables.push(lPositionnable);
	}

	public static function getInstance (): Pause
	{
		if (instance == null) instance = new Pause();
		return instance;
	}

	private function onClickContinue(pEvent:MouseEvent) : Void
	{
		//resume le jeu
		SoundManager.getSound("click").start();
	}
	
	private function onClickQuit(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(TitleCard.getInstance());
		SoundManager.getSound("click").start();
	}

	override public function destroy (): Void
	{
		instance = null;
		buttonContinue.removeEventListener(MouseEvent.CLICK, onClickContinue);
		buttonQuit.removeEventListener(MouseEvent.CLICK, onClickQuit);
		super.destroy();
	}
}