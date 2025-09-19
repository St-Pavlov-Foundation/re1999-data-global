module("modules.logic.scene.shelter.comp.SurvivalShelterSceneGraphicsComp", package.seeall)

local var_0_0 = class("SurvivalShelterSceneGraphicsComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	if BootNativeUtil.isAndroid() then
		local var_1_0 = UnityEngine.SystemInfo.graphicsDeviceName

		arg_1_0.compatibility = string.find(var_1_0, "^Adreno") or string.find(var_1_0, "^Mali")
		arg_1_0.compatibility = arg_1_0.compatibility or SDKMgr.instance:isEmulator()
	else
		arg_1_0.compatibility = true
	end
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.setPPValue(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._unitPPVolume then
		arg_3_0._unitPPVolume.refresh = true
		arg_3_0._unitPPVolume[arg_3_1] = arg_3_2
	end
end

function var_0_0.init(arg_4_0)
	arg_4_0._unitPPVolume = gohelper.findChildComponent(CameraMgr.instance:getMainCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)

	arg_4_0:_refreshGraphics()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, arg_4_0._refreshGraphics, arg_4_0)
	UnityEngine.Shader.EnableKeyword("_FASTER_BLOOM")

	RenderPipelineSetting.ForwardPlusToggle = true
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = true

	local var_4_0 = CameraMgr.instance:getMainCamera()

	arg_4_0._farClip = var_4_0.farClipPlane
	arg_4_0._nearClip = var_4_0.nearClipPlane
	var_4_0.nearClipPlane = 1
	var_4_0.farClipPlane = 100
end

function var_0_0.onSceneClose(arg_5_0)
	arg_5_0:setPPValue("ssaoEnable", false)
	UnityEngine.Shader.DisableKeyword("_FASTER_BLOOM")

	RenderPipelineSetting.ForwardPlusToggle = false
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = false

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, arg_5_0._refreshGraphics, arg_5_0)

	UnityEngine.QualitySettings.masterTextureLimit = 0
	arg_5_0._unitPPVolume = nil

	local var_5_0 = CameraMgr.instance:getMainCamera()

	var_5_0.nearClipPlane = arg_5_0._nearClip
	var_5_0.farClipPlane = arg_5_0._farClip
end

function var_0_0._refreshGraphics(arg_6_0)
	local var_6_0 = CameraMgr.instance:getMainCamera():GetComponent(PostProcessingMgr.PPCustomCamDataType)
	local var_6_1 = GameGlobalMgr.instance:getScreenState():getLocalQuality()

	if var_6_1 == ModuleEnum.Performance.High then
		PostProcessingMgr.instance:setRenderShadow(true)

		var_6_0.renderScale = 1

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", -0.5)

		UnityEngine.QualitySettings.masterTextureLimit = 0

		if arg_6_0.compatibility then
			arg_6_0:setPPValue("ssaoEnable", true)
			arg_6_0:setPPValue("ssaoIntensity", 0.38)
			arg_6_0:setPPValue("ssaoRadius", 0.07)
			arg_6_0:setPPValue("ssaoRenderScale", 0.2)
			arg_6_0:setPPValue("ssaoDepthQuality", 1)
		end
	elseif var_6_1 == ModuleEnum.Performance.Middle then
		PostProcessingMgr.instance:setRenderShadow(true)

		var_6_0.renderScale = 1

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0)

		UnityEngine.QualitySettings.masterTextureLimit = 0

		arg_6_0:setPPValue("ssaoEnable", false)
	elseif var_6_1 == ModuleEnum.Performance.Low then
		arg_6_0:setPPValue("ssaoEnable", false)
		PostProcessingMgr.instance:setRenderShadow(true)

		var_6_0.renderScale = 0.75

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0.5)

		UnityEngine.QualitySettings.masterTextureLimit = 1
	end
end

return var_0_0
