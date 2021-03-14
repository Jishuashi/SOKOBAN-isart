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
class Options extends Screen 
{
	private static var instance: Options;
	private var backgroundOptions:DisplayObject;
	private var optionsTitle:DisplayObject;
	private var buttonKeyboard:DisplayObject;
	private var buttonMouse:DisplayObject;
	private var buttonFrench:DisplayObject;
	private var buttonEnglish:DisplayObject;
	private var buttonSoundOn:DisplayObject;
	private var buttonSoundOff:DisplayObject;
	private var buttonSmallWall:DisplayObject;
	private var buttonBigWall:DisplayObject;
	private var buttonBack:DisplayObject;

	private function new()
	{
		super();
		
		backgroundOptions		= content.getChildByName("backgroundOptions");
		optionsTitle			= content.getChildByName("optionsTitle");
		buttonKeyboard			= content.getChildByName("buttonKeyboard");
		buttonMouse				= content.getChildByName("buttonMouse");
		buttonFrench			= content.getChildByName("buttonFrench");
		buttonEnglish			= content.getChildByName("buttonEnglish");
		buttonSoundOn			= content.getChildByName("buttonSoundOn");
		buttonSoundOff			= content.getChildByName("buttonSoundOff");
		buttonSmallWall			= content.getChildByName("buttonSmallWall");
		buttonBigWall			= content.getChildByName("buttonBigWall");
		buttonBack				= content.getChildByName("btnBack");
		
		buttonBack.addEventListener(MouseEvent.CLICK, onClickBack);
		buttonSmallWall.addEventListener(MouseEvent.CLICK, onClickSmall);
		buttonBigWall.addEventListener(MouseEvent.CLICK, onClickBig);
		
		var lPositionnable:UIPositionable = { item:backgroundOptions, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:optionsTitle, align:AlignType.TOP};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBack, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonKeyboard, align:AlignType.TOP, offsetY:350};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonMouse, align:AlignType.TOP, offsetY:350};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonFrench, align:AlignType.TOP, offsetY:580};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonEnglish, align:AlignType.TOP, offsetY:580};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonSoundOn, align:AlignType.TOP, offsetY:810};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonSoundOff, align:AlignType.TOP, offsetY:810};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonSmallWall, align:AlignType.TOP, offsetY:1100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBigWall, align:AlignType.TOP, offsetY:1170};
		positionables.push(lPositionnable);
	}

	public static function getInstance (): Options
	{
		if (instance == null) instance = new Options();
		return instance;
	}

	private function onClickBack(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(Pause.getInstance());
		SoundManager.getSound("click").start();
	}
	
	private function onClickSmall(pEvent:MouseEvent) : Void
	{
		//implémenter les small wall
		SoundManager.getSound("click").start();
	}
	
	private function onClickBig(pEvent:MouseEvent) : Void
	{
		//implémenter les big wall
		SoundManager.getSound("click").start();
	}

	override public function destroy (): Void
	{
		instance = null;
		buttonBack.removeEventListener(MouseEvent.CLICK, onClickBack);
		buttonSmallWall.removeEventListener(MouseEvent.CLICK, onClickSmall);
		buttonBigWall.removeEventListener(MouseEvent.CLICK, onClickBig);
		super.destroy();
	}
}