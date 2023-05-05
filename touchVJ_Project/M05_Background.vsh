
attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 colorVarying;
varying vec2 texVarying;

void main()
{
    gl_Position = position;
    colorVarying = color;
    texVarying = texCoord;
}

%

varying lowp vec4 colorVarying;
varying mediump vec2 texVarying;

uniform sampler2D BGTexture;

void main()
{
    lowp vec4 TexColor = texture2D( BGTexture, texVarying );
    
    gl_FragColor = TexColor * colorVarying;
}