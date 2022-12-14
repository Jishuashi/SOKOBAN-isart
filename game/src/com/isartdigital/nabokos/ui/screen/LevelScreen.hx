package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import com.isartdigital.nabokos.ui.screen.TutorialHelpScreen;
import motion.Actuate;
import openfl.display.DisplayObject;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;

/**
 * ...
 * @author Blanco
 */
class LevelScreen extends Screen
{
	private static var instance: LevelScreen;
	private var backgroundLevel:DisplayObject;
	private var buttonBack:DisplayObject;
	private var levelTitle:DisplayObject;
	private var buttonTuto:DisplayObject;
	private var buttonLvl1:DisplayObject;
	private var buttonLvl2:DisplayObject;
	private var buttonLvl3:DisplayObject;
	private var buttonLvl4:DisplayObject;
	private var buttonLvl5:DisplayObject;
	private var buttonLvl6:DisplayObject;
	private var buttonLvl7:DisplayObject;
	private var buttonLvl8:DisplayObject;
	private var buttonLvl9:DisplayObject;
	private var buttonLvl10:DisplayObject;
	private var buttonLvl11:DisplayObject;
	private var buttonLvl12:DisplayObject;
	private var unlockBtn:DisplayObject;
	
	private var txtTutoUp:TextField;
	private var txtTutoDown:TextField;
	
	private var txtBackUp: TextField;
	private var txtBackDown: TextField;

	private var textUpArray: Array<TextField>;
	private var textDownArray: Array<TextField>;

	private var lockDisplayList: Array<LockedLevel>;
	
	private var levelIndex : Int;
	private static var lock : Array<Bool> = new Array<Bool>();
	static inline var LEVEL_NB:Float = 12;

	public static var levelCompleteList : Array<Bool> = new Array<Bool>();
	public static var levelCompleteCheck : Bool;

