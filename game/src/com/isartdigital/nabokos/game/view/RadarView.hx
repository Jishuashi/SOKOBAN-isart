package com.isartdigital.nabokos.game.view;
import animateAtlasPlayer.core.Animation;
import com.isartdigital.nabokos.game.model.Blocks;
import com.isartdigital.nabokos.game.view.GameView;
import com.isartdigital.utils.game.GameStage;
import com.isartdigital.utils.game.grids.CellDef;
import com.isartdigital.utils.loader.GameLoader;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.display.Shape;
import openfl.geom.Point;

/**
 * ...
 * @author Hugo CHARTIER
 */
class RadarView extends GameView
{
	
	private static var instance: RadarView;
	public static function getInstance(): RadarView {
		if (instance == null) instance = new RadarView();
		return instance;
	}
	
	public function new()
	{
		super();
		cellSize = { gridX : 100, gridY : 100 };
		
		viewContainer = new Sprite();
		viewContainer.scaleX = 0.66;
		viewContainer.scaleY = 0.66;
	}
	
	/**
	 * Met à jouer la vue Radar en fonction du niveau actuel
	 * @param	pLevel niveau actuel
	 */
	override public function updateView(pLevel:Array<Array<Array<Blocks>>>)
	{
		super.updateView(pLevel);
		
		var lAssets : Animation;
		
		for (y in 0 ... pLevel.length)
		{
			for (x in 0 ... pLevel[y].length)
			{
				var k: Int = pLevel[y][x].length-1;
				
				while (k >= 0) {
					
					switch (pLevel[y][x][k]) {
						case Blocks.WALL:
							lAssets = GameLoader.getAnimationFromAtlas("RadarWall1");
							
						case Blocks.PLAYER :
							lAssets = GameLoader.getAnimationFromAtlas("RadarPlayer");
						
						case Blocks.GROUND :
							lAssets = GameLoader.getAnimationFromAtlas("RadarFloor1");
						
						case Blocks.TARGET :
							lAssets = GameLoader.getAnimationFromAtlas("RadarGoal");
						
						case Blocks.BOX :
							lAssets = GameLoader.getAnimationFromAtlas("RadarBox");
							
						case Blocks.MIRROR :
							lAssets = GameLoader.getAnimationFromAtlas("RadarMirror");
							
						default:
							lAssets = GameLoader.getAnimationFromAtlas("RadarFloor1");
					}
					
					lAssets.x += x * cellSize.gridX;
					lAssets.y += y * cellSize.gridY;
					
					viewContainer.addChild(lAssets);
					
					k--;
				}
			}
		}
		
		viewContainer.alpha = 0.65;
		
		GameStage.getInstance().getGameContainer().addChild(viewContainer);
	}
	
	override public function destroy(): Void {
		super.destroy();
		instance = null;
	}
}