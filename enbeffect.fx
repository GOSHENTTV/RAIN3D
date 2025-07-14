//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries TES Skyrim SE hlsl DX11 format, example adaptation
// visit http://enbdev.com for updates
// Author: Boris Vorontsov
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



//+++++++++++++++++++++++++++++
//internal parameters, modify or add new
//+++++++++++++++++++++++++++++



//+++++++++++++++++++++++++++++
//external enb parameters, do not modify
//+++++++++++++++++++++++++++++

bool UsePaletteTexture < string UIName = "Use ENB Palette Texture"; > = { false };
bool UseAtmos < string UIName = "Use Atmosphere (high altitude)"; > = { false };
int separator0 < string UIName = " "; int UIMin = 0; int UIMax = 0; > = { 0 };
bool UseLevels < string UIName = "Use Levels"; > = { false };
float3 iBlack < string UIName = "  Input Black Point"; string UIWidget = "color"; > = { 0.0314, 0.0353, 0.0392 };
float3 iWhite < string UIName = "  Input White Point"; string UIWidget = "color"; > = { 0.9568, 0.9353, 0.9137 };
float3 oBlack < string UIName = "  Output Black Point"; string UIWidget = "color"; > = { 0.0, 0.0, 0.0 };
float3 oWhite < string UIName = "  Output White Point"; string UIWidget = "color"; > = { 1.0, 1.0, 1.0 };
int separator1 < string UIName = "  "; int UIMin = 0; int UIMax = 0; > = { 0 };
float postfx_vignette_intensity < string UIName = "RDR2::Vignette Intensity"; > = { 0.2996 };
float3 postfx_vignette_tint < string UIName = "RDR2::Vignette Tint"; string UIWidget = "color"; > = { 1.0, 1.0, 1.0 };
float postfx_vignette_axis_scale_x < string UIName = "RDR2::Vignette Axis Scale X"; > = { 1.0 };
float postfx_vignette_axis_scale_y < string UIName = "RDR2::Vignette Axis Scale Y"; > = { 1.0 };
float postfx_vignette_axis_tilt_x < string UIName = "RDR2::Vignette Axis Tilt X"; > = { 0.0 };
float postfx_vignette_axis_tilt_y < string UIName = "RDR2::Vignette Axis Tilt Y"; > = { 0.0 };
float postfx_vignette_inner_radius < string UIName = "RDR2::Vignette Inner Radius"; > = { 0.2 };
float postfx_vignette_outer_radius < string UIName = "RDR2::Vignette Outer Radius"; > = { 2.0 };
int separator2 < string UIName = "   "; int UIMin = 0; int UIMax = 0; > = { 0 };
float vig_int_d < string UIName = "GammaVignette (day)"; float UIMin = 0.0; float UIMax = 1.0; > = { 0.0 };
float vig_int_n < string UIName = "GammaVignette (night)"; float UIMin = 0.0; float UIMax = 1.0; > = { 0.0 };
int separator3 < string UIName = "    "; int UIMin = 0; int UIMax = 0; > = { 0 };
float3 Tint_d < string UIName = "Tint Color (day)"; string UIWidget = "color"; > = { 0.37, 0.39, 0.46 };
float Tinti_d < string UIName = "Tint Intensity (day)"; float UIMin = 0.0; float UIMax = 1.0; > = { 0.0 };
int separator4 < string UIName = "     "; int UIMin = 0; int UIMax = 0; > = { 0 };
float3 Tint_n < string UIName = "Tint Color (night)"; string UIWidget = "color"; > = { 0.37, 0.39, 0.46 };
float Tinti_n < string UIName = "Tint Intensity (night)"; float UIMin = 0.0; float UIMax = 1.0; > = { 0.0 };
int separator5 < string UIName = "      "; int UIMin = 0; int UIMax = 0; > = { 0 };
float3 cm_d < string UIName = "Color Mood (day)"; string UIWidget = "color"; > = { 0.705, 0.635, 0.55 };
float cmi_d < string UIName = "Color Mood Intensity (day)"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.001; > = { 0.0 };
int separator6 < string UIName = "       "; int UIMin = 0; int UIMax = 0; > = { 0 };
float3 cm_n < string UIName = "Color Mood (night)"; string UIWidget = "color"; > = { 0.705, 0.635, 0.55 };
float cmi_n < string UIName = "Color Mood Intensity (night)"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.001; > = { 0.0 };
int separator7 < string UIName = "        "; int UIMin = 0; int UIMax = 0; > = { 0 };
float qBright_d < string UIName = "Bright (day)"; float UIMin = 0.01; float UIMax = 10.0; float UIStep = 0.001; > = { 1.0 };
float qContrast_d < string UIName = "Contrast (day)"; float UIMin = -1.0; float UIMax = 1.0; float UIStep = 0.001; > = { 0.0 };
float qGamma_d < string UIName = "Gamma (day)"; float UIMin = 0.01; float UIStep = 0.001; > = { 1.0 };
float qSaturation_d < string UIName = "Saturation (day)"; float UIStep = 0.001; > = { 1.0 };
int separator8 < string UIName = "         "; int UIMin = 0; int UIMax = 0; > = { 0 };
float qBright_n < string UIName = "Bright (night)"; float UIMin = 0.01; float UIMax = 10.0; float UIStep = 0.001; > = { 1.0 };
float qContrast_n < string UIName = "Contrast (night)"; float UIMin = -1.0; float UIMax = 1.0; float UIStep = 0.001; > = { 0.0 };
float qGamma_n < string UIName = "Gamma (night)"; float UIMin = 0.01; float UIStep = 0.001; > = { 1.0 };
float qSaturation_n < string UIName = "Saturation (night)"; float UIStep = 0.001; > = { 1.0 };
int separator9 < string UIName = "          "; int UIMin = 0; int UIMax = 0; > = { 0 };
float desatR_d < string UIName = "Desaturate Red (day)"; float UIMin = 0.0; > = { 0.0 };
float desatG_d < string UIName = "Desaturate Green (day)"; float UIMin = 0.0; > = { 0.0 };
float desatB_d < string UIName = "Desaturate Blue (day)"; float UIMin = 0.0; > = { 0.0 };
int separator10 < string UIName = "           "; int UIMin = 0; int UIMax = 0; > = { 0 };
float desatR_n < string UIName = "Desaturate Red (night)"; float UIMin = 0.0; > = { 0.0 };
float desatG_n < string UIName = "Desaturate Green (night)"; float UIMin = 0.0; > = { 0.0 };
float desatB_n < string UIName = "Desaturate Blue (night)"; float UIMin = 0.0; > = { 0.0 };
float4 Test1 < string UIName = "Test1"; string UIWidget = "color"; int UIHidden = 1; > ;
float4 Test2 < string UIName = "Test2"; string UIWidget = "color"; int UIHidden = 1; > ;

