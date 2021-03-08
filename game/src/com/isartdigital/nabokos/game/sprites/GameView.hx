package com.isartdigital.nabokos.game.sprites;

import com.isartdigital.utils.game.GameStage;
import openfl.display.Sprite;

/**
 * ...
 * @author Hugo CHARTIER
 */
class GameView extends Sprite
{

	public function new()
	{
		super();

	}

	public function updateView(pLevel : Array<Array<Array<Blocks>>>)
	{
		// met à jour la vue en fonction du niveau qu'on lui donne en paramètre
		
		resetView();
	}
	
	public function resetView(): Void{
		GameStage.getInstance().getGameContainer().removeChildren();
	}
	
	public function destroy():Void {
		
	}
	
}