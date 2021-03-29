package com.isartdigital.nabokos.game.view;
import com.isartdigital.nabokos.game.model.Blocks;
import animateAtlasPlayer.core.Animation;
import com.isartdigital.nabokos.game.model.LevelManager;
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
 * Affichage du jeu au format Isométrique
 * @author Anthony TIREL--TARTUFFE
 */
class IsoView extends GameView {

	private var viewTab: Array<Array<Sprite>>;
	
	private var playerAnim: String;
	
	private var oldLevel: Array<Array<Array<Blocks>>>;
	
	private static var instance: IsoView;
	public static function getInstance(): IsoView {
		if (instance == null) instance = new IsoView();
		return instance;
	}

	private function new() {
		super();
		viewContainer = new Sprite();
		
		cellSize = {gridX: 256, gridY: 128};
	}
	
	public function init(pLevel: Array<Array<Array<Blocks>>>): Void {
		viewTab = new Array<Array<Sprite>>();
		var lAllObjects: Array<CellDef> = new Array<CellDef>();
		
		
		for (y in 0...pLevel.length) {
			viewTab[y] = new Array<Sprite>();
			
			for (x in 0...pLevel[y].length) {
				viewTab[y][x] = new Sprite();
				
				var z: Int = pLevel[y][x].length - 1;
				
				while (z >= 0) {
					
					switch (pLevel[y][x][z]) {
						case Blocks.BOX:
							viewTab[y][x].addChild(GameLoader.getAnimationFromAtlas("IsoBox"));
						
						case Blocks.GROUND:
							viewTab[y][x].addChild(GameLoader.getAnimationFromAtlas("IsoFloor" + Math.ceil(Math.random()*3)));
						
						case Blocks.MIRROR:
							viewTab[y][x].addChild(GameLoader.getAnimationFromAtlas("IsoMirror"));
						
						case Blocks.PLAYER:
							viewTab[y][x].addChild(GameLoader.getAnimationFromAtlas("Player_IDLE_UP"));
						
						case Blocks.TARGET:
							viewTab[y][x].addChild(GameLoader.getAnimationFromAtlas("IsoGoal"));
						
						case Blocks.WALL:
							viewTab[y][x].addChild(GameLoader.getAnimationFromAtlas("IsoWall" + Math.ceil(Math.random() * 3)));
							
						
						case Blocks.EMPTY:
							viewTab[y][x].addChild(GameLoader.getAnimationFromAtlas("IsoEmpty"));
							viewTab[y][x].getChildAt(viewTab[y][x].numChildren - 1).visible = false;
					}
					
					z--;
				}
				
				lAllObjects.push({gridX: x, gridY: y});
			}
		}
		
		IsoManager.init(cellSize.gridX, cellSize.gridY);
		IsoManager.zSort(lAllObjects);
		
		var lViewPos: Point;
		for (cell in lAllObjects) {
			lViewPos = IsoManager.modelToIsoView(new Point(cell.gridX, cell.gridY));
			
			viewContainer.addChild(viewTab[cell.gridY][cell.gridX]);
			viewTab[cell.gridY][cell.gridX].x = lViewPos.x;
			viewTab[cell.gridY][cell.gridX].y = lViewPos.y;
		}
		
		GameStage.getInstance().getGameContainer().addChild(viewContainer);
		
		viewContainer.x = GameStage.getInstance().safeZone.width / 2;
        viewContainer.y = GameStage.getInstance().safeZone.height * 0.2;
        
        var lSafeArea: Float = GameStage.getInstance().safeZone.height * GameStage.getInstance().safeZone.width;
        var lContainerArea: Float = viewContainer.width * viewContainer.height;
        
        while (lContainerArea > lSafeArea) {
            viewContainer.scaleX *= 0.9;
            viewContainer.scaleY *= 0.9;
            
            lContainerArea = viewContainer.width * viewContainer.height;
        }
		
		oldLevel = pLevel;
	}
	
	public override function updateView(pLevel: Array<Array<Array<Blocks>>>): Void {
		var lCellsChanged: Array<Point> = new Array<Point>();
		
		for (y in 0...pLevel.length) {
			
			for (x in 0...pLevel[y].length) {
				
				for (z in 0...pLevel[y][x].length) {
					
					if (pLevel[y][x][z] != oldLevel[y][x][z]) {
						lCellsChanged.push(new Point(x, y));
						break;
					}
				}
			}
		}
		
		for (cell in lCellsChanged) {
			viewTab[Std.int(cell.y)][Std.int(cell.x)].removeChildren();
			
			var z: Int = pLevel[Std.int(cell.y)][Std.int(cell.x)].length - 1;
			
			while (z >= 0) {
				
				switch (pLevel[Std.int(cell.y)][Std.int(cell.x)][z]) {
					case Blocks.BOX:
						viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(GameLoader.getAnimationFromAtlas("IsoBox"));
					
					case Blocks.GROUND:
						viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(GameLoader.getAnimationFromAtlas("IsoFloor" + Math.ceil(Math.random()*3)));
					
					case Blocks.MIRROR:
						viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(GameLoader.getAnimationFromAtlas("IsoMirror"));
					
					case Blocks.PLAYER:
						viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(GameLoader.getAnimationFromAtlas("Player_IDLE_" + playerAnim));
					
					case Blocks.TARGET:
						viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(GameLoader.getAnimationFromAtlas("IsoGoal"));
					
					case Blocks.WALL:
						viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(GameLoader.getAnimationFromAtlas("IsoWall" + Math.ceil(Math.random() * 3)));
					
					case Blocks.EMPTY:
						viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(GameLoader.getAnimationFromAtlas("IsoEmpty"));
						viewTab[Std.int(cell.y)][Std.int(cell.x)].getChildAt(viewTab[Std.int(cell.y)][Std.int(cell.x)].numChildren - 1).visible = false;
				}
				
				z--;
			}
		}
		
		oldLevel = pLevel;
	}
	
	public function updatePlayerAsset(pMove: PlayerActions): Void {
		switch (pMove) {
			case PlayerActions.LEFT:
				playerAnim = "LEFT";
			
			case PlayerActions.RIGHT:
				playerAnim = "RIGHT";
			
			case PlayerActions.UP:
				playerAnim = "UP";
			
			case PlayerActions.DOWN:
				playerAnim = "DOWN";
		}
	}
	
	override public function destroy(): Void {
		super.destroy();
		instance = null;
	}
}