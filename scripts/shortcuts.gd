extends Node

@export var shutdown_popup : Window
@export var shutdown_accept_button : Button

func _ready():
	for child in get_children():
		var button = child.get_node("Button")
		if button: 
			if button.has_meta("TargetWindow"):
				var meta = button.get_meta("TargetWindow")
				if button.has_node(meta):
					var window = button.get_node(meta)
					button.gui_input.connect(func (event: InputEvent):
						if event is InputEventMouseButton and event.double_click:
							window.visible = false
							window.mode = Window.MODE_WINDOWED
							window.visible = true
					)
	
	shutdown_accept_button.pressed.connect(func ():
		GlobalControlls.try_quit()
	)
	
	shutdown_popup.visibility_changed.connect(func ():
		GlobalControlls.is_shutdown_popup_shown = shutdown_popup.visible
	)
	
	GlobalControlls.quit_request.connect(func ():
		shutdown_popup.popup()
		GlobalControlls.facepick_update.emit()
	)


func _on_close_button_input(event) -> void: # Close button work
	if event is InputEventMouseButton and event.double_click:
		GlobalControlls.quit_request.emit()


func _on_github_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.double_click:
		OS.shell_open("https://github.com/Issac8658/DesktopNiko")
