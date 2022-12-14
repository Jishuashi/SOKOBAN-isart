package com.isartdigital.nabokos.game.model;
import openfl.geom.Point;

	
/**
 * Classe gérant l'historique des mouvements du joueur.
 * @author Anthony TIREL--TARTUFFE
 */
class MoveHistory {
	
	/**
	 * instance unique de la classe MoveHistory
	 */
	private static var instance: MoveHistory;
	
	/**
	 * Tableau répertoriant la configuration du niveau avant et après chaque mouvement du joueur
	 */
	private var moveTab: Array<Array<Array<Array<Blocks>>>>;
	
	/**
	 * Tableau qui stocke les positions des boites
	 */
	private var boxPositionTab: Array<Array<Array<Point>>>;
	
	/**
	 * Curseur représentant le format du niveau actuellement représenté
	 */
	private var cursor: Int;
	
	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): MoveHistory {
		if (instance == null) instance = new MoveHistory();
		return instance;
	}
	
	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new() {
		resetTab();
	}

	/**
	 * Remise à défaut du moveTab et du curseur
	 */
	public function resetTab(): Void {
		moveTab = new Array<Array<Array<Array<Blocks>>>>();
		boxPositionTab = new Array<Array<Array<Point>>>();
		
		cursor = -1;
		LevelManager.initLevelCheck = 0;
	}
	
	/**
	 * Sélection le niveau précédent celui actuellement affiché
	 * @return le précédent niveau, à afficher
	 */
	public function undo(): Array<Array<Array<Blocks>>> {
		if (cursor > 0) {
			cursor--;
			LevelManager.reInitBoxesForUndo(boxPositionTab[cursor]);
			
			return moveTab[cursor];
		}
		
		return null;
	}
	
	/**
	 * Séléctionne le niveau suivant celui actuellement affiché
	 * @return le niveau d'après, à afficher
	 */
	public function redo(): Array<Array<Array<Blocks>>> {
		if (cursor < moveTab.length-1) {
			cursor++;
			LevelManager.reInitBoxesForUndo(boxPositionTab[cursor]);
			
			return moveTab[cursor];
		}
		
		return null;
	}
	
	/**
	 * Rajoute un nouveau mouvement au moveTab en supprimant les mouvements situés après le curseur
	 * @param	pLevel nouveau niveau a stocker
	 */
	public function newMove(pLevel: Array<Array<Array<Blocks>>>, pBoxesPosition: Array<Array<Point>>): Void {
		while (cursor < moveTab.length - 1) {
			moveTab.pop();
			boxPositionTab.pop();
		}
		
		moveTab.push(pLevel);
		boxPositionTab.push(pBoxesPosition);
		cursor++;
	}
	
	/**
	 * détruit l'instance unique et met sa référence interne à null
	 */
	public function destroy (): Void {
		instance = null;
	}

}