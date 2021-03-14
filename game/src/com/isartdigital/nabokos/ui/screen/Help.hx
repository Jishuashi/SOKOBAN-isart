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
class Help extends Screen
{
	private static var instance: Help;
	private var backgroundHelp:DisplayObject;
	private var helpTitle:DisplayObject;
	private var buttonBack:DisplayObject;

	private function new()
	{
		super();
		
		backgroundHelp		= content.getChildByName("backgroundHelp");
		helpTitle			= content.getChildByName("helpTitle");
		buttonBack			= content.getChildByName("btnBack");
		
		buttonBack.addEventListener(MouseEvent.CLICK, onClickBack);
		
		var lPositionnable:UIPositionable = { item:backgroundHelp, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:helpTitle, align:AlignType.TOP, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBack, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
	}

	public static function getInstance (): Help
	{
		if (instance == null) instance = new Help();
		return instance;
	}

	private function onClickBack(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(TitleCard.getInstance());
		SoundManager.getSound("click").start();
	}

	override public function destroy (): Void
	{
		instance = null;
		buttonBack.removeEventListener(MouseEvent.CLICK, onClickBack);
		super.destroy();
	}
}