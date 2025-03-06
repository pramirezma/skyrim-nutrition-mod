Scriptname _NutritionCalc extends ActiveMagicEffect

ObjectReference Property ActorFromYourMod Auto
MagicEffect Property MagicEffectFromYourMod Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
    RegisterForSleep() 
; think is better to use 2 type of active effect, one from the food and the other for the spells, the food makes the calculation
; of wich lvl of nutrition is and add a spell with the active effect that is registered for sleep, and these effects are the one
; that can add calculation on others scripts like the stats growth
; 3 differents "type of spells" "with 3 lvls for each"
; logic is
; take the level and the type of the food

    Debug.Notification("started the effect loloolo")
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Debug.Notification("Player went with the effect " + MagicEffectFromYourMod.GetName())
endEvent