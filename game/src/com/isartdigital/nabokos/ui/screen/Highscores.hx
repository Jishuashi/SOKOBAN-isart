package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import motion.Actuate;
import motion.easing.Elastic;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;
import openfl.text.TextField;

/**
 * ...
 * @author Blanco
 */
class Highscores extends Screen
{
	private static var instance: Highscores;
	private var backgroundHighscores:DisplayObject;
	private var highscoresTitle:DisplayObject;
	private var buttonBack:DisplayObject;

	public static var score1 : TextField;
	public static var score2 : TextField;
	public static var score3 : TextField;
	public static var score4 : TextField;
	public static var score5 : TextField;
	public static var score6 : TextField;
	public static var score7 : TextField;
	public static var score8 : TextField;
	public static var score9 : TextField;
	public static var score10 : TextField;
	public static var score11 : TextField;
	
	public static var highscoreList : Array<Int> = new Array<Int>();
	
	private function new()
	{
		super();

		backgroundHighscores	= content.getChildByName("backgroundHighscores");
		highscoresTitle			= content.getChildByName("highscoresTitle");
		buttonBack				= content.getChildByName("btnBack");

		score1				= cast (content.getChildByName("score1"), TextField);
		score2				= cast (content.getChildByName("score2"), TextField);
		score3				= cast (content.getChildByName("score3"), TextField);
		score4				= cast (content.getChildByName("score4"), TextField);
		score5				= cast (content.getChildByName("score5"), TextField);
		score6				= cast(content.getChildByName("score6"), TextField);
		score7				= cast (content.getChildByName("score7"), TextField);
		score8				= cast(content.getChildByName("score8"), TextField);
		score9				= cast(content.getChildByName("score9"), TextField);
		score10				= cast(content.getChildByName("score10"), TextField);
		score11				= cast(content.getChildByName("score11"), TextField);

		buttonBack.addEventListener(MouseEvent.CLICK, onClickBack);

		var lPositionnable:UIPositionable = { item:backgroundHighscores, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:highscoresTitle, align:AlignType.TOP};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBack, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
	}

	public static function getInstance (): Highscores
	{
		if (instance == null) instance = new Highscores();
		return instance;
	}

	private function onClickBack(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(TitleCard.getInstance());
		SoundManager.clickSound();
	}

	override public function destroy (): Void
	{
		instance = null;
		buttonBack.removeEventListener(MouseEvent.CLICK, onClickBack);
		super.destroy();
	}

}