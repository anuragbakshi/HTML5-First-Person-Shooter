class window.Player extends Entity
	@EYE_HEIGHT = 1.73
	@MAX_PITCH = 90
	@SPEED = 0.1
	@JUMP_SPEED = 0.175

	constructor: (position, rotation) ->
		super position, new THREE.Vector3(1, 1, 1), rotation, Player.EYE_HEIGHT, true

	update: ->
		@pollInput()
		@updatePosition()

	pollInput: ->
		@moveForward = keyboard.pressed "W"
		@moveBackward = keyboard.pressed "S"
		@moveLeft = keyboard.pressed "A"
		@moveRight = keyboard.pressed "D"
		
		# Game game = Game.getInstance()
		# rotation.y +=  game.mouseDX * 0.05
		# rotation.x -= game.mouseDY * 0.05
		
		# rotation.x = MathUtils.boundTo(rotation.x, -MAX_PITCH, MAX_PITCH)

	updatePosition: ->
		lastPosition = @position.clone()
			
		movement = new THREE.Vector3
		if @moveForward
			movement.x += Player.SPEED * Math.sin @rotation.y
			movement.z -= Player.SPEED * Math.cos @rotation.y
		
		if @moveBackward
			movement.x -= Player.SPEED * Math.sin @rotation.y
			movement.z += Player.SPEED * Math.cos @rotation.y
		
		if @moveLeft
			movement.x -= Player.SPEED * Math.sin @rotation.y + 90
			movement.z += Player.SPEED * Math.cos @rotation.y + 90
		
		if @moveRight
			movement.x += Player.SPEED * Math.sin @rotation.y + 90
			movement.z -= Player.SPEED * Math.cos @rotation.y + 90

		@velocity.y += World.GRAVITY unless @onGround

		# if(Keyboard.isKeyDown(Keyboard.KEY_SPACE) && onGround)
		# 	velocity.y += JUMP_SPEED
		
		movement.add @velocity
		
		@move movement