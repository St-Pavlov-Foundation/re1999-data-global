module("modules.logic.scene.survival.comp.SurvivalSceneGraphicsComp", package.seeall)

local var_0_0 = class("SurvivalSceneGraphicsComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	if BootNativeUtil.isAndroid() then
		local var_1_0 = UnityEngine.SystemInfo.graphicsDeviceName

		arg_1_0.compatibility = string.find(var_1_0, "^Adreno") or string.find(var_1_0, "^Mali")
		arg_1_0.compatibility = arg_1_0.compatibility or SDKMgr.instance:isEmulator()
	else
		arg_1_0.compatibility = true
	end
end

function var_0_0.setPPValue(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._unitPPVolume then
		arg_2_0._unitPPVolume.refresh = true
		arg_2_0._unitPPVolume[arg_2_1] = arg_2_2
	end
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._unitPPVolume = gohelper.findChildComponent(CameraMgr.instance:getMainCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)

	arg_3_0:_refreshGraphics()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, arg_3_0._refreshGraphics, arg_3_0)
	UnityEngine.Shader.EnableKeyword("_FASTER_BLOOM")

	RenderPipelineSetting.ForwardPlusToggle = true
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = true

	local var_3_0 = CameraMgr.instance:getMainCamera()

	arg_3_0._farClip = var_3_0.farClipPlane
	arg_3_0._nearClip = var_3_0.nearClipPlane
	var_3_0.nearClipPlane = 1
	var_3_0.farClipPlane = 100
end

function var_0_0.onSceneClose(arg_4_0)
	arg_4_0:setPPValue("ssaoEnable", false)
	UnityEngine.Shader.DisableKeyword("_FASTER_BLOOM")

	RenderPipelineSetting.ForwardPlusToggle = false
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = false

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, arg_4_0._refreshGraphics, arg_4_0)

	UnityEngine.QualitySettings.masterTextureLimit = 0
	arg_4_0._unitPPVolume = nil

	local var_4_0 = CameraMgr.instance:getMainCamera()

	var_4_0.nearClipPlane = arg_4_0._nearClip
	var_4_0.farClipPlane = arg_4_0._farClip
end

function var_0_0._refreshGraphics(arg_5_0)
	local var_5_0 = CameraMgr.instance:getMainCamera():GetComponent(PostProcessingMgr.PPCustomCamDataType)
	local var_5_1 = GameGlobalMgr.instance:getScreenState():getLocalQuality()

	if var_5_1 == ModuleEnum.Performance.High then
		PostProcessingMgr.instance:setRenderShadow(true)

		if arg_5_0.compatibility then
			arg_5_0:setPPValue("ssaoEnable", true)
			arg_5_0:setPPValue("ssaoIntensity", 0.38)
			arg_5_0:setPPValue("ssaoRadius", 0.07)
			arg_5_0:setPPValue("ssaoRenderScale", 0.2)
			arg_5_0:setPPValue("ssaoDepthQuality", 1)
		end

		var_5_0.renderScale = 1

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", -0.5)

		UnityEngine.QualitySettings.masterTextureLimit = 0
	elseif var_5_1 == ModuleEnum.Performance.Middle then
		arg_5_0:setPPValue("ssaoEnable", false)
		PostProcessingMgr.instance:setRenderShadow(true)

		var_5_0.renderScale = 1

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0)

		UnityEngine.QualitySettings.masterTextureLimit = 0
	elseif var_5_1 == ModuleEnum.Performance.Low then
		arg_5_0:setPPValue("ssaoEnable", false)
		PostProcessingMgr.instance:setRenderShadow(true)

		var_5_0.renderScale = 0.75

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0.5)

		UnityEngine.QualitySettings.masterTextureLimit = 1
	end
end

return var_0_0
