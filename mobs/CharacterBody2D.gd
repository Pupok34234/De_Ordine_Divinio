# Экстенд класса CharacterBody2D, который представляет собой врага в игре.
extends CharacterBody2D

# Урон, наносимый врагом при атаке.
@export var dmg = 10

# Ссылка на компонент AnimatedSprite2D для управления анимациями.
@onready var anim = $AnimatedSprite2D

# Гравитация, используемая для движения по вертикали.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Флаг, указывающий, следует ли врагу преследовать игрока.
var chase = false

# Скорость движения врага.
var speed = 100

# Флаг, указывающий, жив ли враг.
var alive = true

# Флаг, указывающий, атакует ли враг в данный момент.
var is_attacking = false

# Основной процесс, обрабатывающий ввод пользователя и движение врага.
func _process(delta: float) -> void:
	# Если пользователь нажал кнопку вниз, вызывается функция смерти.
	if Input.is_action_just_pressed("ui_down"):
		death()

	# Если враг находится на земле, применяется гравитация.
	if is_on_floor():
		velocity.y += gravity * delta

	# Получаем позицию игрока и направление от врага к игроку.
	var body = $"../../Player/player"
	var direction = (body.position - self.position).normalized()

	# Если враг жив, выполняются действия в зависимости от состояния преследования и атаки.
	if alive == true:
		if chase == true:
			# Враг движется к игроку с заданной скоростью.
			velocity.x = direction.x * speed
			anim.play("run")
		else:
			# Враг стоит на месте.
			velocity.x = 0
			anim.play("idle")

		# Поворачиваем врага влево или вправо в зависимости от направления к игроку.
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

		# Если враг атакует, начинается цикл атаки.
		if is_attacking == true:
			attack_cycle()

	# Обновляем позицию врага согласно его скорости и столкновениям.
	move_and_slide()

# Событие, вызываемое при входе тела в зону обнаружения врага.
func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "player":
		chase = true

# Событие, вызываемое при выходе тела из зоны обнаружения врага.
func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "player":
		chase = false

# Функция, вызываемая при смерти врага.
func death():
	alive = false
	anim.play("death")
	await anim.animation_finished
	queue_free()

# Функция, запускающая атаку врага.
func attack():
	is_attacking = true 

# Цикл атаки, уменьшающий здоровье игрока и играющий анимацию атаки.
func attack_cycle():
	while is_attacking:
		var body = $"../../Player/player"
		body.health -= dmg
		anim.play("attack")
		await anim.animation_finished
		await get_tree().create_timer(1).timeout
		if is_attacking == false:
			break

# Событие, вызываемое при входе игрока в зону атаки врага.
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		attack()

# Событие, вызываемое при выходе игрока из зоны атаки врага.
func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		is_attacking = false
