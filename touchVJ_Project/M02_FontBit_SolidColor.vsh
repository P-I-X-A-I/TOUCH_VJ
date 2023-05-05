
attribute vec4 position;
attribute float alpha;
uniform vec3 color;
uniform mat4 mvp_Matrix;

varying vec4 colorVarying;

void main()
{
    gl_Position = mvp_Matrix * position;
    colorVarying = vec4( color, alpha );
}

%

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}