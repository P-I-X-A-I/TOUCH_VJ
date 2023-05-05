
attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

uniform mat4 mvpMatrix;
uniform vec3 lightColor;

varying vec4 colorVarying;

void main()
{
    float specular = dot( normal, vec3(0.0, 0.984807753012208, 0.17364817766693) );
    specular = pow( specular, 5.0 );
    
    gl_Position = mvpMatrix * position;
    colorVarying = vec4( color.rgb + lightColor*specular, color.a );
    
}

%

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}