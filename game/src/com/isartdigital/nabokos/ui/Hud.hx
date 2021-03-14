package com.isartdigital.nabokos.ui;

import com.isartdigital.nabokos.game.model.Blocks;
import com.isartdigital.nabokos.game.model.LevelManager;
import com.isartdigital.nabokos.game.model.MoveHistory;
import com.isartdigital.nabokos.game.model.ScoreManager;
import com.isartdigital.nabokos.game.view.IsoView;
import com.isartdigital.nabokos.game.view.RadarView;
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

		txtScore.text = "Coups : " + ScoreManager.get_score();

		btnRetry = content.getChildByName("btnRetry");
		btnUndo = content.getChildByName("btnUndo");
		btnRedo = content.getChildByName("btnRedo");

		btnRetry.addEventListener(MouseEvent.CLICK, retry);
		btnRedo.addEventListener(MouseEvent.CLICK, redo);
		btnUndo.addEventListener(MouseEvent.CLICK, undo);
	}

	public function redo(pEvent : MouseEvent): Void
	{
		var lLevel: Array<Array<Array<Blocks>>> = MoveHistory.getInstance().redo();

		if (lLevel.length != 0)
		{
			ScoreManager.set_score(ScoreManager.get_score() + 1);
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

		if (ScoreManager.get_score() != 0)
		{
			ScoreManager.set_score(ScoreManager.get_score() - 1);
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

		ScoreManager.set_score(0);
		ScoreManager.updateScore();

		IsoView.getInstance().updateView(LevelManager.getCurrentLevel());
		RadarView.getInstance().updateView(LevelManager.getCurrentLevel());
	}

	override public function destroy():Void
	{
		instance = null;
		super.destroy();
	}
}