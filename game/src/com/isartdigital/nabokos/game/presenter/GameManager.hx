package com.isartdigital.nabokos.game.presenter;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.model.MoveHistory;
import com.isartdigital.nabokos.game.model.ScoreManager;
import com.isartdigital.nabokos.game.view.GameView;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.game.view.RadarView;
import com.isartdigital.nabokos.game.model.PlayerActions;
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
import haxe.Json;
import haxe.Template;
import haxe.Timer;
import openfl.Lib;
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
		Hud.getInstance().visible = true;
		
		var lRect :Rectangle = DeviceCapabilities.getScreenRect(GameStage.getInstance());
		
		controller = new KeyboardController(Main.getInstance().stage);
		mouseController = new MouseController();
		
		IsoView.getInstance().updateView(LevelManager.getCurrentLevel());
		RadarView.getInstance().updateView(LevelManager.getCurrentLevel());	
		
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
		trace(pValue);
	}

	public static function pauseGame() : Void
	{
		
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
			}
		}
		
		controller.doAction();
	}
}