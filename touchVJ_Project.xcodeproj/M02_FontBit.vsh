

attribute vec4 position;
uniform vec3 color;
uniform mat4 mvp_Matrix;
uniform float fovyWeight;
uniform float pointSizeBase;

varying vec4 colorVarying;
varying float textureIndex;

void main()
{
    float depthWeight = 1.0 / pow((1.0 - position.z), 1.2);
    textureIndex = ( position.z + 1.0 ) * 8.0;
    
    gl_Position = mvp_Matrix * position;
    colorVarying = vec4( color, 1.0 - abs(position.z));
    gl_PointSize =  pointSizeBase * fovyWeight * depthWeight;    // 12.0 is adjusted value for 90.0fovy
}%




varying lowp vec4 colorVarying;
varying lowp float textureIndex;

uniform sampler2D PointTexture;
void main()
{
    mediump vec2 pointTexCoord = vec2(0.0625*floor(textureIndex) + gl_PointCoord.x*0.0625, gl_PointCoord.y);
    
    lowp float pointColor = texture2D( PointTexture, pointTexCoord).a;
    gl_FragColor = vec4( colorVarying.rgb, colorVarying.a * pointColor );
}

