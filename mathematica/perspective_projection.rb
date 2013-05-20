p1 = [
[100,200,100],
[200,200,100],
[100,300,100],
[200,300,100],
[100,200,200],
[200,200,200],
[100,300,200],
[200,300,200]
]

def transform(point)
  d = 50
  x = -point[0]/(point[2]/d)
  y = point[1]/(point[2]/d)
  return [x,y]
end

p2 = []
p1.each do |point|
	p2 << transform(point)
end
