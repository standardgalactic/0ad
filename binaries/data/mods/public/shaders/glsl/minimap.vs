#version 110

uniform mat4 transform;
uniform mat4 textureTransform;

#if MINIMAP_MASK
  uniform mat4 maskTextureTransform;
  varying vec2 v_maskUV;
#endif

#if MINIMAP_BASE || MINIMAP_LOS || MINIMAP_MASK
  attribute vec3 a_vertex;
  attribute vec2 a_uv0;
#endif

#if MINIMAP_BASE || MINIMAP_LOS
  varying vec2 v_tex;
#endif

#if MINIMAP_POINT
  attribute vec2 a_vertex;
  attribute vec3 a_color;
  varying vec3 color;
#endif

#if MINIMAP_LINE
  attribute vec2 a_vertex;
#endif

void main()
{
  #if MINIMAP_BASE || MINIMAP_LOS
    gl_Position = transform * vec4(a_vertex, 1.0);
    v_tex = (textureTransform * vec4(a_uv0, 0.0, 1.0)).xy;
  #endif

  #if MINIMAP_MASK
    v_maskUV = (maskTextureTransform * vec4(a_uv0, 0.0, 1.0)).xy;
  #endif

  #if MINIMAP_POINT
    gl_Position = transform * vec4(a_vertex, 0.0, 1.0);
    color = a_color;
  #endif

  #if MINIMAP_LINE
    gl_Position = transform * vec4(a_vertex, 0.0, 1.0);
  #endif
}
