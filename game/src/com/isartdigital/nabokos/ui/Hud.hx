package com.isartdigital.nabokos.ui;

import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;

/**
 * ...
 * @author Chadi Husser
 */
class Hud extends Screen 
{
	private static var instance : Hud;
	
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
	}
	
	override public function destroy():Void 
	{
		instance = null;
		super.destroy();
	}
}