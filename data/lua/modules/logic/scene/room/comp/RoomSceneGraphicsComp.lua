module("modules.logic.scene.room.comp.RoomSceneGraphicsComp", package.seeall)

local var_0_0 = class("RoomSceneGraphicsComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0.LAYER_MASK_CullByDistance = LayerMask.GetMask("CullByDistance")
	arg_1_0.LAYER_MASK_CullOnLowQuality = LayerMask.GetMask("CullOnLowQuality")
	arg_1_0.LAYER_INDEX_CullByDistance = LayerMask.NameToLayer("CullByDistance")
	arg_1_0.LAYER_INDEX_CullOnLowQuality = LayerMask.NameToLayer("CullOnLowQuality")
	arg_1_0.highQualityCullingDistance = 6
	arg_1_0.middleQualityCullingDistance = 5.5
	arg_1_0.lowQualityCullingDistance = 3.5

	if BootNativeUtil.isAndroid() then
		local var_1_0 = UnityEngine.SystemInfo.graphicsDeviceName

		arg_1_0.compatibility = string.find(var_1_0, "^Adreno") or string.find(var_1_0, "^Mali")
		arg_1_0.compatibility = arg_1_0.compatibility or SDKMgr.instance:isEmulator()
	else
		arg_1_0.compatibility = true
	end

	if SDKMgr.instance:isEmulator() then
		SceneCulling.useBurst = false
	end
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._unitPPVolume = gohelper.findChildComponent(CameraMgr.instance:getMainCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)

	arg_2_0:_refreshGraphics()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, arg_2_0._refreshGraphics, arg_2_0)

	arg_2_0.projPhysics = UnityEngine.Physics.autoSimulation
	arg_2_0.projTransforms = UnityEngine.Physics.autoSyncTransforms
	UnityEngine.Physics.autoSimulation = false
	UnityEngine.Physics.autoSyncTransforms = true

	local var_2_0 = CameraMgr.instance:getMainCamera()
	local var_2_1 = var_2_0:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	arg_2_0.useLightData = var_2_1.useLightData
	arg_2_0.useLightmap = var_2_1.useLightmap
	arg_2_0.useProbe = var_2_1.useProbe
	var_2_1.useProbe = false
	var_2_1.useLightmap = false
	var_2_1.useLightData = false
	arg_2_0.uiCameraData = CameraMgr.instance:getUICamera():GetComponent(PostProcessingMgr.PPCustomCamDataType)
	arg_2_0.cacheUINeedLights = arg_2_0.uiCameraData.needLights
	arg_2_0.uiCameraData.needLights = false
	arg_2_0.lodBias = UnityEngine.QualitySettings.lodBias

	UnityEngine.Shader.EnableKeyword("_FASTER_BLOOM")
	arg_2_0:getCurScene().go.sceneAmbient:SetReflectionType(0)

	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = true

	PostProcessingMgr.setCameraLayerInt(var_2_0, arg_2_0.LAYER_MASK_CullByDistance, true)
	PostProcessingMgr.setCameraLayerInt(var_2_0, arg_2_0.LAYER_MASK_CullOnLowQuality, false)

	var_2_0.layerCullSpherical = true

	if BootNativeUtil.isWindows() then
		RenderPipelineSetting.ForwardPlusToggle = true
	end

	if BootNativeUtil.isWindows() and GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High then
		arg_2_0:getCurScene().loader:makeSureLoaded({
			RoomScenePreloader.DiffuseGI
		}, arg_2_0._OnGetInstance, arg_2_0)
	end
end

function var_0_0._OnGetInstance(arg_3_0)
	arg_3_0.go_GI = RoomGOPool.getInstance(RoomScenePreloader.DiffuseGI, arg_3_0:getCurScene().go.sceneGO, "diffuse_gi")

	transformhelper.setPos(arg_3_0.go_GI.transform, 0, 0, 0)
end

function var_0_0.setPPValue(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._unitPPVolume then
		arg_4_0._unitPPVolume.refresh = true
		arg_4_0._unitPPVolume[arg_4_1] = arg_4_2
	end
end

function var_0_0.onSceneClose(arg_5_0)
	UnityEngine.Shader.DisableKeyword("_FASTER_BLOOM")

	arg_5_0.uiCameraData.needLights = arg_5_0.cacheUINeedLights
	arg_5_0.uiCameraData = nil

	PostProcessingMgr.instance:setRenderShadow(true)
	PostProcessingMgr.instance:clearLayerCullDistance()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, arg_5_0._refreshGraphics, arg_5_0)

	local var_5_0 = CameraMgr.instance:getMainCamera()
	local var_5_1 = var_5_0:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	arg_5_0.overLookFlag = nil
	var_5_1.renderScale = 1
	var_5_1.useProbe = arg_5_0.useProbe
	var_5_1.useLightmap = arg_5_0.useLightmap
	var_5_1.useLightData = arg_5_0.useLightData
	var_5_1.disableTransparentBackToFrontSort = false
	UnityEngine.Physics.autoSimulation = arg_5_0.projPhysics
	UnityEngine.Physics.autoSyncTransforms = arg_5_0.projTransforms
	arg_5_0.projPhysics = nil
	arg_5_0.projTransforms = nil
	UnityEngine.QualitySettings.lodBias = arg_5_0.lodBias

	PostProcessingMgr.setCameraLayerInt(var_5_0, arg_5_0.LAYER_MASK_CullOnLowQuality, false)
	PostProcessingMgr.setCameraLayerInt(var_5_0, arg_5_0.LAYER_MASK_CullByDistance, false)

	var_5_0.layerCullSpherical = false

	arg_5_0:setPPValue("ssaoEnable", false)

	arg_5_0._unitPPVolume = nil
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = false
	UnityEngine.QualitySettings.masterTextureLimit = 0

	if BootNativeUtil.isWindows() then
		RenderPipelineSetting.ForwardPlusToggle = false
	end

	arg_5_0.go_GI = nil
