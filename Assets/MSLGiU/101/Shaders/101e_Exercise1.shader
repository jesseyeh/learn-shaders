﻿Shader "MSLGiU/101/101e_Exercise1" {
  Properties {
    _MainTex("Texture", 2D) = "white" {}
    _Color("Color", Color) = (1, 1, 1, 1)
  }
  SubShader {
    Tags {
      // make sprites render after opaque geometry
      "Queue" = "Transparent"
    }
    Pass {
      // SrcColor * SrcAlpha + DstColor * OneMinusSrcALpha
      Blend SrcAlpha OneMinusSrcAlpha
      
      CGPROGRAM
      #pragma vertex vert
      #pragma fragment frag

      // user-defined vars
      sampler2D _MainTex;
      float4 _Color;

      #include "UnityCG.cginc"

      struct appdata {
        float4 vertex : POSITION;
        float2 uv : TEXCOORD0;
      };
      struct v2f {
        float4 vertex : SV_POSITION;
        float2 uv : TEXCOORD0;
      };

      v2f vert(appdata v) {
        v2f o;
        // does matrix multiplication on local vertex to transform it from a point on the object to a point on the screen
        o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
        o.uv = v.uv;
        return o;
      }

      float4 frag(v2f i) : SV_Target {
        // draw white pixels to the screen
        float4 color = _Color * tex2D(_MainTex, i.uv);
        return color;
      }

      ENDCG
    }
  }
}