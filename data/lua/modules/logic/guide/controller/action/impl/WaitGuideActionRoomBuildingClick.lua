module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBuildingClick", package.seeall)

local var_0_0 = class("WaitGuideActionRoomBuildingClick", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)
	GuideViewMgr.instance:enableHoleClick()
	GuideViewMgr.instance:setHoleClickCallback(arg_2_0._onClickTarget, arg_2_0)
end

function var_0_0.clearWork(arg_3_0)
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	TaskDispatcher.cancelTask(arg_3_0._onDelayDone, arg_3_0)
end

function var_0_0._onClickTarget(arg_4_0, arg_4_1)
	if arg_4_1 then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:setHoleClickCallback(nil, nil)
		TaskDispatcher.runDelay(arg_4_0._onDelayDone, arg_4_0, 0.01)

		local var_4_0 = tonumber(arg_4_0.actionParam)
		local var_4_1 = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(var_4_0)

		if var_4_1 then
			RoomMap3DClickController.instance:onBuildingEntityClick(var_4_1)
		end
	end
end

function var_0_0._onDelayDone(arg_5_0)
	arg_5_0:onDone(true)
end

return var_0_0
