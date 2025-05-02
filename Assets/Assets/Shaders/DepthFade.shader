// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DepthFade"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_VoronoiScale("VoronoiScale", Range( -1 , 1)) = 0
		_TextureTiling("TextureTiling", Float) = 0
		_DistortionWeight("DistortionWeight", Range( -1 , 3)) = 0
		_PannerSpeed("PannerSpeed", Float) = 0
		_PannerDirection("PannerDirection", Vector) = (0,0,0,0)
		_Blas("Blas", Float) = 0
		_DepthFadeScale("DepthFadeScale", Float) = 0
		_DepthFadePower("DepthFadePower", Range( -0.01 , 0.1)) = 0
		_Direction("Direction", Range( -1 , 1)) = 0

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _VoronoiScale;
			uniform sampler2D _Texture0;
			uniform float _Direction;
			uniform float2 _PannerDirection;
			uniform float _PannerSpeed;
			uniform sampler2D _TextureSample0;
			uniform float _TextureTiling;
			uniform float _DistortionWeight;
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _Blas;
			uniform float _DepthFadeScale;
			uniform float _DepthFadePower;
					float2 voronoihash18( float2 p )
					{
						
						p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
						return frac( sin( p ) *43758.5453);
					}
			
					float voronoi18( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
					{
						float2 n = floor( v );
						float2 f = frac( v );
						float F1 = 8.0;
						float F2 = 8.0; float2 mg = 0;
						for ( int j = -3; j <= 3; j++ )
						{
							for ( int i = -3; i <= 3; i++ )
						 	{
						 		float2 g = float2( i, j );
						 		float2 o = voronoihash18( n + g );
								o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
								float d = 0.5 * dot( r, r );
						 		if( d<F1 ) {
						 			F2 = F1;
						 			F1 = d; mg = g; mr = r; id = o;
						 		} else if( d<F2 ) {
						 			F2 = d;
						 		}
						 	}
						}
						return F1;
					}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord2 = screenPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float4 color19 = IsGammaSpace() ? float4(0.06563723,0.5566038,0.535428,0) : float4(0.005492237,0.2702231,0.2483104,0);
				float mulTime17 = _Time.y * _VoronoiScale;
				float time18 = mulTime17;
				float2 coords18 = i.ase_texcoord1.xy * 1.0;
				float2 id18 = 0;
				float2 uv18 = 0;
				float fade18 = 0.5;
				float voroi18 = 0;
				float rest18 = 0;
				for( int it18 = 0; it18 <4; it18++ ){
				voroi18 += fade18 * voronoi18( coords18, time18, id18, uv18, 0 );
				rest18 += fade18;
				coords18 *= 2;
				fade18 *= 0.5;
				}//Voronoi18
				voroi18 /= rest18;
				float2 temp_cast_0 = (_TextureTiling).xx;
				float2 texCoord3 = i.ase_texcoord1.xy * temp_cast_0 + float2( 0,0 );
				float2 lerpResult14 = lerp( ( (tex2D( _TextureSample0, texCoord3 )).rg + texCoord3 ) , texCoord3 , _DistortionWeight);
				float2 panner21 = ( 1.0 * _Time.y * ( ( _Direction * _PannerDirection ) * _PannerSpeed ) + lerpResult14);
				float4 screenPos = i.ase_texcoord2;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth1 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
				float distanceDepth1 = abs( ( screenDepth1 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
				
				
				finalColor = saturate( ( ( ( color19 + voroi18 ) + tex2D( _Texture0, panner21 ) ) + ( 1.0 - pow( ( ( distanceDepth1 + _Blas ) * _DepthFadeScale ) , _DepthFadePower ) ) ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
374;87;549;543;1174.075;43.47324;1.348993;True;False
Node;AmplifyShaderEditor.CommentaryNode;25;-1440.253,-782.5017;Inherit;False;1633.797;841.6556;Voronoi + Distortion;25;7;11;12;22;21;20;19;18;17;16;15;14;13;23;24;10;9;8;6;5;4;3;2;35;36;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1290.053,-276.855;Inherit;False;Property;_TextureTiling;TextureTiling;3;0;Create;True;0;0;0;False;0;False;0;0.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1135.971,-293.9752;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;4;-959.4247,-333.7525;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;5;-1392.916,-354.9329;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;6;-1361.958,-545.6431;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;e28dc97a9541e3642a48c0e3886688c5;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;35;-1508.527,-73.21375;Inherit;False;Property;_Direction;Direction;10;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;8;-1408.565,-209.1498;Inherit;False;Property;_PannerDirection;PannerDirection;6;0;Create;True;0;0;0;False;0;False;0,0;0,-1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1206.391,-151.1297;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1245.254,-7.051979;Inherit;False;Property;_PannerSpeed;PannerSpeed;5;0;Create;True;0;0;0;False;0;False;0;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;9;-1090.303,-542.9722;Inherit;False;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-889.4387,-384.7126;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1060.622,-131.3656;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-462.1897,-456.5013;Inherit;False;Property;_VoronoiScale;VoronoiScale;2;0;Create;True;0;0;0;False;0;False;0;-0.33;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1305.201,237.2199;Inherit;False;Property;_Blas;Blas;7;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;1;-1383.354,136.6714;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-765.0185,-185.91;Inherit;False;Property;_DistortionWeight;DistortionWeight;4;0;Create;True;0;0;0;False;0;False;0;0;-1;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;15;-530.1682,-97.94525;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;14;-730.2206,-292.2631;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1021.097,243.396;Inherit;False;Property;_DepthFadeScale;DepthFadeScale;8;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-1022.64,138.4008;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;16;-738.7807,-571.3235;Inherit;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;0;False;0;False;61c0b9c0523734e0e91bc6043c72a490;61c0b9c0523734e0e91bc6043c72a490;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleTimeNode;17;-460.1897,-521.5015;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;21;-447.7368,-293.9752;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;19;-361.1897,-732.5017;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;0.06563723,0.5566038,0.535428,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-733.9031,139.9447;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;20;-518.522,-385.3045;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.VoronoiNode;18;-308.1896,-567.5015;Inherit;False;2;0;1;0;4;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.RangedFloatNode;34;-700.9362,241.8519;Inherit;False;Property;_DepthFadePower;DepthFadePower;9;0;Create;True;0;0;0;False;0;False;0;0.005;-0.01;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;30;-409.655,141.4889;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-92.49381,-589.4697;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;22;-255.9895,-371.0163;Inherit;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;24;67.58193,-388.1368;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;31;-76.40038,139.489;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;211.8362,14.5039;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;26;367.9678,15.39342;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;579.2039,15.99738;Float;False;True;-1;2;ASEMaterialInspector;100;1;DepthFade;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;3;0;2;0
WireConnection;4;0;3;0
WireConnection;5;0;4;0
WireConnection;6;1;5;0
WireConnection;36;0;35;0
WireConnection;36;1;8;0
WireConnection;9;0;6;0
WireConnection;10;0;9;0
WireConnection;10;1;3;0
WireConnection;11;0;36;0
WireConnection;11;1;7;0
WireConnection;15;0;11;0
WireConnection;14;0;10;0
WireConnection;14;1;3;0
WireConnection;14;2;12;0
WireConnection;28;0;1;0
WireConnection;28;1;32;0
WireConnection;17;0;13;0
WireConnection;21;0;14;0
WireConnection;21;2;15;0
WireConnection;29;0;28;0
WireConnection;29;1;33;0
WireConnection;20;0;16;0
WireConnection;18;1;17;0
WireConnection;30;0;29;0
WireConnection;30;1;34;0
WireConnection;23;0;19;0
WireConnection;23;1;18;0
WireConnection;22;0;20;0
WireConnection;22;1;21;0
WireConnection;24;0;23;0
WireConnection;24;1;22;0
WireConnection;31;0;30;0
WireConnection;27;0;24;0
WireConnection;27;1;31;0
WireConnection;26;0;27;0
WireConnection;0;0;26;0
ASEEND*/
//CHKSM=0D2D78A8F4F1F2BF62B8F891E705452A76D305F5