extends CharacterBody2D

@onready var flip: Node2D = $flip
@onready var player_sprite: AnimatedSprite2D = $flip/PlayerSprite
@onready var damage_box: Area2D = $flip/damageBox

const SPEED = 60

var doChop = false

func _physics_process(delta: float):
	
	if Input.is_action_just_pressed("hit"):
		_do_chop()
	
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("walk_left", "walk_right")
	direction.y = Input.get_axis("walk_up", "walk_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.x, 0, SPEED)
	
	_set_animation()
	
	move_and_slide()
	
func _set_animation():
		if velocity.x < 0:
			flip.scale.x = -1
		elif velocity.x > 0:
			flip.scale.x = 1
		
		if doChop: return
		
		if velocity:
			player_sprite.play("walk_right")
		else:
			player_sprite.play("idle_down")

func _do_chop():
	if doChop: return
	
	doChop = true
	player_sprite.play("chop_right")
	
func _hit_tree():
	var hasCollision = len(damage_box.get_overlapping_bodies()) > 0
	
	if not hasCollision: return
	
	var collisionBody = damage_box.get_overlapping_bodies()[0]
	
	if collisionBody in get_tree().get_nodes_in_group("trees"):
		collisionBody.get_hit(flip.scale.x)
	
	
func _on_player_sprite_animation_finished():
	
	doChop = false
	
	player_sprite.play("idle_right")



func _on_player_sprite_frame_changed() -> void:
	if player_sprite == null: return
	var frame = player_sprite.frame
	
	if player_sprite.animation == "chop_right" && frame == 3:
		_hit_tree()
		
