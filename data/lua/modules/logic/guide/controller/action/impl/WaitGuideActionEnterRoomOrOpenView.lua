module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterRoomOrOpenView", package.seeall)

local var_0_0 = class("WaitGuideActionEnterRoomOrOpenView", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._modeRequire = tonumber(var_1_0[1])
	arg_1_0._needEnterToTrigger = var_1_0[2] == "1"
	arg_1_0._viewName = var_1_0[3]

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._checkDone, arg_1_0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, arg_1_0._checkDone, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._onOpenView, arg_1_0)

	if not arg_1_0._needEnterToTrigger then
		arg_1_0:_checkDone()
	end
end

function var_0_0.clearWork(arg_2_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_2_0._checkDone, arg_2_0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, arg_2_0._checkDone, arg_2_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onOpenView, arg_2_0)
	GuidePriorityController.instance:remove(arg_2_0.guideId)
end

function var_0_0._onOpenView(arg_3_0, arg_3_1)
	if arg_3_1 == arg_3_0._viewName then
		arg_3_0:_checkDone()
	end
end

function var_0_0._checkDone(arg_4_0)
	if arg_4_0:checkGuideLock() then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		local var_4_0 = RoomModel.instance:getGameMode()
		local var_4_1 = false

		if arg_4_0._modeRequire then
			var_4_1 = var_4_0 == arg_4_0._modeRequire
		else
			var_4_1 = RoomController.instance:isEditMode()
		end

		if var_4_1 then
			GuidePriorityController.instance:add(arg_4_0.guideId, arg_4_0._satisfyPriority, arg_4_0, 0.01)
		end
	end
end

function var_0_0._satisfyPriority(arg_5_0)
	arg_5_0:onDone(true)
end

return var_0_0
