package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.presenter.GameManager;
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
	private var buttonOptions:DisplayObject;
	private var buttonQuit:DisplayObject;

	private function new()
	{
		super();
		
		backgroundPause		= content.getChildByName("backgroundPause");
		pauseTitle			= content.getChildByName("pauseTitle");
		buttonContinue		= content.getChildByName("btnContinue");
		buttonOptions		= content.getChildByName("btnOptions");
		buttonQuit			= content.getChildByName("btnQuit");
		
		buttonContinue.addEventListener(MouseEvent.CLICK, onClickContinue);
		buttonOptions.addEventListener(MouseEvent.CLICK, onClickOptions);
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
		UIManager.closeScreens();
		Hud.getInstance().visible = true;
		SoundManager.getSound("click").start();
	}
	
	private function onClickOptions(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(Options.getInstance());
		SoundManager.getSound("click").start();
	}
	
	private function onClickQuit(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(TitleCard.getInstance());
		UIManager.closeHud();
		SoundManager.getSound("click").start();
	}

	override public function destroy (): Void
	{
		instance = null;
		buttonContinue.removeEventListener(MouseEvent.CLICK, onClickContinue);
		buttonOptions.removeEventListener(MouseEvent.CLICK, onClickOptions);
		buttonQuit.removeEventListener(MouseEvent.CLICK, onClickQuit);
		super.destroy();
	}
}