#include "ENBFeeder.fxh"

float4 ENBParams01;
float4 Timer;
float4 ScreenSize;
float4 Weather;
Texture2D TextureColor;
Texture2D TextureBloom;
Texture2D TextureLens;
Texture2D TextureAdaptation;
Texture2D TextureDepth;
Texture2D TexturePalette < string ResourceName = "enbpalette.bmp"; > ;
Texture2D noisetex < string ResourceName = "wPN/18690.png"; > ;

SamplerState	Sampler0
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState	Sampler1
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerComparisonState Sampler5
{
	Filter = COMPARISON_MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
	ComparisonFunc = LESS;
};

struct VS_INPUT_POST
{
	float3 pos	: POSITION;
	float2 txcoord	: TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos	: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
};
struct VS_OUTPUT_POST2
{
	float4 pos	: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
	nointerpolation float4 txcoord1	: TEXCOORD1;
	float3 txcoord2	: TEXCOORD2;
	nointerpolation float4 dn0 : UI0;
	nointerpolation float4 dn1 : UI1;
	nointerpolation float4 dn2 : UI2;
	nointerpolation float4 dn3 : UI3;
	nointerpolation float4 txcoord7 : TEXCOORD7;
	float4 txcoord8 : TEXCOORD8;
	nointerpolation float4 txcoord9 : TEXCOORD9;
};

