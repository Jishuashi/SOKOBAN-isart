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
	/**
	 * Le stage en lui-même
	 */
	private var myStage:Stage;
	
	/**
	 * Tableau qui référence si la touche vient d'être appuyée
	 */
	private var allKeysJustDown:Array<Bool>	= [];
	
	/**
	 * Tableau qui référence si al touche est actuellement appuyée
	 */
	private var allKeysDown:Array<Bool> = [];

	public function new(pStage:Stage)
	{
		myStage = pStage;
		myStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
		myStage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
	}

	/**
	 * Remise à zéro du tableau allKeysJustDown
	 */
	public function doAction():Void {
		var tabLength: Int = allKeysJustDown.length;
		
		for (i in 0...tabLength) {
			allKeysJustDown[i] = false;
		}
	}
	
	/**
	 * indique si la touche gauche vient d'être appuyée
	 * @return boolean
	 */
	public function isLeftDown():Bool
	{
		return (allKeysJustDown[Keyboard.LEFT] || allKeysJustDown[Keyboard.Q]);
	}
	
	/**
	 * indique si la touche droite vient d'être appuyée
	 * @return boolean
	 */
	public function isRightDown():Bool
	{
		return (allKeysJustDown[Keyboard.RIGHT] || allKeysJustDown[Keyboard.D]);
	}

	/**
	 * indique si la touche haut vient d'être appuyée
	 * @return boolean
	 */
	public function isUpDown():Bool
	{
		return (allKeysJustDown[Keyboard.UP] || allKeysJustDown[Keyboard.Z]);
	}

	/**
	 * indique si la touche down vient d'être appuyée
	 * @return boolean
	 */
	public function isDownDown():Bool
	{
		return (allKeysJustDown[Keyboard.DOWN] || allKeysJustDown[Keyboard.S]);
	}

	/**
	 * Réaction à l'appuis d'une touche
	 * @param	pEvent event généré par l'appuis de touche
	 */
	private function onKeyboardDown(pEvent:KeyboardEvent):Void
	{
		if (!allKeysDown[pEvent.keyCode])
			allKeysJustDown[pEvent.keyCode] = true;
		
		allKeysDown[pEvent.keyCode] = true;
	}
	
	/**
	 * Réaction à l'arrête de l'appuis d'une touche
	 * @param	pEvent event généré par l'arrête d'appuis de touche
	 */
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