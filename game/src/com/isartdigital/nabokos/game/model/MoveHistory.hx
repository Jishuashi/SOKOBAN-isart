package com.isartdigital.nabokos.game.model;

	
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

	
	public function resetTab(): Void {
		moveTab = new Array<Array<Array<Array<Blocks>>>>();
		
		cursor = -1;
	}
	
	public function undo(): Array<Array<Array<Blocks>>> {
		if (cursor > 0) {
			cursor--;
			
			return moveTab[cursor];
		}
		
		return null;
	}
	
	
	public function redo(): Array<Array<Array<Blocks>>> {
		if (cursor < moveTab.length-1) {
			cursor++;
			
			return moveTab[cursor];
		}
		
		return null;
	}
	
	
	public function newMove(pLevel: Array<Array<Array<Blocks>>>): Void {
		trace("cursor = " + cursor);
		trace("moveTab.length = " + moveTab.length);
		
		while (cursor < moveTab.length - 1) {
			moveTab.pop();
		}
		
		trace("cursor = " + cursor);
		trace("moveTab.length = " + moveTab.length);
		
		moveTab.push(pLevel);
		
		cursor++;
		
		trace("cursor = " + cursor);
		trace("moveTab.length = " + moveTab.length);
	}
	
	/**
	 * détruit l'instance unique et met sa référence interne à null
	 */
	public function destroy (): Void {
		instance = null;
	}

}