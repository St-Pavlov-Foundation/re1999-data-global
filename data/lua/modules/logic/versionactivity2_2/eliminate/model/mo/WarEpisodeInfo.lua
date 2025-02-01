module("modules.logic.versionactivity2_2.eliminate.model.mo.WarEpisodeInfo", package.seeall)

slot0 = pureTable("WarEpisodeInfo")

function slot0.init(slot0, slot1)
	slot0:initFromParam(slot1.id, slot1.star)
end

function slot0.initFromParam(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.star = slot2
	slot0.config = lua_eliminate_episode.configDict[slot0.id]
end

return slot0
