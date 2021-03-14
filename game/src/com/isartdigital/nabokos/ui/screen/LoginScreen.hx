package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import openfl.display.DisplayObject;
import openfl.display.SimpleButton;
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
	//private var pseudoButton:DisplayObject;
	public var pseudo(get, null):String;

	private function new()
	{
		super();
		
		backgroundLogin		= content.getChildByName("backgroundLogin");
		loginTitle			= content.getChildByName("loginTitle");
		buttonEnter			= content.getChildByName("btnEnter");
		//pseudoButton		= content.getChildByName("btnPseudo");
		errorText 			= cast(content.getChildByName("errorTextField"), TextField);
		mdpText 			= cast(content.getChildByName("mdpText"), TextField);
		mdpText.text = "pseudo";
		mdpText.type = TextFieldType.INPUT;
		mdpText.selectable = true;
		mdpText.maxChars = 12;
		mdpText.restrict = "A-Z a-z 0-9";
		
		buttonEnter.addEventListener(MouseEvent.CLICK, onClickEnter);
		//pseudoButton.addEventListener(MouseEvent.CLICK, onClickPseudo);
		
		var lPositionnable:UIPositionable = { item:backgroundLogin, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:loginTitle, align:AlignType.TOP, offsetY:100};
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
	
	//private function onClickPseudo(pEvent:MouseEvent) : Void
	//{
		//mdpText.text = "";
	//}

	override public function destroy (): Void
	{
		instance = null;
		buttonEnter.removeEventListener(MouseEvent.CLICK, onClickEnter);
		//pseudoButton.removeEventListener(MouseEvent.CLICK, onClickPseudo);
		super.destroy();
	}
}