cbuffer postfx_cbuffer : register(b5)
{
	float4 dofProj : packoffset(c0);
	float4 dofShear : packoffset(c1);
	float4 dofDist : packoffset(c2);
	float4 hiDofParams : packoffset(c3);
	float4 hiDofMiscParams : packoffset(c4);
	float4 PostFXAdaptiveDofEnvBlurParams : packoffset(c5);
	float4 PostFXAdaptiveDofCustomPlanesParams : packoffset(c6);
	float4 BloomParams : packoffset(c7);
	float4 Filmic0 : packoffset(c8);
	float4 Filmic1 : packoffset(c9);
	float4 BrightTonemapParams0 : packoffset(c10);
	float4 BrightTonemapParams1 : packoffset(c11);
	float4 DarkTonemapParams0 : packoffset(c12);
	float4 DarkTonemapParams1 : packoffset(c13);
	float2 TonemapParams : packoffset(c14);
	float4 NoiseParams : packoffset(c15);
	float4 DirectionalMotionBlurParams : packoffset(c16);
	float4 DirectionalMotionBlurIterParams : packoffset(c17);
	float4 MBPrevViewProjMatrixX : packoffset(c18);
	float4 MBPrevViewProjMatrixY : packoffset(c19);
	float4 MBPrevViewProjMatrixW : packoffset(c20);
	float3 MBPerspectiveShearParams0 : packoffset(c21);
	float3 MBPerspectiveShearParams1 : packoffset(c22);
	float3 MBPerspectiveShearParams2 : packoffset(c23);
	float lowLum : packoffset(c23.w);
	float highLum : packoffset(c24);
	float topLum : packoffset(c24.y);
	float scalerLum : packoffset(c24.z);
	float offsetLum : packoffset(c24.w);
	float offsetLowLum : packoffset(c25);
	float offsetHighLum : packoffset(c25.y);
	float noiseLum : packoffset(c25.z);
	float noiseLowLum : packoffset(c25.w);
	float noiseHighLum : packoffset(c26);
	float bloomLum : packoffset(c26.y);
	float4 colorLum : packoffset(c27);
	float4 colorLowLum : packoffset(c28);
	float4 colorHighLum : packoffset(c29);
	float4 HeatHazeParams : packoffset(c30);
	float4 HeatHazeTex1Params : packoffset(c31);
	float4 HeatHazeTex2Params : packoffset(c32);
	float4 HeatHazeOffsetParams : packoffset(c33);
	float4 LensArtefactsParams0 : packoffset(c34);
	float4 LensArtefactsParams1 : packoffset(c35);
	float4 LensArtefactsParams2 : packoffset(c36);
	float4 LensArtefactsParams3 : packoffset(c37);
	float4 LensArtefactsParams4 : packoffset(c38);
	float4 LensArtefactsParams5 : packoffset(c39);
	float4 LightStreaksColorShift0 : packoffset(c40);
	float4 LightStreaksBlurColWeights : packoffset(c41);
	float4 LightStreaksBlurDir : packoffset(c42);
	float4 globalFreeAimDir : packoffset(c43);
	float4 globalFogRayParam : packoffset(c44);
	float4 globalFogRayFadeParam : packoffset(c45);
	float4 lightrayParams : packoffset(c46);
	float4 lightrayParams2 : packoffset(c47);
	float4 seeThroughParams : packoffset(c48);
	float4 seeThroughColorNear : packoffset(c49);
	float4 seeThroughColorFar : packoffset(c50);
	float4 seeThroughColorVisibleBase : packoffset(c51);
	float4 seeThroughColorVisibleWarm : packoffset(c52);
	float4 seeThroughColorVisibleHot : packoffset(c53);
	float4 debugParams0 : packoffset(c54);
	float4 debugParams1 : packoffset(c55);
	float PLAYER_MASK : packoffset(c56);
	float4 VignettingParams : packoffset(c57);
	float4 VignettingColor : packoffset(c58);
	float4 GradientFilterColTop : packoffset(c59);
	float4 GradientFilterColBottom : packoffset(c60);
	float4 GradientFilterColMiddle : packoffset(c61);
	float4 DamageOverlayMisc : packoffset(c62);
	float4 ScanlineFilterParams : packoffset(c63);
	float ScreenBlurFade : packoffset(c64);
	float4 ColorCorrectHighLum : packoffset(c65);
	float4 ColorShiftLowLum : packoffset(c66);
	float Desaturate : packoffset(c67);
	float Gamma : packoffset(c67.y);
	float4 LensDistortionParams : packoffset(c68);
	float4 DistortionParams : packoffset(c69);
	float4 BlurVignettingParams : packoffset(c70);
	float4 BloomTexelSize : packoffset(c71);
	float4 TexelSize : packoffset(c72);
	float4 GBufferTexture0Param : packoffset(c73);
	float2 rcpFrame : packoffset(c74);
	float4 sslrParams : packoffset(c75);
	float3 sslrCenter : packoffset(c76);
	float4 ExposureParams0 : packoffset(c77);
	float4 ExposureParams1 : packoffset(c78);
	float4 ExposureParams2 : packoffset(c79);
	float4 ExposureParams3 : packoffset(c80);
	float4 LuminanceDownsampleOOSrcDstSize : packoffset(c81);
	float4 QuadPosition : packoffset(c82);
	float4 QuadTexCoords : packoffset(c83);
	float4 QuadScale : packoffset(c84);
	float4 BokehBrightnessParams : packoffset(c85);
	float4 BokehParams1 : packoffset(c86);
	float4 BokehParams2 : packoffset(c87);
	float2 DOFTargetSize : packoffset(c88);
	float2 RenderTargetSize : packoffset(c88.z);
	float BokehGlobalAlpha : packoffset(c89);
	float BokehAlphaCutoff : packoffset(c89.y);
	bool BokehEnableVar : packoffset(c89.z);
	float BokehSortLevel : packoffset(c89.w);
	float BokehSortLevelMask : packoffset(c90);
	float BokehSortTransposeMatWidth : packoffset(c90.y);
	float BokehSortTransposeMatHeight : packoffset(c90.z);
	float currentDOFTechnique : packoffset(c90.w);
	float4 fpvMotionBlurWeights : packoffset(c91);
	float3 fpvMotionBlurVelocity : packoffset(c92);
	float fpvMotionBlurSize : packoffset(c92.w);
}

