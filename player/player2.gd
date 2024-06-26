extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = 100

var NPC_in_range = false

func _physics_process(delta: float) -> void:
	anim_player()
	able_to_talk()
	player_movement(delta)
	
#поднятие предметов
func _on_pickup_area_area_entered(area: Area2D) -> void:
	
	if area.has_method("on_pickup"):
		area.on_pickup()


#детект зоны взаимодействия (общение с NPC)
func _on_talk_area_body_entered(body: Node2D) -> void:
	if body.has_method("NPC"):
		NPC_in_range = true
func _on_talk_area_body_exited(body: Node2D) -> void:
	if body.has_method("NPC"):
		NPC_in_range = false

func able_to_talk(): 
	if NPC_in_range == true and Global.in_dialogue == false and Global.can_start_dialogue:
		if Input.is_action_just_pressed("ui_accept"):
			Global.in_dialogue = true
			Global.can_start_dialogue = false
			DialogueManager.show_example_dialogue_balloon(load("res://test1.dialogue"), "test1")
			

func delay_dialodue():
	$dialogue_timer.start()
func _on_dialogue_timer_timeout() -> void:
	Global.can_start_dialodue = true
	
#движение игрока + анимации
func player_movement(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta 

	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#anim.play("jump")

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			#anim.play("run")
			pass
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			#anim.play("idle")
			pass
	
	
		
	move_and_slide()
func anim_player():
	
	#var idle_direction = 0
	#if Input.is_action_just_pressed("left"):
		#idle_direction = 0
	#if Input.is_action_just_pressed("right"):
		#idle_direction = 1
	#
	#if idle_direction == 0:
		#anim.play("idle")
	#else:
		#anim.flip_h = true
		#anim.play("idle")
	
	#var facing 
	#if Input.is_action_pressed("left"):
		#facing = -1
	#if Input.is_action_pressed("right"):
		#facing = 1
		#
		#
	#if velocity.x == 0:
		#if facing == 1:
			#anim.play("idle")
		#if facing == -1:
			#anim.flip_h = true
			#anim.play("idle")
			#
	var DV : int
	if velocity.x > 0 or velocity.x < 0:
		DV = velocity.x 
	if DV > 0:
		anim.flip_h = false
	elif DV < 0:
		anim.flip_h = true
	
		
	if velocity.x:
		anim.play("run")
	else:
		anim.play("idle")
	if velocity.y < 0:
		anim.play("jump")
	if velocity.y > 0:
		anim.play("fall")
		
func testingAwait():
	await get_tree().create_timer(2.0).timeout
	print("await кажется работает")


