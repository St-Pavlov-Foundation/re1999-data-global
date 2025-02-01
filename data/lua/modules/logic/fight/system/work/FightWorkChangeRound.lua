module("modules.logic.fight.system.work.FightWorkChangeRound", package.seeall)

slot0 = class("FightWorkChangeRound", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getVersion() < 3 then
		slot0:onDone(true)

		return
	end

	FightModel.instance._curRoundId = (FightModel.instance._curRoundId or 1) + 1

	FightController.instance:dispatchEvent(FightEvent.ChangeRound)

	for slot5, slot6 in ipairs(FightEntityModel.instance:getList()) do
		slot6.subCd = 0

		FightController.instance:dispatchEvent(FightEvent.ChangeEntitySubCd, slot6.uid)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
