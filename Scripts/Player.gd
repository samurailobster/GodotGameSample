extends KinematicBody2D

var speed = 3
var move_direction = Vector2(0, 0)
var target

var canMove = true
var canInteract = false

func _ready():
    set_process_input(true)
    set_fixed_process(true)

func _fixed_process(delta):
	if(canMove):
		move_player()
	handle_interactions()
		
func handle_interactions():
	if(canInteract and Input.is_key_pressed(KEY_E)):
		get_node("../../DialogueParser").init_dialogue(target.get_name())
		canMove = false

func move_player():
	move_direction = Vector2(0,0)
	if(Input.is_key_pressed(KEY_A)):
		move_direction += Vector2(-1, 0)
	if(Input.is_key_pressed(KEY_D)):
		move_direction += Vector2(1, 0)
	if(Input.is_key_pressed(KEY_W)):
		move_direction += Vector2(0, -1)
	if(Input.is_key_pressed(KEY_S)):
		move_direction += Vector2(0, 1)
	move(move_direction.normalized() * speed)

func _on_Area2D_body_enter(body, obj):
	canInteract = true
	target = obj
	
func _on_Area2D_body_exit(body, obj):
	canInteract = false
	target = null