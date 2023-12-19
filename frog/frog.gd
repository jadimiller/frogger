extends CharacterBody2D


const SPEED = 300.0


func _ready():
	velocity = Vector2(0, -SPEED)


func _physics_process(_delta):
	var collided := move_and_slide()
	if collided:
		velocity.y *= -1


func _on_area_2d_body_entered(body):
	if body.is_in_group("car"):
		kill()


func kill():
	queue_free()