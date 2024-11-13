extends CharacterBody2D

# Variables para controlar la velocidad y la gravedad
var _gravity = 10
var _speed = 110
var _target: Node2D
@onready var _animation := $AnimatedSprite2D  # Nodo de animación

# Función de inicialización
func _ready():
	_target = get_tree().get_nodes_in_group("player")[0]
	if _target == null:
		print("Error: No se encontró el nodo 'MainCharacter'.")

func _physics_process(delta):
	apply_gravity()
	follow(delta)

func apply_gravity():
	# Aplica la gravedad a la velocidad vertical
	velocity.y += _gravity

func follow(delta):
	if _target != null:
		var direction = position.direction_to(_target.position)
		velocity.x = direction.x * _speed  # Solo aplica la velocidad en el eje X
		
		# Imprime la dirección y la velocidad para depuración
		print("Dirección: ", direction)
		print("Velocidad: ", velocity)
		move_and_slide()
		# Control de la animación
		if velocity.x < 0:
			_animation.flip_h = true
		elif velocity.x > 0:
			_animation.flip_h = false

		# Cambia la animación basada en el estado de movimiento
		if velocity.length() > 0.1:  # Evita un estado de "idle" cuando el personaje se mueve ligeramente
			_animation.play("idle")
		else:
			_animation.play("idle")
