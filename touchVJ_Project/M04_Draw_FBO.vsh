
attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;
uniform mat4 mvp_Matrix;

varying vec4 colorVarying;
varying vec2 texCoordVarying;

void main()
{
    gl_Position = mvp_Matrix * position;
    colorVarying = color;
    texCoordVarying = texCoord;
}

%

varying lowp vec4 colorVarying;
varying mediump vec2 texCoordVarying;
uniform sampler2D FBO_Tex;

void main()
{
    lowp vec3 texColor = texture2D( FBO_Tex, texCoordVarying ).rgb;
    
    gl_FragColor = vec4( colorVarying.rgb + texColor, colorVarying.a );
}