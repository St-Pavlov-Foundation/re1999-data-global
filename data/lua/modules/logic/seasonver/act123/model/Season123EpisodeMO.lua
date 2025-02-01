module("modules.logic.seasonver.act123.model.Season123EpisodeMO", package.seeall)

slot0 = pureTable("Season123EpisodeMO")

function slot0.init(slot0, slot1)
	slot0.layer = slot1.layer
	slot0.state = slot1.state or 0
	slot0.round = slot1.round or 0
	slot0.effectMainCelebrityEquipIds = slot1.effectMainCelebrityEquipIds or {}

	slot0:initHeroes(slot1.heroInfos)
end

function slot0.update(slot0, slot1)
	slot0.state = slot1.state
	slot0.round = slot1.round
	slot0.effectMainCelebrityEquipIds = slot1.effectMainCelebrityEquipIds

	slot0:updateHeroes(slot1.heroInfos)
end

function slot0.isFinished(slot0)
	return slot0.state == 1
end

function slot0.initHeroes(slot0, slot1)
	slot0.heroes = {}
	slot0.heroesMap = {}

	if not slot1 then
		return
	end

	for slot5 = 1, #slot1 do
		slot7 = Season123HeroMO.New()

		slot7:init(slot1[slot5])
		table.insert(slot0.heroes, slot7)

		slot0.heroesMap[slot7.heroUid] = slot7
	end
end

function slot0.updateHeroes(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5 = 1, #slot1 do
		if not slot0.heroesMap[slot1[slot5].heroUid] then
			slot7 = Season123HeroMO.New()

			slot7:init(slot6)
			table.insert(slot0.heroes, slot7)

			slot0.heroesMap[slot7.heroUid] = slot7
		else
			slot7:update(slot6)
		end
	end
end

return slot0
