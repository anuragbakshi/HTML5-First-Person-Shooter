class window.World
	@GRAVITY = -0.01
	@AIR_RESISTANCE = 0.95

	###
	worldSize: Vec3
	###
	constructor: (worldSize) ->
		# Preallocate 3D array to store blocks
		@blocks = Array worldSize.x
		for x in [0...worldSize.x] by 1
			blocks[x] = Array worldSize.y
			for y in [0...worldSize.y] by 1
				blocks[x][y] = Array worldSize.z

		@blocks[0] = new Block
		@camera = new THREE.PerspectiveCamera 75, innerWidth / innerHeight, 0.1, 1000

		@player = new Player new THREE.Vector3(0, 0, 1), new THREE.Vector3(0, 0, 0)

	update: ->
		@player.update()

	getCubes: (aabb) ->
		minVertex = new THREE.Vector3 Math.min(aabb.v1.x, aabb.v2.x), Math.min(aabb.v1.y, aabb.v2.y), Math.min(aabb.v1.z, aabb.v2.z)
		maxVertex = new THREE.Vector3 Math.max(aabb.v1.x, aabb.v2.x), Math.max(aabb.v1.y, aabb.v2.y), Math.max(aabb.v1.z, aabb.v2.z)
		
		cubes = []
		unless minVertex.x < 0 or minVertex.y < 0 or minVertex.z < 0 or maxVertex.x >= blocks.length or maxVertex.y >= blocks[0].length or maxVertex.z >= blocks[0][0].length
			for x in [Math.floor(minVertex.x), Math.floor(maxVertex.x) + 1]
				for y in [Math.floor(minVertex.y), Math.floor(maxVertex.y) + 1]
					for z in [Math.floor(minVertex.z), Math.floor(maxVertex.z) + 1]
						cubes.add new AABB new THREE.Vector3(x, y, z), new THREE.Vector3(x + 1, y + 1, z + 1) if @blocks[x][y][z]?
		
		cubes