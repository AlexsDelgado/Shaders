// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "unit12"
{
	Properties
	{
		_fondo("fondo", 2D) = "white" {}
		_lava("lava", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Float0("Float 0", Float) = 0.1
		_FlowmapLava("FlowmapLava", Range( -1 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		ZTest Always
		Stencil
		{
			Ref 1
			Comp Equal
			Pass Keep
			Fail Keep
			ZFail Zero
		}
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _fondo;
		uniform sampler2D _lava;
		uniform float _Float0;
		uniform sampler2D _TextureSample0;
		uniform float _FlowmapLava;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float4 appendResult175 = (float4(ase_worldPos.y , ase_worldPos.z , 0.0 , 0.0));
			float4 RockTexture189 = tex2D( _fondo, appendResult175.xy );
			float2 temp_cast_1 = (( _Time.y * _Float0 )).xx;
			float4 appendResult174 = (float4(ase_worldPos.x , ase_worldPos.z , 0.0 , 0.0));
			float4 lerpResult185 = lerp( appendResult174 , tex2D( _TextureSample0, appendResult174.xy ) , _FlowmapLava);
			float2 panner178 = ( 1.0 * _Time.y * temp_cast_1 + lerpResult185.rg);
			float4 LavaTexture193 = tex2D( _lava, panner178 );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float4 lerpResult176 = lerp( RockTexture189 , LavaTexture193 , ase_vertexNormal.z);
			o.Albedo = lerpResult176.rgb;
			o.Emission = lerpResult176.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD1;
				float3 worldNormal : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0.8;30.4;766.4;763.8;-1810.322;134.1584;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;192;-440.5088,150.127;Inherit;False;1781.961;658.0272;Lava;11;172;174;179;182;186;180;181;185;178;171;193;LavaTexture;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;172;-390.5088,200.127;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;174;-154.5998,223.8951;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;191;446.4738,-533.1114;Inherit;False;1261.616;308.4777;RockTexture;4;187;175;170;189;RockTexture;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;180;197.2453,694.2745;Inherit;False;Property;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;0.1;0.0005;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;179;173.8268,612.9211;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;186;-144.4367,599.9916;Inherit;False;Property;_FlowmapLava;FlowmapLava;4;0;Create;True;0;0;0;False;0;False;0;0.08;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;182;-150.0885,404.4214;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;None;1c08f909e4e1e5a46b5b258b12da15cc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;394.7458,648.5715;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;185;252.0198,325.1195;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;187;496.4738,-483.1114;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;175;804.3493,-477.7936;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;178;599.4407,524.749;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;171;808.7128,334.0988;Inherit;True;Property;_lava;lava;1;0;Create;True;0;0;0;False;0;False;-1;b4d341dfc17bfaf4185898ae8dc734e0;b4d341dfc17bfaf4185898ae8dc734e0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;170;1058.653,-467.2505;Inherit;True;Property;_fondo;fondo;0;0;Create;True;0;0;0;False;0;False;-1;931c330df8cc6654d8688273d22f6a6a;931c330df8cc6654d8688273d22f6a6a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;189;1468.689,-453.6502;Inherit;False;RockTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;193;1101.584,640.6248;Inherit;False;LavaTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;177;1891.292,401.4394;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;194;1864.304,266.8649;Inherit;False;193;LavaTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;1871.585,159.0586;Inherit;False;189;RockTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;176;2127.245,200.268;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;168;2392.546,48.12527;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;unit12;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;7;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;True;1;False;-1;255;False;-1;255;False;-1;5;False;-1;1;False;-1;1;False;-1;2;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;174;0;172;1
WireConnection;174;1;172;3
WireConnection;182;1;174;0
WireConnection;181;0;179;0
WireConnection;181;1;180;0
WireConnection;185;0;174;0
WireConnection;185;1;182;0
WireConnection;185;2;186;0
WireConnection;175;0;187;2
WireConnection;175;1;187;3
WireConnection;178;0;185;0
WireConnection;178;2;181;0
WireConnection;171;1;178;0
WireConnection;170;1;175;0
WireConnection;189;0;170;0
WireConnection;193;0;171;0
WireConnection;176;0;190;0
WireConnection;176;1;194;0
WireConnection;176;2;177;3
WireConnection;168;0;176;0
WireConnection;168;2;176;0
ASEEND*/
//CHKSM=6DAB3D1EC0CC191D55584357BEBACF22B578ECE1