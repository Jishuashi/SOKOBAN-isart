package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
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
		
		buttonBack.addEventListener(MouseEvent.CLICK, onClickBack);
		//buttonTuto.addEventListener(MouseEvent.CLICK, onClickTuto);
		//buttonLvl1.addEventListener(MouseEvent.CLICK, onClick1);
		//buttonLvl2.addEventListener(MouseEvent.CLICK, onClick2);
		//buttonLvl3.addEventListener(MouseEvent.CLICK, onClick3);
		//buttonLvl4.addEventListener(MouseEvent.CLICK, onClick4);
		//buttonLvl5.addEventListener(MouseEvent.CLICK, onClick5);
		//buttonLvl6.addEventListener(MouseEvent.CLICK, onClick6);
		//buttonLvl7.addEventListener(MouseEvent.CLICK, onClick7);
		//buttonLvl8.addEventListener(MouseEvent.CLICK, onClick8);
		//buttonLvl9.addEventListener(MouseEvent.CLICK, onClick9);
		
		var lPositionnable:UIPositionable = { item:backgroundLevel, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonBack, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		lPositionnable = { item:levelTitle, align:AlignType.TOP};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonTuto, align:AlignType.TOP, offsetY:350};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl1, align:AlignType.TOP_LEFT, offsetY:600, offsetX:900};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl2, align:AlignType.TOP, offsetY:600};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl3, align:AlignType.TOP_RIGHT, offsetY:600, offsetX:950};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl4, align:AlignType.TOP_LEFT, offsetY:850, offsetX:900};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl5, align:AlignType.TOP, offsetY:850};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl6, align:AlignType.TOP_RIGHT, offsetY:850, offsetX:950};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl7, align:AlignType.TOP_LEFT, offsetY:1100, offsetX:900};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl8, align:AlignType.TOP, offsetY:1100};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonLvl9, align:AlignType.TOP_RIGHT, offsetY:1100, offsetX:950};
		positionables.push(lPositionnable);
	}

	public static function getInstance (): LevelScreen
	{
		if (instance == null) instance = new LevelScreen();
		return instance;
	}

	private function onClickBack(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(TitleCard.getInstance());
		SoundManager.getSound("click").start();
	}

	override public function destroy (): Void
	{
		instance = null;
		buttonBack.removeEventListener(MouseEvent.CLICK, onClickBack);
		//buttonTuto.removeEventListener(MouseEvent.CLICK, onClickTuto);
		//buttonLvl1.removeEventListener(MouseEvent.CLICK, onClick1);
		//buttonLvl2.removeEventListener(MouseEvent.CLICK, onClick2);
		//buttonLvl3.removeEventListener(MouseEvent.CLICK, onClick3);
		//buttonLvl4.removeEventListener(MouseEvent.CLICK, onClick4);
		//buttonLvl5.removeEventListener(MouseEvent.CLICK, onClick5);
		//buttonLvl6.removeEventListener(MouseEvent.CLICK, onClick6);
		//buttonLvl7.removeEventListener(MouseEvent.CLICK, onClick7);
		//buttonLvl8.removeEventListener(MouseEvent.CLICK, onClick8);
		//buttonLvl9.removeEventListener(MouseEvent.CLICK, onClick9);
		super.destroy();
	}
}