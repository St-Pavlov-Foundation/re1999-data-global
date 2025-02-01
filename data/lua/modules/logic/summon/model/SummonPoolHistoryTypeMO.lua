module("modules.logic.summon.model.SummonPoolHistoryTypeMO", package.seeall)

slot0 = pureTable("SummonPoolHistoryTypeMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.config = slot2 or SummonConfig.instance:getPoolDetailConfig(slot1)
end

return slot0
