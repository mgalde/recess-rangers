extends ColorRect

# Animation variables
var time = 0.0
var cloud_speed = 30.0

# Cloud data structure
class Cloud:
	var position: Vector2
	var speed: float
	var size: float
	var opacity: float
	
	func _init(pos: Vector2, spd: float, sz: float, op: float):
		position = pos
		speed = spd
		size = sz
		opacity = op

# Array to store our clouds
var clouds: Array[Cloud] = []

# Colors for our gradient
var sky_colors = {
	"top": Color(0.8, 0.4, 0.2, 1.0),    # Orange sky
	"middle": Color(0.95, 0.7, 0.4, 1.0), # Light orange
	"bottom": Color(0.7, 0.5, 0.3, 1.0)   # Sandy brown
}

func _ready():
	# Create the gradient background
	var gradient = Gradient.new()
	gradient.add_point(0.0, sky_colors.top)
	gradient.add_point(0.5, sky_colors.middle)
	gradient.add_point(1.0, sky_colors.bottom)
	
	var gradient_texture = GradientTexture2D.new()
	gradient_texture.gradient = gradient
	gradient_texture.fill_from = Vector2(0.0, 0.0)
	gradient_texture.fill_to = Vector2(0.0, 1.0)
	gradient_texture.width = 1280
	gradient_texture.height = 720
	
	# Initialize clouds with different properties
	init_clouds()
	
	# Set up shader material for gradient
	var shader_material = ShaderMaterial.new()
	shader_material.shader = preload("res://resources/gradient_shader.gdshader")
	self.material = shader_material

func init_clouds():
	# Create multiple clouds with varying properties
	clouds.append(Cloud.new(Vector2(100, 100), 20.0, 1.0, 0.3))
	clouds.append(Cloud.new(Vector2(400, 150), 15.0, 0.8, 0.25))
	clouds.append(Cloud.new(Vector2(700, 80), 25.0, 1.2, 0.2))
	clouds.append(Cloud.new(Vector2(1000, 120), 18.0, 0.9, 0.35))
	clouds.append(Cloud.new(Vector2(250, 180), 22.0, 0.7, 0.28))
	
func _process(delta):
	time += delta
	
	# Update cloud positions
	for cloud in clouds:
		cloud.position.x += cloud.speed * delta
		if cloud.position.x > 1380:  # Past right edge
			cloud.position.x = -100   # Reset to left side
	
	queue_redraw()

func _draw():
	# Draw mountains (adjusted to be more prominent)
	var mountain_points = PackedVector2Array([
		Vector2(0, 500),          # Left edge
		Vector2(200, 250),        # First peak
		Vector2(400, 450),        # Valley
		Vector2(600, 200),        # Highest peak
		Vector2(800, 350),        # Small peak
		Vector2(1000, 280),       # Another peak
		Vector2(1280, 500),       # Right edge
		Vector2(1280, 720),       # Bottom right
		Vector2(0, 720)           # Bottom left
	])
	
	# Draw mountain ranges with different shades for depth
	# Background mountains (lighter shade)
	var bg_mountains = PackedVector2Array([
		Vector2(0, 400),
		Vector2(300, 200),
		Vector2(600, 350),
		Vector2(900, 180),
		Vector2(1280, 400),
		Vector2(1280, 720),
		Vector2(0, 720)
	])
	draw_colored_polygon(bg_mountains, Color(0.4, 0.3, 0.2, 0.6))
	
	# Foreground mountains (darker shade)
	draw_colored_polygon(mountain_points, Color(0.3, 0.2, 0.1, 0.8))
	
	# Draw all clouds
	for cloud in clouds:
		draw_cloud(cloud)

func draw_cloud(cloud: Cloud):
	var cloud_color = Color(1, 1, 1, cloud.opacity)
	var base_radius = 30 * cloud.size
	
	# Draw main cloud body
	draw_circle(cloud.position, base_radius, cloud_color)
	# Draw additional cloud puffs
	draw_circle(cloud.position + Vector2(20, -10) * cloud.size, base_radius * 0.8, cloud_color)
	draw_circle(cloud.position + Vector2(-20, -10) * cloud.size, base_radius * 0.8, cloud_color)
	draw_circle(cloud.position + Vector2(35, 5) * cloud.size, base_radius * 0.6, cloud_color)
	draw_circle(cloud.position + Vector2(-35, 5) * cloud.size, base_radius * 0.6, cloud_color)
