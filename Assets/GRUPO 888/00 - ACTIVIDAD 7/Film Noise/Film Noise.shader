// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Film Noise"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_PannerSpeed("PannerSpeed", Vector) = (0.5,0.5,0,0)
		_TextureNoise("TextureNoise", 2D) = "white" {}
		_LerpDistortion("LerpDistortion", Float) = 0.01
		_GrayScale("GrayScale", Float) = 1

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform sampler2D _TextureNoise;
			uniform float2 _PannerSpeed;
			uniform float _LerpDistortion;
			uniform float _GrayScale;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 texCoord4 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner7 = ( _Time.y * _PannerSpeed + texCoord4);
				float4 tex2DNode8 = tex2D( _TextureNoise, panner7 );
				float4 appendResult9 = (float4(tex2DNode8.r , tex2DNode8.g , 0.0 , 0.0));
				float4 lerpResult11 = lerp( float4( texCoord4, 0.0 , 0.0 ) , appendResult9 , _LerpDistortion);
				float4 tex2DNode12 = tex2D( _MainTex, lerpResult11.xy );
				float grayscale3 = Luminance(tex2DNode12.rgb);
				float4 temp_cast_3 = (grayscale3).xxxx;
				float4 lerpResult13 = lerp( tex2DNode12 , temp_cast_3 , _GrayScale);
				

				finalColor = lerpResult13;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
485;664;944;335;1967.489;128.8929;1.544059;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;6;-2199.429,393.2635;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;5;-2175.003,226.3836;Inherit;False;Property;_PannerSpeed;PannerSpeed;0;0;Create;True;0;0;0;False;0;False;0.5,0.5;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-2219.124,67.2179;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;7;-1955.429,208.2631;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;8;-1760.428,180.2632;Inherit;True;Property;_TextureNoise;TextureNoise;1;0;Create;True;0;0;0;False;0;False;-1;cd460ee4ac5c1e746b7a734cc7cc64dd;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;9;-1443.517,207.9108;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1488.675,374.1331;Inherit;False;Property;_LerpDistortion;LerpDistortion;2;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-1202.42,-12.72743;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;11;-1222.904,62.37632;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;12;-988.8643,11.93214;Inherit;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCGrayscale;3;-647.6278,86.4743;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-604.6478,177.7163;Inherit;False;Property;_GrayScale;GrayScale;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;13;-383.5177,18.2317;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-193.941,18.31291;Float;False;True;-1;2;ASEMaterialInspector;0;2;Film Noise;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;7;0;4;0
WireConnection;7;2;5;0
WireConnection;7;1;6;0
WireConnection;8;1;7;0
WireConnection;9;0;8;1
WireConnection;9;1;8;2
WireConnection;11;0;4;0
WireConnection;11;1;9;0
WireConnection;11;2;10;0
WireConnection;12;0;1;0
WireConnection;12;1;11;0
WireConnection;3;0;12;0
WireConnection;13;0;12;0
WireConnection;13;1;3;0
WireConnection;13;2;14;0
WireConnection;0;0;13;0
ASEEND*/
//CHKSM=B360070405A88E5D05A2B7E72424B0E5428ACF08