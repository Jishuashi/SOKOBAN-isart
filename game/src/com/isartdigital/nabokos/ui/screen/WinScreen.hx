package com.isartdigital.nabokos.ui.screen;

import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.model.ScoreManager;
import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.game.view.RadarView;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import haxe.Timer;
import motion.Actuate;
import motion.easing.Elastic;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import org.zamedev.particles.Particle;
import org.zamedev.particles.ParticleSystem;
import org.zamedev.particles.loaders.ParticleLoader;
import org.zamedev.particles.renderers.DefaultParticleRenderer;

/**
 * ...
 * @author Blanco
 */
class WinScreen extends Screen
{
	private static var instance: WinScreen;
	private var backgroundVictory:DisplayObject;
	private var victoryTitle:DisplayObject;
	private var buttonContinue:DisplayObject;
	private var buttonQuit:DisplayObject;
	private var victoryAnimation:MovieClip;
	
	private var star1 : DisplayObject;
	private var star2 : DisplayObject;
	private var blue : DisplayObject;

	private var txtScore : TextField;
	private var txtHighscore : TextField;

	private function new()
	{
		super();

		backgroundVictory	= content.getChildByName("backgroundVictory");
		victoryTitle		= content.getChildByName("victoryTitle");
		buttonContinue		= content.getChildByName("btnContinue");
		buttonQuit			= content.getChildByName("btnQuit");
		victoryAnimation 	= cast(content.getChildByName("victoryAnimation"), MovieClip);
		
		star1 = content.getChildByName("star1");
		star2 = content.getChildByName("star2");
		blue = content.getChildByName("blueStar");
		
		star1.scaleX = star1.scaleY = star2.scaleX = star2.scaleY = 0;
		
		txtScore = cast(content.getChildByName("txtScore"), TextField);
		txtHighscore = cast(content.getChildByName("txtHighscore"), TextField);

		buttonContinue.addEventListener(MouseEvent.CLICK, onClickContinue);
		buttonQuit.addEventListener(MouseEvent.CLICK, onClickQuit);

		txtScore.text = "Nombre de coups : " + ScoreManager.score;
		txtHighscore.text = "Highscore : " + ScoreManager.endScore;

		var lPositionnable:UIPositionable = {item:backgroundVictory, align:AlignType.FIT_SCREEN};
		positionables.push(lPositionnable);
		lPositionnable = { item:victoryTitle, align:AlignType.TOP, offsetY:200};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonContinue, align:AlignType.BOTTOM, offsetY:300};
		positionables.push(lPositionnable);
		lPositionnable = { item:buttonQuit, align:AlignType.BOTTOM, offsetY:100};
		positionables.push(lPositionnable);
		
		buttonContinue .alpha = 0;
		buttonQuit.alpha = 0;
		victoryAnimation .alpha = 0;
		txtScore.alpha = 0;
		txtHighscore .alpha = 0;

		Actuate.tween (victoryTitle, 		1, {scaleX:3, scaleY:3}).ease(Elastic.easeIn).reverse();
		Actuate.tween (buttonContinue, 		2, {alpha:1}).delay(1);
		Actuate.tween (buttonQuit, 			2, {alpha:1}).delay(1);
		Actuate.tween (victoryAnimation, 	2, {alpha:1}).delay(1);
		Actuate.tween (txtScore, 			2, {alpha:1}).delay(1);
		Actuate.tween (txtHighscore, 		2, {alpha:1}).delay(1);
	}

	public static function getInstance (): WinScreen
	{
		if (instance == null) instance = new WinScreen();
		return instance;
	}
	
	public function displayStars():Void
	{
		if (LevelManager.allStars[LevelManager.levelNum] == 1)
		{
			Actuate.tween(star1 , 1 , {scaleX : 3 , scaleY : 3});
		}
		else 
		{
			
			Actuate.tween(star1 , 1 , {scaleX : 3 , scaleY : 3});
			Actuate.tween(star2 , 1 , {scaleX : 3 , scaleY : 3});
			
			blue.visible = false;
			
			Actuate.tween(star1 , 2 , {rotation : 360});
			Actuate.tween(star2 , 2 , {rotation : 360});
		}
		
	}	

	private function onClickContinue(pEvent:MouseEvent) : Void
	{
		IsoView.getInstance().resetView();
		RadarView.getInstance().resetView();
		GameManager.mouseController.destroy();

		LevelManager.levelNum += 1;
		LevelManager.selectLevel(LevelManager.levelNum);

		GameManager.start();

		SoundManager.clickSound();
	}

	private function onClickQuit(pEvent:MouseEvent) : Void
	{
		IsoView.getInstance().resetView();
		RadarView.getInstance().resetView();
		GameManager.mouseController.destroy();

		Main.getInstance().game1.fadeOut(0.005);
		Timer.delay(function()
		{
			Main.getInstance().game1.stop();
		}, 500);
		Main.getInstance().ambiance1.start();
		Main.getInstance().ambiance1.fadeIn(0.005);

		UIManager.addScreen(TitleCard.getInstance());
		SoundManager.clickSound();
	}

	override public function destroy (): Void
	{
		instance = null;
		buttonContinue.removeEventListener(MouseEvent.CLICK, onClickContinue);
		buttonQuit.removeEventListener(MouseEvent.CLICK, onClickQuit);
		super.destroy();
	}
}