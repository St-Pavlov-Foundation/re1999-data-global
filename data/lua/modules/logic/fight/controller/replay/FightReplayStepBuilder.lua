module("modules.logic.fight.controller.replay.FightReplayStepBuilder", package.seeall)

slot0 = class("FightReplayStepBuilder")

function slot0.buildReplaySequence()
	slot0 = FlowSequence.New()

	for slot5, slot6 in ipairs(FightReplayModel.instance:getList()) do
		slot0:addWork(FightReplayWorkWaitCardStage.New())

		for slot10, slot11 in ipairs(slot6.clothSkillOpers) do
			slot0:addWork(FightReplayWorkClothSkill.New(slot11))
		end

		slot10 = FightModel.instance
		slot11 = slot10

		slot0:addWork(WorkWaitSeconds.New(0.1 / slot10.getSpeed(slot11)))

		function slot10()
			FightController.instance:setCurStage(FightEnum.Stage.Card)
		end

		slot0:addWork(FunctionWork.New(slot10))

		for slot10, slot11 in ipairs(slot6.opers) do
			if slot11:isMoveCard() then
				slot0:addWork(FightReplayWorkMoveCard.New(slot11))
			elseif slot11:isPlayCard() then
				slot0:addWork(FightReplayWorkPlayCard.New(slot11))
			elseif slot11:isMoveUniversal() then
				slot0:addWork(FightReplayWorkMoveUniversal.New(slot11))
			elseif slot11:isPlayerFinisherSkill() then
				slot0:addWork(FightReplyWorkPlayerFinisherSkill.New(slot11))
			end
		end

		slot0:addWork(FightReplayWorkWaitRoundEnd.New())
		slot0:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	end

	return slot0
end

return slot0