VS_OUTPUT_POST VS_Draw(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}

float4 dn4_func(float4 d4, float4 n4) {
	float t = Test2.w ? GameTime : Weather.w;
	float4 dn = lerp(n4, d4, smoothstep(5.0, 5.5, t));
	return lerp(dn, n4, smoothstep(21.0, 21.5, t));
}
VS_OUTPUT_POST2 VS_Draw2(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST2 OUT;
	OUT.pos.xyz = IN.pos.xyz;
	OUT.pos.w = 1.0;
	OUT.txcoord0.xy = IN.txcoord.xy;

	float t = Test2.w ? GameTime : Weather.w;
	float3 lightdir = lerp(moonDirection, sunDirection, smoothstep(5.0, 5.5, t));
	OUT.txcoord1.xyz = lerp(lightdir, moonDirection, smoothstep(21.0, 21.5, t));

	float t0 = smoothstep(4.1, 4.7, t);
	float t1 = smoothstep(4.7, 5.9, t);
	float t2 = smoothstep(5.9, 9.0, t);
	float t3 = smoothstep(18.7, 19.9, t);
	float t4 = smoothstep(19.9, 21.0, t);
	float t5 = smoothstep(21.0, 21.9, t);
	float tx = lerp(0.001, 0.06, t0);
	tx = lerp(tx, 2.7, t1);
	tx = lerp(tx, 38.0, t2);
	tx = lerp(tx, 18.0, t3);
	tx = lerp(tx, 0.2, t4);
	tx = lerp(tx, 0.001, t5);

	//			no,extr,cle,clrng,cld,over,smog,fogg,rain,thun,bliz,neut,snow,snowl,xms,hallo
	const float w[16] = { 0.1,1.0,0.6,0.6,0.5,0.2,0.5,0.3,0.3,0.1,0.1,0.5,0.1,0.2,0.1,0.4 };
	tx *= lerp(w[(int)qWeather.x], w[(int)qWeather.y], qWeather.z);
	OUT.txcoord1.w = tx;

	float2 tvec = IN.txcoord.xy * float2(2.0, -2.0) + float2(-1.0, 1.0);
	tvec *= dofProj.xy;
	float3 wpos = ViewInverse0.xyz * tvec.x;
	wpos += ViewInverse1.xyz * tvec.y;
	wpos -= ViewInverse2.xyz;
	wpos.z -= 0.015;//
	OUT.txcoord2.xyz = wpos;

	OUT.dn0 = dn4_func(float4(Tint_d, Tinti_d), float4(Tint_n, Tinti_n));
	OUT.dn1 = dn4_func(float4(qBright_d, qContrast_d, qGamma_d, qSaturation_d), float4(qBright_n, qContrast_n, qGamma_n, qSaturation_n));
	OUT.dn2 = dn4_func(float4(desatR_d, desatG_d, desatB_d, vig_int_d), float4(desatR_n, desatG_n, desatB_n, vig_int_n));
	OUT.dn3 = dn4_func(float4(cm_d, cmi_d), float4(cm_n, cmi_n));

	OUT.txcoord7.x = 1.0;
	if ((VignettingParams.z > 0.9991) && (VignettingParams.z < 0.9998)) OUT.txcoord7.x = 0.0;
	if ((VignettingParams.z > 0.9982) && (VignettingParams.z < 0.9990)) OUT.txcoord7.x = 0.33333334;
	OUT.txcoord7.y = 0.0;//
	OUT.txcoord7.zw = TextureAdaptation.SampleLevel(Sampler0, 0, 0).xy;

	float isweno = ((Test1.x > 0.0) && (Test1.x < 10.0)) ? Test1.x : 0.0;
	float isLoad = Test2.w ? isweno : (OUT.txcoord7.x == 0.0);
	isLoad = isLoad * (1.0 - saturate(ExteriorInterior)) * (1.0 - Test2.y);
	//float spd = lerp(0.74, 1.0, saturate((dofProj.x - 0.8289914) * 5.0656252));
	float spd = lerp(0.74, 1.0, saturate((dofProj.x - 0.6217436) * 6.7541646));
	OUT.txcoord8.xy = Test2.w ? IN.txcoord.xy : IN.txcoord.xy * spd + (1.0 - spd) * float2(0.5, 0.19);
	OUT.txcoord8.zw = 0.0;//

	OUT.txcoord9.x = TextureBloom.Load(0).w;
	OUT.txcoord9.y = TextureBloom.Load(int3(0, 1, 0)).w;
	OUT.txcoord9.z = TextureBloom.Load(int3(0, 2, 0)).w;
	OUT.txcoord9.w = saturate(isLoad * (1.0 - OUT.txcoord9.z) + OUT.txcoord9.z);

	return OUT;
}

