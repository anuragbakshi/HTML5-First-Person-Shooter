window.scene = new THREE.Scene
# window.camera = new THREE.PerspectiveCamera 75, innerWidth / innerHeight, 0.1, 1000

window.renderer = new THREE.WebGLRenderer
renderer.setSize innerWidth, innerHeight
document.body.appendChild renderer.domElement

stats = new Stats
stats.setMode 0
stats.domElement.style.position = "fixed"
stats.domElement.style.left = "0px"
stats.domElement.style.top = "0px"
document.body.appendChild stats.domElement

# geometry = new THREE.CubeGeometry 1, 1, 1
# material = new THREE.MeshBasicMaterial {color: 0x00ff00}
# cube = new THREE.Mesh geometry, material
# scene.add cube

# window.block = new Block
# window.player = new Player new THREE.Vector3(0, 0, 0), new THREE.Vector3(0, 0, 0)
window.world = new World 16

window.keyboard = new THREEx.KeyboardState

# camera.position.z = 5

render = ->
	stats.begin()

	# cube.rotation.x += 0.1
	# cube.rotation.y += 0.1
	# camera.position.z -= 0.01

	# renderer.render scene, camera
	world.update()
	world.player.lookThrough()
	renderer.render scene, world.camera
	requestAnimationFrame render

	stats.end()

render()