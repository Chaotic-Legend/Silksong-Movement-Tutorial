extends CharacterBody2D

enum STATE {
	FALL,
	FLOOR,
	JUMP,
	DOUBLE_JUMP,
	FLOAT,
	LEDGE_CLIMB,
	LEDGE_JUMP,
}

const FALL_GRAVITY := 1500.0
const FALL_VELOCITY := 500.0
const WALK_VELOCITY := 200.0

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite

var active_state := STATE.FALL

func _ready() -> void:
	switch_state(active_state)

func _physics_process(delta: float) -> void:
	process_state(delta)
	move_and_slide()

func switch_state(to_state: STATE) -> void:
	active_state = to_state
	
	# State specific things that need to run only once upon entering the next state.
	match active_state:
		STATE.FALL:
			animated_sprite.play("fall")

func process_state(delta: float) -> void:
	match active_state:
		STATE.FALL:
			velocity.y = move_toward(velocity.y, FALL_VELOCITY, FALL_GRAVITY * delta)
			handle_movement()
			
			if is_on_floor():
				switch_state(STATE.FLOOR)
		
		STATE.FLOOR:
			if Input.get_axis("move_left", "move_right"):
				animated_sprite.play("walk")
			else:
				animated_sprite.play("idle")
			handle_movement()
			
			if not is_on_floor():
				switch_state(STATE.FALL)
				
func  handle_movement() -> void:
	var input_direction := signf(Input.get_axis("move_left", "move_right"))
	if input_direction:
		animated_sprite.flip_h = input_direction < 0
	velocity.x = input_direction * WALK_VELOCITY
