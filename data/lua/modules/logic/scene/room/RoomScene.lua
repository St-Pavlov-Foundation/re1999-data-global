module("modules.logic.scene.room.RoomScene", package.seeall)

local var_0_0 = class("RoomScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	arg_1_0:_addComp("director", RoomSceneDirector)
	arg_1_0:_addComp("tween", RoomSceneTweenComp)
	arg_1_0:_addComp("timer", RoomSceneTimerComp)
	arg_1_0:_addComp("init", RoomSceneInitComp)
	arg_1_0:_addComp("level", RoomSceneLevelComp)
	arg_1_0:_addComp("loader", RoomSceneLoader)
	arg_1_0:_addComp("preloader", RoomScenePreloader)
	arg_1_0:_addComp("bloom", RoomSceneBloomComp)
	arg_1_0:_addComp("go", RoomSceneGOComp)
	arg_1_0:_addComp("bending", RoomSceneBendingComp)
	arg_1_0:_addComp("camera", RoomSceneCameraComp)
	arg_1_0:_addComp("light", RoomSceneLightComp)
	arg_1_0:_addComp("weather", RoomSceneWeatherComp)
	arg_1_0:_addComp("ambient", RoomSceneAmbientComp)
	arg_1_0:_addComp("mapmgr", RoomSceneMapEntityMgr)
	arg_1_0:_addComp("inventorymgr", RoomSceneInventoryEntitySelectMgr)
	arg_1_0:_addComp("buildingmgr", RoomSceneBuildingEntityMgr)
	arg_1_0:_addComp("charactermgr", RoomSceneCharacterEntityMgr)
	arg_1_0:_addComp("vehiclemgr", RoomSceneVehicleEntityMgr)
	arg_1_0:_addComp("crittermgr", RoomSceneCritterEntityMgr)
	arg_1_0:_addComp("buildingcrittermgr", RoomSceneBuildingCritterMgr)
	arg_1_0:_addComp("sitemgr", RoomSceneTransportSiteEntityMgr)
	arg_1_0:_addComp("ocean", RoomSceneOceanComp)
	arg_1_0:_addComp("fog", RoomSceneFogComp)
	arg_1_0:_addComp("fsm", RoomSceneFSMComp)
	arg_1_0:_addComp("view", RoomSceneViewComp)
	arg_1_0:_addComp("touch", RoomSceneTouchComp)
	arg_1_0:_addComp("graphics", RoomSceneGraphicsComp)
	arg_1_0:_addComp("character", RoomSceneCharacterComp)
	arg_1_0:_addComp("fovblock", RoomSceneCameraFOVBlockComp)
	arg_1_0:_addComp("path", RoomScenePathComp)
	arg_1_0:_addComp("debug", RoomSceneDebugComp)
	arg_1_0:_addComp("audio", RoomSceneAudioComp)
	arg_1_0:_addComp("cameraFollow", RoomSceneCameraFollowComp)
end

var_0_0.UnitCameraKey = "RoomScene_UnitCameraKey"

function var_0_0.onStart(arg_2_0, arg_2_1, arg_2_2)
	RoomHelper.logElapse("RoomScene:onStart")
	GameResMgr:SetMaxFileLoadingCount(128)

	local var_2_0 = CameraMgr.instance:getMainCamera()

	arg_2_0._mainFarClipValue = var_2_0.farClipPlane
	arg_2_0._mainNearClipValue = var_2_0.nearClipPlane

	CameraMgr.instance:setSceneCameraActive(false, var_0_0.UnitCameraKey)
	var_0_0.super.onStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:initPPVolume()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, arg_2_0.updatePPLevel, arg_2_0)
end

function var_0_0.initPPVolume(arg_3_0)
	if arg_3_0._ppVolumeGo then
		return
	end

	arg_3_0._highProfile = ConstAbCache.instance:getRes(RoomResourceEnum.PPVolume.High)
	arg_3_0._middleProfile = ConstAbCache.instance:getRes(RoomResourceEnum.PPVolume.Middle)
	arg_3_0._lowProfile = ConstAbCache.instance:getRes(RoomResourceEnum.PPVolume.Low)
	arg_3_0._ppVolumeGo = gohelper.create3d(CameraMgr.instance:getMainCameraGO(), "PPVolume")
	arg_3_0._ppVolumeWrap = gohelper.onceAddComponent(arg_3_0._ppVolumeGo, PostProcessingMgr.PPVolumeWrapType)

	arg_3_0:updatePPLevel()
end

function var_0_0.updatePPLevel(arg_4_0)
	if not arg_4_0._ppVolumeWrap then
		return
	end

	local var_4_0 = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local var_4_1 = arg_4_0._highProfile

	if var_4_0 == ModuleEnum.Performance.High then
		var_4_1 = arg_4_0._highProfile
	elseif var_4_0 == ModuleEnum.Performance.Middle then
		var_4_1 = arg_4_0._middleProfile
	elseif var_4_0 == ModuleEnum.Performance.Low then
		var_4_1 = arg_4_0._lowProfile
	end

	arg_4_0._ppVolumeWrap:SetProfile(var_4_1)
end

function var_0_0.onClose(arg_5_0)
	RoomHelper.logElapse("RoomScene:onClose")
	GameGlobalMgr.instance:getScreenState():resetMaxFileLoadingCount()
	CameraMgr.instance:setSceneCameraActive(true, var_0_0.UnitCameraKey)
	var_0_0.super.onClose(arg_5_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, arg_5_0.updatePPLevel, arg_5_0)
	arg_5_0:destroyPPVolume()

	if arg_5_0._mainFarClipValue then
		local var_5_0 = CameraMgr.instance:getMainCamera()

		var_5_0.farClipPlane = arg_5_0._mainFarClipValue
		var_5_0.nearClipPlane = arg_5_0._mainNearClipValue
		arg_5_0._mainFarClipValue = nil
		arg_5_0._mainNearClipValue = nil
	end
end

function var_0_0.destroyPPVolume(arg_6_0)
	if not arg_6_0._ppVolumeGo then
		return
	end

	gohelper.destroy(arg_6_0._ppVolumeGo)

	arg_6_0._ppVolumeGo = nil
	arg_6_0._ppVolumeWrap = nil
	arg_6_0._highProfile = nil
	arg_6_0._middleProfile = nil
	arg_6_0._lowProfile = nil
end

return var_0_0
