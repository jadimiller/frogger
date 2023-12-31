extends CharacterBody2D

@onready var turt_sprite := $SpriteTurt
@onready var turtle_sprite := $SpriteTurtle
@onready var splat := $Splat

var turted : bool = false
var SPEED : int = 50


func _ready() -> void:
	velocity = Vector2(0, -SPEED)


func _physics_process(_delta) -> void:
	if turted:
		pass
	else:
		var collided := move_and_slide()
		if collided:
			velocity.y *= -1
			turtle_sprite.flip_v = !turtle_sprite.flip_v
			turt_sprite.flip_v = !turt_sprite.flip_v
		
		
func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("car") or body.is_in_group("deadly_obstacles"): 
		turt()
	if body.is_in_group("very_deadly_obstacles"):
		die()


func die() -> void:
	splat.set_modulate(Color.RED)
	splat.emitting = true
	SFX.play_squish()
	$CollisionShape2D.set_deferred("disabled",true)
	$Area2D.queue_free()
	turtle_sprite.visible = false
	turt_sprite.visible = false
	

func turt() -> void:
	$CollisionShape2D.set_deferred("disabled",true)
	SFX.play_thud()
	turtle_sprite.visible = false
	turt_sprite.visible = true
	turted = true 
