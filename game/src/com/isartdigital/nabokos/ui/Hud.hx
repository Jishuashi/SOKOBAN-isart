package com.isartdigital.nabokos.ui;

import com.isartdigital.nabokos.game.model.Blocks;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.model.MoveHistory;
import com.isartdigital.nabokos.game.model.ScoreManager;
import com.isartdigital.nabokos.game.presenter.GameManager;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.game.view.RadarView;
import com.isartdigital.utils.game.GameStage;
import com.isartdigital.nabokos.ui.screen.LevelScreen;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import openfl.Lib;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.SimpleButton;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;

/**
 * ...
 * @author Chadi Husser
 */
class Hud extends Screen
{
	private static var instance : Hud;

	private var btnRetry : DisplayObject;
	private var btnUndo : DisplayObject;
	private var btnRedo : DisplayObject;
	//private var btnQuit : DisplayObject;
	//private var backgroundHud : DisplayObject;
	public var levelNumber : TextField;
	private static var mcTopCenter : MovieClip;

	private var redoIsPossible : Bool = false;

	public static var txtScore : TextField;

	public static function getInstance() : Hud
	{
		if (instance == null) instance = new Hud();
		return instance;
	}

	public function new()
	{
		super();

		var lPositionnable:UIPositionable;
		lPositionnable = { item:content.getChildByName("mcTopCenter"), align:AlignType.TOP};
		positionables.push(lPositionnable);

		mcTopCenter = cast(lPositionnable.item, MovieClip);

		txtScore = cast(mcTopCenter.getChildByName("txtScore"), TextField);

		txtScore.text = "Coups : " + ScoreManager.score;

		btnRetry = content.getChildByName("btnRetry");
		btnUndo = content.getChildByName("btnUndo");
		btnRedo = content.getChildByName("btnRedo");
		//btnQuit = content.getChildByName("btnQuit");
		//btnPause = content.getChildByName("backgroundHud");
		levelNumber = cast(content.getChildByName("levelNumber"), TextField);

		btnRetry.addEventListener(MouseEvent.CLICK, retry);
		btnRedo.addEventListener(MouseEvent.CLICK, redo);
		btnUndo.addEventListener(MouseEvent.CLICK, undo);
		//btnQuit.addEventListener(MouseEvent.CLICK, quit);
		
		lPositionnable = { item:btnRetry, align:AlignType.TOP_RIGHT, offsetY:100, offsetX:250};
		positionables.push(lPositionnable);
		lPositionnable = { item:btnUndo, align:AlignType.BOTTOM_RIGHT, offsetY:100, offsetX:250};
		positionables.push(lPositionnable);
		lPositionnable = { item:btnRedo, align:AlignType.BOTTOM_RIGHT, offsetY:250, offsetX:250};
		positionables.push(lPositionnable);
		//lPositionnable = { item:btnQuit, align:AlignType.TOP_LEFT, offsetY:100, offsetX:650};
		//positionables.push(lPositionnable);
		//lPositionnable = { item:backgroundHud, align:AlignType.FIT_SCREEN};
		//positionables.push(lPositionnable);
	}

	public function redo(pEvent : MouseEvent): Void
	{
		var lLevel: Array<Array<Array<Blocks>>> = MoveHistory.getInstance().redo();

		if (lLevel.length != 0)
		{
			ScoreManager.score++;
			ScoreManager.updateScore();
		}

		if (lLevel != null)
		{
			LevelManager.editCurrentLevel(lLevel);
			
			IsoView.getInstance().updateView(lLevel);
			RadarView.getInstance().updateView(lLevel);
		}
	}

	public function undo(pEvent : MouseEvent): Void
	{
		var lLevel: Array<Array<Array<Blocks>>> = MoveHistory.getInstance().undo();

		if (ScoreManager.score != 0)
		{
			ScoreManager.score--;
			ScoreManager.updateScore();
		}

		if (lLevel != null)
		{
			LevelManager.editCurrentLevel(lLevel);

			IsoView.getInstance().updateView(lLevel);
			RadarView.getInstance().updateView(lLevel);
		}
	}

	public function retry(pEvent : MouseEvent): Void
	{
		LevelManager.selectLevel(LevelManager.levelNum);

		ScoreManager.score = 0;
		ScoreManager.updateScore();

		IsoView.getInstance().init(LevelManager.getCurrentLevel());
		RadarView.getInstance().updateView(LevelManager.getCurrentLevel());
	}
	
	private function quit(pEvent:MouseEvent) : Void
	{
		UIManager.addScreen(LevelScreen.getInstance());
		//Hud.getInstance().visible = false;
		SoundManager.getSound("click").start();
	}

	override public function destroy():Void
	{
		instance = null;
		btnRetry.removeEventListener(MouseEvent.CLICK, retry);
		btnRedo.removeEventListener(MouseEvent.CLICK, redo);
		btnUndo.removeEventListener(MouseEvent.CLICK, undo);
		//btnQuit.removeEventListener(MouseEvent.CLICK, quit);
		super.destroy();
	}
}