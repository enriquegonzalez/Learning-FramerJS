# Override the default background color for layers
Framer.Defaults.Layer.backgroundColor = "red"
Framer.Defaults.Layer.borderRadius = 10

layerA = new Layer({x:0, name: "hi"})

print "Screen:", Screen.width, Screen.height, Screen.size
print "Canvas:", Canvas.width, Canvas.height, Canvas.size
print "LayerA:", layerA.x, layerA.name, layerA.opacity, layerA.backgroundColor, layerA.borderRadius, layerA.height, layerA.width

# PROPERTIES
layerB = new Layer
	x:150, y:0, width:100, height:100, backgroundColor: "hsla(360,100%,100%,1)", scale:1, borderRadius:3

layerB.rotation = 45
layerB.opacity = 0.8
layerB.scale = 0.8

# POSITION
layerB.x = layerA.x
layerB.x = layerA.midX
layerB.y = layerA.midY
layerA.center()
layerB.centerX()

# HIERARCHY
layerC = new Layer({backgroundColor:"hsla(50,90%,50%,1)", width:200, height:200})
layerD = new Layer({backgroundColor:"hsla(360,100%,100%,1)"})
layerD.superLayer = layerC
layerC.addSubLayer(layerD)
layerC.centerX()
layerC.y = 230
layerD.center()

layerE = new Layer({backgroundColor:"hsla(50,90%,50%,1)", width:200, height:200})
layerF = new Layer({backgroundColor:"hsla(360,100%,100%,1)"})
layerF.superLayer = layerE
layerE.addSubLayer(layerF)
layerE.centerX()
layerE.y = 730
layerF.center()

# TEXT – Get this module: https://github.com/awt2542/textLayer-for-Framer
# Or keep it simple with the below:
# TEXT - With Vertical and Horizontal Centering
layerD.html = "OK"
layerD.style.color = "hsla(0,0%,0%,1)"
layerD.style.textAlign = "center"
layerD.style.lineHeight = 3.5
	# Alternative horizontal and vertical centering of text
	# THE "Hi!" is its own Layer and sublayer of F
layerG = new Layer({backgroundColor:null,height:30, width:40})
layerG.superLayer = layerF
layerF.addSubLayer(layerG)
layerG.html = "HI!"
layerG.style.color = "hsla(0,0%,0%,1)"
layerG.center()

# ANIMATION
layerA.animate
	properties:
		opacity: 0.5
	curve: "ease"
	repeat: 1
	delay: 2
	time: 1
	
layerB.animate
	properties:
		opacity: 0.25
		x:450
		y:150
# SPRING(tension, friction, velocity)
# Tension = stiffness of the spring, more tension = more speed and bounce
# Friction = the brake, more friction = more resistance
# Velocity = initial velocity, more velocity = more push
	curve: "spring(300,15,0)"
	repeat: 2

# STATES
layerH = new Layer({backgroundColor:"hsla(305, 100%, 38%, 1)", x: 80, y: 280, opacity: 0.5})
layerH.html = "XO"
layerH.style.textAlign = "center"
layerH.style.lineHeight = 3.5
layerH.states.add
	fade: {opacity:1}
	second: {scale: 0.75}
	third: {rotation: 90, scale: 1, blur: 3}
# Switch states with animation
layerH.states.switch("fade")
# Switch states without animation
# layerA.states.switchInstant("fade")

layerH.states.animationOptions = 
	curve: "spring(600,30,0)"

# EDITING STATES
layerH.states.remove("second")

# EVENSTS
# Toggle states on click
layerH.on Events.Click, -> 
    layerH.states.next()

layerE.on Events.TouchStart, ->  
	layerF.animate 
	   	properties:
	        x:100
	    curve: "ease-in-out"
 
layerF.on Events.AnimationEnd, ->
	layerF.animate
 		properties:
        	x:10
        curve: "ease-in-out"

# DRAGGING
# Make the layer draggable 
layerA.draggable.enabled = true
# Prevent vertical dragging
layerA.draggable.horizontal = true
layerA.draggable.vertical = false
# Alternative way by setting the speed
layerA.draggable.speedX = 1
layerA.draggable.speedY = 0
# Set the constraints frame
layerA.draggable.constraints = {
    x: 100
    y: 500
    width: 450
    height: 80
}

# Disable overdrag
layerA.draggable.overdrag = true
# Disable bounce
layerA.draggable.bounce = false
# Disable momentum
layerA.draggable.momentum = false

# Start dragging
layerA.on Events.DragStart, ->
    this.animate 
        properties: {scale: 1.1}

# When moving the draggable layer
layerA.on Events.DragMove, (event) -> 
    layerA.html = "moving"

# After dragging
layerA.on Events.DragEnd, -> 
    this.animate 
        properties: {scale: 1}
        layerA.html = ""

# DRAGGING ANIMATION ALTERNATIVE
# FOR THIS TO WORK 
# Tuen on .bounce and .momentum
# Dont use DragStart or DragEnd     
# After DragEnd, the DragAnimation starts
# layerA.on Events.DragAnimationDidStart, ->
#     this.animate 
#         properties: {scale: 3}
#         layerA.html = "start"

# Starts with the momentum and bounce
# layerA.on Events.DragAnimationDidEnd, -> 
#     this.animate 
#         properties: {scale: 1}