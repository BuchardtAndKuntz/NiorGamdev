extends Panel





func _on_StartGame_pressed():
	show()


func _process(delta):
	if Input.is_action_just_pressed("jump") && visible==true:
		get_tree().change_scene("res://Scenes/MainLevel.tscn")
