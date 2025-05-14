module("modules.logic.scene.room.comp.RoomSceneInitComp", package.seeall)

local var_0_0 = class("RoomSceneInitComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._originalCameraTransparencySortModeList = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:_setTransparencySortMode()
	RoomMapController.instance:initMap()
	RoomHelper.initSceneRootTrs()
end

function var_0_0.onSceneClose(arg_3_0)
	arg_3_0:_revertTransparencySortMode()

	if GameSceneMgr.instance:getNextSceneType() ~= SceneType.Room and RoomController.instance:isObMode() then
		-- block empty
	end

	RoomMapController.instance:clearMap()
end

function var_0_0._setTransparencySortMode(arg_4_0)
	arg_4_0._originalCameraTransparencySortModeList = {}

	local var_4_0 = CameraMgr.instance:getMainCamera()
	local var_4_1 = CameraMgr.instance:getUnitCamera()
	local var_4_2 = CameraMgr.instance:getOrthCamera()

	arg_4_0:_setTransparencySortModeSingleCamera(var_4_0)
	arg_4_0:_setTransparencySortModeSingleCamera(var_4_1)
	arg_4_0:_setTransparencySortModeSingleCamera(var_4_2)
end

function var_0_0._setTransparencySortModeSingleCamera(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	table.insert(arg_5_0._originalCameraTransparencySortModeList, {
		camera = arg_5_1,
		originalTransparencySortMode = arg_5_1.transparencySortMode
	})

	arg_5_1.transparencySortMode = UnityEngine.TransparencySortMode.Default
end

function var_0_0._revertTransparencySortMode(arg_6_0)
	if not arg_6_0._originalCameraTransparencySortModeList then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._originalCameraTransparencySortModeList) do
		iter_6_1.camera.transparencySortMode = iter_6_1.originalTransparencySortMode
	end
end

return var_0_0
