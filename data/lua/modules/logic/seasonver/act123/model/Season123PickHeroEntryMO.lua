module("modules.logic.seasonver.act123.model.Season123PickHeroEntryMO", package.seeall)

slot0 = pureTable("Season123PickHeroEntryMO")

function slot0.ctor(slot0, slot1)
	slot0.id = slot1
	slot0.heroMO = nil
	slot0.isSupport = false
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.heroId = slot2
	slot0.heroUid = slot1
	slot0.heroMO = HeroModel.instance:getById(slot0.heroUid)
end

function slot0.getIsEmpty(slot0)
	return slot0.heroUid == nil or slot0.heroUid == 0
end

function slot0.updateByPickMO(slot0, slot1)
	slot0.heroUid = slot1.uid
	slot0.heroId = slot1.heroId
	slot0.skinId = slot1.skin
	slot0.isSupport = false
	slot0.heroMO = HeroModel.instance:getById(slot0.heroUid)
end

function slot0.updateByPickAssistMO(slot0, slot1)
	slot0.heroUid = slot1.id
	slot0.heroId = slot1.heroMO.heroId
	slot0.skinId = slot1.heroMO.skin
	slot0.isSupport = true
	slot0.heroMO = slot1.heroMO
end

function slot0.updateByHeroMO(slot0, slot1, slot2)
	slot0.heroId = slot1.heroId
	slot0.heroUid = slot1.uid
	slot0.skinId = slot1.skin
	slot0.heroMO = slot1
	slot0.isSupport = slot2
end

function slot0.setEmpty(slot0)
	slot0.heroUid = nil
	slot0.heroId = nil
	slot0.heroMO = nil
	slot0.skinId = nil
	slot0.isSupport = false
end

return slot0
