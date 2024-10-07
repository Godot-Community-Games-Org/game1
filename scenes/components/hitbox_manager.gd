extends Area2D

class_name HitboxManager


func _on_body_entered(body: Node2D) -> void:
	print("Hey! a body has entered a hitbox", body)
	
	# We can use this for spikes / magma / cactus / or any other things 
	
	#if body.has_method("damage"):
		#
		#var attack = AttackManager.new()
		#
		## lets say this is a cactus that damages the player with the given damage 
		#attack.attack_damage = 2.0 
		#body.damage(attack)
