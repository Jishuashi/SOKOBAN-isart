package com.isartdigital.nabokos.game.sprites;

import com.isartdigital.utils.game.GameStage;
import com.isartdigital.utils.game.grids.CellDef;
import openfl.display.Sprite;

/**
 * ...
 * @author Hugo CHARTIER
 */
class GameView extends Sprite
{
	
	private var cellSize : CellDef;
	private var viewContainer: Sprite;

	public function new()
	{
		super();

	}

	public function updateView(pLevel : Array<Array<Array<Blocks>>>)
	{
		// met à jour la vue en fonction du niveau qu'on lui donne en paramètre
		
		trace("Updated");
		
		resetView();
	}
	
	public function resetView(): Void{
		viewContainer.removeChildren();
	}
	
	public function destroy():Void {
		
	}
	
}