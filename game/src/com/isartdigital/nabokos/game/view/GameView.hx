package com.isartdigital.nabokos.game.view;

import com.isartdigital.nabokos.game.model.Blocks;
import com.isartdigital.utils.game.GameStage;
import com.isartdigital.utils.game.grids.CellDef;
import openfl.display.Sprite;

/**
 * ...
 * @author Hugo CHARTIER
 */
class GameView extends Sprite 
{
	/**
	 * taille des cases du tableau
	 */
	private var cellSize : CellDef;
	
	/**
	 * Conteneur de chaque vue
	 */
	private var viewContainer: Sprite;

	public function new()
	{
		super();
	}

	/**
	 * Met à jour la vue en fonction du niveau qu'on lui donne en paramètre
	 * @param	pLevel
	 */
	public function updateView(pLevel : Array<Array<Array<Blocks>>>): Void {
		resetView();
	}
	
	/**
	 * supprime tous les enfants de la vue actuelle
	 */
	public function resetView(): Void {
		viewContainer.removeChildren();
	}
	
	public function destroy(): Void {
		
	}
}