module("modules.logic.guide.controller.action.impl.WaitGuideActionFightDragCard", package.seeall)

local var_0_0 = class("WaitGuideActionFightDragCard", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = {}

	for iter_1_0 = 2, #var_1_0 do
		local var_1_3 = var_1_0[iter_1_0]

		table.insert(var_1_2, var_1_3)
	end

	GuideViewMgr.instance:enableDrag(true)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.FightMoveCard, {
		from = var_1_1,
		tos = var_1_2
	}, arg_1_0.guideId)
	FightController.instance:registerCallback(FightEvent.OnGuideDragCard, arg_1_0._onGuideDragCard, arg_1_0)
end

function var_0_0._onGuideDragCard(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideDragCard, arg_2_0._onGuideDragCard, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	GuideViewMgr.instance:enableDrag(false)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.FightMoveCard, nil, arg_3_0.guideId)
	FightController.instance:unregisterCallback(FightEvent.OnGuideDragCard, arg_3_0._onGuideDragCard, arg_3_0)
end

return var_0_0
