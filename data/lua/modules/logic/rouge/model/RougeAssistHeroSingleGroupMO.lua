module("modules.logic.rouge.model.RougeAssistHeroSingleGroupMO", package.seeall)

slot0 = pureTable("RougeAssistHeroSingleGroupMO")

function slot0.ctor(slot0)
	slot0.id = nil
	slot0.heroUid = nil
	slot0.heroId = nil
	slot0._heroMo = nil
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.heroUid = slot2 or "0"
	slot0._heroMo = slot3
	slot0.heroId = slot3 and slot3.heroId or 0
end

function slot0.getHeroMO(slot0)
	return slot0._heroMo
end

function slot0.isTrial(slot0)
	return true
end

return slot0
