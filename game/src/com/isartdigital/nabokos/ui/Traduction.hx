package com.isartdigital.nabokos.ui;
import com.isartdigital.nabokos.ui.screen.Options;
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
	private static var traductionData: String;
	private static var tradObject: Dynamic;

	public function new()
	{
		
	}

	public static function init(pData:String):Void
	{
		traductionData = pData;
		tradObject = Json.parse(traductionData);
		
		trace(getField("PLAY").en, "trad");
	}
	
	public static function getField(pField: String) : Dynamic
	{
		return Reflect.field(tradObject, "LABEL_" + pField);
	}
	
	public static function translateToFrench():Void
	{
		Options.getInstance().translateButtonsOption(false);
		TitleCard.getInstance().translateButtonsTitleCard(false);
	}
	
	public static function translateToEnglish():Void
	{
		Options.getInstance().translateButtonsOption(true);
		TitleCard.getInstance().translateButtonsTitleCard(true);
	}
	
	public static function getText(pButton:DisplayObject): TextField
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
}