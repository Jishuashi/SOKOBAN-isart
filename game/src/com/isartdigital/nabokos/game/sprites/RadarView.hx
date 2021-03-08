package com.isartdigital.nabokos.game.sprites;
import animateAtlasPlayer.core.Animation;
import com.isartdigital.nabokos.game.Blocks;
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
	private var cellSize : Point = new Point(0, 0);
	private var radarCellDef : CellDef = { gridX : 100, gridY : 100 };

	
	private static var instance: RadarView;
	public static function getInstance(): RadarView {
		if (instance == null) instance = new RadarView();
		return instance;
	}
	
	public function new()
	{
		super();
	}

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
							lAssets = GameLoader.getAnimationFromAtlas("RadarWall");
							
						case Blocks.PLAYER :
							lAssets = GameLoader.getAnimationFromAtlas("RadarPlayer");
						
						case Blocks.GROUND :
							lAssets = GameLoader.getAnimationFromAtlas("RadarFloor");
						
						case Blocks.TARGET :
							lAssets = GameLoader.getAnimationFromAtlas("RadarGoal");
						
						case Blocks.BOX :
							lAssets = GameLoader.getAnimationFromAtlas("RadarBox");
							
						default:
							lAssets = GameLoader.getAnimationFromAtlas("RadarFloor");
					}
					
					lAssets.x += x * radarCellDef.gridX;
					lAssets.y += y * radarCellDef.gridY;
					
					GameStage.getInstance().getGameContainer().addChild(lAssets);
					
					k--;
				}
			}
		}
	}
	
	override public function destroy(): Void {
		super.destroy();
		instance = null;
	}
}