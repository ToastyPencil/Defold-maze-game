varying highp vec4 var_position;
varying mediump vec3 var_normal;
varying mediump vec2 var_texcoord0;
varying mediump vec4 var_light;

uniform lowp sampler2D tex0;
uniform lowp sampler2D tex1;
uniform lowp vec4 tint0;
uniform lowp vec4 tint1;

void main()
{
  
    vec4 tint0_pm = vec4(tint0.xyz * tint0.w, tint0.w);
    vec4 tint1_pm = vec4(tint1.xyz * tint1.w, tint1.w);

    vec4 color0 = texture2D(tex0, var_texcoord0.xy); // * tint0_pm;
    vec4 color1 = texture2D(tex1, var_texcoord0.xy); // * tint1_pm;
    gl_FragColor = color1* color0; 
}

