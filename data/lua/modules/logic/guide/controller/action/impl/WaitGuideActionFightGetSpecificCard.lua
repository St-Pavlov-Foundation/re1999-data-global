module("modules.logic.guide.controller.action.impl.WaitGuideActionFightGetSpecificCard", package.seeall)

local var_0_0 = class("WaitGuideActionFightGetSpecificCard", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = string.split(arg_1_3, "#")

	arg_1_0._cardSkillId = tonumber(var_1_0[1])
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)
	FightController.instance:registerCallback(FightEvent.OnDistributeCards, arg_2_0._onDistributeCardDone, arg_2_0)
end

function var_0_0._onRoundStart(arg_3_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local var_3_0 = FightDataHelper.handCardMgr.handCard

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if arg_3_0._cardSkillId == iter_3_1.skillId then
				if FightDataHelper.stateMgr:getIsAuto() then
					FightController.instance:dispatchEvent(FightEvent.OnGuideStopAutoFight)
				end

				GuideModel.instance:setFlag(GuideModel.GuideFlag.FightSetSpecificCardIndex, iter_3_0)
				arg_3_0:clearWork()
				arg_3_0:onDone(true)
			end
		end
	end
end

function var_0_0._onDistributeCardDone(arg_4_0)
	local var_4_0 = FightDataHelper.handCardMgr.handCard

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if arg_4_0._cardSkillId == iter_4_1.skillId then
			if FightDataHelper.stateMgr:getIsAuto() then
				FightController.instance:dispatchEvent(FightEvent.OnGuideStopAutoFight)
			end

			GuideModel.instance:setFlag(GuideModel.GuideFlag.FightSetSpecificCardIndex, iter_4_0)
			arg_4_0:clearWork()
			arg_4_0:onDone(true)
		end
	end
end

function var_0_0.clearWork(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, arg_5_0._onRoundStart, arg_5_0)
end

return var_0_0
