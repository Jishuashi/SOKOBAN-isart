package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.GameManager;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.UIPositionable;
import com.isartdigital.utils.ui.Screen;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;

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
	private var buttonSound:DisplayObject;
	private var buttonLangues:DisplayObject;

	private function new()
	{
		super();
		backgroundTitle		= content.getChildByName("backgroundTitle");
		buttonPlay 			= content.getChildByName("btnPlay");
		buttonHelp			= content.getChildByName("btnHelp");
		buttonHighscores 	= content.getChildByName("btnHighscores");
		buttonSound			= content.getChildByName("btnSound");
		buttonLangues		= content.getChildByName("btnLangues");
		
		buttonPlay.addEventListener(MouseEvent.CLICK, onClickPlay);
		buttonHelp.addEventListener(MouseEvent.CLICK, onClickHelp);
		buttonHighscores.addEventListener(MouseEvent.CLICK, onClickHighscores);
		buttonSound.addEventListener(MouseEvent.CLICK, onClickSound);
		buttonLangues.addEventListener(MouseEvent.CLICK, onClickLangues);
		
		var lPositionnable:UIPositionable = { item:backgroundTitle, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonPlay, align:AlignType.BOTTOM, offsetY:150};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonHelp, align:AlignType.BOTTOM, offsetY:250};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonHighscores, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonSound, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLangues, align:AlignType.BOTTOM, offsetY:250};
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
		//GameManager.start();
		SoundManager.getSound("click").start();
	}

	private function onClickHelp(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(Help.getInstance());
		SoundManager.getSound("click").start();
	}

	private function onClickHighscores(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(Highscores.getInstance());
		SoundManager.getSound("click").start();
	}

	private function onClickSound(pEvent:MouseEvent) : Void
	{
		//changer le son
		SoundManager.getSound("click").start();
	}

	private function onClickLangues(pEvent:MouseEvent) : Void
	{
		//changer le json de langue
		SoundManager.getSound("click").start();
	}

	override public function destroy():Void
	{
		instance = null;
		buttonPlay.removeEventListener(MouseEvent.CLICK, onClickPlay);
		buttonHelp.removeEventListener(MouseEvent.CLICK, onClickHelp);
		buttonHighscores.removeEventListener(MouseEvent.CLICK, onClickHighscores);
		buttonSound.removeEventListener(MouseEvent.CLICK, onClickSound);
		buttonLangues.removeEventListener(MouseEvent.CLICK, onClickLangues);
		super.destroy();
	}
}