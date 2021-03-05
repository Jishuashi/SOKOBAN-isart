package com.isartdigital.nabokos.game.sprites;

import com.isartdigital.utils.game.stateObjects.StateAtlas;
import com.isartdigital.utils.game.stateObjects.colliders.ColliderType;

/**
 * ...
 * @author Hugo CHARTIER
 */
class RadarAssets extends StateAtlas 
{

	public function new(pAssetName:String) 
	{
		super(pAssetName);
		
	}
	
	override function get_colliderType():ColliderType 
	{
		return ColliderType.SIMPLE;
	}
	
	override function get_stateDefault():String 
	{
		return "RadarWall";
	}
	
}