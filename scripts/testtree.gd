extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var health = 3

func _ready() -> void:
	add_to_group("trees")

func _process(delta: float):
	if health == 0: _death()
		

func _death():
	if health > 0: return
	
	animated_sprite_2d.play("death")
	
func get_hit(PlayerDirectionX):
	animated_sprite_2d.flip_h = PlayerDirectionX == 1
	animated_sprite_2d.play("chop")
	
	health -= 1


func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite_2d.flip_h = false
	animated_sprite_2d.play("idle")
