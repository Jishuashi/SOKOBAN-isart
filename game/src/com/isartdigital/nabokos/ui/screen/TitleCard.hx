package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.model.ScoreManager;
import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.utils.math.Color;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.UIPositionable;
import com.isartdigital.utils.ui.Screen;
import motion.Actuate;
import motion.easing.Elastic;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;

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
	//private var modifiedPlayText:TextField;

	private function new()
	{
		super();
		
		backgroundTitle		= content.getChildByName("backgroundTitle");
		buttonPlay 			= content.getChildByName("btnPlay");
		buttonHelp			= content.getChildByName("btnHelp");
		buttonHighscores 	= content.getChildByName("btnHighscores");
		
		buttonPlay.addEventListener(MouseEvent.CLICK, onClickPlay);
		buttonHelp.addEventListener(MouseEvent.CLICK, onClickHelp);
		buttonHighscores.addEventListener(MouseEvent.CLICK, onClickHighscores);
		
		var lPositionnable:UIPositionable = { item:backgroundTitle, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonPlay, align:AlignType.BOTTOM, offsetY:150};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonHelp, align:AlignType.BOTTOM_RIGHT, offsetY:100, offsetX:500};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonHighscores, align:AlignType.BOTTOM_LEFT, offsetY:100, offsetX:500};
		positionables.push(lPositionnable);
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
		UIManager.addScreen(Highscores.getInstance());
		SoundManager.clickSound();
	}

	override public function destroy():Void
	{
		instance = null;
		buttonPlay.removeEventListener(MouseEvent.CLICK, onClickPlay);
		buttonHelp.removeEventListener(MouseEvent.CLICK, onClickHelp);
		buttonHighscores.removeEventListener(MouseEvent.CLICK, onClickHighscores);
		super.destroy();
	}
}