float3 Atmosphere(float3 res, float2 uv, float3 wpos, float4 lightdir)
{
	float3 direction = normalize(wpos);
	float scatter = exp2((dot(lightdir.xyz, direction) - 1.0)) * 0.5;
	float3 atmosphere = float3(0.72, 0.89, 1.4);
	atmosphere += normalize(atmosphere) * scatter;
	atmosphere *= lightdir.w;
	atmosphere *= TextureDepth.SampleCmpLevelZero(Sampler5, uv, 0.9975).x;
	float alt = (min(max(ViewInverse3.z, 700.0), 920.0) - ViewInverse3.z) / direction.z;
	float height = saturate(-direction.z * 100.0) * lerp(0.0, 0.06, saturate(ViewInverse3.z * 0.01 - 800.0 * 0.01));
	return lerp(res, max(res, atmosphere), smoothstep(22000.0, 20000.0, alt) * height);
}

float4 PS_Draw(VS_OUTPUT_POST2 IN, float4 v0 : SV_Position0) : SV_Target
{
	float3 res = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0).xyz;
	res += TextureLens.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz * ENBParams01.y;
	float3 bloom = TextureBloom.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	float grayadaptation = TextureAdaptation.SampleLevel(Sampler0, IN.txcoord0.xy, 0).x;
	grayadaptation = rcp(grayadaptation);
	grayadaptation = max(0.06, grayadaptation);
	grayadaptation = min(10.0, grayadaptation);
	res *= grayadaptation;
	bloom *= grayadaptation;
	res += max(bloom - res, 0.0) * ENBParams01.x * 2.0;

	float4 r0, r1, r2;
	r1.xy = IN.txcoord0.xy - 0.5;
	r2.x = dot(float2(postfx_vignette_axis_scale_x, postfx_vignette_axis_tilt_y), r1.xy);
	r2.y = dot(float2(postfx_vignette_axis_tilt_x, postfx_vignette_axis_scale_y), r1.xy);
	r1.xy = postfx_vignette_outer_radius * r2.xy;
	r1.x = dot(r1.xy, r1.xy);
	r1.x = r1.x - 0.04;
	r1.x = postfx_vignette_inner_radius * r1.x;
	r1.x = max(0.0, r1.x);
	r1.y = (r1.x < 1.0);
	r1.z = exp2(r1.x * -10.0);
	r1.z = 1.0 - r1.z;
	r1.xw = r1.xx - float2(1.0, 2.0);
	r1.w = exp2(r1.w * 10.0);
	r1.x = (0.0 < r1.x) ? r1.w : 0.0;
	r1.x = 0.998 + r1.x;
	r1.x = r1.y ? r1.z : r1.x;
	r1.yzw = res * postfx_vignette_tint;
	r1.yzw = r1.yzw * postfx_vignette_intensity - res;
	res = r1.xxx * r1.yzw + res;

	r1.xy = IN.txcoord0.xy - 0.5;
	r0.w = dot(r1.xy, r1.xy);
	r0.w = 1.0 - r0.w;
	r0.w = log2(r0.w);
	r0.w = VignettingParams.y * r0.w;
	r0.w = exp2(r0.w);
	r0.w = saturate(VignettingParams.x + r0.w);
	r0.w = saturate(VignettingParams.z * r0.w);
	r1.xyz = 1.0 - VignettingColor.xyz;
	r1.xyz = r0.w * r1.xyz + VignettingColor.xyz;
	r0.xyz = r1.xyz * r0.xyz;

	r0.w = dot(res, float3(0.2126, 0.7152, 0.0722));
	r0.xyz = lerp(r0.w, res, Desaturate);
	r1.x = saturate(r0.w / ColorShiftLowLum.w);
	r1.xyz = lerp(ColorShiftLowLum.xyz, ColorCorrectHighLum.xyz, r1.x);
	r2.xyz = r1.xyz * r0.xyz;
	r1.w = 1.0 - ColorCorrectHighLum.w;
	r0.w = -r1.w + r0.w;
	r1.w = 1.0 - r1.w;
	r1.w = max(0.01, r1.w);
	r0.w = saturate(r0.w / r1.w);
	r0.xyz = -r0.xyz * r1.xyz + r0.xyz;
	r0.xyz = saturate(r0.w * r0.xyz + r2.xyz);
	res = pow(r0.xyz, Gamma);//1.0/2.2

	return float4(res, IN.txcoord7.x);
}

