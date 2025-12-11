module("modules.logic.survival.define.SurvivalRainParam", package.seeall)

local var_0_0 = _M
local var_0_1 = UnityEngine.Shader

var_0_0._SurvivalEdgeFlow = var_0_1.PropertyToID("_SurvivalEdgeFlow")
var_0_0._SurvialObjectParams = var_0_1.PropertyToID("_SurvialObjectParams")
var_0_0._SurvialEdgeMap = var_0_1.PropertyToID("_SurvialEdgeMap")
var_0_0._SurvialEdgeMapParams = var_0_1.PropertyToID("_SurvialEdgeMapParams")
var_0_0._SurvialEdgeColor1 = var_0_1.PropertyToID("_SurvialEdgeColor1")
var_0_0._SurvialEdgeColor2 = var_0_1.PropertyToID("_SurvialEdgeColor2")
var_0_0._SurvialEdgeSize = var_0_1.PropertyToID("_SurvialEdgeSize")
var_0_0._SurvivalRain_Background = var_0_1.PropertyToID("_SurvivalRain_Background")
var_0_0._SurvivalRain_Background_Params = var_0_1.PropertyToID("_SurvivalRain_Background_Params")
var_0_0._SurvivalRain_FlowMap = var_0_1.PropertyToID("_SurvivalRain_FlowMap")
var_0_0._SurvivalRain_FlowMap_Params = var_0_1.PropertyToID("_SurvivalRain_FlowMap_Params")
var_0_0._SurvivalRain_Obj_Color = var_0_1.PropertyToID("_SurvivalRain_Obj_Color")
var_0_0._SurvivalRain_Glitch_Params = var_0_1.PropertyToID("_SurvivalRain_Glitch_Params")
var_0_0._SurvivalRain_TextMap = var_0_1.PropertyToID("_SurvivalRain_TextMap")
var_0_0._SurvivalRain_TextMap_Params = var_0_1.PropertyToID("_SurvivalRain_TextMap_Params")
var_0_0._SurvivalRain_NoiseMap = var_0_1.PropertyToID("_SurvivalRain_NoiseMap")
var_0_0._SurvivalRain_NoiseMap_Params = var_0_1.PropertyToID("_SurvivalRain_NoiseMap_Params")
var_0_0._SurvivalRain_Main_Color = var_0_1.PropertyToID("_SurvivalRain_Main_Color")
var_0_0.ParamToShaderFunc = {
	[var_0_0._SurvivalEdgeFlow] = var_0_1.SetGlobalFloat,
	[var_0_0._SurvialObjectParams] = var_0_1.SetGlobalVector,
	[var_0_0._SurvialEdgeMap] = var_0_1.SetGlobalTexture,
	[var_0_0._SurvialEdgeMapParams] = var_0_1.SetGlobalVector,
	[var_0_0._SurvialEdgeColor1] = var_0_1.SetGlobalColor,
	[var_0_0._SurvialEdgeColor2] = var_0_1.SetGlobalColor,
	[var_0_0._SurvialEdgeSize] = var_0_1.SetGlobalFloat,
	[var_0_0._SurvivalRain_Background] = var_0_1.SetGlobalTexture,
	[var_0_0._SurvivalRain_Background_Params] = var_0_1.SetGlobalVector,
	[var_0_0._SurvivalRain_FlowMap] = var_0_1.SetGlobalTexture,
	[var_0_0._SurvivalRain_FlowMap_Params] = var_0_1.SetGlobalVector,
	[var_0_0._SurvivalRain_Obj_Color] = var_0_1.SetGlobalColor,
	[var_0_0._SurvivalRain_Glitch_Params] = var_0_1.SetGlobalVector,
	[var_0_0._SurvivalRain_TextMap] = var_0_1.SetGlobalTexture,
	[var_0_0._SurvivalRain_TextMap_Params] = var_0_1.SetGlobalVector,
	[var_0_0._SurvivalRain_NoiseMap] = var_0_1.SetGlobalTexture,
	[var_0_0._SurvivalRain_NoiseMap_Params] = var_0_1.SetGlobalVector,
	[var_0_0._SurvivalRain_Main_Color] = var_0_1.SetGlobalColor
}
var_0_0[SurvivalEnum.RainType.Rain1] = {
	KeyWord = "_SURVIAL_SCENE",
	[var_0_0._SurvivalEdgeFlow] = 0.08
}

local var_0_2 = Quaternion.Euler(2.951, 247.931, 226.092) * Vector3.forward

var_0_0[SurvivalEnum.RainType.Rain2] = {
	KeyWord = "_ENABLE_SURVIVAL_RAIN_DISTORTION",
	[var_0_0._SurvivalEdgeFlow] = 0,
	[var_0_0._SurvialObjectParams] = Vector4(var_0_2.x, var_0_2.y, var_0_2.z, 0.08),
	[var_0_0._SurvialEdgeMap] = "rain_edge02",
	[var_0_0._SurvialEdgeMapParams] = Vector4(1, 1, 0.1, 0.62),
	[var_0_0._SurvialEdgeColor1] = Color(0.459, 0.8862, 0.5693, 1),
	[var_0_0._SurvialEdgeColor2] = Color(0.1618, 0.2839, 0.518, 1),
	[var_0_0._SurvialEdgeSize] = 3.82,
	[var_0_0._SurvivalRain_Background] = "rain_bg2",
	[var_0_0._SurvivalRain_Background_Params] = Vector4(0.025, 0.1, 0, 0),
	[var_0_0._SurvivalRain_FlowMap] = "rain_bg2_flow",
	[var_0_0._SurvivalRain_FlowMap_Params] = Vector4(0.25, 1, 0.18, 0.1),
	[var_0_0._SurvivalRain_Obj_Color] = Color(0.52201, 0.6588, 0.4018, 0.3411)
}

local var_0_3 = Quaternion.Euler(1, 250, 250) * Vector3.forward

var_0_0[SurvivalEnum.RainType.Rain3] = {
	KeyWord = "_ENABLE_SURVIVAL_RAIN_GLITCH",
	[var_0_0._SurvivalEdgeFlow] = 0,
	[var_0_0._SurvialObjectParams] = Vector4(var_0_3.x, var_0_3.y, var_0_3.z, 0.08),
	[var_0_0._SurvialEdgeMap] = "rain_edge02",
	[var_0_0._SurvialEdgeMapParams] = Vector4(1, 1, 0.1, 0.62),
	[var_0_0._SurvialEdgeColor1] = Color(0.8862, 0.7725, 0.6431, 1),
	[var_0_0._SurvialEdgeColor2] = Color(0.2392, 0.3176, 0.4352, 1),
	[var_0_0._SurvialEdgeSize] = 3.82,
	[var_0_0._SurvivalRain_Background] = "rain_3_map",
	[var_0_0._SurvivalRain_Background_Params] = Vector4(10, 10, 0.2, 1),
	[var_0_0._SurvivalRain_Glitch_Params] = Vector4(0.5, 1000, 10, 10),
	[var_0_0._SurvivalRain_TextMap] = "rain_bg3",
	[var_0_0._SurvivalRain_TextMap_Params] = Vector4(8, 0.5, 0.2, 1.18),
	[var_0_0._SurvivalRain_NoiseMap] = "rain_3_noise",
	[var_0_0._SurvivalRain_NoiseMap_Params] = Vector4(10, 10, 1, 1),
	[var_0_0._SurvivalRain_Main_Color] = Color(0.7882, 0.3098, 1, 0.2274),
	[var_0_0._SurvivalRain_Obj_Color] = Color(0.2, 0.2509804, 0.3647059, 0.8)
}

return var_0_0
