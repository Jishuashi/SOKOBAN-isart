package com.isartdigital.nabokos.ui.screen;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.Screen;
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
	
	public static function getInstance (): TutorialHelpScreen {
		if (instance == null) instance = new TutorialHelpScreen();
		return instance;
	}
	
	private function new()
	{
		super();
		buttonArrow			= content.getChildByName("btnArrow");
		buttonArrow.addEventListener(MouseEvent.CLICK, onClickArrow);
	}
	
	private function onClickArrow(pEvent:MouseEvent) : Void
	{
		trace("tuto selected");
		
		LevelManager.levelNum = 0;
		
		LevelManager.selectLevel(LevelManager.levelNum);
		
		GameManager.start();
		SoundManager.getSound("click").start();
	}
	
	override public function destroy (): Void {
		instance = null;
		buttonArrow.removeEventListener(MouseEvent.CLICK, onClickArrow);
		super.destroy();
	}
}