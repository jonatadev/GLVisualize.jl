using GLVisualize, GeometryTypes, GLAbstraction, Colors, Reactive, FileIO

w = glscreen()
n = 50
t = bounce(0:10)

const border = 50f0
function bounce_particles(pos_velo, _)
    positions, velocity = pos_velo
    dt = 0.1f0
    @inbounds for i=1:length(positions)
        pos,velo = positions[i], velocity[i]
        positions[i] = Point2f0(pos[1], pos[2] + velo*dt)
        if pos[2] <= border
            velocity[i] = abs(velo)
        else
            velocity[i] = velo - 9.8*dt
        end
    end
    positions, velocity
end
start_position = (rand(Point2f0, n)*700f0) + border
position_velocity = foldp(bounce_particles,
    (start_position, zeros(Float32, n)),
    t
)
circle = HyperSphere(Point2f0(0), 20f0)
vis = visualize((circle, map(first, position_velocity)),
    image=loadasset("doge.png"),
    stroke_width=2f0,
    stroke_color=RGBA{Float32}(0.91,0.91,0.91,1)
)
view(vis, method=:orthographic_pixel)
renderloop(w)
