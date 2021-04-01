package com.isartdigital.nabokos.ui.screen;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import openfl.events.MouseEvent;
import openfl.display.DisplayObject;

	
/**
 * ...
 * @author Blanco
 */
class TutorialHelpScreen extends Screen 
{
	private static var instance: TutorialHelpScreen;
	private var buttonArrow:DisplayObject;
	private var backgroundHelp:DisplayObject;
	
	public static function getInstance (): TutorialHelpScreen {
		if (instance == null) instance = new TutorialHelpScreen();
		return instance;
	}
	
	private function new()
	{
		super();
		backgroundHelp		= content.getChildByName("backgroundHelp");
		buttonArrow			= content.getChildByName("btnArrow");
		buttonArrow.addEventListener(MouseEvent.CLICK, onClickArrow);
		var lPositionnable:UIPositionable = { item:backgroundHelp, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
	}
	
	private function onClickArrow(pEvent:MouseEvent) : Void
	{
		LevelManager.levelNum = 0;
		
		LevelManager.selectLevel(LevelManager.levelNum);
		
		GameManager.start();
		SoundManager.clickSound();
	}
	
	override public function destroy (): Void {
		instance = null;
		buttonArrow.removeEventListener(MouseEvent.CLICK, onClickArrow);
		super.destroy();
	}
}