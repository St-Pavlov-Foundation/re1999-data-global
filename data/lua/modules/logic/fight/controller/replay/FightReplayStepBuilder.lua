module("modules.logic.fight.controller.replay.FightReplayStepBuilder", package.seeall)

local var_0_0 = class("FightReplayStepBuilder")

function var_0_0.buildReplaySequence()
	local var_1_0 = FlowSequence.New()
	local var_1_1 = FightReplayModel.instance:getList()

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		var_1_0:addWork(FightReplayWorkWaitCardStage.New())

		for iter_1_2, iter_1_3 in ipairs(iter_1_1.clothSkillOpers) do
			var_1_0:addWork(FightReplayWorkClothSkill.New(iter_1_3))
		end

		var_1_0:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
		var_1_0:addWork(FunctionWork.New(function()
			FightDataHelper.tempMgr.replayAiJiAoQtePreTimeline = nil

			FightController.instance:setCurStage(FightEnum.Stage.Card)
		end))

		for iter_1_4, iter_1_5 in ipairs(iter_1_1.opers) do
			if iter_1_5:isMoveCard() then
				var_1_0:addWork(FightReplayWorkMoveCard.New(iter_1_5))
			elseif iter_1_5:isPlayCard() then
				var_1_0:addWork(FightReplayWorkPlayCard.New(iter_1_5))
			elseif iter_1_5:isMoveUniversal() then
				var_1_0:addWork(FightReplayWorkMoveUniversal.New(iter_1_5))
			elseif iter_1_5:isPlayerFinisherSkill() then
				var_1_0:addWork(FightReplyWorkPlayerFinisherSkill.New(iter_1_5))
			elseif iter_1_5:isBloodPoolSkill() then
				var_1_0:addWork(FightReplyWorkBloodPoolSkill.New(iter_1_5))
			end
		end

		if #iter_1_1.opers == 0 then
			var_1_0:addWork(FunctionWork.New(function()
				FightRpc.instance:sendBeginRoundRequest(FightDataHelper.operationDataMgr:getOpList())
			end))
		end

		var_1_0:addWork(FightReplayWorkWaitRoundEnd.New())
		var_1_0:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	end

	return var_1_0
end

return var_0_0
