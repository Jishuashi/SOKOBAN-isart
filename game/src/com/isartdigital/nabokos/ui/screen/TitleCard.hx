package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.model.ScoreManager;
import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.utils.math.Color;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.UIPositionable;
import com.isartdigital.utils.ui.Screen;
import motion.Actuate;
import motion.easing.Cubic;
import motion.easing.Elastic;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import com.isartdigital.nabokos.ui.screen.Highscores;

/**
 * ...
 * @author Chadi Husser
 */
class TitleCard extends Screen
{
	private static var instance : TitleCard;
	private var backgroundTitle:DisplayObject;
	private var buttonPlay:DisplayObject;
	private var buttonHelp:DisplayObject;
	private var buttonHighscores:DisplayObject;
	private var btnCredits:DisplayObject;
	private var englishBtn:DisplayObject;
	private var frenchBtn:DisplayObject;
	private var soundOff:DisplayObject;
	private var soundOn:DisplayObject;
	
	private var txt: TextField;

	private function new()
	{
		super();
		
		backgroundTitle		= content.getChildByName("backgroundTitle");
		buttonPlay			= content.getChildByName("btnPlay");
		buttonHelp			= content.getChildByName("btnHelp");
		buttonHighscores	= content.getChildByName("btnHighscores");
		btnCredits			= content.getChildByName("btnCredits");
		englishBtn			= content.getChildByName("englishBtn");
		frenchBtn			= content.getChildByName("frenchBtn");
		soundOff			= content.getChildByName("soundOff");
		soundOn				= content.getChildByName("soundOn");
		
		buttonPlay.addEventListener(MouseEvent.CLICK, onClickPlay);
		buttonHelp.addEventListener(MouseEvent.CLICK, onClickHelp);
		buttonHighscores.addEventListener(MouseEvent.CLICK, onClickHighscores);
		btnCredits.addEventListener(MouseEvent.CLICK, onClickCredits);
		englishBtn.addEventListener(MouseEvent.CLICK, onClickEnglish);
		frenchBtn.addEventListener(MouseEvent.CLICK, onClickFrench);
		soundOff.addEventListener(MouseEvent.CLICK, onClickOff);
		soundOn.addEventListener(MouseEvent.CLICK, onClickOn);
		
		var lPositionnable:UIPositionable = { item:backgroundTitle, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonPlay, align:AlignType.BOTTOM, offsetY:150};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonHelp, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonHighscores, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:btnCredits, align:AlignType.TOP_RIGHT, offsetY:100, offsetX:350};
		positionables.push(lPositionnable);
		
		Actuate.tween (buttonPlay,	 		1, {y:1300}, false).reverse().ease(Cubic.easeIn);
		Actuate.tween (buttonHelp,	 		1.5, {x:1700}, false).reverse().ease(Cubic.easeIn);
		Actuate.tween (buttonHighscores,	1.5, {x:-1700}, false).reverse().ease(Cubic.easeIn);
		Actuate.tween (btnCredits,			2, {y:-1300}, false).reverse().ease(Cubic.easeIn);
	}

	public static function getInstance() : TitleCard
	{
		if (instance == null) instance = new TitleCard();
		return instance;
	}

	private function onClickPlay(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(LevelScreen.getInstance());
		SoundManager.clickSound();
	}

	private function onClickHelp(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(Help.getInstance());
		SoundManager.clickSound();
	}

	private function onClickHighscores(pEvent:MouseEvent) : Void
	{
		//Highscores.getInstance().initTextScore();
		UIManager.addScreen(Highscores.getInstance());
		SoundManager.clickSound();
	}
	
	private function onClickCredits(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(Credits.getInstance());
		SoundManager.clickSound();
	}
	
	private function onClickFrench(pEvent:MouseEvent) : Void
	{
		SoundManager.clickSound();
		Traduction.translateToFrench();
	}
	
	private function onClickEnglish(pEvent:MouseEvent) : Void
	{
		SoundManager.clickSound();
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
	
	public function translateButtonsTitleCard(pEnglish:Bool):Void
	{
		if (pEnglish){
			//buttonPlay.text = Traduction.getField("PLAY").en;
			trace ("english");
		} else{
			//buttonBack.text = Traduction.getField("PLAY").fr;
			trace ("french");
		}
	}

	override public function destroy():Void
	{
		instance = null;
		buttonPlay.removeEventListener(MouseEvent.CLICK, onClickPlay);
		buttonHelp.removeEventListener(MouseEvent.CLICK, onClickHelp);
		buttonHighscores.removeEventListener(MouseEvent.CLICK, onClickHighscores);
		btnCredits.removeEventListener(MouseEvent.CLICK, onClickCredits);
		super.destroy();
	}
}