float4 PS_DrawOriginal(VS_OUTPUT_POST2 IN, float4 v0 : SV_Position0) : SV_Target
{
	float4 r0, r1, r2, r3;

	float3 bloom = TextureBloom.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz;
	float dirt = TextureBloom.SampleLevel(Sampler1, IN.txcoord8.xy, 0).w * IN.txcoord9.w;
	float right = TextureBloom.SampleLevel(Sampler1, IN.txcoord8.xy, 0, int2(1, 0)).w;
	float bottom = TextureBloom.SampleLevel(Sampler1, IN.txcoord8.xy, 0, int2(0, 1)).w;
	if ((v0.x < 1) && (v0.y < 3)) dirt = right = bottom = 0.0;
	float2 distort = saturate(dirt - float2(right * right, bottom * bottom)) * IN.txcoord9.x;
	r0.xyz = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy + distort, 0).xyz;
	r0.xyz += bloom * dirt * IN.txcoord9.y;
	if (IN.txcoord9.y == 0.0)r0.xyz = TextureColor.SampleLevel(Sampler0, IN.txcoord0.xy, 0).xyz;

	if (ViewInverse3.z > 700.0 && UseAtmos) r0.xyz = Atmosphere(r0.xyz, IN.txcoord0.xy, IN.txcoord2, IN.txcoord1);
	r0.xyz += TextureLens.SampleLevel(Sampler1, IN.txcoord0.xy, 0).xyz * ENBParams01.y;
	float2 adaptation = IN.txcoord7.zw;
	//float2 adaptation = TextureAdaptation.SampleLevel(Sampler0, IN.txcoord0.xy, 0).xy;
	r0.xyz += max(bloom - r0.xyz, 0.0) * ENBParams01.x;

	//dither
	r0.w = noisetex.Load(int3((int2)v0.yx & int2(63, 63), 0)).x * 2.0 - 1.0;
	r0.xyz = r0.w * 0.000781 + sqrt(r0.xyz);
	r0.xyz = r0.xyz * r0.xyz;

	//rdr2 vignette
	r1.xy = IN.txcoord0.xy - 0.5;
	r2.x = dot(float2(postfx_vignette_axis_scale_x, postfx_vignette_axis_tilt_y), r1.xy);
	r2.y = dot(float2(postfx_vignette_axis_tilt_x, postfx_vignette_axis_scale_y), r1.xy);
	r1.xy = postfx_vignette_outer_radius * r2.xy;
	r1.x = dot(r1.xy, r1.xy);
	r1.x = r1.x - 0.04;
	r1.x = postfx_vignette_inner_radius * r1.x;
	r1.x = max(0.0, r1.x);
	r1.y = (r1.x < 1.0);
	r1.z = exp2(r1.x * -10.0);
	r1.z = 1.0 - r1.z;
	r1.xw = r1.xx - float2(1.0, 2.0);
	r1.w = exp2(r1.w * 10.0);
	r1.x = (0.0 < r1.x) ? r1.w : 0.0;
	r1.x = 0.998 + r1.x;
	r1.x = r1.y ? r1.z : r1.x;
	r1.yzw = r0.xyz * postfx_vignette_tint;
	r1.yzw = r1.yzw * postfx_vignette_intensity - r0.xyz;
	r0.xyz = r1.xxx * r1.yzw + r0.xyz;

	//gta5 vignette
	r1.xy = IN.txcoord0.xy - 0.5;
	r0.w = dot(r1.xy, r1.xy);
	r0.w = 1.0 - r0.w;
	r0.w = log2(r0.w);
	r0.w = VignettingParams.y * r0.w;
	r0.w = exp2(r0.w);
	r0.w = saturate(VignettingParams.x + r0.w);
	r0.w = saturate(VignettingParams.z * r0.w);
	r1.xyz = 1.0 - VignettingColor.xyz;
	r1.xyz = r0.w * r1.xyz + VignettingColor.xyz;
	r0.xyz = r1.xyz * r0.xyz;

	//gta5 tonemap
	r0.xyz = min(float3(65504.0, 65504.0, 65504.0), r0.xyz);
	r0.w = saturate(adaptation.y * TonemapParams.x + TonemapParams.y);
	r1.xyzw = DarkTonemapParams0.xyzw - BrightTonemapParams0.xyzw;
	r1.xyzw = r0.w * r1.xyzw + BrightTonemapParams0.xyzw;
	r2.xyz = DarkTonemapParams1.zxy - BrightTonemapParams1.zxy;
	r2.xyz = r0.w * r2.xyz + BrightTonemapParams1.zxy;
	r3.xy = r2.yz * r1.w;
	r0.w = r1.z * r1.y;
	r1.z = r1.x * r2.x + r0.w;
	r1.z = r2.x * r1.z + r3.x;
	r1.w = r1.x * r2.x + r1.y;
	r1.w = r2.x * r1.w + r3.y;
	r1.z = r1.z / r1.w;
	r1.w = r2.y / r2.z;
	r1.z = r1.z - r1.w;
	r1.z = 1.0 / r1.z;

	r0.xyz = adaptation.x * r0.xyz;
	r0.xyz = max(float3(0.0, 0.0, 0.0), r0.xyz);
	r2.xyz = r1.x * r0.xyz + r0.w;
	r2.xyz = r0.xyz * r2.xyz + r3.x;
	r3.xzw = r1.x * r0.xyz + r1.y;
	r0.xyz = r0.xyz * r3.xzw + r3.y;
	r0.xyz = r2.xyz / r0.xyz;
	r0.xyz = r0.xyz - r1.w;
	r0.xyz = saturate(r0.xyz * r1.z);

	//gta5 color process
	r0.w = dot(r0.xyz, float3(0.2126, 0.7152, 0.0722));
	r0.xyz = r0.xyz - r0.w;
	r0.xyz = Desaturate * r0.xyz + r0.w;
	r1.x = saturate(r0.w / ColorShiftLowLum.w);
	r1.yzw = ColorCorrectHighLum.xyz - ColorShiftLowLum.xyz;
	r1.xyz = r1.x * r1.yzw + ColorShiftLowLum.xyz;
	r2.xyz = r1.xyz * r0.xyz;
	r1.w = 1.0 - ColorCorrectHighLum.w;
	r0.w = -r1.w + r0.w;
	r1.w = 1.0 - r1.w;
	r1.w = max(0.01, r1.w);
	r0.w = saturate(r0.w / r1.w);
	r0.xyz = -r0.xyz * r1.xyz + r0.xyz;
	r0.xyz = saturate(r0.w * r0.xyz + r2.xyz);
	r0.xyz = pow(r0.xyz, Gamma);

	//extra color process
	r0.xyz = lerp(r0.xyz, r0.xyz * r0.xyz, smoothstep(0.0, 1.0, distance(IN.txcoord0.xy, float2(0.5, 1.0))) * IN.dn2.w);
	r0.xyz = lerp(r0.xyz, r0.xyz * IN.dn0.xyz * 2.55, IN.dn0.w);
	r0.xyz = r0.xyz * IN.dn1.x;
	r0.xyz = lerp(r0.xyz, 0.5 * (1.0 + sin((r0.xyz - 0.5) * 3.1415926)), IN.dn1.y);
	r0.xyz = pow(r0.xyz, IN.dn1.z);
	r0.xyz = saturate(lerp(dot(r0.xyz, float3(0.2126, 0.7152, 0.0722)), r0.xyz, IN.dn1.w));
	float sr = saturate((r0.x - r0.z - r0.y + r0.x) * IN.dn2.x);
	float sg = saturate((r0.y - r0.x - r0.z + r0.y) * IN.dn2.y);
	float sb = saturate((r0.z - r0.x - r0.y + r0.z) * IN.dn2.z);
	float fLum = dot(r0.xyz, 0.3333333);
	float3 colMood = lerp(IN.dn3.xyz * saturate(fLum * 2.0), 1.0, saturate(fLum - 0.5) * 2.0);
	r0.xyz = lerp(r0.xyz, colMood, saturate(fLum * IN.dn3.w));
	r0.xyz = lerp(r0.xyz, dot(r0.xyz, float3(0.2126, 0.7152, 0.0722)), saturate(sr + sg + sb));
	if (UseLevels) r0.xyz = (r0.xyz - iBlack) / (iWhite - iBlack) * (oWhite - oBlack) + oBlack;
	//if (UseLevels) r0.xyz = (r0.xyz - iBlack) / (iWhite - iBlack);

	[branch] if (UsePaletteTexture)
	{
		float brightness = adaptation.x;//0.001
		brightness = brightness / (brightness + 1.0);
		float3 palette;
		float2 uvpalette;
		r0.xyz = saturate(r0.xyz);
		uvpalette.y = brightness;
		uvpalette.x = r0.x;
		palette.x = TexturePalette.SampleLevel(Sampler1, uvpalette, 0).x;
		uvpalette.x = r0.y;
		palette.y = TexturePalette.SampleLevel(Sampler1, uvpalette, 0).y;
		uvpalette.x = r0.z;
		palette.z = TexturePalette.SampleLevel(Sampler1, uvpalette, 0).z;
		r0.xyz = palette;
	}

	r0.w = IN.txcoord7.x;
	return r0;
}

technique11 Draw < string UIName = "ENBSeries"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw2()));
		SetPixelShader(CompileShader(ps_5_0, PS_Draw()));
	}
}
technique11 ORIGINALPOSTPROCESS < string UIName = "Vanilla"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw2()));
		SetPixelShader(CompileShader(ps_5_0, PS_DrawOriginal()));
	}
}