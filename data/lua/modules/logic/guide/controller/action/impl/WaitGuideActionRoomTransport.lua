module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomTransport", package.seeall)

local var_0_0 = class("WaitGuideActionRoomTransport", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._modeRequire = 2

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._checkDone, arg_1_0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, arg_1_0._checkDone, arg_1_0)

	arg_1_0._goStepId = tonumber(arg_1_0.actionParam)
end

function var_0_0.clearWork(arg_2_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_2_0._checkDone, arg_2_0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, arg_2_0._checkDone, arg_2_0)
end

function var_0_0._checkDone(arg_3_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		local var_3_0 = RoomModel.instance:getGameMode()
		local var_3_1 = false

		if arg_3_0._modeRequire then
			var_3_1 = var_3_0 == arg_3_0._modeRequire
		else
			var_3_1 = RoomController.instance:isEditMode()
		end

		if var_3_1 then
			arg_3_0:checkCondition()
		end
	end
end

function var_0_0.checkCondition(arg_4_0)
	if GuideActionCondition.checkRoomTransport() then
		local var_4_0 = GuideModel.instance:getById(arg_4_0.guideId)

		if var_4_0 then
			var_4_0.currStepId = arg_4_0._goStepId - 1
		end

		arg_4_0:onDone(true)
	end
end

return var_0_0
