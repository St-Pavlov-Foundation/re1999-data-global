module("modules.logic.scene.room.comp.RoomSceneGraphicsComp", package.seeall)

slot0 = class("RoomSceneGraphicsComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0.LAYER_MASK_CullByDistance = LayerMask.GetMask("CullByDistance")
	slot0.LAYER_MASK_CullOnLowQuality = LayerMask.GetMask("CullOnLowQuality")
	slot0.LAYER_INDEX_CullByDistance = LayerMask.NameToLayer("CullByDistance")
	slot0.LAYER_INDEX_CullOnLowQuality = LayerMask.NameToLayer("CullOnLowQuality")
	slot0.highQualityCullingDistance = 6
	slot0.middleQualityCullingDistance = 5.5
	slot0.lowQualityCullingDistance = 3.5

	if BootNativeUtil.isAndroid() then
		slot0.compatibility = string.find(UnityEngine.SystemInfo.graphicsDeviceName, "^Adreno") or string.find(slot1, "^Mali")
		slot0.compatibility = slot0.compatibility or SDKMgr.instance:isEmulator()
	else
		slot0.compatibility = true
	end

	if SDKMgr.instance:isEmulator() then
		SceneCulling.useBurst = false
	end
end

function slot0.init(slot0, slot1, slot2)
	slot0._unitPPVolume = gohelper.findChildComponent(CameraMgr.instance:getMainCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)

	slot0:_refreshGraphics()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, slot0._refreshGraphics, slot0)

	slot0.projPhysics = UnityEngine.Physics.autoSimulation
	slot0.projTransforms = UnityEngine.Physics.autoSyncTransforms
	UnityEngine.Physics.autoSimulation = false
	UnityEngine.Physics.autoSyncTransforms = true
	slot3 = CameraMgr.instance:getMainCamera()
	slot4 = slot3:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	slot0.useLightData = slot4.useLightData
	slot0.useLightmap = slot4.useLightmap
	slot0.useProbe = slot4.useProbe
	slot4.useProbe = false
	slot4.useLightmap = false
	slot4.useLightData = false
	slot0.lodBias = UnityEngine.QualitySettings.lodBias

	UnityEngine.Shader.EnableKeyword("_FASTER_BLOOM")
	slot0:getCurScene().go.sceneAmbient:SetReflectionType(0)

	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = true

	PostProcessingMgr.setCameraLayerInt(slot3, slot0.LAYER_MASK_CullByDistance, true)
	PostProcessingMgr.setCameraLayerInt(slot3, slot0.LAYER_MASK_CullOnLowQuality, false)

	slot3.layerCullSpherical = true

	if BootNativeUtil.isWindows() then
		RenderPipelineSetting.ForwardPlusToggle = true
	end

	if BootNativeUtil.isWindows() and GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High then
		slot0:getCurScene().loader:makeSureLoaded({
			RoomScenePreloader.DiffuseGI
		}, slot0._OnGetInstance, slot0)
	end
end

function slot0._OnGetInstance(slot0)
	slot0.go_GI = RoomGOPool.getInstance(RoomScenePreloader.DiffuseGI, slot0:getCurScene().go.sceneGO, "diffuse_gi")

	transformhelper.setPos(slot0.go_GI.transform, 0, 0, 0)
end

function slot0.setPPValue(slot0, slot1, slot2)
	if slot0._unitPPVolume then
		slot0._unitPPVolume.refresh = true
		slot0._unitPPVolume[slot1] = slot2
	end
end

function slot0.onSceneClose(slot0)
	UnityEngine.Shader.DisableKeyword("_FASTER_BLOOM")
	PostProcessingMgr.instance:setRenderShadow(true)
	PostProcessingMgr.instance:clearLayerCullDistance()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, slot0._refreshGraphics, slot0)

	slot1 = CameraMgr.instance:getMainCamera()
	slot2 = slot1:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	slot0.overLookFlag = nil
	slot2.renderScale = 1
	slot2.useProbe = slot0.useProbe
	slot2.useLightmap = slot0.useLightmap
	slot2.useLightData = slot0.useLightData
	UnityEngine.Physics.autoSimulation = slot0.projPhysics
	UnityEngine.Physics.autoSyncTransforms = slot0.projTransforms
	slot0.projPhysics = nil
	slot0.projTransforms = nil
	UnityEngine.QualitySettings.lodBias = slot0.lodBias

	PostProcessingMgr.setCameraLayerInt(slot1, slot0.LAYER_MASK_CullOnLowQuality, false)
	PostProcessingMgr.setCameraLayerInt(slot1, slot0.LAYER_MASK_CullByDistance, false)

	slot1.layerCullSpherical = false

	slot0:setPPValue("ssaoEnable", false)

	slot0._unitPPVolume = nil
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = false
	UnityEngine.QualitySettings.masterTextureLimit = 0

	if BootNativeUtil.isWindows() then
		RenderPipelineSetting.ForwardPlusToggle = false
	end

	slot0.go_GI = nil
