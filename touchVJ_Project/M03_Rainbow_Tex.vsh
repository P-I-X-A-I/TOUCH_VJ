
attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;
uniform mat4 mvpMatrix;

varying vec4 colorVarying;
varying vec2 texCoordVarying;

void main()
{
    gl_Position = mvpMatrix * position;
    colorVarying = color;
    texCoordVarying = texCoord;
    
}

%

varying lowp vec4 colorVarying;
varying mediump vec2 texCoordVarying;
uniform sampler2D lineTex;

void main()
{
    lowp vec4 texColor = texture2D( lineTex, texCoordVarying );
    gl_FragColor = colorVarying * texColor;
}