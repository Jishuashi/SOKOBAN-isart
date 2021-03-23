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
class Help extends Screen
{
	private static var instance: Help;
	private var backgroundHelp:DisplayObject;
	private var helpTitle:DisplayObject;
	private var buttonBack:DisplayObject;
	private var help1:DisplayObject;
	private var arrow1:DisplayObject;
	private var help2:DisplayObject;
	private var arrow2:DisplayObject;
	private var help3:DisplayObject;

	private function new()
	{
		super();
		
		backgroundHelp		= content.getChildByName("backgroundHelp");
		helpTitle			= content.getChildByName("helpTitle");
		buttonBack			= content.getChildByName("btnBack");
		help1				= content.getChildByName("help1");
		arrow1				= content.getChildByName("arrow1");
		help2				= content.getChildByName("help2");
		arrow2				= content.getChildByName("arrow2");
		help3				= content.getChildByName("help3");
		
		buttonBack.addEventListener(MouseEvent.CLICK, onClickBack);
		
		var lPositionnable:UIPositionable = { item:backgroundHelp, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:helpTitle, align:AlignType.TOP, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBack, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		
		help1 .alpha = 0;
		arrow1.alpha = 0;
		help2 .alpha = 0;
		arrow2.alpha = 0;
		help3 .alpha = 0;
		
		Actuate.tween (buttonBack, 		0.5, {x:0, y:600}).ease(Elastic.easeOut);
		Actuate.tween (helpTitle,		0.5, {alpha:0}).reverse();
		Actuate.tween (help1,			1, {alpha:1});
		Actuate.tween (arrow1,			1, {alpha:1}).delay(1);
		Actuate.tween (help2,			1, {alpha:1}).delay(2);
		Actuate.tween (arrow2,			1, {alpha:1}).delay(3);
		Actuate.tween (help3,			1, {alpha:1}).delay(4);
	}

	public static function getInstance (): Help
	{
		if (instance == null) instance = new Help();
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