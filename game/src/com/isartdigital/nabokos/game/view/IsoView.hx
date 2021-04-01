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
import motion.Actuate;
import motion.easing.Linear;


/**
 * Affichage du jeu au format Isométrique
 * @author Anthony TIREL--TARTUFFE
 */
class IsoView extends GameView {

	private var viewTab: Array<Array<Sprite>>;
	private var animTab: Array<Array<Array<Animation>>>;
	
	private var fadingOutBoxes: Array<Animation>;
	
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
		animTab = new Array<Array<Array<Animation>>>();
		fadingOutBoxes = new Array<Animation>();
		
		var lAllObjects: Array<CellDef> = new Array<CellDef>();
		var lAsset: Animation;
		
		for (y in 0...pLevel.length) {
			viewTab[y] = new Array<Sprite>();
			animTab[y] = new Array<Array<Animation>>();

			for (x in 0...pLevel[y].length) {
				viewTab[y][x] = new Sprite();
				animTab[y][x] = new Array<Animation>();
				
				var z: Int = pLevel[y][x].length - 1;
				
				while (z >= 0) {
					
					switch (pLevel[y][x][z]) {
						case Blocks.BOX:
							lAsset = GameLoader.getAnimationFromAtlas("IsoBox");
						
						case Blocks.GROUND:
							lAsset = GameLoader.getAnimationFromAtlas("IsoFloor" + Math.ceil(Math.random()*3));
						
						case Blocks.MIRROR:
							lAsset = GameLoader.getAnimationFromAtlas("IsoMirror");
						
						case Blocks.PLAYER:
							lAsset = GameLoader.getAnimationFromAtlas("Player_IDLE_UP");
						
						case Blocks.TARGET:
							lAsset = GameLoader.getAnimationFromAtlas("IsoGoal");
						
						case Blocks.WALL:
							lAsset = GameLoader.getAnimationFromAtlas("IsoWall" + Math.ceil(Math.random() * 3));
							
						
						case Blocks.EMPTY:
							lAsset = GameLoader.getAnimationFromAtlas("IsoEmpty");
							lAsset.visible = false;
					}
					
					viewTab[y][x].addChild(lAsset);
					animTab[y][x].push(lAsset);
					
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
			for (i in 0...animTab[Std.int(cell.y)][Std.int(cell.x)].length) {
				var lAnim: Animation = animTab[Std.int(cell.y)][Std.int(cell.x)][i];
				
				if (!fadingOutBoxes.contains(lAnim)) {
					viewTab[Std.int(cell.y)][Std.int(cell.x)].removeChild(lAnim);
				}
				
				if (lAnim.name == "IsoBox" || lAnim.name.indexOf("Player") != -1) {
					animTab[Std.int(cell.y)][Std.int(cell.x)].splice(i, 1);
				}
			}
			
			var z: Int = pLevel[Std.int(cell.y)][Std.int(cell.x)].length - 1;
			
			while (z >= 0) {
				
				var lBlock: Blocks = pLevel[Std.int(cell.y)][Std.int(cell.x)][z];
				
				if (lBlock == Blocks.GROUND || lBlock == Blocks.MIRROR || lBlock == Blocks.TARGET || lBlock == Blocks.EMPTY) {
					viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(animTab[Std.int(cell.y)][Std.int(cell.x)][0]);
				} 
				else if (lBlock == Blocks.PLAYER) {
					var lAnim: Animation = GameLoader.getAnimationFromAtlas("Player_IDLE_" + playerAnim);
					
					viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(lAnim);
					
					animTab[Std.int(cell.y)][Std.int(cell.x)].push(lAnim);
				} else if (lBlock == Blocks.BOX) {
					var lBox: Animation = GameLoader.getAnimationFromAtlas("IsoBox");
					
					if (!oldLevel[Std.int(cell.y)][Std.int(cell.x)].contains(Blocks.BOX) &&
						!oldLevel[Std.int(cell.y) + 1][Std.int(cell.x)].contains(Blocks.BOX) &&
						!oldLevel[Std.int(cell.y) - 1][Std.int(cell.x)].contains(Blocks.BOX) &&
						!oldLevel[Std.int(cell.y)][Std.int(cell.x) + 1].contains(Blocks.BOX) &&
						!oldLevel[Std.int(cell.y)][Std.int(cell.x) - 1].contains(Blocks.BOX)
					) {
						Actuate.tween(lBox, 0.5, {alpha:1}).ease(Linear.easeNone);
						lBox.alpha = 0;
					}
					
					viewTab[Std.int(cell.y)][Std.int(cell.x)].addChild(lBox);
					
					animTab[Std.int(cell.y)][Std.int(cell.x)].push(lBox);
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
	
	public function removeReflections(pCoords: Array<Point>){
		fadingOutBoxes = new Array<Animation>();
		
		for (pos in pCoords) {
			for (i in 0...animTab[Std.int(pos.y)][Std.int(pos.x)].length) {
				if (animTab[Std.int(pos.y)][Std.int(pos.x)][i].name == "IsoBox") {
					Actuate.tween(animTab[Std.int(pos.y)][Std.int(pos.x)][i], 0.2, {alpha: 0}).ease(Linear.easeNone);
					fadingOutBoxes.push(animTab[Std.int(pos.y)][Std.int(pos.x)][i]);
				}
			}
		}
	}
	
	public function winAnimation(): Void {
		for (y in 0...animTab.length) {
			for (x in 0...animTab[y].length) {
				for (z in 0...animTab[y][x].length) {
					if (animTab[y][x][z].name == "IsoBox") {
						
						Actuate.transform(animTab[y][x][z], 0.5).color(0xFFFFFF, 0.2).ease(Linear.easeNone);
						
						Actuate.transform(animTab[y][x][z], 0.5, false).color(0xFFFFFF, 0).ease(Linear.easeNone).delay(0.5);
					}
				}
			}
		}
		
		Actuate.timer(1.2).onComplete(LevelManager.win);
	}
	
	override public function destroy(): Void {
		super.destroy();
		instance = null;
	}
}