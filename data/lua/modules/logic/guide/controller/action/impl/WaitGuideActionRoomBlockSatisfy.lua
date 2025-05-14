module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBlockSatisfy", package.seeall)

local var_0_0 = class("WaitGuideActionRoomBlockSatisfy", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._check, arg_1_0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, arg_1_0._check, arg_1_0)

	arg_1_0._blockCount = tonumber(arg_1_0.actionParam)

	arg_1_0:_check()
end

function var_0_0._check(arg_2_0)
	if arg_2_0:_checkBlockCount() and arg_2_0:_checkRoomOb() then
		GuidePriorityController.instance:add(arg_2_0.guideId, arg_2_0._satisfyPriority, arg_2_0, 0.01)
	end
end

function var_0_0._checkBlockCount(arg_3_0)
	return RoomMapBlockModel.instance:getFullBlockCount() >= arg_3_0._blockCount
end

function var_0_0._checkRoomOb(arg_4_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		return RoomController.instance:isObMode()
	end
end

function var_0_0.clearWork(arg_5_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_5_0._check, arg_5_0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, arg_5_0._check, arg_5_0)
	GuidePriorityController.instance:remove(arg_5_0.guideId)
end

function var_0_0._satisfyPriority(arg_6_0)
	arg_6_0:onDone(true)
end

return var_0_0
