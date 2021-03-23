package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.nabokos.game.presenter.MouseController;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.game.view.RadarView;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import haxe.Timer;
import motion.Actuate;
import motion.easing.Elastic;
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
		
		Actuate.tween (buttonContinue, 1, {x:0, y: -140}).ease(Elastic.easeOut);
		Actuate.tween (buttonOptions, 1, {x:0, y:115}).ease(Elastic.easeOut);
		Actuate.tween (buttonQuit, 1, {x:0, y:380}).ease(Elastic.easeOut);
		
		Main.getInstance().game1.fadeOut(0.005);
		Timer.delay(function(){
			Main.getInstance().game1.stop();
		}, 500);
		Main.getInstance().ambiance1.start();
		Main.getInstance().ambiance1.fadeIn(0.005);
	}

	public static function getInstance (): Pause
	{
		if (instance == null) instance = new Pause();
		return instance;
	}

	private function onClickContinue(pEvent:MouseEvent) : Void
	{
		UIManager.closeScreens();
		Main.getInstance().ambiance1.fadeOut(0.005);
		Timer.delay(function(){
			Main.getInstance().ambiance1.stop();
		}, 500);
		Main.getInstance().game1.start();
		Main.getInstance().game1.fadeIn(0.005);
		
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
		IsoView.getInstance().resetView();
		RadarView.getInstance().resetView();
		GameManager.mouseController.destroy();
		
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