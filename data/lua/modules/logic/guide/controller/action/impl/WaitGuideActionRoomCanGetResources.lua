module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomCanGetResources", package.seeall)

local var_0_0 = class("WaitGuideActionRoomCanGetResources", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._partId = tonumber(arg_1_0.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterOneSceneFinish, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._onOpenViewFinish, arg_1_0)
end

function var_0_0._onEnterOneSceneFinish(arg_2_0, arg_2_1)
	if arg_2_0:checkGuideLock() then
		return
	end

	if arg_2_1 == SceneType.Room and RoomController.instance:isObMode() and #RoomProductionHelper.getCanGainLineIdList(arg_2_0._partId) > 0 then
		GuidePriorityController.instance:add(arg_2_0.guideId, arg_2_0._satisfyPriority, arg_2_0, 0.01)
	end
end

function var_0_0._onOpenViewFinish(arg_3_0, arg_3_1)
	if arg_3_0:checkGuideLock() then
		return
	end

	if arg_3_1 == ViewName.RoomInitBuildingView then
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_4_0._onEnterOneSceneFinish, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)
	GuidePriorityController.instance:remove(arg_4_0.guideId)
end

function var_0_0._satisfyPriority(arg_5_0)
	arg_5_0:onDone(true)
end

return var_0_0
