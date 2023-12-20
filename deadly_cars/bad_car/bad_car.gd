extends CharacterBody2D


@onready var bad_car_sprite := $SpriteBadCar
@onready var splat := $Splat
const SPEED = 200.0


func _ready():
	velocity = Vector2(0, -SPEED)


func _physics_process(_delta):
	var collided := move_and_slide()
	if collided:
		velocity.y *= -1
		bad_car_sprite.flip_v = !bad_car_sprite.flip_v
		
		
func _on_area_2d_body_entered(body):
	if body.is_in_group("very_deadly_obstacles"):
		die()


# also not splatting
func die():
	splat.set_modulate(Color.BLUE)
	splat.emitting = true
	SFX.play_crash()
	$CollisionShape2D.set_deferred("disabled", true)
	bad_car_sprite.visible = false