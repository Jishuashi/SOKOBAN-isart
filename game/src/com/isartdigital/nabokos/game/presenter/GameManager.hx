package com.isartdigital.nabokos.game.presenter;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.model.MoveHistory;
import com.isartdigital.nabokos.game.model.ScoreManager;
import com.isartdigital.nabokos.game.view.GameView;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.game.view.RadarView;
import com.isartdigital.nabokos.game.model.PlayerActions;
import com.isartdigital.nabokos.ui.screen.LevelScreen;
import com.isartdigital.nabokos.ui.Hud;
import com.isartdigital.nabokos.ui.UIManager;
import com.isartdigital.utils.debug.Debug;
import com.isartdigital.utils.game.GameStage;
import com.isartdigital.nabokos.game.presenter.KeyboardController;
import com.isartdigital.utils.loader.GameLoader;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.system.DeviceCapabilities;
import com.isartdigital.utils.system.Monitor;
import com.isartdigital.utils.system.MonitorField;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.UIPositionable;
import haxe.Json;
import haxe.Template;
import haxe.Timer;
import openfl.Lib;
import openfl.display.DisplayObject;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import org.zamedev.particles.ParticleSystem;
import org.zamedev.particles.loaders.ParticleLoader;
import org.zamedev.particles.renderers.DefaultParticleRenderer;

/**
 * ...
 * @author Chadi Husser
 */
class GameManager
{
	public static var controller:KeyboardController;
	public static var mouseController: MouseController;
	private static var particleSystem :ParticleSystem;
	private static var controls:DisplayObject;
	public static var soundOn:Bool;
	public static var englishOn:Bool;

	public static function start() : Void
	{
		
		UIManager.closeScreens();
		
		Main.getInstance().ambiance1.fadeOut(0.005);
		Timer.delay(function(){
			Main.getInstance().ambiance1.stop();
		}, 500);
		Main.getInstance().game1.start();
		Main.getInstance().game1.fadeIn(0.005);
		
		UIManager.openHud();
		//Hud.getInstance().visible = true;
		Hud.getInstance().levelNumber.text = "level " + LevelManager.levelNum;
		
		Hud.getInstance().controls.alpha = 0;
		if (LevelManager.levelNum == 0)
		{
			Hud.getInstance().controls.alpha = 1;
		}
		
		//if (LevelManager.levelNum == 0)
		//{
			//controls = content.getChildByName("controls");
			//controls.alpha = 1;
			//var lPositionnable:UIPositionable = { item:controls, align:AlignType.BOTTOM_LEFT, offsetY:100, offsetX:100};
			//positionables.push(lPositionnable);
		//}
		//else
		//{
			//controls = content.getChildByName("controls");
			//controls.alpha = 0;
		//}
		
		var lRect :Rectangle = DeviceCapabilities.getScreenRect(GameStage.getInstance());
		
		IsoView.getInstance().init(LevelManager.getCurrentLevel());
		RadarView.getInstance().updateView(LevelManager.getCurrentLevel());	
		
		controller = new KeyboardController(Main.getInstance().stage);
		mouseController = new MouseController();
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, gameLoop);
	}

	public static function resumeGame() : Void
	{
	}

	private static function onClick(pEvent:MouseEvent) : Void
	{
		particleSystem.emit(GameStage.getInstance().getGameContainer().mouseX, GameStage.getInstance().getGameContainer().mouseY);
		particleSystem.resume();
	}

	private static function onChange(pValue:Bool) : Void
	{
	}

	public static function pauseGame() : Void
	{
		Lib.current.stage.removeEventListener(Event.ENTER_FRAME, gameLoop);
	}

	private static function gameLoop(pEvent:Event) : Void
	{
		var lPlayerAction: PlayerActions = null;
		
		if (controller.isLeftDown()) {
			lPlayerAction = PlayerActions.LEFT;
		}
		else if (controller.isRightDown()) {
			lPlayerAction = PlayerActions.RIGHT;
		}
		else if (controller.isDownDown()) {
			lPlayerAction = PlayerActions.DOWN;
		}
		else if (controller.isUpDown()) {
			lPlayerAction = PlayerActions.UP;
		}
		
		if (lPlayerAction != null) {
			if (LevelManager.playerAction(lPlayerAction)) {
				MoveHistory.getInstance().newMove(LevelManager.getCurrentLevel(), LevelManager.getBoxPosisition());
				
				IsoView.getInstance().updatePlayerAsset(lPlayerAction);
				IsoView.getInstance().updateView(LevelManager.getCurrentLevel());
				RadarView.getInstance().updateView(LevelManager.getCurrentLevel());
				
				LevelManager.winCondition();
			}
		}
		controller.doAction();
	}
}