module("modules.logic.dungeon.model.RoleStoryDispatchHeroMo", package.seeall)

slot0 = pureTable("RoleStoryDispatchHeroMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.heroId = 0
	slot0.config = nil
	slot0.storyId = 0
	slot0.isEffect = false
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1.id
	slot0.heroId = slot1.heroId
	slot0.config = slot1.config
	slot0.level = slot1.level
	slot0.rare = slot0.config.rare
	slot0.storyId = slot2
	slot0.isEffect = slot3
end

function slot0.isDispatched(slot0)
	return RoleStoryModel.instance:isHeroDispatching(slot0.heroId, slot0.storyId)
end

function slot0.isEffectHero(slot0)
	return slot0.isEffect
end

return slot0
