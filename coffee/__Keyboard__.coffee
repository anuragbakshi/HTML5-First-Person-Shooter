window.Keyboard =
	keycodeAliases:
		left: 37
		up: 38
		right: 39
		down: 40
		space: 32
		pageup: 33
		pagedown: 34
		tab: 9

	keycodes: {}
	modifiers: {}

	init: ->
		document.addEventListener "keydown", (event) ->
			Keyboard.keycodes[event.keyCode] = true

		document.addEventListener "keyup", (event) ->
			#

	onKeyEvent: (event, pressed) ->
		Keyboard.keycodes[event.keyCode] = pressed

		Keyboard.modifiers.shift = event.shiftKey
		Keyboard.modifiers.ctrl = event.ctrlKey
		Keyboard.modifiers.alt = event.altKey
		Keyboard.modifiers.meta = event.metaKey

	isPressed: (keyDescription) ->
		keys = keyDescription.split "+"
		for k in keys
			pressed =
				if Keyboard.modifiers[k]?
					Keyboard.modifiers[k]
				else if Keyboard.keycodeAliases[k]?
					pressed = Keyboard.keycodes[Keyboard.keycodeAliases[k]]
				else
					pressed	= Keyboard.keycodes[k.toUpperCase().charCodeAt 0]

			false unless pressed

		true