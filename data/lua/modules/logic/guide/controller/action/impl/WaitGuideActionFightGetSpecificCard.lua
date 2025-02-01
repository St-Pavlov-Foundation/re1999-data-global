module("modules.logic.guide.controller.action.impl.WaitGuideActionFightGetSpecificCard", package.seeall)

slot0 = class("WaitGuideActionFightGetSpecificCard", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0._cardSkillId = tonumber(string.split(slot3, "#")[1])
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnDistributeCards, slot0._onDistributeCardDone, slot0)
end

function slot0._onRoundStart(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card or slot1 == FightEnum.Stage.AutoCard then
		for slot6, slot7 in ipairs(FightCardModel.instance:getHandCards()) do
			if slot0._cardSkillId == slot7.skillId then
				if slot1 == FightEnum.Stage.AutoCard then
					FightController.instance:dispatchEvent(FightEvent.OnGuideStopAutoFight)
				end

				GuideModel.instance:setFlag(GuideModel.GuideFlag.FightSetSpecificCardIndex, slot6)
				slot0:clearWork()
				slot0:onDone(true)
			end
		end
	end
end

function slot0._onDistributeCardDone(slot0)
	slot1 = FightModel.instance:getCurStage()

	for slot6, slot7 in ipairs(FightCardModel.instance:getHandCards()) do
		if slot0._cardSkillId == slot7.skillId then
			if FightModel.instance:isAuto() then
				FightController.instance:dispatchEvent(FightEvent.OnGuideStopAutoFight)
			end

			GuideModel.instance:setFlag(GuideModel.GuideFlag.FightSetSpecificCardIndex, slot6)
			slot0:clearWork()
			slot0:onDone(true)
		end
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, slot0._onRoundStart, slot0)
end

return slot0
