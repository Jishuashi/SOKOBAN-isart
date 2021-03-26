package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.model.SaveStorage;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIComponent;
import com.isartdigital.utils.ui.UIPositionable;
import motion.Actuate;
import openfl.display.DisplayObject;
import openfl.display.SimpleButton;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.ui.Keyboard;

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
	private var pseudoBox:DisplayObject;
	public var pseudo(get, null):String;
	
	public var pseudoList: Array<String> = new Array<String>();

	private function new()
	{
		super();
		
		buttonEnter		= content.getChildByName("btnEnter");
		backgroundLogin	= content.getChildByName("backgroundLogin");
		loginTitle		= content.getChildByName("loginTitle");
		pseudoBox		= content.getChildByName("pseudoBox");
		
		errorText	= cast(content.getChildByName("errorTextField"), TextField);
		mdpText 	= cast(content.getChildByName("mdpText"), TextField);
		mdpText.text = "pseudo";
		mdpText.type = TextFieldType.INPUT;
		mdpText.selectable = true;
		mdpText.maxChars = 12;
		mdpText.restrict = "A-Z a-z 0-9";
		
		LevelManager.bigWallOn = false;
		
		mdpText.addEventListener(MouseEvent.CLICK, onClickPseudo);
		buttonEnter.addEventListener(MouseEvent.CLICK, onClickEnter);
		addEventListener(KeyboardEvent.KEY_DOWN, onClickEnterKeyboard);
		
		var lPositionnable:UIPositionable = { item:backgroundLogin, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:loginTitle, align:AlignType.TOP, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonEnter, align:AlignType.BOTTOM, offsetY:500};
		positionables.push(lPositionnable);
		
		Actuate.tween (loginTitle,	 0.5, {alpha:0}).reverse();
		Actuate.tween (buttonEnter,	 0.5, {alpha:0}).reverse();
		Actuate.tween (pseudoBox,	 0.5, {alpha:0}).reverse();
		Actuate.tween (mdpText,		 0.5, {alpha:0}).reverse();
	}

	public static function getInstance (): LoginScreen
	{
		if (instance == null) instance = new LoginScreen();
		return instance;
	}

	private function addButton(pButton:String, pCallback:MouseEvent->Void, pAlignType:AlignType, pOffsetY:Int=0, pOffsetX:Int = 0) :Void
	{
		var lButton:DisplayObject = content.getChildByName(pButton);
		lButton.addEventListener(MouseEvent.CLICK, pCallback);
		var lPositionnable:UIPositionable = { item:lButton, align:pAlignType, offsetY:pOffsetY, offsetX:pOffsetX};
		positionables.push(lPositionnable);
	}

	private function addPositionnable(pPositionnable:String, pAlignType:AlignType, pOffsetY:Int = 0, pOffsetX:Int = 0) :Void
	{
		var pPositionnable:DisplayObject = content.getChildByName(pPositionnable);
		var lPositionnable:UIPositionable = { item:pPositionnable, align:pAlignType, offsetY:pOffsetY, offsetX:pOffsetX};
		positionables.push(lPositionnable);
	}

	public function get_pseudo():String
	{
		return mdpText.text;
	}

	private function onClickEnter(pEvent:MouseEvent) : Void
	{
		if (mdpText.length >= 3)
		{
			trace (pseudo);
			UIManager.addScreen(TitleCard.getInstance());
			SoundManager.clickSound();
			SaveStorage.getInstance().initStorage(pseudo);
		}
		else errorText.text = "password too short";
	}
	
	private function onClickEnterKeyboard(pEvent:KeyboardEvent) : Void
	{
		if (pEvent.keyCode == Keyboard.ENTER)
		{
			if (mdpText.length >= 3)
			{
				trace (pseudo);
				UIManager.addScreen(TitleCard.getInstance());
				SoundManager.clickSound();
				SaveStorage.getInstance().initStorage(pseudo);
			}
			else errorText.text = "password too short";
		}
	}

	private function onClickPseudo(pEvent:MouseEvent) : Void
	{
		mdpText.text = "";
	}

	override public function destroy (): Void
	{
		instance = null;
		mdpText.removeEventListener(MouseEvent.CLICK, onClickPseudo);
		buttonEnter.removeEventListener(MouseEvent.CLICK, onClickEnter);
		removeEventListener(KeyboardEvent.KEY_DOWN, onClickEnterKeyboard);
		super.destroy();
	}
}