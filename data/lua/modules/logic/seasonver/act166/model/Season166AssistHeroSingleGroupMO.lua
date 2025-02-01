module("modules.logic.seasonver.act166.model.Season166AssistHeroSingleGroupMO", package.seeall)

slot0 = class("Season166AssistHeroSingleGroupMO", Season166HeroSingleGroupMO)

function slot0.ctor(slot0)
	slot0.id = nil
	slot0.heroUid = nil
	slot0.heroId = nil
	slot0._heroMo = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.heroUid = 0
	slot0._heroMo = slot2.heroMO
	slot0.heroId = slot2 and slot2.heroId or 0
	slot0.userId = slot2 and slot2.userId or 0
	slot0.pickAssistHeroMO = slot2
	slot0.isAssist = true
end

function slot0.getHeroMO(slot0)
	return slot0._heroMo
end

function slot0.isTrial(slot0)
	return true
end

return slot0
