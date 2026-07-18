class_name ReplayRecorder
extends Node

var history: Array[Dictionary] = []

func record_event(event_name: String, data: Dictionary) -> void:
	var event := {
		"event": event_name,
		"data": data,
		"timestamp": Time.get_ticks_msec()
	}
	history.append(event)
	# print("Recorded: ", event_name) # Uncomment for debugging

func replay() -> void:
	pass

func clear() -> void:
	history.clear()
