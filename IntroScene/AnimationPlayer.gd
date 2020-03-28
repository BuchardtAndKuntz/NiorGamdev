extends AnimationPlayer

var hasPlayed


func _ready():
	play("BlackOut")


func _process(delta):
	if(!is_playing()):
		get_tree().change_scene("res://Scenes/StartScene.tscn")
