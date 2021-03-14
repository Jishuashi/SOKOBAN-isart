package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;

	
/**
 * ...
 * @author Blanco
 */
class WinScreen extends Screen 
{
	private static var instance: WinScreen;
	private var backgroundVictory:DisplayObject;
	private var victoryTitle:DisplayObject;
	private var buttonContinue:DisplayObject;
	private var buttonQuit:DisplayObject;
	private var victoryAnimation:MovieClip;

	private function new()
	{
		super();
		
		backgroundVictory	= content.getChildByName("backgroundVictory");
		victoryTitle		= content.getChildByName("victoryTitle");
		buttonContinue		= content.getChildByName("btnContinue");
		buttonQuit			= content.getChildByName("btnQuit");
		victoryAnimation 	= cast(content.getChildByName("victoryAnimation"), MovieClip);
		
		buttonContinue.addEventListener(MouseEvent.CLICK, onClickContinue);
		buttonQuit.addEventListener(MouseEvent.CLICK, onClickQuit);
		
		var lPositionnable:UIPositionable = { item:backgroundVictory, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:victoryTitle, align:AlignType.TOP, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonContinue, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonQuit, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		victoryAnimation.
		//victoryAnimation.gotoAndStop(victoryAnimation.totalFrames);
	}

	public static function getInstance (): WinScreen
	{
		if (instance == null) instance = new WinScreen();
		return instance;
	}

	private function onClickContinue(pEvent:MouseEvent) : Void
	{
		//LevelManager.levelNum = LevelManager.currentLevel +1;
		//trace("next nevel is number " + LevelManager.currentLevel);
		//
		//LevelManager.selectLevel(LevelManager.levelNum);
		//
		//GameManager.start();
		
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