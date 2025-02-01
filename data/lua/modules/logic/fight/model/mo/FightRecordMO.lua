module("modules.logic.fight.model.mo.FightRecordMO", package.seeall)

slot0 = pureTable("FightRecordMO")

function slot0.init(slot0, slot1)
	slot0.fightId = slot1.fightId
	slot0.fightName = slot1.fightName
	slot0.fightTime = slot1.fightTime
	slot0.fightResult = slot1.fightResult

	FightStatModel.instance:setAtkStatInfo(slot1.attackStatistics)
end

return slot0
