module("modules.logic.fight.model.data.FightCacheFightDataMgr", package.seeall)

slot0 = FightDataClass("FightCacheFightDataMgr")

function slot0.onConstructor(slot0)
	slot0.cache = {}
end

function slot0.cacheFightWavePush(slot0, slot1)
	table.insert(slot0.cache, slot1)
end

function slot0.getAndRemove(slot0)
	return table.remove(slot0.cache, 1)
end

return slot0
