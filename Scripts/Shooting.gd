extends Node

var scene_bullet_path = "res://GameObjects/Bullet.tscn"
onready var map = get_node("TileMap")

var shootDelay = 1
var shootCooldown = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if shootCooldown > 0:
		shootCooldown -= delta
		if shootCooldown < 0:
			shootCooldown = 0
	else:
		if Input.is_action_pressed("ui_shoot"):
			print("Shoot")
			shootCooldown = shootDelay
			shoot(2)
	
	pass

func shoot(directionVector):
	var bullet_scene = load(scene_bullet_path)
	var bullet_scene_instanced = bullet_scene.instance()
	
	# Calculate position
	var sprite_size_vector = bullet_scene_instanced.get_node("Area2D/Sprite").get_rect().size
	var temp_player_pos = Vector2(600,400) #TODO Should be the pos of the player or end of gun
	#var start_bullet_pos = map.map_to_world(temp_player_pos)
	var spawn_position = Vector2(temp_player_pos.x + (sprite_size_vector.x /2), temp_player_pos.y + (sprite_size_vector.y /2))
	
	# Set postition
	bullet_scene_instanced.global_translate(spawn_position)
	
	# Add to level
	get_parent().add_child(bullet_scene_instanced)
	
	# Set direction of bullet
	# TODO
	
	pass
