extends CharacterBody2D

@export var movement_speed: float = 500
var character_direction: Vector2

func _physics_process(delta: float) -> void:
	character_direction.x = Input.get_axis("walk_left", "walk_right")
	character_direction.y = Input.get_axis("walk_up", "walk_down")
