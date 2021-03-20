package com.isartdigital.utils.ui;

import motion.actuators.SimpleActuator;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.utils.Assets;

/**
 * Classe de base d'écran
 * @author Chadi Husser
 */
class Screen extends UIComponent 
{

	private var content:MovieClip;
	
	private function new(?pLibrary:String="ui") 
	{
		super();
		content = Assets.getMovieClip(pLibrary + ":" + Type.getClassName(Type.getClass(this)).split(".").pop());
		addChild(content);
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init (pEvent:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		stage.addEventListener(Event.RESIZE, onResize);
		onResize();
	}
		
	/**
	 * nettoie l'instance
	 */
	override public function destroy (): Void {
		content = null;
		removeEventListener(Event.ADDED_TO_STAGE, init);
		stage.removeEventListener(Event.RESIZE, onResize);
		super.destroy();
	}
}