extends Sprite2D

var dragging = false
var cnct = null
var of = Vector2(0,0)
var bottomin = false
var topin = false

var areabotm = null
var areatop = null

@export var type = ""
var roll = 3

func _ready() -> void:
	match type:
		"normal":
			roll = randi_range(1,6)
	%num.text = str(roll)
		
func _process(delta: float) -> void:
	if dragging:
		bottomin = false
		topin = false
		position = get_global_mouse_position() - of
	elif cnct != null:
		position = cnct
		cnct = null


func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false

func _on_top_area_entered(area: Area2D) -> void:
	if dragging and not topin:
		areatop = area
		cnct = area.get_parent().position
		cnct += area.position*0.5
		topin = true

func _on_bottom_area_area_entered(area: Area2D) -> void:
	if dragging and not bottomin:
		areabotm = area
		cnct = area.get_parent().position
		cnct += area.position*0.5
		bottomin = true

func _on_top_area_exited(area: Area2D) -> void:
	if area == areatop:
		bottomin = false

func _on_bottom_area_exited(area: Area2D) -> void:
	if area == areabotm:
		bottomin = false
