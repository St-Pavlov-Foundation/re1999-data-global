module("modules.logic.scene.survival.comp.SurvivalScenePPVolume", package.seeall)

local var_0_0 = class("SurvivalScenePPVolume", BaseSceneComp)

var_0_0.HighProfilePath = RoomResourceEnum.PPVolume.High
var_0_0.MiddleProfilePath = RoomResourceEnum.PPVolume.Middle
var_0_0.LowProfilePath = RoomResourceEnum.PPVolume.Low
var_0_0.UnitCameraKey = "SurvivalScene_UnitCameraKey"

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:initPPVolume()
	arg_1_0:_setCamera()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, arg_1_0.updatePPLevel, arg_1_0)
end

function var_0_0.initPPVolume(arg_2_0)
	if arg_2_0._ppVolumeGo then
		return
	end

	arg_2_0._highProfile = ConstAbCache.instance:getRes(var_0_0.HighProfilePath)
	arg_2_0._middleProfile = ConstAbCache.instance:getRes(var_0_0.MiddleProfilePath)
	arg_2_0._lowProfile = ConstAbCache.instance:getRes(var_0_0.LowProfilePath)

	CameraMgr.instance:setSceneCameraActive(false, var_0_0.UnitCameraKey)

	arg_2_0._ppVolumeGo = gohelper.create3d(CameraMgr.instance:getMainCameraGO(), "PPVolume")
	arg_2_0._ppVolumeWrap = gohelper.onceAddComponent(arg_2_0._ppVolumeGo, PostProcessingMgr.PPVolumeWrapType)

	arg_2_0:updatePPLevel()
end

function var_0_0._setCamera(arg_3_0)
	local var_3_0 = CameraMgr.instance:getMainCameraGO():GetComponent(PostProcessingMgr.PPCustomCamDataType)

	arg_3_0._originalusePostProcess = var_3_0.usePostProcess
	arg_3_0._originalMainCameraVolumeTrigger = var_3_0.volumeTrigger
	var_3_0.usePostProcess = true
	var_3_0.volumeTrigger = arg_3_0._ppVolumeGo.transform
end

function var_0_0._resetCamera(arg_4_0)
	local var_4_0 = CameraMgr.instance:getMainCameraGO():GetComponent(PostProcessingMgr.PPCustomCamDataType)

	var_4_0.usePostProcess = arg_4_0._originalusePostProcess
	var_4_0.volumeTrigger = arg_4_0._originalMainCameraVolumeTrigger
	arg_4_0._originalusePostProcess = nil
	arg_4_0._originalMainCameraVolumeTrigger = nil
end

function var_0_0.updatePPLevel(arg_5_0)
	if not arg_5_0._ppVolumeWrap then
		return
	end

	local var_5_0 = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local var_5_1 = arg_5_0._highProfile
	local var_5_2 = CameraMgr.instance:getMainCameraGO()

	if var_5_0 == ModuleEnum.Performance.High then
		var_5_1 = arg_5_0._highProfile
	elseif var_5_0 == ModuleEnum.Performance.Middle then
		var_5_1 = arg_5_0._middleProfile
	elseif var_5_0 == ModuleEnum.Performance.Low then
		var_5_1 = arg_5_0._lowProfile
	end

	arg_5_0._ppVolumeWrap:SetProfile(var_5_1)
end

function var_0_0.destoryPPVolume(arg_6_0)
	if not arg_6_0._ppVolumeGo then
		return
	end

	CameraMgr.instance:setSceneCameraActive(true, var_0_0.UnitCameraKey)
	gohelper.destroy(arg_6_0._ppVolumeGo)

	arg_6_0._ppVolumeGo = nil
	arg_6_0._ppVolumeWrap = nil
	arg_6_0._highProfile = nil
	arg_6_0._middleProfile = nil
	arg_6_0._lowProfile = nil
end

function var_0_0.onSceneClose(arg_7_0)
	arg_7_0:_resetCamera()
	arg_7_0:destoryPPVolume()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, arg_7_0.updatePPLevel, arg_7_0)
end

return var_0_0
