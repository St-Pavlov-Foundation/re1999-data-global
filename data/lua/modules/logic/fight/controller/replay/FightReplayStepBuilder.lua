module("modules.logic.fight.controller.replay.FightReplayStepBuilder", package.seeall)

slot0 = class("FightReplayStepBuilder")

function slot0.buildReplaySequence()
	slot0 = FlowSequence.New()

	for slot5, slot6 in ipairs(FightReplayModel.instance:getList()) do
		slot10 = FightReplayWorkWaitCardStage.New

		slot0:addWork(slot10())

		for slot10, slot11 in ipairs(slot6.clothSkillOpers) do
			slot0:addWork(FightReplayWorkClothSkill.New(slot11))
		end

		slot0:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))

		slot10 = FunctionWork.New

		slot0:addWork(slot10(function ()
			FightController.instance:setCurStage(FightEnum.Stage.Card)
		end))

		for slot10, slot11 in ipairs(slot6.opers) do
			if slot11:isMoveCard() then
				slot0:addWork(FightReplayWorkMoveCard.New(slot11))
			elseif slot11:isPlayCard() then
				slot0:addWork(FightReplayWorkPlayCard.New(slot11))
			elseif slot11:isMoveUniversal() then
				slot0:addWork(FightReplayWorkMoveUniversal.New(slot11))
			end
		end

		slot0:addWork(FightReplayWorkWaitRoundEnd.New())
		slot0:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	end

	return slot0
end

return slot0
