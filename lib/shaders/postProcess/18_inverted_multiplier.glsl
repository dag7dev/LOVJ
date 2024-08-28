//extern float _time;
vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
{
	#define M_PI 3.1415926535897932384626433832795
	/*
	
	vec2 shiftUV = texture_coords - 0.5;
	float radius = sqrt(dot(shiftUV, shiftUV));
	float angle = atan(shiftUV.y, shiftUV.x); // here angle is [-pi; pi]

	float segmentAngle = 2*M_PI / _segmentParameter;
	angle -= segmentAngle*floor(angle / segmentAngle);

	angle = min(angle, segmentAngle - angle);

	texture_coords = (vec2(cos(angle), sin(angle)) * radius) + 0.5;

	texture_coords = max(min(texture_coords, 2.0 - texture_coords), -texture_coords);
	//return vec4(angle, 0.0, 0.0, 1.0);
	return vec4(Texel(tex, texture_coords));
	*/
	
	// trianle wave : abs(2.*fract(x)-1.);
	color = Texel(tex, vec2(abs(2.*(fract(texture_coords.x)-.5)), 
							abs(2.*(fract(texture_coords.y)-.5))));
	
	//color.w += sin((texture_coords.x+_time)+sin(_time)+texture_coords.y*10.);
	
	return color;
}