	private function new()
	{
		super();

		backgroundLevel		= content.getChildByName("backgroundLevel");
		buttonBack			= content.getChildByName("btnBack");
		levelTitle			= content.getChildByName("levelTitle");
		buttonTuto			= content.getChildByName("btnTuto");
		buttonLvl1			= content.getChildByName("btnLvl1");
		buttonLvl2			= content.getChildByName("btnLvl2");
		buttonLvl3			= content.getChildByName("btnLvl3");
		buttonLvl4			= content.getChildByName("btnLvl4");
		buttonLvl5			= content.getChildByName("btnLvl5");
		buttonLvl6			= content.getChildByName("btnLvl6");
		buttonLvl7			= content.getChildByName("btnLvl7");
		buttonLvl8			= content.getChildByName("btnLvl8");
		buttonLvl9			= content.getChildByName("btnLvl9");
		buttonLvl10			= content.getChildByName("btnLvl10");
		buttonLvl11			= content.getChildByName("btnLvl11");
		buttonLvl12			= content.getChildByName("btnLvl12");
		unlockBtn			= content.getChildByName("unlockBtn");
		
		textUpArray = new Array<TextField>();
		textDownArray = new Array<TextField>();
		
		txtTutoUp = Traduction.getTextUp(buttonTuto);
		txtTutoDown = Traduction.getTextOver(buttonTuto);
		trace (txtTutoDown.text, txtTutoUp.text, "tuto text");
		
		txtBackUp = Traduction.getTextUp(buttonBack);
		txtBackDown = Traduction.getTextOver(buttonBack);
		trace (txtBackDown.text,txtBackUp.text , "text Back");
		
		textUpArray.push(Traduction.getTextUp(buttonLvl1));
		textUpArray.push(Traduction.getTextUp(buttonLvl2));
		textUpArray.push(Traduction.getTextUp(buttonLvl3));
		textUpArray.push(Traduction.getTextUp(buttonLvl4));
		textUpArray.push(Traduction.getTextUp(buttonLvl5));
		textUpArray.push(Traduction.getTextUp(buttonLvl6));
		textUpArray.push(Traduction.getTextUp(buttonLvl7));
		textUpArray.push(Traduction.getTextUp(buttonLvl8));
		textUpArray.push(Traduction.getTextUp(buttonLvl9));
		textUpArray.push(Traduction.getTextUp(buttonLvl10));
		textUpArray.push(Traduction.getTextUp(buttonLvl11));
		textUpArray.push(Traduction.getTextUp(buttonLvl12));
		
		textDownArray.push(Traduction.getTextOver(buttonLvl1));
		textDownArray.push(Traduction.getTextOver(buttonLvl2));
		textDownArray.push(Traduction.getTextOver(buttonLvl3));
		textDownArray.push(Traduction.getTextOver(buttonLvl4));
		textDownArray.push(Traduction.getTextOver(buttonLvl5));
		textDownArray.push(Traduction.getTextOver(buttonLvl6));
		textDownArray.push(Traduction.getTextOver(buttonLvl7));
		textDownArray.push(Traduction.getTextOver(buttonLvl8));
		textDownArray.push(Traduction.getTextOver(buttonLvl9));
		textDownArray.push(Traduction.getTextOver(buttonLvl10));
		textDownArray.push(Traduction.getTextOver(buttonLvl11));
		textDownArray.push(Traduction.getTextOver(buttonLvl12));
		
		buttonBack.addEventListener(MouseEvent.CLICK, onClickBack);
		buttonTuto.addEventListener(MouseEvent.CLICK, onClickTuto);
		buttonLvl1.addEventListener(MouseEvent.CLICK, onClick1);
		buttonLvl2.addEventListener(MouseEvent.CLICK, onClick2);
		buttonLvl3.addEventListener(MouseEvent.CLICK, onClick3);
		buttonLvl4.addEventListener(MouseEvent.CLICK, onClick4);
		buttonLvl5.addEventListener(MouseEvent.CLICK, onClick5);
		buttonLvl6.addEventListener(MouseEvent.CLICK, onClick6);
		buttonLvl7.addEventListener(MouseEvent.CLICK, onClick7);
		buttonLvl8.addEventListener(MouseEvent.CLICK, onClick8);
		buttonLvl9.addEventListener(MouseEvent.CLICK, onClick9);
		buttonLvl10.addEventListener(MouseEvent.CLICK, onClick10);
		buttonLvl11.addEventListener(MouseEvent.CLICK, onClick11);
		buttonLvl12.addEventListener(MouseEvent.CLICK, onClick12);
		unlockBtn.addEventListener(MouseEvent.CLICK, onClickUnlock);

		var lPositionnable:UIPositionable = { item:backgroundLevel, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBack, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:levelTitle, align:AlignType.TOP};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonTuto, align:AlignType.TOP, offsetY:350};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl1, align:AlignType.TOP, offsetY:550};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl2, align:AlignType.TOP, offsetY:550};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl3, align:AlignType.TOP, offsetY:550};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl4, align:AlignType.TOP, offsetY:750};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl5, align:AlignType.TOP, offsetY:750};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl6, align:AlignType.TOP, offsetY:750};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl7, align:AlignType.TOP, offsetY:950};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl8, align:AlignType.TOP, offsetY:950};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl9, align:AlignType.TOP, offsetY:950};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl10, align:AlignType.TOP, offsetY:1150};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl11, align:AlignType.TOP, offsetY:1150};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl12, align:AlignType.TOP, offsetY:1150};
		positionables.push(lPositionnable);
		lPositionnable = { item:unlockBtn, align:AlignType.TOP_RIGHT, offsetY:350, offsetX:350};
		positionables.push(lPositionnable);

		buttonBack .alpha = 0;
		levelTitle .alpha = 0;
		buttonLvl1 .alpha = 0;
		buttonLvl2 .alpha = 0;
		buttonLvl3 .alpha = 0;
		buttonLvl4 .alpha = 0;
		buttonLvl5 .alpha = 0;
		buttonLvl6 .alpha = 0;
		buttonLvl7 .alpha = 0;
		buttonLvl8 .alpha = 0;
		buttonLvl9 .alpha = 0;
		buttonLvl10 .alpha = 0;
		buttonLvl11 .alpha = 0;
		buttonLvl12 .alpha = 0;
		unlockBtn  .alpha = 0;

		Actuate.tween (buttonBack,	5, {alpha:1});
		Actuate.tween (levelTitle,	5, {alpha:1});
		Actuate.tween (buttonLvl1,	5, {alpha:1});
		Actuate.tween (buttonLvl2,	5, {alpha:1});
		Actuate.tween (buttonLvl3,	5, {alpha:1});
		Actuate.tween (buttonLvl4,	5, {alpha:1});
		Actuate.tween (buttonLvl5,	5, {alpha:1});
		Actuate.tween (buttonLvl6,	5, {alpha:1});
		Actuate.tween (buttonLvl7,	5, {alpha:1});
		Actuate.tween (buttonLvl8,	5, {alpha:1});
		Actuate.tween (buttonLvl9,	5, {alpha:1});
		Actuate.tween (buttonLvl10,	5, {alpha:1});
		Actuate.tween (buttonLvl11,	5, {alpha:1});
		Actuate.tween (buttonLvl12,	5, {alpha:1});
		Actuate.tween (unlockBtn,	5, {alpha:1});
		
		lockDisplayList = new Array<LockedLevel>();
		
		updateLockDisplay();
		
		translateButtonsLevelScreen(Traduction.english);
	}

	public static function getInstance (): LevelScreen
	{
		if (instance == null) instance = new LevelScreen();
		else instance.updateLockDisplay();
		return instance;
	}

	public static function initCompleteListAndLock():Void
	{
		for (i in 0... LevelManager.levels.length)
		{
			levelCompleteList[i] = false;
		}

		for (j in 1... LevelManager.levels.length)
		{
			lock [j] = true;

		}
		
		lock[0] = false;
	}

	public function unlockLevel():Void
	{
		if (levelCompleteList[LevelManager.levelNum] && LevelManager.levelNum < LEVEL_NB - 1)
		{
			lock[LevelManager.levelNum + 1] = false;
		}
	}
	
	public function unlockLevelSave()
	{
		for (i in 0... LevelManager.levels.length) 
		{
			if (levelCompleteList[i])
			{
				if (i < 13)
				{
					lock[i + 1] = false;
				}
			}
		}
	}
	
	public static function allLevelComplete():Bool
	{
		var lReturn : Bool = false;
		var lCountLevelComplete : Int = 0;

		for (i in 0... LevelManager.levels.length)
		{
			if (levelCompleteList[i])
			{
				lCountLevelComplete += 1;
			}
		}

		if (lCountLevelComplete == LevelManager.levels.length)
		{
			lReturn = true;
		}

		return lReturn;
	}

	private function onClickBack(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(TitleCard.getInstance());
		SoundManager.clickSound();
	}

	private function onClickTuto(pEvent : MouseEvent) : Void
	{
		UIManager.addScreen(TutorialHelpScreen.getInstance());
		SoundManager.clickSound();
	}

	private function onClick1(pEvent : MouseEvent) : Void
	{
		levelIndex = 1;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick2(pEvent : MouseEvent) : Void
	{
		levelIndex = 2;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick3(pEvent : MouseEvent) : Void
	{
		levelIndex = 3;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick4(pEvent : MouseEvent) : Void
	{
		levelIndex = 4;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick5(pEvent : MouseEvent) : Void
	{
		levelIndex = 5;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick6(pEvent : MouseEvent) : Void
	{
		levelIndex = 6;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick7(pEvent : MouseEvent) : Void
	{
		levelIndex = 7;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick8(pEvent : MouseEvent) : Void
	{
		levelIndex = 8;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick9(pEvent : MouseEvent) : Void
	{
		levelIndex = 9;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick10(pEvent : MouseEvent) : Void
	{
		levelIndex = 10;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick11(pEvent : MouseEvent) : Void
	{
		levelIndex = 11;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick12(pEvent : MouseEvent) : Void
	{
		levelIndex = 12;
		if (!lock [levelIndex])
			{
				//trace("1 selected");
				levelSelect(levelIndex);
			}
	}
	
	private function onClickUnlock(e:MouseEvent):Void {
		LevelManager.levelNum = 12;
		
		for (i in 0...13) {
			lock[i] = false;
		}
	}

	private function levelSelect(pLevel : Int):Void
	{
		LevelManager.levelNum = pLevel;

		LevelManager.selectLevel(LevelManager.levelNum);

		GameManager.start();
	}
	
	public function translateButtonsLevelScreen(pEnglish:Bool):Void
	{
		if (pEnglish){
			txtTutoUp.text = Traduction.getField("TUTORIAL").en;
			txtTutoDown.text = Traduction.getField("TUTORIAL").en;
			
			txtBackUp.text = Traduction.getField("BACK").en;
			txtBackDown.text = Traduction.getField("BACK").en;
			
			trace (txtBackUp.text, txtBackDown.text);
			
			for (i in 0...textDownArray.length){
				textUpArray[i].text = Traduction.getField("LEVEL").en + " " + (i + 1);
				textDownArray[i].text = Traduction.getField("LEVEL").en + " " + (i + 1);
				
				trace (textUpArray[i].text, textDownArray[i].text);
				trace (i);
			}
		} else{
			txtTutoUp.text = Traduction.getField("TUTORIAL").fr;
			txtTutoDown.text = Traduction.getField("TUTORIAL").fr;
			
			txtBackUp.text = Traduction.getField("BACK").fr;
			txtBackDown.text = Traduction.getField("BACK").fr;
			
			for (i in 0...textDownArray.length){
				textUpArray[i].text = Traduction.getField("LEVEL").fr + " " + (i + 1);
				textDownArray[i].text = Traduction.getField("LEVEL").fr + " " + (i + 1);
				
				trace (textUpArray[i].text, textDownArray[i].text);
				trace (i);
			}
		}
	}

	public function displayLockButton(pLvlNum: Int, pBtn: DisplayObject): Void {
		if (lock[pLvlNum] && lockDisplayList[pLvlNum] == null) {
			var lLock: LockedLevel = new LockedLevel();
			
			lLock.x = pBtn.x;
			lLock.y = pBtn.y;
			
			content.addChild(lLock);
			lockDisplayList[pLvlNum] = lLock;
			
			Actuate.transform(pBtn, 0).color(0x000000, 0.75);
		} else if (!lock[pLvlNum]) {
			content.removeChild(lockDisplayList[pLvlNum]);
			lockDisplayList[pLvlNum] = null;
			Actuate.transform(pBtn, 0).color(0x000000, 0);
		}
	}
	
	public function updateLockDisplay(): Void {
		displayLockButton(0, buttonTuto);
		displayLockButton(1, buttonLvl1);
		displayLockButton(2, buttonLvl2);
		displayLockButton(3, buttonLvl3);
		displayLockButton(4, buttonLvl4);
		displayLockButton(5, buttonLvl5);
		displayLockButton(6, buttonLvl6);
		displayLockButton(7, buttonLvl7);
		displayLockButton(8, buttonLvl8);
		displayLockButton(9, buttonLvl9);
		displayLockButton(10, buttonLvl10);
		displayLockButton(11, buttonLvl11);
		displayLockButton(12, buttonLvl12);
	}
	
	override function onResize(pEvent:Event = null):Void {
		super.onResize(pEvent);
		
		if (lockDisplayList[0] != null) {
			lockDisplayList[0].x = buttonTuto.x;
			lockDisplayList[0].y = buttonTuto.y;
		}
		if (lockDisplayList[1] != null) {
			lockDisplayList[1].x = buttonLvl1.x;
			lockDisplayList[1].y = buttonLvl1.y;
		}
		if (lockDisplayList[2] != null) {
			lockDisplayList[2].x = buttonLvl2.x;
			lockDisplayList[2].y = buttonLvl2.y;
		}
		if (lockDisplayList[3] != null) {
			lockDisplayList[3].x = buttonLvl3.x;
			lockDisplayList[3].y = buttonLvl3.y;
		}
		if (lockDisplayList[4] != null) {
			lockDisplayList[4].x = buttonLvl4.x;
			lockDisplayList[4].y = buttonLvl4.y;
		}
		if (lockDisplayList[5] != null) {
			lockDisplayList[5].x = buttonLvl5.x;
			lockDisplayList[5].y = buttonLvl5.y;
		}
		if (lockDisplayList[6] != null) {
			lockDisplayList[6].x = buttonLvl6.x;
			lockDisplayList[6].y = buttonLvl6.y;
		}
		if (lockDisplayList[7] != null) {
			lockDisplayList[7].x = buttonLvl7.x;
			lockDisplayList[7].y = buttonLvl7.y;
		}
		if (lockDisplayList[8] != null) {
			lockDisplayList[8].x = buttonLvl8.x;
			lockDisplayList[8].y = buttonLvl8.y;
		}
		if (lockDisplayList[9] != null) {
			lockDisplayList[9].x = buttonLvl9.x;
			lockDisplayList[9].y = buttonLvl9.y;
		}
		if (lockDisplayList[10] != null) {
			lockDisplayList[10].x = buttonLvl10.x;
			lockDisplayList[10].y = buttonLvl10.y;
		}
		if (lockDisplayList[11] != null) {
			lockDisplayList[11].x = buttonLvl11.x;
			lockDisplayList[11].y = buttonLvl11.y;
		}
		if (lockDisplayList[12] != null) {
			lockDisplayList[12].x = buttonLvl12.x;
			lockDisplayList[12].y = buttonLvl12.y;
		}
	}
	
	override public function destroy (): Void
	{
		instance = null;
		buttonBack.removeEventListener(MouseEvent.CLICK, onClickBack);
		buttonTuto.removeEventListener(MouseEvent.CLICK, onClickTuto);
		buttonLvl1.removeEventListener(MouseEvent.CLICK, onClick1);
		buttonLvl2.removeEventListener(MouseEvent.CLICK, onClick2);
		buttonLvl3.removeEventListener(MouseEvent.CLICK, onClick3);
		buttonLvl4.removeEventListener(MouseEvent.CLICK, onClick4);
		buttonLvl5.removeEventListener(MouseEvent.CLICK, onClick5);
		buttonLvl6.removeEventListener(MouseEvent.CLICK, onClick6);
		buttonLvl7.removeEventListener(MouseEvent.CLICK, onClick7);
		buttonLvl8.removeEventListener(MouseEvent.CLICK, onClick8);
		buttonLvl9.removeEventListener(MouseEvent.CLICK, onClick9);
		buttonLvl10.removeEventListener(MouseEvent.CLICK, onClick10);
		buttonLvl11.removeEventListener(MouseEvent.CLICK, onClick11);
		buttonLvl12.removeEventListener(MouseEvent.CLICK, onClick12);
		super.destroy();
	}
}