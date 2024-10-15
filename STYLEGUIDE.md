##NOTES: 
#Please read through all this before working on code. It saves everyone time. Thanks! :3

# Double hashes (##) = documentation. Put on same line as var or func to document it. Docs should clearly and simply explain what a function/var does and cover any hacks/jank/unique stuff related to it. However, try and keep them concise and non-repetitive.

#DENOTATIONS:
#ALERT,ATTENTION,CAUTION,CRITICAL,DANGER,SECURITY
#BUG,DEPRECATED,FIXME,HACK,TASK,TBD,TODO,WARNING
#INFO,NOTE,NOTICE,TEST,TESTING
#USE THESE WHENEVER POSSIBLE, as they will help QA better do their job.

#ALWAYS type your variables. If you can't type them, there's a 95% chance what you're doing isn't a good idea.

#CASES: 
	#snake_case: Used for signals, variables, functions, etc
	#PascalCase: Used for class names, object types, etc
	#MACRO_CASE: Used for enum names and declarations, constants, etc.
	#camelCase: Generally not used for much here. Use PascalCase instead.

#Tips:
#Never abbreviate. Ever.

#Watch for cyclical references (When x depends on y but y also depends on x)

#Keep usage of while loops to a minimum to prevent stack overflows. If you must use a while, either reconsider your approach or add a variable that limits the max iterations.

#Don't tear apart and rewrite someone else's code.

#Use PackedArrays whenever possible. Will save tons of memory in the long run.

#REMEMBER, DICTIONARIES ARE PASSED BY REFERENCE, NOT COPY. (This has screwed me more time than I can remember.)

#Try not to transfer objects (scenes, resources, etc) over functions. Not only is this just good practice, but will make multiplayer stupidly easy if we ever go that direction.

#If you can do it via composition, do it via composition.

#Make it simple.

#Don't be afraid to ask for help. We're a community for a reason :3




class_name NameHere ##In PascelCase
extends Node ##What you want to extend
##Documentation for script goes here

const CONSTANT_VALUE: int = 0451 ##in MACRO_CASE
enum ENUMERATION {VALUE1,VALUE2} ##In MACRO_CASE

signal signal_name ##in snake_case
signal signal_with_arguments(arg1: int) ##Remember to type your arguments

@export var exported_var: Node ##(snake_case) Also type your variables PLEASE

var unexported_var: float = 1.0 ##If possible, always give a default value
var set_get_var: String = "This is a styleGuide!":
	set(val): ##Function that is called whenever the variable is set to something.
		set_get_var = val
		set_function(val)
	get: ##Function that is called whenever the var is retrieved. Whatever it returns is what is retrieved
		return set_get_var

@onready var onready_var: Node2D = $Root/onreadyNode2D ##Onreadies used for refs to nodes in scene.

func _init() -> void: ##Make sure to specify the return values of your functions. Done via "-> <TYPE_RETURNED>"
	print("Do your initialization code (code that should run when the node is INSTANTIATED NOT ADDED TO SCENE) here! This is rarely needed.")

func _ready() -> void: ##Do double hashes to document things. This comment is documentation for this function as it starts on the same line.
	print("Do your start code here!")
	signal_with_arguments.connect(_signal_call_func) ##Connecting signal to func
	

func initialize(variable_in: String, scene_root: Node) -> void: #user defined init function for dependency injection
	set_get_var = variable_in #Runs the set function defined above
 
func _unhandled_input(_event) -> void:
	pass #Do your input code here


func _physics_process(_delta) -> void:
	pass #Do your NON-FPS-DEPENDENT update logic here (runs every physics tick, or 60 times per second by default)

func _process(_delta) -> void:
	pass #Do your FPS-DEPENDENT update logic here (runs every frame)

func my_function() -> float: ##Basic function that returns a float.
	return 32.0

func my_function_with_args(argument1: int) -> String: ##Basic functions that takes in an argument and returns something dependant on it.
	match argument1:
		1:
			return "Case 1"
		2:
			return "Case 2"
		_: #If argument1 doesn't match any of the other cases, defaults to this one
			return "Default case"

func set_function(value: String) -> void: ##Called in the above setter for set_get_var
	print("set_get_var was set to "+value)

func _my_private_function() -> void: ##Cannot be accessed outside of this script.
	print("This function cannot be accessed outside of this script")

func _signal_call_func(value_in: int): ##Function called by signal. Generally these should be private, however there are _rare_ exceptions.
	print(str(value_in))

class MyClass: ##Kinda like a struct. Can be instanced like an object.
	var foo: int = 0
	func _init():
		print("new MyClass instantiated!")
	static func constructor(value: int): ##Java-esque Constructor. Not required, but good practice.
		var inst: MyClass  = MyClass.new()
		inst.foo = value
		return inst
