module("modules.logic.roleactivity.model.RoleActivityLevelMo", package.seeall)

slot0 = pureTable("RoleActivityLevelMo")

function slot0.init(slot0, slot1)
	slot0.config = slot1
	slot0.isUnlock = DungeonModel.instance:isUnlock(slot1)
	slot0.star = DungeonModel.instance:getEpisodeInfo(slot1.id) and slot2.star or 0
end

function slot0.update(slot0)
	slot0.isUnlock = DungeonModel.instance:isUnlock(slot0.config)
	slot0.star = DungeonModel.instance:getEpisodeInfo(slot0.config.id) and slot1.star or 0
end

return slot0
