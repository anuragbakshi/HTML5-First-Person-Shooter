class window.Entity
	@SPEED = 0.1

	constructor: (position, size, rotation, @heightOffset, @collidable) ->
		halfSize = size
			.clone()
			.divideScalar 2

		min = new THREE.Vector3
		min.subVectors position, halfSize

		max = new THREE.Vector3
		max.addVectors position, halfSize

		@boundingBox = new AABB min, max

		@position = position.clone()

		@lastPosition = position.clone()

		@velocity = new THREE.Vector3

		@rotation = rotation.clone()

	move: (distance) ->
		@lastPosition.copy @position

		oldDistance = distance.clone()
		boundingBoxCopy = @boundingBox.clone()
		cubes = window.world.getCubes @boundingBox.clone().expand distance

		distance.y = cube.clipYCollide @boundingBox, distance.y for cube in cubes
		@boundingBox.move new THREE.Vector3 0, distance.y, 0

		stepFurther = @onGround or oldDistance.y isnt distance.y and oldDistance.y < 0

		distance.x = cube.clipXCollide @boundingBox, distance.x for cube in cubes
		@boundingBox.move new THREE.Vector3 distance.x, 0, 0

		distance.z = cube.clipZCollide @boundingBox, distance.z for cube in cubes
		@boundingBox.move new THREE.Vector3 0, 0, distance.z

		if Entity.SPEED > 0 and stepFurther and @ySlideOffset < 0.05 and (oldDistance.x isnt distance.x or oldDistance.z isnt distance.z)
			newX = distance.x
			newY = distance.y
			newZ = distance.z
			distance.x = oldDistance.x
			distance.y = Entity.SPEED
			distance.z = oldDistance.z
			newCopy = @boundingBox.clone()
			@boundingBox = boundingBoxCopy.clone()
			cubes = window.world.getCubes @boundingBox.expand new Vector3 oldDistance.x, distance.y, oldDistance.z

			distance.y = cube.clipYCollide @boundingBox, distance.y for cube in cubes
			@boundingBox.move new Vector3 0, distance.y, 0

			distance.x = cube.clipXCollide @boundingBox, distance.x for cube in cubes
			@boundingBox.move new Vector3 distance.x, 0, 0

			distance.z = cube.clipZCollide @boundingBox, distance.z for cube in cubes
			@boundingBox.move new Vector3 0, 0, distance.z

			if newX * newX + newZ * newZ >= distance.x * distance.x + distance.z * distance.z
				distance.x = newX
				distance.y = newY
				distance.z = newZ
				@boundingBox = newCopy.clone()
			else
				@ySlideOffset += 0.5

		@horizontalCollision = oldDistance.x isnt distance.x or oldDistance.z isnt distance.z
		@onGround = oldDistance.y isnt distance.y and oldDistance.y < 0
		@collision = @horizontalCollision or oldDistance.y isnt distance.y
		
		if @onGround
			# calculateFallDamage()
		else if distance.y < 0
			@fallDistance -= distance.y
		
		if oldDistance.x isnt distance.x
			velocity.x = 0
		
		if oldDistance.y isnt distance.y
			velocity.y = 0
		
		if oldDistance.z isnt distance.z
			velocity.z = 0

		@position.x = (@boundingBox.v1.x + @boundingBox.v2.x) / 2
		@position.y = @boundingBox.v1.y + @heightOffset - @ySlideOffset
		@position.z = (@boundingBox.v1.z + @boundingBox.v2.z) / 2
		
		@velocity.multiplyScalar World.AIR_RESISTANCE

	lookThrough: ->
		world.camera.position = @position.clone()