extends Node2D


class_name HealthManager 

@export var MAX_HEALTH := 100.0 
var health: float #Fractional damage can be added 

func _ready() -> void:
	health = MAX_HEALTH
	
func damage(attack: AttackManager):
	health -= attack.attack_damage
	# Delete the player / object / entity 
	if health <= 0:
		queue_free()
