extends CharacterBody2D

@onready var animation= $AnimationPlayer
const SPEED = 500.0
const JUMP_VELOCITY = -250.0

@export var attacking = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LeftClick_Attack"):
		animation.play("Attack")
		attacking = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.play("Jump")
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)






	move_and_slide()
	if velocity.x<0:
		$Sprite.flip_h=true
	if !attacking:
		if velocity.x<0:
			animation.play("Run")
			$Sprite.flip_h=true
		elif velocity.x>0:
			animation.play("Run")
			$Sprite.flip_h=false
		else:
			animation.play("Idle")




func _on_weapon_hit_player_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		area.take_damage()
		
