extends Node2D

class_name AttackManager

enum attack_types {MELEE, RANGED, MAGIC, EXPLOSIVE}	

# Default is melee 
@export var attack_type : attack_types

@export var attack_damage := 10.0

var attack_position : Vector2
