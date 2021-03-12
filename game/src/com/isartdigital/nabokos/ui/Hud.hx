package com.isartdigital.nabokos.ui;

import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.game.view.RadarView;
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
	private var btnUndo : DisplayObject;
	private var btnRedo : DisplayObject;
	
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
		
		btnRetry = content.getChildByName("btnRetry");
		btnUndo = content.getChildByName("btnUndo");
		btnRedo = content.getChildByName("btnRedo");
		
		btnRetry.addEventListener(MouseEvent.CLICK, retry);
		btnRedo.addEventListener(MouseEvent.CLICK, redo);
		btnRedo.addEventListener(MouseEvent.CLICK, undo);
	}
	//
	//public function redo(pEvent : MouseEvent){}
	//
	//public function undo(pEvent : MouseEvent){}
	
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