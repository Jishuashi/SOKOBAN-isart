package com.isartdigital.utils.game;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Blanco
 */
class KeyboardController
{
	private var myStage:Stage;
	private var allKeysJustDown:Array<Bool>	= [];
	private var allKeysDown:Array<Bool> = [];
	
	public var leftDown(get, null):Bool;
	public var rightDown(get, null):Bool;
	public var upDown(get, null):Bool;
	public var downDown(get, null):Bool;

	public function new(pStage:Stage)
	{
		myStage = pStage;
		myStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
		myStage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
	}

	public function doAction():Void
	{
		for (i in allKeysJustDown.length-1...0) 
		{
			allKeysJustDown[i] = false;
		}
	}

	private function get_leftDown():Bool
	{
		trace("left");
		return (allKeysJustDown[Keyboard.LEFT] || allKeysJustDown[Keyboard.Q]);
	}
	
	private function get_rightDown():Bool
	{
		trace("right");
		return (allKeysJustDown[Keyboard.RIGHT] || allKeysJustDown[Keyboard.D]);
	}

	private function get_upDown():Bool
	{
		trace("up");
		return (allKeysJustDown[Keyboard.UP] || allKeysJustDown[Keyboard.Z]);
	}

	private function get_downDown():Bool
	{
		trace("down");
		return (allKeysJustDown[Keyboard.DOWN] || allKeysJustDown[Keyboard.S]);
	}

	private function onKeyboardDown(pEvent:KeyboardEvent):Void
	{
		if (!allKeysDown[pEvent.keyCode])
			allKeysJustDown[pEvent.keyCode] = true;
		
		allKeysDown[pEvent.keyCode] = true;
	}

	private function onKeyboardUp(pEvent:KeyboardEvent):Void
	{
		allKeysDown[pEvent.keyCode] = false;
	}

	public function destroy():Void
	{
		myStage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
		myStage.removeEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
		
		allKeysDown = null;
		myStage       = null;
	}

}