end

function slot0._refreshGraphics(slot0)
	slot4 = slot0:getCurScene().go.sceneCulling

	if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High then
		PostProcessingMgr.instance:setRenderShadow(true)

		CameraMgr.instance:getMainCamera():GetComponent(PostProcessingMgr.PPCustomCamDataType).renderScale = 1
		slot4.smallRate = 0.005
		slot4.proxyRate = 0.015
		UnityEngine.QualitySettings.lodBias = 1

		if slot0.compatibility then
			slot0:setPPValue("ssaoEnable", true)
			slot0:setPPValue("ssaoIntensity", 0.38)
			slot0:setPPValue("ssaoRadius", 0.07)
			slot0:setPPValue("ssaoRenderScale", 0.2)
			slot0:setPPValue("ssaoDepthQuality", 1)
		end

		PostProcessingMgr.instance:setLayerCullDistance(slot0.LAYER_INDEX_CullByDistance, slot0.highQualityCullingDistance)
		PostProcessingMgr.instance:setLayerCullDistance(slot0.LAYER_INDEX_CullOnLowQuality, slot0.highQualityCullingDistance)

		UnityEngine.QualitySettings.masterTextureLimit = 0
	elseif slot1 == ModuleEnum.Performance.Middle then
		slot3.renderScale = 0.8
		UnityEngine.QualitySettings.lodBias = 0.9

		PostProcessingMgr.instance:setRenderShadow(true)
		slot0:setPPValue("ssaoEnable", false)
		slot0:getCurScene().go.sceneAmbient:SetReflectionType(0)
		PostProcessingMgr.instance:setLayerCullDistance(slot0.LAYER_INDEX_CullByDistance, slot0.middleQualityCullingDistance)
		PostProcessingMgr.instance:setLayerCullDistance(slot0.LAYER_INDEX_CullOnLowQuality, slot0.middleQualityCullingDistance)

		slot4.smallRate = 0.02
		slot4.proxyRate = 0.03
		UnityEngine.QualitySettings.masterTextureLimit = 0
	elseif slot1 == ModuleEnum.Performance.Low then
		slot3.renderScale = 0.7
		UnityEngine.QualitySettings.lodBias = 0.7

		PostProcessingMgr.instance:setRenderShadow(false)
		slot0:setPPValue("ssaoEnable", false)
		slot0:getCurScene().go.sceneAmbient:SetReflectionType(0)
		PostProcessingMgr.instance:setLayerCullDistance(slot0.LAYER_INDEX_CullByDistance, slot0.lowQualityCullingDistance)
		PostProcessingMgr.instance:setLayerCullDistance(slot0.LAYER_INDEX_CullOnLowQuality, slot0.lowQualityCullingDistance)

		slot4.smallRate = 0.03
		slot4.proxyRate = 0.075
		UnityEngine.QualitySettings.masterTextureLimit = 1
	end
end

function slot0.setupShadowParam(slot0, slot1, slot2)
	if slot0.overLookFlag ~= slot1 then
		slot3, slot4 = nil

		if slot0:getCurScene() ~= nil and slot5.go ~= nil then
			slot3 = slot5.go.sceneShadow
			slot4 = slot5.go.sceneAmbient
		end

		if slot3 ~= nil then
			if slot1 then
				slot3.overrideShadowCascadesOption = true
				slot3.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.NoCascades
				slot3.overrideShadowResolution = true
				slot3.shadowResolution = 1600
				slot3.softShadow = true
			else
				slot3.overrideShadowCascadesOption = true
				slot3.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.TwoCascades
				slot3.overrideShadowResolution = true
				slot3.shadowResolution = 2048
				slot3.softShadow = true
			end

			slot3:ApplyProperty()
		end

		if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High and slot0.compatibility then
			if slot1 then
				slot4:SetReflectionType(0)
				slot0:setPPValue("ssaoIntensity", 0.38)
				slot0:setPPValue("ssaoRadius", 0.07)
			else
				slot4:SetReflectionType(1)
				slot0:setPPValue("ssaoIntensity", 0.38)
				slot0:setPPValue("ssaoRadius", 0.015)
			end
		end

		if slot1 then
			PostProcessingMgr.setCameraLayerInt(CameraMgr.instance:getMainCamera(), slot0.LAYER_MASK_CullOnLowQuality, false)
		elseif slot6 ~= ModuleEnum.Performance.Low then
			PostProcessingMgr.setCameraLayerInt(CameraMgr.instance:getMainCamera(), slot0.LAYER_MASK_CullOnLowQuality, true)
		end

		slot0.overLookFlag = slot1
	end
end

return slot0
