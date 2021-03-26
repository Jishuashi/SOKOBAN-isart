package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.nabokos.game.model.LevelManager;
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

	private var levelIndex : Int;
	private static var lock : Array<Bool> = new Array<Bool>();

	public static var levelCompleteList : Array<Bool> = new Array<Bool>();

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

		Actuate.tween (buttonBack,	1, {alpha:1});
		Actuate.tween (levelTitle,	1, {alpha:1});
		Actuate.tween (buttonLvl1,	1, {alpha:1});
		Actuate.tween (buttonLvl2,	1, {alpha:1});
		Actuate.tween (buttonLvl3,	1, {alpha:1});
		Actuate.tween (buttonLvl4,	1, {alpha:1});
		Actuate.tween (buttonLvl5,	1, {alpha:1});
		Actuate.tween (buttonLvl6,	1, {alpha:1});
		Actuate.tween (buttonLvl7,	1, {alpha:1});
		Actuate.tween (buttonLvl8,	1, {alpha:1});
		Actuate.tween (buttonLvl9,	1, {alpha:1});
		Actuate.tween (buttonLvl10,	1, {alpha:1});
		Actuate.tween (buttonLvl11,	1, {alpha:1});
		Actuate.tween (buttonLvl12,	1, {alpha:1});
	}

	public static function getInstance (): LevelScreen
	{
		if (instance == null) instance = new LevelScreen();
		return instance;
	}

	public static function initCompleteListAndLock():Void
	{
		for (i in 0... LevelManager.levels.length)
		{
			levelCompleteList[i] = false;
		}

		for (j in 0... LevelManager.levels.length)
		{
			lock [j] = true;

		}

		trace(lock);
	}

	public function unlockLevel():Void
	{
		if (levelCompleteList[LevelManager.levelNum] && LevelManager.levelNum < 13)
		{
			lock [LevelManager.levelNum + 1] = false;
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
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick2(pEvent : MouseEvent) : Void
	{
		levelIndex = 2;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick3(pEvent : MouseEvent) : Void
	{
		levelIndex = 3;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick4(pEvent : MouseEvent) : Void
	{
		levelIndex = 4;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick5(pEvent : MouseEvent) : Void
	{
		levelIndex = 5;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick6(pEvent : MouseEvent) : Void
	{
		levelIndex = 6;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick7(pEvent : MouseEvent) : Void
	{
		levelIndex = 7;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick8(pEvent : MouseEvent) : Void
	{
		levelIndex = 8;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick9(pEvent : MouseEvent) : Void
	{
		levelIndex = 9;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick10(pEvent : MouseEvent) : Void
	{
		levelIndex = 10;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick11(pEvent : MouseEvent) : Void
	{
		levelIndex = 11;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function onClick12(pEvent : MouseEvent) : Void
	{
		levelIndex = 12;
		if (!lock [levelIndex])
			{
				trace("1 selected");
				levelSelect(levelIndex);
			}
	}

	private function levelSelect(pLevel : Int):Void
	{
		LevelManager.levelNum = pLevel;

		LevelManager.selectLevel(LevelManager.levelNum);

		GameManager.start();
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