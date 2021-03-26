package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;
import openfl.text.TextField;

	
/**
 * ...
 * @author Blanco
 */
class FinalWin extends Screen 
{
	private static var instance: FinalWin;
	private var backgroundFinalWin:DisplayObject;
	private var FinalWinTitle:DisplayObject;
	private var btnHighscores:DisplayObject;
	private var btnMenu:DisplayObject;
	private var totalStars:TextField;

	private function new()
	{
		super();
		
		backgroundFinalWin	= content.getChildByName("backgroundFinalWin");
		FinalWinTitle		= content.getChildByName("FinalWinTitle");
		btnHighscores		= content.getChildByName("btnHighscores");
		btnMenu				= content.getChildByName("btnMenu");
		totalStars			= cast(content.getChildByName("totalStars"), TextField);
		
		btnHighscores.addEventListener(MouseEvent.CLICK, onClickHighscores);
		btnMenu.addEventListener(MouseEvent.CLICK, onClickMenu);
		
		var lPositionnable:UIPositionable = { item:backgroundFinalWin, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:FinalWinTitle, align:AlignType.TOP};
		positionables.push(lPositionnable);
		
		FinalWinTitle.alpha = 0;
		totalStars .alpha = 0;
		btnHighscores.alpha = 0;
		btnMenu .alpha = 0;
		
		Actuate.tween (FinalWinTitle,		1, {alpha:1});
		Actuate.tween (totalStars,			1, {alpha:1});
		Actuate.tween (btnHighscores,		1, {alpha:1});
		Actuate.tween (btnMenu,				1, {alpha:1});
	}

	public static function getInstance (): FinalWin
	{
		if (instance == null) instance = new FinalWin();
		return instance;
	}

	private function onClickHighscores(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(Highscores.getInstance());
		SoundManager.clickSound();
	}
	
	private function onClickMenu(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(TitleCard.getInstance());
		SoundManager.clickSound();
	}

	override public function destroy (): Void
	{
		instance = null;
		btnHighscores.removeEventListener(MouseEvent.CLICK, onClickHighscores);
		btnMenu.removeEventListener(MouseEvent.CLICK, onClickMenu);
		super.destroy();
	}
}