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
	public var viewContainer: Sprite;
	
	/**
	 * tableau qui stocke les tiles générées aléatoirement au lancement d'un niveau
	 */
	private var randomTileList: Array<String>;

	public function new()
	{
		super();
	}

	/**
	 * Met à jour la vue en fonction du niveau qu'on lui donne en paramètre
	 * @param	pLevel
	 */
	public function updateView(pLevel : Array<Array<Array<Blocks>>>): Void {
		GameStage.getInstance().stage.focus = GameStage.getInstance().stage;
		resetView();
	}
	
	/**
	 * supprime tous les enfants de la vue actuelle
	 */
	public function resetView(): Void {
		viewContainer.removeChildren();
	}
	
	private function generateRandomTile(pBaseTileName:String, pNbOfTiles:Int) : String{
		return pBaseTileName + Math.ceil(Math.random() * pNbOfTiles);
	}
	
	private function selectTile(pInitialTileName:String, pNbrOfTiles:Int, pIndex:Int, pCheck: Int, pList:Array<String>):String{
		var lTile: String;
		
		if (pCheck == 0){
			lTile = generateRandomTile(pInitialTileName, pNbrOfTiles);
			pList.push(lTile);
		} else {
			lTile = pList[pIndex];
		}
		
		return lTile;
	}
	
	public function destroy(): Void {
		
	}
}