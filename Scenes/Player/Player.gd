class_name Player
extends CharacterBody2D

@export var player_speed := 250

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * player_speed

func _physics_process(delta):
	get_input()
	move_and_slide()
