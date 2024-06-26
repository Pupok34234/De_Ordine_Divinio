extends Node

@onready var D_T: Timer = $dialogue_timer
@onready var player2 = get_node("res://player/player2.gd")
var times_BV_met = 0
var BV_is_angry = false
var in_dialogue = false
var can_start_dialogue = true

func D_end():
	times_BV_met += 1
	in_dialogue = false
	can_start_dialogue = true
	#var timer = Timer.new()
	#timer.wait_time = 3.0 
	#timer.autostart = true 
	#timer.one_shot = true
	#timer.timeout.connect("on_timer_out")
	
func on_timer_out():
	can_start_dialogue = true
