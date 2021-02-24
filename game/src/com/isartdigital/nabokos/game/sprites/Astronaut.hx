package com.isartdigital.nabokos.game.sprites;

import com.isartdigital.utils.game.stateObjects.StateAtlas;
import com.isartdigital.utils.game.stateObjects.colliders.ColliderType;

/**
 * ...
 * @author Chadi Husser
 */
class Astronaut extends StateAtlas 
{
	public function new() 
	{
		super();
	}
	
	override function get_colliderType():ColliderType 
	{
		return ColliderType.SIMPLE;
	}
	
	override function get_stateDefault():String 
	{
		return "fire";
	}
}