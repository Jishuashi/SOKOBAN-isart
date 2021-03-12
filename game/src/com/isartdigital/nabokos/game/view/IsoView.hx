package com.isartdigital.nabokos.game.view;
import com.isartdigital.nabokos.game.model.Blocks;
import animateAtlasPlayer.core.Animation;
import com.isartdigital.nabokos.game.model.PlayerActions;
import com.isartdigital.nabokos.game.view.GameView;
import com.isartdigital.utils.game.GameStage;
import com.isartdigital.utils.game.grids.CellDef;
import com.isartdigital.utils.game.grids.iso.IsoManager;
import com.isartdigital.utils.loader.GameLoader;
import flash.Lib;
import flash.display.Sprite;
import flash.geom.Point;
import haxe.ds.HashMap;
import haxe.ds.Map;


/**
 * ...
 * @author Anthony TIREL--TARTUFFE
 */
class IsoView extends GameView {
	
	private var player: Animation;
	
	private static var instance: IsoView;
	public static function getInstance(): IsoView {
		if (instance == null) instance = new IsoView();
		return instance;
	}
	
	public function new() {
		super();
		
		cellSize = { gridX: 256, gridY : 128 };
		
		IsoManager.init(cellSize.gridX, cellSize.gridY);
		
		viewContainer = new Sprite();
		
		player = GameLoader.getAnimationFromAtlas("Player_IDLE_UP");
	}
	
	override public function updateView(pLevel:Array<Array<Array<Blocks>>>) {
		super.updateView(pLevel);
		
		var lAsset: Animation;
		var lAllObjects: Map<CellDef, Animation> = new Map<CellDef, Animation>();
		var lListToSort: Array<CellDef> = new Array<CellDef>();
		var lGridPos: CellDef;
		var lViewPos: Point;
		
		for (y in 0...pLevel.length) {
			
			for (x in 0...pLevel[y].length) {
				
				var k: Int = pLevel[y][x].length-1;
				
				while (k >= 0) {
					
					switch (pLevel[y][x][k]) {
						case Blocks.WALL:
							lAsset = GameLoader.getAnimationFromAtlas("IsoWall");
							
						case Blocks.PLAYER :
							lAsset = player;
						
						case Blocks.GROUND :
							lAsset = GameLoader.getAnimationFromAtlas("IsoFloor");
						
						case Blocks.TARGET :
							lAsset = GameLoader.getAnimationFromAtlas("IsoGoal");
						
						case Blocks.BOX :
							lAsset = GameLoader.getAnimationFromAtlas("IsoBox");
						
						case Blocks.MIRROR :
							lAsset = GameLoader.getAnimationFromAtlas("IsoMirror");
							
						default:
							lAsset = GameLoader.getAnimationFromAtlas("IsoFloor");
							
					}	
					
					lGridPos = {gridX : x, gridY: y};
					
					lViewPos = IsoManager.modelToIsoView(new Point(lGridPos.gridX, lGridPos.gridY));
					
					lAsset.x = lViewPos.x;
					lAsset.y = lViewPos.y;
					
					lAllObjects.set(lGridPos, lAsset);
					
					lListToSort.push(lGridPos);
				
					k--;
				}
			}
		}
		
		IsoManager.zSort(lListToSort);
		
		for (i in 0...lListToSort.length) {
			viewContainer.addChild(lAllObjects.get(lListToSort[i]));
		}
		
		GameStage.getInstance().getGameContainer().addChild(viewContainer);
		
		viewContainer.x = GameStage.getInstance().getGameContainer().width / 2;
		viewContainer.y = GameStage.getInstance().getGameContainer().height * 0.2;
	}
	
	public function updatePlayerAsset(pMove: PlayerActions): Void{
		switch (pMove) {
			case PlayerActions.LEFT:
				player = GameLoader.getAnimationFromAtlas("Player_IDLE_LEFT");
				
			case PlayerActions.RIGHT:
				player = GameLoader.getAnimationFromAtlas("Player_IDLE_RIGHT");
				
			case PlayerActions.UP:
				player = GameLoader.getAnimationFromAtlas("Player_IDLE_UP");
				
			case PlayerActions.DOWN:
				player = GameLoader.getAnimationFromAtlas("Player_IDLE_DOWN");
		}
	}
	
	override public function destroy(): Void {
		super.destroy();
		instance = null;
	}
}