attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;
uniform mat4 mvp_Matrix;

varying vec4 colorVarying;
varying vec2 texVarying;

void main()
{
    gl_Position = mvp_Matrix * position;
    colorVarying = color;
    texVarying = texCoord;
}%

varying lowp vec4 colorVarying;
varying mediump vec2 texVarying;
uniform sampler2D UNF_BoardTex;

void main()
{
    lowp vec4 texColor = texture2D( UNF_BoardTex, texVarying );
    
    gl_FragColor = colorVarying * texColor;
}
