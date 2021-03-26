package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import motion.Actuate;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;

	
/**
 * ...
 * @author Blanco
 */
class Credits extends Screen 
{
	private static var instance: Credits;
	private var backgroundCredits:DisplayObject;
	private var CreditsTitle:DisplayObject;
	private var GameProgrammers:DisplayObject;
	private var Anthony:DisplayObject;
	private var Denis:DisplayObject;
	private var Hugo:DisplayObject;
	private var Louis:DisplayObject;
	private var Garance:DisplayObject;
	private var Musics:DisplayObject;
	private var son1:DisplayObject;
	private var son2:DisplayObject;
	private var source:DisplayObject;
	
	private function new()
	{
		super();
		backgroundCredits		= content.getChildByName("backgroundCredits");
		CreditsTitle			= content.getChildByName("CreditsTitle");
		GameProgrammers			= content.getChildByName("GameProgrammers");
		Anthony					= content.getChildByName("Anthony");
		Denis					= content.getChildByName("Denis");
		Hugo					= content.getChildByName("Hugo");
		Louis					= content.getChildByName("Louis");
		Garance					= content.getChildByName("Garance");
		Musics					= content.getChildByName("Musics");
		son1					= content.getChildByName("son1");
		son2					= content.getChildByName("son2");
		source					= content.getChildByName("source");
		
		addEventListener(MouseEvent.CLICK, onClickNext);
		
		var lPositionnable:UIPositionable = { item:backgroundCredits, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:CreditsTitle, align:AlignType.TOP};
		positionables.push(lPositionnable);
		
		CreditsTitle .alpha = 0;
		GameProgrammers.alpha = 0;
		Anthony .alpha = 0;
		Denis.alpha = 0;
		Hugo .alpha = 0;
		Louis .alpha = 0;
		Garance .alpha = 0;
		Musics .alpha = 0;
		son1 .alpha = 0;
		son2 .alpha = 0;
		source .alpha = 0;
		
		Actuate.tween (CreditsTitle,	0.5, {alpha:1});
		Actuate.tween (GameProgrammers,	0.5, {alpha:1}).delay(0.5);
		Actuate.tween (Anthony,	 		0.5, {alpha:1}).delay(1);
		Actuate.tween (Denis,			0.5, {alpha:1}).delay(1.5);
		Actuate.tween (Hugo,			0.5, {alpha:1}).delay(2);
		Actuate.tween (Louis,			0.5, {alpha:1}).delay(2.5);
		Actuate.tween (Garance,			0.5, {alpha:1}).delay(3);
		Actuate.tween (Musics,			0.5, {alpha:1}).delay(3.5);
		Actuate.tween (son1,			0.5, {alpha:1}).delay(4);
		Actuate.tween (son2,			0.5, {alpha:1}).delay(4.5);
		Actuate.tween (source,			0.5, {alpha:1}).delay(5);
	}
	
	public static function getInstance (): Credits {
		if (instance == null) instance = new Credits();
		return instance;
	}
	
	private function onClickNext(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(TitleCard .getInstance());
		SoundManager.clickSound();
	}
	
	override public function destroy (): Void {
		instance = null;
		removeEventListener(MouseEvent.CLICK, onClickNext);
		super.destroy();
	}
}