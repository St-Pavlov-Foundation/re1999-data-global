module("modules.logic.fight.controller.FightEventExtend", package.seeall)

slot0 = class("FightEventExtend")

function slot0.addConstEvents(slot0)
	FightController.instance:registerCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

function slot0._onStageChange(slot0, slot1)
	if slot1 ~= FightEnum.Stage.Card then
		return
	end

	for slot6, slot7 in ipairs(FightCardModel.instance:getHandCards()) do
		if FightDataHelper.entityMgr:getById(slot7.uid) and FightConfig:isUniqueSkill(slot7.skillId, slot8.modelId) then
			FightController.instance:dispatchEvent(FightEvent.OnGuideGetUniqueCard)

			return
		end
	end
end

return slot0
