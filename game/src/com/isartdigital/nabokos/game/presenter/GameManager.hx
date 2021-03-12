package com.isartdigital.nabokos.game.presenter;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.view.GameView;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.game.view.RadarView;
import com.isartdigital.nabokos.game.sprites.Template;
import com.isartdigital.nabokos.game.model.PlayerActions;
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
	private static var particleSystem :ParticleSystem;

	public static function start() : Void
	{
		
		UIManager.closeScreens();
		
		UIManager.openHud();
		
		var lJson:Dynamic = Json.parse(GameLoader.getText("assets/settings/player.json"));
		Monitor.setSettings(lJson, Template.getInstance());
		
		var fields : Array<MonitorField> = [{name:"smoothing", onChange:onChange}, {name:"x", step:1}, {name:"y", step:100}];
		Monitor.start(Template.getInstance(), fields, lJson);
		
		var lRect :Rectangle = DeviceCapabilities.getScreenRect(GameStage.getInstance());
		
		controller = new KeyboardController(Main.getInstance().stage);
		
		IsoView.getInstance().updateView(LevelManager.getCurrentLevel());
		RadarView.getInstance().updateView(LevelManager.getCurrentLevel());	
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, gameLoop);
	}

	public static function resumeGame() : Void
	{
		SoundManager.getSound("world1").start();
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
			IsoView.getInstance().updatePlayerAsset(PlayerActions.LEFT);
			lPlayerAction = PlayerActions.LEFT;
		}
		else if (controller.isRightDown()) {
			IsoView.getInstance().updatePlayerAsset(PlayerActions.RIGHT);
			lPlayerAction = PlayerActions.RIGHT;
		}
		else if (controller.isDownDown()) {
			IsoView.getInstance().updatePlayerAsset(PlayerActions.DOWN);
			lPlayerAction = PlayerActions.DOWN;
		}
		else if (controller.isUpDown()) {
			IsoView.getInstance().updatePlayerAsset(PlayerActions.UP);
			lPlayerAction = PlayerActions.UP;
		}
		
		if (lPlayerAction != null) {
			if (LevelManager.playerAction(lPlayerAction)) {
				IsoView.getInstance().updateView(LevelManager.getCurrentLevel());
				RadarView.getInstance().updateView(LevelManager.getCurrentLevel());
			}
		}
		
		controller.doAction();
	}
}