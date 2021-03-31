package com.isartdigital.nabokos.ui.screen;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import motion.Actuate;
import motion.easing.Elastic;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.display.SimpleButton;
import openfl.events.MouseEvent;
import openfl.text.TextField;
	
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
	
	private var textBackUp:TextField;
	private var textBackDown:TextField;

	private function new()
	{
		super();
		
		backgroundOptions		= content.getChildByName("backgroundOptions");
		optionsTitle			= content.getChildByName("optionsTitle");
		buttonFrench			= content.getChildByName("buttonFrench");
		buttonEnglish			= content.getChildByName("buttonEnglish");
		buttonSoundOn			= content.getChildByName("buttonSoundOn");
		buttonSoundOff			= content.getChildByName("buttonSoundOff");
		buttonBack				= content.getChildByName("btnBack");
		
		textBackUp = Traduction.getTextUp(buttonBack);
		textBackDown = Traduction.getTextOver(buttonBack);
		
		buttonBack.addEventListener(MouseEvent.CLICK, onClickBack);
		buttonFrench.addEventListener(MouseEvent.CLICK, onClickFrench);
		buttonEnglish.addEventListener(MouseEvent.CLICK, onClickEnglish);
		buttonSoundOn.addEventListener(MouseEvent.CLICK, onClickOn);
		buttonSoundOff.addEventListener(MouseEvent.CLICK, onClickOff);
		
		var lPositionnable:UIPositionable = { item:backgroundOptions, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:optionsTitle,	 align:AlignType.TOP};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBack,		 align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		
		Actuate.tween (buttonFrench,	1, {x:-215, y:-160}).ease(Elastic.easeOut);
		Actuate.tween (buttonEnglish,	1, {x:215, y:-160}).ease(Elastic.easeOut);
		Actuate.tween (buttonSoundOn,	1, {x:-215, y:50}).ease(Elastic.easeOut);
		Actuate.tween (buttonSoundOff,	1, {x:215, y:50}).ease(Elastic.easeOut);
		
		//translateButtonsOption(Traduction.english);
	}

	public static function getInstance (): Options
	{
		if (instance == null) instance = new Options();
		return instance;
	}

	private function onClickBack(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(Pause.getInstance());
		SoundManager.clickSound();
	}
	
	private function onClickFrench(pEvent:MouseEvent) : Void
	{
		SoundManager.clickSound();
		Traduction.english = false;
		Traduction.translateToFrench();
	}
	
	private function onClickEnglish(pEvent:MouseEvent) : Void
	{
		SoundManager.clickSound();
		Traduction.english = true;
		Traduction.translateToEnglish();
	}
	
	private function onClickOn(pEvent:MouseEvent) : Void
	{
		SoundManager.mainVolume = 0.5;
		Main.getInstance().ambiance1.loop();
	}
	
	private function onClickOff(pEvent:MouseEvent) : Void
	{
		SoundManager.mainVolume = 0;
	}
	
	//public function translateButtonsOption(pEnglish:Bool):Void
	//{
		//if (pEnglish){
			//textBackUp.text = Traduction.getField("BACK").en;
			//textBackDown.text = Traduction.getField("BACK").en;
		//} else{
			//textBackUp.text = Traduction.getField("BACK").fr;
			//textBackDown.text = Traduction.getField("BACK").fr;
		//}
	//}
	
	override public function destroy (): Void
	{
		instance = null;
		buttonBack.removeEventListener(MouseEvent.CLICK, onClickBack);
		buttonFrench.removeEventListener(MouseEvent.CLICK, onClickFrench);
		buttonEnglish.removeEventListener(MouseEvent.CLICK, onClickEnglish);
		buttonSoundOn.removeEventListener(MouseEvent.CLICK, onClickOn);
		buttonSoundOff.removeEventListener(MouseEvent.CLICK, onClickOff);
		super.destroy();
	}
}