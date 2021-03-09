package com.isartdigital.nabokos.ui;

import com.isartdigital.nabokos.game.LevelManager;
import com.isartdigital.nabokos.game.sprites.IsoView;
import com.isartdigital.nabokos.game.sprites.RadarView;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import openfl.Lib;
import openfl.display.DisplayObject;
import openfl.display.SimpleButton;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Chadi Husser
 */
class Hud extends Screen 
{
	private static var instance : Hud;
	
	private var btnRetry : DisplayObject;
	
	public static function getInstance() : Hud {
		if (instance == null) instance = new Hud();
		return instance;
	}
	
	public function new() 
	{
		super();
		
		var lPositionnable:UIPositionable;
		lPositionnable = { item:content.getChildByName("mcTopCenter"), align:AlignType.TOP};
		positionables.push(lPositionnable);
		lPositionnable = { item:content.getChildByName("mcBottomLeft"), align:AlignType.BOTTOM_LEFT};
		positionables.push(lPositionnable);
		
		
		btnRetry = content.getChildByName("btnRtry");
		
		btnRetry.addEventListener(MouseEvent.CLICK , retry);
		
	}
	
	public function retry(pEvent : MouseEvent)
	{		
		LevelManager.selectLevel(LevelManager.levelNum);
		
		
		IsoView.getInstance().updateView(LevelManager.getCurrentLevel());
		RadarView.getInstance().updateView(LevelManager.getCurrentLevel());
	}
	
	
	
	
	override public function destroy():Void 
	{
		instance = null;
		super.destroy();
	}
}