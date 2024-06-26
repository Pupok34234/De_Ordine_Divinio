extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

func _process(delta: float) -> void:
	anim.play("idle")
func NPC():
	pass
