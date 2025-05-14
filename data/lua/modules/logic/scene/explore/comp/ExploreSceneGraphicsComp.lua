module("modules.logic.scene.explore.comp.ExploreSceneGraphicsComp", package.seeall)

local var_0_0 = class("ExploreSceneGraphicsComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:_refreshGraphics()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, arg_2_0._refreshGraphics, arg_2_0)

	arg_2_0.projPhysics = UnityEngine.Physics.autoSimulation
	arg_2_0.projTransforms = UnityEngine.Physics.autoSyncTransforms
	UnityEngine.Physics.autoSimulation = false
	UnityEngine.Physics.autoSyncTransforms = true
	RenderPipelineSetting.selectedOutlineToggle = false
	RenderPipelineSetting.ForwardPlusToggle = true

	local var_2_0 = CameraMgr.instance:getMainCamera()

	arg_2_0._farClip = var_2_0.farClipPlane
	arg_2_0._nearClip = var_2_0.nearClipPlane
	var_2_0.nearClipPlane = 1
	var_2_0.farClipPlane = 220

	UnityEngine.Shader.EnableKeyword("_FASTER_BLOOM")
	PostProcessingMgr.setCameraLayer(var_2_0, "UI3DAfterPostProcess", true)

	if BootNativeUtil.isMobilePlayer() or SLFramework.FrameworkSettings.IsEditor then
		RenderPipelineSetting.uiUnderclocking = true
	end
end

function var_0_0.onSceneClose(arg_3_0)
	RenderPipelineSetting.uiUnderclocking = false

	UnityEngine.Shader.DisableKeyword("_FASTER_BLOOM")
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, arg_3_0._refreshGraphics, arg_3_0)
	PostProcessingMgr.instance:setRenderShadow(true)
	UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0)
	UnityEngine.Shader.DisableKeyword("_QUALITY_LOW")
	UnityEngine.Shader.DisableKeyword("_QUALITY_MEDIUM")

	UnityEngine.QualitySettings.masterTextureLimit = 0
	UnityEngine.Physics.autoSimulation = arg_3_0.projPhysics
	UnityEngine.Physics.autoSyncTransforms = arg_3_0.projTransforms
	arg_3_0.projPhysics = nil

	local var_3_0 = CameraMgr.instance:getMainCamera()

	var_3_0.nearClipPlane = arg_3_0._nearClip
	var_3_0.farClipPlane = arg_3_0._farClip
	var_3_0:GetComponent(PostProcessingMgr.PPCustomCamDataType).renderScale = 1

	PostProcessingMgr.setCameraLayer(var_3_0, "UI3DAfterPostProcess", false)
	PostProcessingMgr.setCameraLayer(var_3_0, "CullOnLowQuality", false)

	RenderPipelineSetting.selectedOutlineToggle = false
	RenderPipelineSetting.ForwardPlusToggle = false
end

function var_0_0._refreshGraphics(arg_4_0)
	local var_4_0 = CameraMgr.instance:getMainCamera()
	local var_4_1 = var_4_0:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	local var_4_2 = GameGlobalMgr.instance:getScreenState():getLocalQuality()

	if var_4_2 == ModuleEnum.Performance.High then
		PostProcessingMgr.instance:setRenderShadow(true)

		var_4_1.renderScale = 1

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", -0.5)
		UnityEngine.Shader.DisableKeyword("_QUALITY_LOW")
		UnityEngine.Shader.DisableKeyword("_QUALITY_MEDIUM")

		UnityEngine.QualitySettings.masterTextureLimit = 0

		PostProcessingMgr.setCameraLayer(var_4_0, "CullOnLowQuality", true)
	elseif var_4_2 == ModuleEnum.Performance.Middle then
		var_4_1.renderScale = 0.8

		PostProcessingMgr.instance:setRenderShadow(true)
		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0)
		UnityEngine.Shader.EnableKeyword("_QUALITY_MEDIUM")
		UnityEngine.Shader.DisableKeyword("_QUALITY_LOW")

		UnityEngine.QualitySettings.masterTextureLimit = 0

		PostProcessingMgr.setCameraLayer(var_4_0, "CullOnLowQuality", true)
	elseif var_4_2 == ModuleEnum.Performance.Low then
		var_4_1.renderScale = 0.6

		PostProcessingMgr.instance:setRenderShadow(false)
		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 1)
		UnityEngine.Shader.DisableKeyword("_QUALITY_MEDIUM")
		UnityEngine.Shader.EnableKeyword("_QUALITY_LOW")

		UnityEngine.QualitySettings.masterTextureLimit = 1

		PostProcessingMgr.setCameraLayer(var_4_0, "CullOnLowQuality", false)
	end
end

return var_0_0
