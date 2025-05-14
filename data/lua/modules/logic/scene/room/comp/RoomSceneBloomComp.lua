module("modules.logic.scene.room.comp.RoomSceneBloomComp", package.seeall)

local var_0_0 = class("RoomSceneBloomComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._originalBloomColor = nil
	arg_1_0._originalBloomActive = nil
	arg_1_0._originalBloomlocalActive = nil
	arg_1_0._originalBloomIntensity = nil
	arg_1_0._originalBloomThreshold = nil
	arg_1_0._originalBloomDiffusion = nil
	arg_1_0._originalBloomRTDownTimes = nil
	arg_1_0._originalBloomPercent = nil
	arg_1_0._originalMaskActive = nil
	arg_1_0._originalMainCameraVolumeTrigger = nil
	arg_1_0._originalMainCameraUsePostProcess = nil
	arg_1_0._originalMainCameraVolumeMask = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = lua_scene_level.configDict[arg_2_2]
	local var_2_1 = GameGlobalMgr.instance:getScreenState().grade

	arg_2_0._unitPPVolume = gohelper.findChildComponent(CameraMgr.instance:getMainCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)
	arg_2_0._originalBloomColor = arg_2_0:_getUnitPPValue("localBloomColor")

	arg_2_0:_setUnitPPValue("localBloomColor", Color.New(var_2_0.bloomR, var_2_0.bloomG, var_2_0.bloomB, var_2_0.bloomA))

	arg_2_0._originalBloomActive = arg_2_0:_getUnitPPValue("bloomActive")

	arg_2_0:_setUnitPPValue("bloomActive", var_2_0.useBloom == 1 and var_2_1 ~= ModuleEnum.Performance.Low)

	arg_2_0._originalBloomlocalActive = arg_2_0:_getUnitPPValue("localBloomActive")

	arg_2_0:_setUnitPPValue("localBloomActive", false)

	arg_2_0._originalBloomIntensity = arg_2_0:_getUnitPPValue("bloomIntensity")

	arg_2_0:_setUnitPPValue("bloomIntensity", 11)

	arg_2_0._originalBloomThreshold = arg_2_0:_getUnitPPValue("bloomThreshold")

	arg_2_0:_setUnitPPValue("bloomThreshold", 1)

	arg_2_0._originalBloomDiffusion = arg_2_0:_getUnitPPValue("bloomDiffusion")

	arg_2_0:_setUnitPPValue("bloomDiffusion", 4)

	arg_2_0._originalBloomRTDownTimes = arg_2_0:_getUnitPPValue("bloomRTDownTimes")

	arg_2_0:_setUnitPPValue("bloomRTDownTimes", 1)

	arg_2_0._originalBloomPercent = arg_2_0:_getUnitPPValue("bloomPercent")

	arg_2_0:_setUnitPPValue("bloomPercent", 1)

	arg_2_0._originalMaskActive = arg_2_0:_getUnitPPValue("localMaskActive")

	arg_2_0:_setUnitPPValue("localMaskActive", false)
	arg_2_0:_setUnitPPValue("LocalMaskActive", false)
	arg_2_0:_setCamera()
end

function var_0_0._setCamera(arg_3_0)
	local var_3_0 = CameraMgr.instance:getMainCameraGO():GetComponent(PostProcessingMgr.PPCustomCamDataType)

	arg_3_0._originalMainCameraVolumeTrigger = var_3_0.volumeTrigger

	if arg_3_0._unitPPVolume then
		var_3_0.volumeTrigger = arg_3_0._unitPPVolume.transform
	end

	arg_3_0._originalMainCameraUsePostProcess = var_3_0.usePostProcess
	var_3_0.usePostProcess = true
	arg_3_0._originalMainCameraVolumeMask = var_3_0.volumeMask
	var_3_0.volumeMask = LayerMask.GetMask("Unit")
end

function var_0_0._setUnitPPValue(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._unitPPVolume then
		arg_4_0._unitPPVolume.refresh = true
		arg_4_0._unitPPVolume[arg_4_1] = arg_4_2
	end
end

function var_0_0._getUnitPPValue(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._unitPPVolume then
		return arg_5_0._unitPPVolume[arg_5_1]
	end
end

function var_0_0.onSceneClose(arg_6_0)
	if arg_6_0._originalBloomColor ~= nil then
		arg_6_0:_setUnitPPValue("localBloomColor", arg_6_0._originalBloomColor)

		arg_6_0._originalBloomColor = nil
	end

	if arg_6_0._originalBloomActive ~= nil then
		arg_6_0:_setUnitPPValue("bloomActive", arg_6_0._originalBloomActive)

		arg_6_0._originalBloomActive = nil
	end

	if arg_6_0._originalBloomlocalActive ~= nil then
		arg_6_0:_setUnitPPValue("localBloomActive", arg_6_0._originalBloomlocalActive)

		arg_6_0._originalBloomlocalActive = nil
	end

	if arg_6_0._originalBloomIntensity ~= nil then
		arg_6_0:_setUnitPPValue("bloomIntensity", arg_6_0._originalBloomIntensity)

		arg_6_0._originalBloomIntensity = nil
	end

	if arg_6_0._originalBloomThreshold ~= nil then
		arg_6_0:_setUnitPPValue("bloomThreshold", arg_6_0._originalBloomThreshold)

		arg_6_0._originalBloomThreshold = nil
	end

	if arg_6_0._originalBloomDiffusion ~= nil then
		arg_6_0:_setUnitPPValue("bloomDiffusion", arg_6_0._originalBloomDiffusion)

		arg_6_0._originalBloomDiffusion = nil
	end

	if arg_6_0._originalBloomRTDownTimes ~= nil then
		arg_6_0:_setUnitPPValue("bloomRTDownTimes", arg_6_0._originalBloomRTDownTimes)

		arg_6_0._originalBloomRTDownTimes = nil
	end

	if arg_6_0._originalBloomPercent ~= nil then
		arg_6_0:_setUnitPPValue("bloomPercent", arg_6_0._originalBloomPercent)

		arg_6_0._originalBloomPercent = nil
	end

	if arg_6_0._originalMaskActive ~= nil then
		arg_6_0:_setUnitPPValue("localMaskActive", arg_6_0._originalMaskActive)
		arg_6_0:_setUnitPPValue("LocalMaskActive", arg_6_0._originalMaskActive)

		arg_6_0._originalMaskActive = nil
	end

	arg_6_0:_resetCamera()

	arg_6_0._unitPPVolume = nil
end

function var_0_0._resetCamera(arg_7_0)
	local var_7_0 = CameraMgr.instance:getMainCameraGO():GetComponent(PostProcessingMgr.PPCustomCamDataType)

	var_7_0.volumeTrigger = arg_7_0._originalMainCameraVolumeTrigger
	var_7_0.usePostProcess = arg_7_0._originalMainCameraUsePostProcess
	var_7_0.volumeMask = arg_7_0._originalMainCameraVolumeMask
end

return var_0_0
