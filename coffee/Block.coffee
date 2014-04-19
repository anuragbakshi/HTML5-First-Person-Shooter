class window.Block
	constructor: (@position) ->
		@geometry = new THREE.CubeGeometry 1, 1, 1
		@material = new THREE.MeshBasicMaterial
			color: 0xffffff
			wireframe: true

		@mesh = new THREE.Mesh @geometry, @material
		window.scene.add @mesh