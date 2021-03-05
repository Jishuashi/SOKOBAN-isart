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

	public function new()
	{
		super();
	}

	override public function updateView(pLevel:Array<Array<Blocks>>)
	{
		super.updateView(pLevel);

		var lAssets : Animation;

		for (i in 0 ... pLevel.length)
		{
			for (j in 0 ... pLevel[i].length)
			{

				if (pLevel[i][j] == Blocks.WALL)
				{
					lAssets = GameLoader.getAnimationFromAtlas("RadarWall");

					lAssets.x += j * radarCellDef.gridX;
					lAssets.y += i * radarCellDef.gridY;

					GameStage.getInstance().getGameContainer().addChild(lAssets);
					continue;
				}
				else if (pLevel[i][j] == Blocks.PLAYER)
				{
					lAssets = GameLoader.getAnimationFromAtlas("RadarPlayer");

					lAssets.x += j * radarCellDef.gridX;
					lAssets.y += i * radarCellDef.gridY;

					GameStage.getInstance().getGameContainer().addChild(lAssets);
					continue;
				}
				else if (pLevel[i][j] == Blocks.GROUND)
				{
					lAssets = GameLoader.getAnimationFromAtlas("RadarFloor");

					lAssets.x += j * radarCellDef.gridX;
					lAssets.y += i * radarCellDef.gridY;

					GameStage.getInstance().getGameContainer().addChild(lAssets);
					continue;
				}
				else if (pLevel[i][j] == Blocks.TARGET)
				{
					lAssets = GameLoader.getAnimationFromAtlas("RadarGoal");

					lAssets.x += j * radarCellDef.gridX;
					lAssets.y += i * radarCellDef.gridY;

					GameStage.getInstance().getGameContainer().addChild(lAssets);
					continue;
				}
				else if (pLevel[i][j] == Blocks.BOX)
				{
					lAssets = GameLoader.getAnimationFromAtlas("RadarBox");

					lAssets.x += j * radarCellDef.gridX;
					lAssets.y += i * radarCellDef.gridY;

					GameStage.getInstance().getGameContainer().addChild(lAssets);
					continue;
				}
			}

		}

	}

}