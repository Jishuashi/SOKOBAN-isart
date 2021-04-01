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
	
	private var txtPlayUp: TextField;
	private var txtPlayOver: TextField;
	
	private var txtHelpUp: TextField;
	private var txtHelpOver: TextField;
	
	private var txtHighScoreUp: TextField;
	private var txtHighScoreOver: TextField;

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
		
		txtPlayUp = Traduction.getTextUp(buttonPlay);
		txtPlayOver = Traduction.getTextOver(buttonPlay);
		
		txtHelpUp = Traduction.getTextUp(buttonHelp);
		txtHelpOver = Traduction.getTextOver(buttonHelp);
		
		txtHighScoreUp = Traduction.getTextUp(buttonHighscores);
		txtHighScoreOver = Traduction.getTextOver(buttonHighscores);
		
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
		Actuate.tween (btnCredits,			2, {y: -1300}, false).reverse().ease(Cubic.easeIn);
		
		translateButtonsTitleCard(Traduction.english);
		
		if (GameManager.soundOn) {
			soundOn.alpha = 1;
			soundOff.alpha = 0;
		}
		else{
			soundOn.alpha = 0;
			soundOff.alpha = 1;
		}
		if (GameManager.englishOn) {
			englishBtn.alpha = 1;
			frenchBtn.alpha = 0;
		}
		else{
			englishBtn.alpha = 0;
			frenchBtn.alpha = 1;
		}
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
	
	private function onClickEnglish(pEvent:MouseEvent) : Void
	{
		SoundManager.clickSound();
		Traduction.english = false;
		Traduction.translateToFrench();
		frenchBtn.alpha = 1;
		englishBtn.alpha = 0;
		GameManager.englishOn = false;
	}
	
	private function onClickFrench(pEvent:MouseEvent) : Void
	{
		SoundManager.clickSound();
		Traduction.english = true;
		Traduction.translateToEnglish();
		frenchBtn.alpha = 0;
		englishBtn.alpha = 1;
		GameManager.englishOn = true;
	}
	
	private function onClickOff(pEvent:MouseEvent) : Void
	{
		SoundManager.mainVolume = 0.5;
		Main.getInstance().ambiance1.loop();
		soundOn.alpha = 1;
		soundOff.alpha = 0;
		GameManager.soundOn = true;
	}
	
	private function onClickOn(pEvent:MouseEvent) : Void
	{
		SoundManager.mainVolume = 0;
		soundOn.alpha = 0;
		soundOff.alpha = 1;
		GameManager.soundOn = false;
	}
	
	public function translateButtonsTitleCard(pEnglish:Bool):Void
	{
		if (pEnglish){
			txtPlayUp.text = Traduction.getField("PLAY").en;
			txtPlayOver.text = Traduction.getField("PLAY").en;
			
			txtHelpUp.text = Traduction.getField("HELP").en;
			txtHelpOver.text = Traduction.getField("HELP").en;
			
			txtHighScoreUp.text = Traduction.getField("RANKING").en;
			txtHighScoreOver.text = Traduction.getField("RANKING").en;
		} else{
			txtPlayUp.text = Traduction.getField("PLAY").fr;
			txtPlayOver.text = Traduction.getField("PLAY").fr;
			
			txtHelpUp.text = Traduction.getField("HELP").fr;
			txtHelpOver.text = Traduction.getField("HELP").fr;
			
			txtHighScoreUp.text = Traduction.getField("RANKING").fr;
			txtHighScoreOver.text = Traduction.getField("RANKING").fr;
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