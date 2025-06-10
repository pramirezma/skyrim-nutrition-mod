Scriptname _NutritionCalc extends ActiveMagicEffect

ObjectReference Property ActorFromYourMod Auto
MagicEffect Property MagicEffectFromYourMod Auto

int Property _ITEM_CARBS_QUALITY auto
int Property _ITEM_PROTEIN_QUALITY Auto
int Property _ITEM_FATS_QUALITY auto

Spell property NutritionUnhealthyBalanced auto
Spell property NutritionNormalBalanced auto
Spell property NutritionHealthyBalanced auto
Spell property NutritionUnhealthyCarbsProteinFocused auto
Spell property NutritionNormalCarbsProteinFocused auto
Spell property NutritionHealthyCarbsProteinFocused auto
Spell property NutritionUnhealthyCarbsFatFocused auto
Spell property NutritionNormalCarbsFatFocused auto
Spell property NutritionHealthyCarbsFatFocused auto
Spell property NutritionUnhealthyFatProteinFocused auto
Spell property NutritionNormalFatProteinFocused auto
Spell property NutritionHealthyFatProteinFocused auto
Spell property NutritionUnhealthyCarbsFocused auto
Spell property NutritionNormalCarbsFocused auto
Spell property NutritionHealthyCarbsFocused auto
Spell property NutritionUnhealthyProteinFocused auto
Spell property NutritionNormalProteinFocused auto
Spell property NutritionHealthyProteinFocused auto
Spell property NutritionUnhealthyFatFocused auto
Spell property NutritionNormalFatFocused auto
Spell property NutritionHealthyFatFocused auto

GlobalVariable Property _CURRENT_CARBS_QUALITY auto
GlobalVariable Property _CURRENT_PROTEIN_QUALITY auto
GlobalVariable Property _CURRENT_FATS_QUALITY auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    RegisterForSleep() 

    If _ITEM_CARBS_QUALITY > _CURRENT_CARBS_QUALITY.GetValue()
        _CURRENT_CARBS_QUALITY.SetValue(_ITEM_CARBS_QUALITY)
        Debug.Notification("Carbs quality is now: " + _CURRENT_CARBS_QUALITY.GetValue())
    EndIf

    If _ITEM_PROTEIN_QUALITY > _CURRENT_PROTEIN_QUALITY.GetValue()
        _CURRENT_PROTEIN_QUALITY.SetValue(_ITEM_PROTEIN_QUALITY)
        Debug.Notification("Protein quality is now: " + _CURRENT_PROTEIN_QUALITY.GetValue())
    EndIf

    If _ITEM_FATS_QUALITY > _CURRENT_FATS_QUALITY.GetValue()
        _CURRENT_FATS_QUALITY.SetValue(_ITEM_FATS_QUALITY)
        Debug.Notification("Fats quality is now: " + _CURRENT_FATS_QUALITY.GetValue())
    EndIf
; think is better to use 2 type of active effect, one from the food and the other for the spells, the food makes the calculation
; of wich lvl of nutrition is and add a spell with the active effect that is registered for sleep, and these effects are the one
; that can add calculation on others scripts like the stats growth
; 3 differents "type of spells" "with 3 lvls for each"
; logic is
; take the level and the type of the food
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Debug.Notification("Player went with the effect " + MagicEffectFromYourMod.GetName())
endEvent


