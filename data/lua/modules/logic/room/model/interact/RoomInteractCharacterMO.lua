module("modules.logic.room.model.interact.RoomInteractCharacterMO", package.seeall)

slot0 = pureTable("RoomInteractCharacterMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.heroId
	slot0.use = slot1.use
	slot0.heroMO = HeroModel.instance:getByHeroId(slot0.id)
	slot0.heroId = slot0.heroMO.heroId
	slot0.skinId = slot0.heroMO.skin
	slot0.heroConfig = HeroConfig.instance:getHeroCO(slot0.heroId)
	slot0.skinConfig = SkinConfig.instance:getSkinCo(slot0.skinId)
end

return slot0
