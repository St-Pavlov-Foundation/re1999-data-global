module("modules.logic.seasonver.act123.model.Season123PickAssistMO", package.seeall)

slot0 = pureTable("Season123PickAssistMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.heroUid
	slot0.assistMO = Season123AssistHeroMO.New()

	slot0.assistMO:init(slot1)

	slot0.heroMO = Season123HeroUtils.createHeroMOByAssistMO(slot0.assistMO, true)
end

function slot0.getId(slot0)
	return slot0.id
end

function slot0.isSameHero(slot0, slot1)
	slot2 = false

	if slot1 then
		slot2 = slot0:getId() == slot1:getId()
	end

	return slot2
end

function slot0.getPlayerInfo(slot0)
	return {
		userId = slot0.assistMO.userId,
		name = slot0.assistMO.name,
		level = slot0.assistMO.userLevel,
		portrait = slot0.assistMO.portrait,
		bg = slot0.assistMO.bg
	}
end

return slot0
