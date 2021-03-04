package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldType;

	
/**
 * ...
 * @author Blanco
 */
class LoginScreen extends Screen 
{
	private static var instance: LoginScreen;
	private var errorText:TextField;
	private var mdpText:TextField;
	private var backgroundLogin:DisplayObject;
	private var buttonEnter:DisplayObject;
	private var loginTitle:DisplayObject;
	public var pseudo(get, null):String;

	private function new()
	{
		super();
		
		backgroundLogin		= content.getChildByName("backgroundLogin");
		buttonEnter			= content.getChildByName("btnEnter");		
		errorText 			= cast(content.getChildByName("errorTextField"), TextField);
		mdpText 			= cast(content.getChildByName("mdpText"), TextField);
		mdpText.text = "pseudo";
		mdpText.type = TextFieldType.INPUT;
		mdpText.selectable = true;
		mdpText.maxChars = 12;
		mdpText.restrict = "A-Z a-z 0-9";
		
		buttonEnter.addEventListener(MouseEvent.CLICK, onClickEnter);
		
		var lPositionnable:UIPositionable = { item:backgroundLogin, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
	}
	
	public static function getInstance (): LoginScreen
	{
		if (instance == null) instance = new LoginScreen();
		return instance;
	}
	
	private function get_pseudo():String
	{
		return mdpText.text;
	}
	
	private function onClickEnter(pEvent:MouseEvent) : Void
	{
		if (mdpText.length >= 3)
		{
			trace (pseudo);
			UIManager.addScreen(TitleCard.getInstance());
			SoundManager.getSound("click").start();
		}
		else errorText.text = "password too short";
	}

	override public function destroy (): Void
	{
		instance = null;
		buttonEnter.removeEventListener(MouseEvent.CLICK, onClickEnter);
		super.destroy();
	}
}