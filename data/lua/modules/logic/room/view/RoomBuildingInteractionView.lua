module("modules.logic.room.view.RoomBuildingInteractionView", package.seeall)

local var_0_0 = class("RoomBuildingInteractionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnlockscreen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_lockscreen")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlockscreen:AddClickListener(arg_2_0._btnlockscreenOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlockscreen:RemoveClickListener()
end

function var_0_0._btnlockscreenOnClick(arg_4_0)
	arg_4_0:closeThis()
	arg_4_0:_resetCamera()
end

function var_0_0._resetCamera(arg_5_0)
	local var_5_0 = RoomCharacterController.instance:getPlayingInteractionParam()

	if not var_5_0 or var_5_0.behaviour ~= RoomCharacterEnum.InteractionType.Building then
		return
	end

	local var_5_1 = RoomCharacterModel.instance:getCharacterMOById(var_5_0.heroId)

	if not var_5_1 then
		return
	end

	local var_5_2 = GameSceneMgr.instance:getCurScene()

	if not var_5_2 or not var_5_2.camera then
		return
	end

	local var_5_3 = var_5_2.camera

	if var_5_3:getCameraState() == RoomEnum.CameraState.InteractionCharacterBuilding then
		local var_5_4 = var_5_1.currentPosition

		var_5_3:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = var_5_4.x,
			focusY = var_5_4.z
		})
	end
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
