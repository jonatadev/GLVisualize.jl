using GLVisualize, GeometryTypes, GLAbstraction, Colors, Reactive, FileIO

w = glscreen()

const t    = bounce(0f0:0.1f0:1000f0)
radius     = 200f0
middle     = Point2f0(w.area.value.w/2, w.area.value.h/2)
circle_pos = Point2f0[(Point2f0(sin(i), cos(i))*radius)+middle for i=linspace(0, 2pi, 20)]
rotation   = Vec2f0[normalize(Vec2f0(middle)-Vec2f0(p)) for p in circle_pos]
scales     = map(t) do t
    Vec2f0[Vec2f0(30, ((sin(i+t)+1)/2)*60) for i=linspace(0, 2pi, 20)]
end
a = visualize((CIRCLE, circle_pos), rotation=rotation, scale=scales, model=scalematrix(Vec3f0(0.03)))
view(a)
renderloop(w)
