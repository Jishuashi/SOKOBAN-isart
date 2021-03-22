package com.isartdigital.nabokos.game.presenter;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.model.MoveHistory;
import com.isartdigital.nabokos.game.model.PlayerActions;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.game.view.RadarView;
import com.isartdigital.utils.game.CollisionManager.HitBoxesOrHitPoints;
import com.isartdigital.utils.game.grids.iso.IsoManager;
import openfl.events.MouseEvent;
import openfl.geom.Point;

/**
 * ...
 * @author Anthony TIREL--TARTUFFE
 */
class MouseController {

	public function new() {
		IsoView.getInstance().viewContainer.addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(pEvent:MouseEvent):Void {
		var lClickPointView: Point = IsoView.getInstance().viewContainer.globalToLocal(new Point(pEvent.stageX, pEvent.stageY));
		
		var lClickPointModel: Point = IsoManager.isoViewToModel(lClickPointView);
		
		var lPlayerPos: Point = LevelManager.getPlayerPosition();
		
		var lMovement: Point = new Point(lClickPointModel.x - lPlayerPos.x, lClickPointModel.y - lPlayerPos.y);
		
		if (lMovement.x != 0) lMovement.x /= Math.abs(lMovement.x);
		if (lMovement.y != 0) lMovement.y /= Math.abs(lMovement.y);
		
		if (lMovement.equals(new Point(0, 0))) return;
		
		var lPlayerAction: PlayerActions;
		
		trace(lMovement); 
		
		if (lMovement.x != 0) {
			lPlayerAction = (lMovement.x == 1 ? PlayerActions.RIGHT : PlayerActions.LEFT);
			
			if (LevelManager.playerAction(lPlayerAction)) {
				updateViews(lPlayerAction);
				return;
			}
		}
		if (lMovement.y != 0) {
			lPlayerAction = (lMovement.y == 1 ? PlayerActions.DOWN : PlayerActions.UP);
			
			if (LevelManager.playerAction(lPlayerAction)) {
				updateViews(lPlayerAction);
				return;
			}
		}
	}
	
	private function updateViews(pPlayerAction: PlayerActions): Void {
		MoveHistory.getInstance().newMove(LevelManager.getCurrentLevel(), LevelManager.getBoxPosisition());
		
		IsoView.getInstance().updatePlayerAsset(pPlayerAction);
		IsoView.getInstance().updateView(LevelManager.getCurrentLevel());
		RadarView.getInstance().updateView(LevelManager.getCurrentLevel());
	}
}