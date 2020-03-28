extends Panel

onready var label = $Label
var StrSttart = "Congratulations you made it home to your cauldron! \n Time to for some poultry soup! \n \n \n \n You found "
var StrEnd = " ingredients! \n \n Press escape to quit \n or \n press Enter to keep playing"



func updateCount():
	label.text = String(StrSttart + str(AbilityFlags.ingredients) + StrEnd)


func _on_WinScreen_visibility_changed():
	if visible==true:
		updateCount()
