module("modules.logic.scene.explore.comp.ExploreSceneGraphicsComp", package.seeall)

slot0 = class("ExploreSceneGraphicsComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0:_refreshGraphics()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, slot0._refreshGraphics, slot0)

	slot0.projPhysics = UnityEngine.Physics.autoSimulation
	slot0.projTransforms = UnityEngine.Physics.autoSyncTransforms
	UnityEngine.Physics.autoSimulation = false
	UnityEngine.Physics.autoSyncTransforms = true
	RenderPipelineSetting.selectedOutlineToggle = false
	RenderPipelineSetting.ForwardPlusToggle = true
	slot3 = CameraMgr.instance:getMainCamera()
	slot0._farClip = slot3.farClipPlane
	slot0._nearClip = slot3.nearClipPlane
	slot3.nearClipPlane = 1
	slot3.farClipPlane = 220

	UnityEngine.Shader.EnableKeyword("_FASTER_BLOOM")
	PostProcessingMgr.setCameraLayer(slot3, "UI3DAfterPostProcess", true)

	if BootNativeUtil.isMobilePlayer() or SLFramework.FrameworkSettings.IsEditor then
		RenderPipelineSetting.uiUnderclocking = true
	end
end

function slot0.onSceneClose(slot0)
	RenderPipelineSetting.uiUnderclocking = false

	UnityEngine.Shader.DisableKeyword("_FASTER_BLOOM")
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, slot0._refreshGraphics, slot0)
	PostProcessingMgr.instance:setRenderShadow(true)
	UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0)
	UnityEngine.Shader.DisableKeyword("_QUALITY_LOW")
	UnityEngine.Shader.DisableKeyword("_QUALITY_MEDIUM")

	UnityEngine.QualitySettings.masterTextureLimit = 0
	UnityEngine.Physics.autoSimulation = slot0.projPhysics
	UnityEngine.Physics.autoSyncTransforms = slot0.projTransforms
	slot0.projPhysics = nil
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.nearClipPlane = slot0._nearClip
	slot1.farClipPlane = slot0._farClip
	slot1:GetComponent(PostProcessingMgr.PPCustomCamDataType).renderScale = 1

	PostProcessingMgr.setCameraLayer(slot1, "UI3DAfterPostProcess", false)
	PostProcessingMgr.setCameraLayer(slot1, "CullOnLowQuality", false)

	RenderPipelineSetting.selectedOutlineToggle = false
	RenderPipelineSetting.ForwardPlusToggle = false
end

function slot0._refreshGraphics(slot0)
	if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High then
		PostProcessingMgr.instance:setRenderShadow(true)

		CameraMgr.instance:getMainCamera():GetComponent(PostProcessingMgr.PPCustomCamDataType).renderScale = 1

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", -0.5)
		UnityEngine.Shader.DisableKeyword("_QUALITY_LOW")
		UnityEngine.Shader.DisableKeyword("_QUALITY_MEDIUM")

		UnityEngine.QualitySettings.masterTextureLimit = 0

		PostProcessingMgr.setCameraLayer(slot1, "CullOnLowQuality", true)
	elseif slot3 == ModuleEnum.Performance.Middle then
		slot2.renderScale = 0.8

		PostProcessingMgr.instance:setRenderShadow(true)
		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0)
		UnityEngine.Shader.EnableKeyword("_QUALITY_MEDIUM")
		UnityEngine.Shader.DisableKeyword("_QUALITY_LOW")

		UnityEngine.QualitySettings.masterTextureLimit = 0

		PostProcessingMgr.setCameraLayer(slot1, "CullOnLowQuality", true)
	elseif slot3 == ModuleEnum.Performance.Low then
		slot2.renderScale = 0.6

		PostProcessingMgr.instance:setRenderShadow(false)
		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 1)
		UnityEngine.Shader.DisableKeyword("_QUALITY_MEDIUM")
		UnityEngine.Shader.EnableKeyword("_QUALITY_LOW")

		UnityEngine.QualitySettings.masterTextureLimit = 1

		PostProcessingMgr.setCameraLayer(slot1, "CullOnLowQuality", false)
	end
end

return slot0
