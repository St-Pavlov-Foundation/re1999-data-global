module("modules.logic.guide.controller.action.impl.GuideActionFightVictory", package.seeall)

local var_0_0 = class("GuideActionFightVictory", BaseGuideAction)
local var_0_1 = 2.5

function var_0_0.onStart(arg_1_0, arg_1_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	arg_1_0._playVictoryList = {}

	TaskDispatcher.runDelay(arg_1_0._onVictoryEnd, arg_1_0, var_0_1)

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1.spine:hasAnimation(SpineAnimState.victory) then
			arg_1_0._victoryActName = FightHelper.processEntityActionName(iter_1_1, SpineAnimState.victory)

			iter_1_1.spine:addAnimEventCallback(arg_1_0._onAnimEvent, arg_1_0, iter_1_1)
			iter_1_1.spine:play(arg_1_0._victoryActName, false, true, true)

			if iter_1_1.nameUI then
				iter_1_1.nameUI:setActive(false)
			end

			table.insert(arg_1_0._playVictoryList, iter_1_1)
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0._onAnimEvent(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 == arg_2_0._victoryActName and arg_2_2 == SpineAnimEvent.ActionComplete then
		local var_2_0 = arg_2_4

		var_2_0:resetAnimState()
		var_2_0.spine:removeAnimEventCallback(arg_2_0._onAnimEvent, arg_2_0)
	end
end

function var_0_0._onVictoryEnd(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._playVictoryList) do
		iter_3_1:resetAnimState()
		iter_3_1.spine:removeAnimEventCallback(arg_3_0._onAnimEvent, arg_3_0)
	end
end

function var_0_0.onDestroy(arg_4_0)
	var_0_0.super.onDestroy(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onVictoryEnd, arg_4_0)

	arg_4_0._playVictoryList = nil
end

return var_0_0
