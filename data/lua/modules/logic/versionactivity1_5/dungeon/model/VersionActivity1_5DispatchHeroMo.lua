module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DispatchHeroMo", package.seeall)

slot0 = pureTable("VersionActivity1_5DispatchVersionActivity1_5DispatchHeroMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.heroId = 0
	slot0.config = nil
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.heroId = slot1.heroId
	slot0.config = slot1.config
	slot0.level = slot1.level
	slot0.rare = slot0.config.rare
end

function slot0.isDispatched(slot0)
	return VersionActivity1_5DungeonModel.instance:isDispatched(slot0.heroId)
end

return slot0
