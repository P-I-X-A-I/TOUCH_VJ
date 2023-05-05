attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 colorVarying;
varying vec2 texCoordVarying;
void main()
{
    gl_Position = position;
    
    colorVarying = color;
    texCoordVarying = texCoord;
}

%

varying lowp vec4 colorVarying;
varying mediump vec2 texCoordVarying;
uniform sampler2D patternTexture;

void main()
{
    lowp vec4 texColor = texture2D( patternTexture, texCoordVarying );
    //gl_FragColor = colorVarying * texColor;
    gl_FragColor = vec4( colorVarying.rgb+texColor.rgb, colorVarying.a*texColor.a);
}