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

	public function new(pStage:Stage)
	{
		myStage = pStage;
		myStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
		myStage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
	}

	public function doAction():Void {
		var tabLength: Int = allKeysJustDown.length;
		
		for (i in 0...tabLength) {
			allKeysJustDown[i] = false;
		}
	}

	public function isLeftDown():Bool
	{
		//trace(allKeysJustDown[Keyboard.LEFT]);
		//trace(allKeysJustDown[Keyboard.Q]);
		return (allKeysJustDown[Keyboard.LEFT] || allKeysJustDown[Keyboard.Q]);
	}
	
	public function isRightDown():Bool
	{
		//trace("right");
		return (allKeysJustDown[Keyboard.RIGHT] || allKeysJustDown[Keyboard.D]);
	}

	public function isUpDown():Bool
	{
		//trace("up");
		return (allKeysJustDown[Keyboard.UP] || allKeysJustDown[Keyboard.Z]);
	}

	public function isDownDown():Bool
	{
		//trace("down");
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
		myStage     = null;
	}

}