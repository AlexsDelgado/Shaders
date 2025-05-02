// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Space UV"
{
	Properties
	{
		_Mask("Mask", 2D) = "white" {}
		_ScreenUVTexture("Screen UV Texture", 2D) = "white" {}
		_WorldSpaceTexture("WorldSpaceTexture", 2D) = "white" {}
		_Tiling("Tiling", Vector) = (0.5,0.5,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _WorldSpaceTexture;
		uniform float2 _Tiling;
		uniform sampler2D _ScreenUVTexture;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 normalizeResult58 = normalize( ( ase_worldPos - _WorldSpaceCameraPos ) );
			float4 WorldSpaceTexture61 = tex2D( _WorldSpaceTexture, ( normalizeResult58 * float3( _Tiling ,  0.0 ) ).xy );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float4 appendResult8 = (float4(ase_screenPosNorm.x , ase_screenPosNorm.y , 0.0 , 0.0));
			float4 ScreenSpaceTexture65 = tex2D( _ScreenUVTexture, appendResult8.xy );
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float Mask67 = ( 1.0 - tex2D( _Mask, uv_Mask ).r );
			float4 lerpResult48 = lerp( WorldSpaceTexture61 , ScreenSpaceTexture65 , Mask67);
			float4 UVTexture42 = lerpResult48;
			o.Albedo = UVTexture42.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
782;692;647;307;2868.767;651.8664;2.993035;False;False
Node;AmplifyShaderEditor.CommentaryNode;63;-2448.062,-445.1522;Inherit;False;1587.44;424.0781;Wrold Space;8;56;51;57;58;55;53;61;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;56;-2398.062,-239.8104;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;51;-2323.911,-395.1522;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;66;-2294.67,107.736;Inherit;False;1095.292;330.7263;Screen Space;4;7;8;49;65;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;57;-2074.256,-317.4079;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;58;-1894.588,-318.0137;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;55;-1912.676,-182.554;Inherit;False;Property;_Tiling;Tiling;3;0;Create;True;0;0;0;False;0;False;0.5,0.5;3,3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;68;-2199.624,525.7217;Inherit;False;783.0591;280;Mask;3;5;4;67;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;7;-2244.67,157.8291;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-1676.402,-262.6375;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-2022.387,185.3023;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;5;-2149.624,575.7217;Inherit;True;Property;_Mask;Mask;0;0;Create;True;0;0;0;False;0;False;-1;4d7e6bc97bce9a94cbbb0f6bf004198f;4d7e6bc97bce9a94cbbb0f6bf004198f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;50;-1468.703,-290.7019;Inherit;True;Property;_WorldSpaceTexture;WorldSpaceTexture;2;0;Create;True;0;0;0;False;0;False;-1;b3d4730e24858ea419873d76821eabe8;b3d4730e24858ea419873d76821eabe8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;49;-1785.757,157.736;Inherit;True;Property;_ScreenUVTexture;Screen UV Texture;1;0;Create;True;0;0;0;False;0;False;-1;933774e2a6016bc4e924436fac067004;933774e2a6016bc4e924436fac067004;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;4;-1837.931,604.206;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;65;-1469.26,158.1378;Inherit;False;ScreenSpaceTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;61;-1123.393,-290.3231;Inherit;False;WorldSpaceTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-1655.965,599.7733;Inherit;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;-920.4581,223.535;Inherit;False;65;ScreenSpaceTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;-856.4246,304.8044;Inherit;False;67;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-914.1576,139.7894;Inherit;False;61;WorldSpaceTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;48;-616.717,147.6237;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;-440.5081,141.7158;Inherit;False;UVTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-224.5648,-70.6351;Inherit;False;42;UVTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;7.140808,-65.29596;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Space UV;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;57;0;51;0
WireConnection;57;1;56;0
WireConnection;58;0;57;0
WireConnection;53;0;58;0
WireConnection;53;1;55;0
WireConnection;8;0;7;1
WireConnection;8;1;7;2
WireConnection;50;1;53;0
WireConnection;49;1;8;0
WireConnection;4;0;5;1
WireConnection;65;0;49;0
WireConnection;61;0;50;0
WireConnection;67;0;4;0
WireConnection;48;0;62;0
WireConnection;48;1;69;0
WireConnection;48;2;70;0
WireConnection;42;0;48;0
WireConnection;0;0;44;0
ASEEND*/
//CHKSM=8AFD403031F2782A21A4143054022854AEF0B267