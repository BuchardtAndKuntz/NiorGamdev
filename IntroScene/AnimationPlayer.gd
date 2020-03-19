extends AnimationPlayer

var hasPlayed


func _ready():
	play("BlackOut")


#func _process(delta):
	#if(!is_playing()):
	#	get_tree().change_scene("res://Scenes/MenuScene.tscn")
		
	#if Input.is_action_pressed("dogde"):
	#	LoadingScene.change_scene("res://Splash.tscn","res://Scenes/MenuScene.tscn",0.0)
	#if Input.is_action_pressed("close_game"):
	#	LoadingScene.change_scene("res://Splash.tscn","res://Scenes/MenuScene.tscn",0.0)