Function CalculateDiet(int carbsQuality, int proteinQuality, int fatQuality, Actor akTarget)
    int maxQuality = GetMaxQuality(carbsQuality, proteinQuality, fatQuality)
    Spell dietEffect = None

    If carbsQuality == maxQuality && proteinQuality == maxQuality && fatQuality == maxQuality
        If maxQuality == 0
            dietEffect = NutritionUnhealthyBalanced
        ElseIf maxQuality == 1
            dietEffect = NutritionNormalBalanced
        ElseIf maxQuality == 2
            dietEffect = NutritionHealthyBalanced
        EndIf
    ElseIf carbsQuality == maxQuality && proteinQuality == maxQuality
        If maxQuality == 0
            dietEffect = NutritionUnhealthyCarbsProteinFocused
        ElseIf maxQuality == 1
            dietEffect = NutritionNormalCarbsProteinFocused
        ElseIf maxQuality == 2
            dietEffect = NutritionHealthyCarbsProteinFocused
        EndIf
    ElseIf carbsQuality == maxQuality && fatQuality == maxQuality
        If maxQuality == 0
            dietEffect = NutritionUnhealthyCarbsFatFocused
        ElseIf maxQuality == 1
            dietEffect = NutritionNormalCarbsFatFocused
        ElseIf maxQuality == 2
            dietEffect = NutritionHealthyCarbsFatFocused
        EndIf
    ElseIf proteinQuality == maxQuality && fatQuality == maxQuality
        If maxQuality == 0
            dietEffect = NutritionUnhealthyFatProteinFocused
        ElseIf maxQuality == 1
            dietEffect = NutritionNormalFatProteinFocused
        ElseIf maxQuality == 2
            dietEffect = NutritionHealthyFatProteinFocused
        EndIf
    ElseIf carbsQuality == maxQuality
        If maxQuality == 0
            dietEffect = NutritionUnhealthyCarbsFocused
        ElseIf maxQuality == 1
            dietEffect = NutritionNormalCarbsFocused
        ElseIf maxQuality == 2
            dietEffect = NutritionHealthyCarbsFocused
        EndIf
    ElseIf proteinQuality == maxQuality
        If maxQuality == 0
            dietEffect = NutritionUnhealthyProteinFocused
        ElseIf maxQuality == 1
            dietEffect = NutritionNormalProteinFocused
        ElseIf maxQuality == 2
            dietEffect = NutritionHealthyProteinFocused
        EndIf
    ElseIf fatQuality == maxQuality
        If maxQuality == 0
            dietEffect = NutritionUnhealthyFatFocused
        ElseIf maxQuality == 1
            dietEffect = NutritionNormalFatFocused
        ElseIf maxQuality == 2
            dietEffect = NutritionHealthyFatFocused
        EndIf
    EndIf

    If dietEffect != None
        akTarget.AddSpell(dietEffect)
        Debug.Notification("Diet effect applied: " + dietEffect.GetName())
    EndIf
EndFunction


int Function GetMaxQuality(int a, int b, int c)
    int max = a
    if b > max
        max = b
    endif
    if c > max
        max = c
    endif
    return max
EndFunction

Function RemovePreviousNutritionSpell(Actor akTarget)
    Spell[] nutritionSpells = new Spell[21]
    nutritionSpells[0] = NutritionUnhealthyBalanced
    nutritionSpells[1] = NutritionNormalBalanced
    nutritionSpells[2] = NutritionHealthyBalanced
    nutritionSpells[3] = NutritionUnhealthyCarbsProteinFocused
    nutritionSpells[4] = NutritionNormalCarbsProteinFocused
    nutritionSpells[5] = NutritionHealthyCarbsProteinFocused
    nutritionSpells[6] = NutritionUnhealthyCarbsFatFocused
    nutritionSpells[7] = NutritionNormalCarbsFatFocused
    nutritionSpells[8] = NutritionHealthyCarbsFatFocused
    nutritionSpells[9] = NutritionUnhealthyFatProteinFocused
    nutritionSpells[10] = NutritionNormalFatProteinFocused
    nutritionSpells[11] = NutritionHealthyFatProteinFocused
    nutritionSpells[12] = NutritionUnhealthyCarbsFocused
    nutritionSpells[13] = NutritionNormalCarbsFocused
    nutritionSpells[14] = NutritionHealthyCarbsFocused
    nutritionSpells[15] = NutritionUnhealthyProteinFocused
    nutritionSpells[16] = NutritionNormalProteinFocused
    nutritionSpells[17] = NutritionHealthyProteinFocused
    nutritionSpells[18] = NutritionUnhealthyFatFocused
    nutritionSpells[19] = NutritionNormalFatFocused
    nutritionSpells[20] = NutritionHealthyFatFocused

    int i = 0
    Bool bBreak = False
    while (i < nutritionSpells.Length) && !bBreak
        if akTarget.HasSpell(nutritionSpells[i])
            akTarget.RemoveSpell(nutritionSpells[i])
            Debug.Notification("Removed previous nutrition spell: " + nutritionSpells[i].GetName())
            bBreak = True
        endif
        i += 1
    endwhile
EndFunction