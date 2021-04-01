package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import motion.Actuate;
import motion.easing.Cubic;
import motion.easing.Elastic;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.text.TextField;

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
	
	private var txtTitle: TextField;
	private var txtHelp1: TextField;
	private var txtHelp2: TextField;
	private var txtHelp3: TextField;
	
	private var txtBackUp: TextField;
	private var txtBackOver: TextField; 

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
		
		var lIntermediaire: DisplayObjectContainer = cast(helpTitle, DisplayObjectContainer);
		txtTitle = cast(lIntermediaire.getChildAt(0), TextField);
		txtHelp1 = Traduction.getTextHelp(help1);
		txtHelp2 = Traduction.getTextHelp(help2);
		txtHelp3 = Traduction.getTextHelp(help3);
		
		txtBackUp = Traduction.getTextUp(buttonBack);
		txtBackOver = Traduction.getTextOver(buttonBack);
		
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
		
		Actuate.tween (buttonBack,	 	0.5, {x:0, y:850}, false).reverse().ease(Cubic.easeIn);
		Actuate.tween (helpTitle,	 	0.5, {x:0, y:-950}, false).reverse().ease(Cubic.easeIn);
		Actuate.tween (help1,			1, {alpha:1});
		Actuate.tween (arrow1,			1, {alpha:1}).delay(0.5);
		Actuate.tween (help2,			1, {alpha:1}).delay(1);
		Actuate.tween (arrow2,			1, {alpha:1}).delay(1.5);
		Actuate.tween (help3,			1, {alpha:1}).delay(2);
		
		translateButtonsHelp(Traduction.english);
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

	public function translateButtonsHelp(pEnglish:Bool):Void
	{
		if (pEnglish){
			txtTitle.text = Traduction.getField("HELP").en;
			txtHelp1.text = Traduction.getField("HELP1").en;
			txtHelp2.text = Traduction.getField("HELP2").en;
			txtHelp3.text = Traduction.getField("HELP3").en;
			
			txtBackUp.text = Traduction.getField("BACK").en;
			txtBackOver.text = Traduction.getField("BACK").en;
		} else{
			txtTitle.text = Traduction.getField("HELP").fr;
			txtHelp1.text = Traduction.getField("HELP1").fr;
			txtHelp2.text = Traduction.getField("HELP2").fr;
			txtHelp3.text = Traduction.getField("HELP3").fr;
			
			txtBackUp.text = Traduction.getField("BACK").fr;
			txtBackOver.text = Traduction.getField("BACK").fr;
		}
	}
	
	override public function destroy (): Void
	{
		instance = null;
		buttonBack.removeEventListener(MouseEvent.CLICK, onClickBack);
		super.destroy();
	}
}