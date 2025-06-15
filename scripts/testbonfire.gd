extends StaticBody2D

@export var burn_duration := 10.0
var time_left := 0.0
var is_burning := true

@onready var anim = $AnimatedSprite2D
@onready var progress_bar = $TextureProgressBar
@onready var audio = $AudioStreamPlayer2D

func _ready() -> void:
	start_fire()



func _process(delta: float) -> void:
	if is_burning:
		time_left -= delta
		progress_bar.value = time_left
		if time_left <= 0:
			extinguish()
			
			
func start_fire():
	time_left = burn_duration
	is_burning = true
	anim.play("idle")
	

func extinguish():
	is_burning = false
	progress_bar.visible = false
	audio.stop()
	get_tree().change_scene_to_file("res://scenes/testscenes/game_over_ui.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		audio.play()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		audio.stop()
