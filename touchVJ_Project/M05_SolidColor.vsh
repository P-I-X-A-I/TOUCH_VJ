
attribute vec2 sizeWeight;
attribute vec4 position;
attribute vec4 color;

uniform mat4 mvpMatrix;
uniform float pointSize;

varying vec4 colorVarying;
varying float texShiftVarying;

void main()
{
    gl_Position = mvpMatrix * position;
    colorVarying = color;
    
    gl_PointSize = pointSize*sizeWeight.x;
    
    texShiftVarying = sizeWeight.y;
}

%

varying lowp vec4 colorVarying;
uniform sampler2D texPoint;
varying mediump float texShiftVarying;

void main()
{
    mediump vec2 texCoord = vec2( gl_PointCoord.x*0.0625 + texShiftVarying*0.0625 , gl_PointCoord.y );
    lowp vec4 texColor = texture2D( texPoint, texCoord);
    gl_FragColor = colorVarying*texColor;
}