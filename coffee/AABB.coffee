class window.AABB
	@EPSILON = 0

	constructor: (@v1, @v2) ->
	
	clone: (aabb) ->
		new AABB @v1.clone(), @v2.clone()
	
	expand: (vector) ->
		(if vector.x < 0 then @v1 else @v2).x += vector.x
		(if vector.y < 0 then @v1 else @v2).y += vector.y
		(if vector.z < 0 then @v1 else @v2).z += vector.z

		@

	grow: (vector) ->
		v1 = @v1.clone().sub vector
		v2 = @v2.clone().add vector

		@
	
	clipXCollide: (aabb, x) ->
		if aabb.v2.y > @v1.y and aabb.v1.y < @v2.y
			if aabb.v2.z > @v1.z and aabb.v1.z < @v2.z
				collX = @v1.x - aabb.v2.x - EPSILON
				if x > 0 and aabb.v2.x <= @v1.x and collX < x
					collX
				
				collX = @v2.x - aabb.v1.x + EPSILON
				if x < 0 and aabb.v1.x >= @v2.x and collX > x
					collX
		
		x

	clipYCollide: (aabb, y) ->
		if aabb.v2.x > @v1.x and aabb.v1.x < @v2.x
			if aabb.v2.z > @v1.z and aabb.v1.z < @v2.z
				collY = @v1.y - aabb.v2.y - EPSILON
				if y > 0 and aabb.v2.y <= @v1.y and collY < y
					collY
				
				collY = @v2.y - aabb.v1.y + EPSILON
				if y < 0 and aabb.v1.y >= @v2.y and collY > y
					collY
		
		y
				

	clipZCollide: (aabb, z) ->
		if aabb.v2.x > @v1.x and aabb.v1.x < @v2.x
			if aabb.v2.y > @v1.y and aabb.v1.y < @v2.y
				collZ = @v1.z - aabb.v2.z - EPSILON
				if z > 0 and aabb.v2.z <= @v1.z and collZ < z
					collZ
				
				collZ = @v2.z - aabb.v1.z + EPSILON
				if z < 0 and aabb.v1.z >= @v2.z and collZ > z
					collZ
		
		z
	
	intersects: (aabb) ->
		aabb.v2.x > @v1.x and aabb.v1.x < @v2.x and aabb.v2.y > @v1.y and aabb.v1.y < @v2.y and aabb.v2.z > @v1.z and aabb.v1.z < @v2.z

	intersectsInner: (aabb) ->
		aabb.v2.x >= @v1.x and aabb.v1.x <= @v2.x and aabb.v2.y >= @v1.y and aabb.v1.y <= @v2.y and aabb.v2.z >= @v1.z and aabb.v1.z <= @v2.z

	move: (vector) ->
		@v1.add vector
		@v2.add vector
	
	contains: (point) ->
		point.x > this.v1.x and point.x < this.v2.x and point.y > this.v1.y and point.y < this.v2.y and point.z > this.v1.z and point.z < this.v2.z
	
	getSize:  ->
		length = this.v2.x - this.v1.x
		height = this.v2.y - this.v1.y
		depth = this.v2.z - this.v1.z
		(length + height + depth) / 3
	
	shrink: (vector) ->
		(if vector.x < 0 then @v1 else @v2).x -= vector.x
		(if vector.y < 0 then @v1 else @v2).y -= vector.y
		(if vector.z < 0 then @v1 else @v2).z -= vector.z

		@