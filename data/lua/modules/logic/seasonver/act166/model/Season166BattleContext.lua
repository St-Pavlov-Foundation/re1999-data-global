module("modules.logic.seasonver.act166.model.Season166BattleContext", package.seeall)

slot0 = pureTable("Season166BattleContext")

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.actId = slot1
	slot0.episodeId = slot2
	slot0.baseId = slot3
	slot0.talentId = slot4
	slot0.trainId = slot5
	slot0.teachId = slot6
	slot0.episodeType = lua_episode.configDict[slot0.episodeId] and slot7.type
	slot0.battleId = slot7 and slot7.battleId
end

return slot0
