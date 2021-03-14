package com.isartdigital.nabokos.game.presenter;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Garance LESPAGNOL
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
		return (allKeysJustDown[Keyboard.LEFT] || allKeysJustDown[Keyboard.Q]);
	}
	
	public function isRightDown():Bool
	{
		return (allKeysJustDown[Keyboard.RIGHT] || allKeysJustDown[Keyboard.D]);
	}

	public function isUpDown():Bool
	{
		return (allKeysJustDown[Keyboard.UP] || allKeysJustDown[Keyboard.Z]);
	}

	public function isDownDown():Bool
	{
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