end

function var_0_0._refreshGraphics(arg_6_0)
	local var_6_0 = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local var_6_1 = CameraMgr.instance:getMainCamera():GetComponent(PostProcessingMgr.PPCustomCamDataType)
	local var_6_2 = arg_6_0:getCurScene().go.sceneCulling

	if var_6_0 == ModuleEnum.Performance.High then
		PostProcessingMgr.instance:setRenderShadow(true)

		var_6_1.renderScale = 1
		var_6_2.smallRate = 0.005
		var_6_2.proxyRate = 0.015
		UnityEngine.QualitySettings.lodBias = 1

		if arg_6_0.compatibility then
			arg_6_0:setPPValue("ssaoEnable", true)
			arg_6_0:setPPValue("ssaoIntensity", 0.38)
			arg_6_0:setPPValue("ssaoRadius", 0.07)
			arg_6_0:setPPValue("ssaoRenderScale", 0.2)
			arg_6_0:setPPValue("ssaoDepthQuality", 1)
		end

		PostProcessingMgr.instance:setLayerCullDistance(arg_6_0.LAYER_INDEX_CullByDistance, arg_6_0.highQualityCullingDistance)
		PostProcessingMgr.instance:setLayerCullDistance(arg_6_0.LAYER_INDEX_CullOnLowQuality, arg_6_0.highQualityCullingDistance)

		UnityEngine.QualitySettings.masterTextureLimit = 0
	elseif var_6_0 == ModuleEnum.Performance.Middle then
		var_6_1.renderScale = 0.8
		UnityEngine.QualitySettings.lodBias = 0.9

		PostProcessingMgr.instance:setRenderShadow(true)
		arg_6_0:setPPValue("ssaoEnable", false)
		arg_6_0:getCurScene().go.sceneAmbient:SetReflectionType(0)
		PostProcessingMgr.instance:setLayerCullDistance(arg_6_0.LAYER_INDEX_CullByDistance, arg_6_0.middleQualityCullingDistance)
		PostProcessingMgr.instance:setLayerCullDistance(arg_6_0.LAYER_INDEX_CullOnLowQuality, arg_6_0.middleQualityCullingDistance)

		var_6_2.smallRate = 0.02
		var_6_2.proxyRate = 0.03
		UnityEngine.QualitySettings.masterTextureLimit = 0
	elseif var_6_0 == ModuleEnum.Performance.Low then
		var_6_1.renderScale = 0.7
		UnityEngine.QualitySettings.lodBias = 0.7

		PostProcessingMgr.instance:setRenderShadow(false)
		arg_6_0:setPPValue("ssaoEnable", false)
		arg_6_0:getCurScene().go.sceneAmbient:SetReflectionType(0)
		PostProcessingMgr.instance:setLayerCullDistance(arg_6_0.LAYER_INDEX_CullByDistance, arg_6_0.lowQualityCullingDistance)
		PostProcessingMgr.instance:setLayerCullDistance(arg_6_0.LAYER_INDEX_CullOnLowQuality, arg_6_0.lowQualityCullingDistance)

		var_6_2.smallRate = 0.03
		var_6_2.proxyRate = 0.075
		UnityEngine.QualitySettings.masterTextureLimit = 1
	end
end

function var_0_0.setupShadowParam(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.overLookFlag ~= arg_7_1 then
		local var_7_0
		local var_7_1
		local var_7_2 = arg_7_0:getCurScene()
		local var_7_3 = CameraMgr.instance:getMainCamera()

		if var_7_2 ~= nil and var_7_2.go ~= nil then
			var_7_0 = var_7_2.go.sceneShadow
			var_7_1 = var_7_2.go.sceneAmbient
		end

		if var_7_0 ~= nil then
			if arg_7_1 then
				var_7_0.overrideShadowCascadesOption = true
				var_7_0.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.NoCascades
				var_7_0.overrideShadowResolution = true
				var_7_0.shadowResolution = 1600
				var_7_0.softShadow = true
			else
				var_7_0.overrideShadowCascadesOption = true
				var_7_0.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.TwoCascades
				var_7_0.overrideShadowResolution = true
				var_7_0.shadowResolution = 2048
				var_7_0.softShadow = true
			end

			var_7_0:ApplyProperty()
		end

		local var_7_4 = GameGlobalMgr.instance:getScreenState():getLocalQuality()

		if var_7_4 == ModuleEnum.Performance.High and arg_7_0.compatibility then
			if arg_7_1 then
				var_7_1:SetReflectionType(0)
				arg_7_0:setPPValue("ssaoIntensity", 0.38)
				arg_7_0:setPPValue("ssaoRadius", 0.07)
			else
				var_7_1:SetReflectionType(1)
				arg_7_0:setPPValue("ssaoIntensity", 0.38)
				arg_7_0:setPPValue("ssaoRadius", 0.015)
			end
		end

		if arg_7_1 then
			PostProcessingMgr.setCameraLayerInt(var_7_3, arg_7_0.LAYER_MASK_CullOnLowQuality, false)
		elseif var_7_4 ~= ModuleEnum.Performance.Low then
			PostProcessingMgr.setCameraLayerInt(var_7_3, arg_7_0.LAYER_MASK_CullOnLowQuality, true)
		end

		local var_7_5 = var_7_3:GetComponent(PostProcessingMgr.PPCustomCamDataType)

		if arg_7_1 then
			var_7_5.disableTransparentBackToFrontSort = true
		else
			var_7_5.disableTransparentBackToFrontSort = false
		end

		arg_7_0.overLookFlag = arg_7_1
	end
end

return var_0_0
