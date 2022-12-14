package com.isartdigital.nabokos.ui;
import com.isartdigital.nabokos.ui.screen.Help;
import com.isartdigital.nabokos.ui.screen.Highscores;
import com.isartdigital.nabokos.ui.screen.LevelScreen;
import com.isartdigital.nabokos.ui.screen.TitleCard;
import haxe.Json;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.display.SimpleButton;
import openfl.text.TextField;

/**
 * ...
 * @author Denis Loni Majid
 */
class Traduction
{
	public static var english: Bool = true;
	
	private static var traductionData: String;
	private static var tradObject: Dynamic;
	
	public function new()
	{
		
	}

	public static function init(pData:String):Void
	{
		traductionData = pData;
		tradObject = Json.parse(traductionData);
	}
	
	public static function getField(pField: String) : Dynamic
	{
		return Reflect.field(tradObject, "LABEL_" + pField);
	}
	
	public static function translateToFrench():Void
	{
		TitleCard.getInstance().translateButtonsTitleCard(false);
		LevelScreen.getInstance().translateButtonsLevelScreen(false);
		Highscores.getInstance().translateButtonsHighscore(false);
		Help.getInstance().translateButtonsHelp(false);
	}
	
	public static function translateToEnglish():Void
	{
		TitleCard.getInstance().translateButtonsTitleCard(true);
		LevelScreen.getInstance().translateButtonsLevelScreen(true);
		Highscores.getInstance().translateButtonsHighscore(true);
		Help.getInstance().translateButtonsHelp(true);
	}
	
	public static function getTextUp(pButton:DisplayObject): TextField
	{
		var lButton: SimpleButton = cast(pButton, SimpleButton);
		var lBtn : DisplayObjectContainer = cast(lButton.upState, DisplayObjectContainer);
		var lReturn: TextField = new TextField();
		
        for (i in 0...lBtn.numChildren)
        {
            
            if (Std.is(lBtn.getChildAt(i), MovieClip))
            {
                var lBtnChild : MovieClip = cast(lBtn.getChildAt(i), MovieClip);
                var lChildDisplay : DisplayObjectContainer = cast(lBtnChild , DisplayObjectContainer);
                
                for (j in 0... lBtn.numChildren)
                {
                    if (Std.is(lChildDisplay.getChildAt(j) ,TextField))
                    {
                        lReturn = cast(lChildDisplay.getChildAt(j), TextField);
                    }
                }
            }
        }
		
		return lReturn;
	}
	
	public static function getTextOver(pButton:DisplayObject): TextField
	{
		var lButton: SimpleButton = cast(pButton, SimpleButton);
		var lBtn : DisplayObjectContainer = cast(lButton.overState, DisplayObjectContainer);
		var lReturn: TextField = new TextField();
		
        for (i in 0...lBtn.numChildren)
        {
            
            if (Std.is(lBtn.getChildAt(i), MovieClip))
            {
                var lBtnChild : MovieClip = cast(lBtn.getChildAt(i), MovieClip);
                var lChildDisplay : DisplayObjectContainer = cast(lBtnChild , DisplayObjectContainer);
                
                for (j in 0... lBtn.numChildren)
                {
                    if (Std.is(lChildDisplay.getChildAt(j) ,TextField))
                    {
                        lReturn = cast(lChildDisplay.getChildAt(j), TextField);
                    }
                }
            }
        }
		
		return lReturn;
	}
	
	public static function getTextHelp(pObject: DisplayObject):TextField
	{
		var lObjectContainer: DisplayObjectContainer = cast(pObject, DisplayObjectContainer);
		var lReturn: TextField = new TextField();
		
		for (i in 0...lObjectContainer.numChildren)
		{
			if (Std.is(lObjectContainer.getChildAt(i), MovieClip))
            {
                var lChildDisplay : DisplayObjectContainer = cast(lObjectContainer.getChildAt(i) , DisplayObjectContainer);
                
                for (j in 0... lChildDisplay.numChildren)
                {
                    if (Std.is(lChildDisplay.getChildAt(j) ,TextField))
                    {
                        lReturn = cast(lChildDisplay.getChildAt(j), TextField);
                    }
                }
            }
		}
		
		return lReturn;
	}
}