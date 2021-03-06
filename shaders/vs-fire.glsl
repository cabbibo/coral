
uniform vec3 lightPos;
uniform float time;
uniform sampler2D t_audio;

uniform float audioDisplacement;
uniform float distancePower;
uniform float audioBand;

varying vec3 vPos;
varying vec3 vNorm;
varying vec3 vView;

varying mat3 vNormalMat;
varying vec3 vLightDir;
varying float vDisplacement;

varying vec3 vMVPos;
varying vec4 vAudio;

varying float vAudioLookup;


void main(){

  vPos  = position;
  vNorm = normal;

  vView = modelViewMatrix[3].xyz;
  vNormalMat = normalMatrix;

  vNorm = normal;
  
  vec3 lightDir = normalize( lightPos -  (modelViewMatrix * vec4( vPos , 1.0 )).xyz );
  vLightDir = lightDir;

  vAudioLookup = abs(sin( pow( length( vPos) ,3. ) * audioBand /200. ));
  vec4 a = texture2D( t_audio , vec2( vAudioLookup ,0.));
  
  vAudio = a;
  vPos += vNorm * pow( length( a ), 5.) * pow( length(vPos), distancePower ) * audioDisplacement / 100.;
  vDisplacement = length( vPos );
  vMVPos = (modelViewMatrix * vec4( vPos , 1.0 )).xyz;

  gl_Position = projectionMatrix * modelViewMatrix * vec4( vPos , 1.0 );

}
