module("modules.logic.room.model.critter.RoomTrainCritterMO", package.seeall)

slot0 = pureTable("RoomTrainCritterMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.critterMO = CritterModel.instance:getCritterMOByUid(slot0.id)
	slot0.heroId = slot0.heroMO.heroId
	slot0.skinId = slot0.heroMO.skin
	slot0.heroConfig = HeroConfig.instance:getHeroCO(slot0.heroId)
	slot0.skinConfig = SkinConfig.instance:getSkinCo(slot0.skinId)
end

return slot0
