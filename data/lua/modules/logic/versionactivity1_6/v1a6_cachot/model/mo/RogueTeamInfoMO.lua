module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueTeamInfoMO", package.seeall)

slot0 = pureTable("RogueTeamInfoMO")

function slot0.init(slot0, slot1)
	slot0.groupIdx = slot1.groupIdx
	slot0._allHeros = {}
	slot0.fightHeros = {}

	for slot5, slot6 in ipairs(slot1.fightHeros) do
		slot7 = HeroMo.New()

		slot7:update(slot6)
		table.insert(slot0.fightHeros, slot7)

		slot0._allHeros[slot6.heroId] = true
	end

	slot0.supportHeros = {}

	for slot5, slot6 in ipairs(slot1.supportHeros) do
		slot7 = HeroMo.New()

		slot7:update(slot6)
		table.insert(slot0.supportHeros, slot7)

		slot0._allHeros[slot6.heroId] = true
	end

	slot0.lifes = {}
	slot0.lifeMap = {}

	for slot5, slot6 in ipairs(slot1.lifes) do
		slot7 = RogueHeroLifeMO.New()

		slot7:init(slot6)
		table.insert(slot0.lifes, slot7)

		slot0.lifeMap[slot7.heroId] = slot7
	end

	slot0.groupInfos = {}
	slot0.groupInfoMap = {}

	for slot5, slot6 in ipairs(slot1.groupInfos) do
		slot7 = RogueGroupInfoMO.New()

		slot7:init(slot6)
		table.insert(slot0.groupInfos, slot7)

		slot0.groupInfoMap[slot7.id] = slot7
	end

	slot5 = slot1.groupBoxStar

	slot0:updateGroupBoxStar(slot5)

	slot0.equipUids = {}
	slot0.equipUidsMap = {}

	for slot5, slot6 in ipairs(slot1.equipUids) do
		table.insert(slot0.equipUids, slot6)

		slot0.equipUidsMap[slot6] = true
	end
end

function slot0.hasEquip(slot0, slot1)
	return slot0.equipUidsMap[slot1]
end

function slot0.updateGroupBoxStar(slot0, slot1)
	slot0.groupBoxStar = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.groupBoxStar, slot6)
	end
end

function slot0.getHeroHp(slot0, slot1)
	return slot0.lifeMap[slot1]
end

function slot0.getCurGroupInfo(slot0)
	return slot0.groupInfoMap[slot0.groupIdx]
end

function slot0.getGroupInfos(slot0)
	slot1 = {}

	for slot5 = 1, 4 do
		if not slot0.groupInfos[slot5] then
			RogueGroupInfoMO.New():init({
				id = slot5,
				heroList = {},
				equips = {}
			})
		end

		table.insert(slot1, slot6)
	end

	return slot1
end

function slot0.getAllHeroIdsMap(slot0)
	return slot0._allHeros
end

function slot0.getAllHeroUids(slot0)
	for slot5, slot6 in ipairs(slot0.fightHeros) do
		if HeroModel.instance:getByHeroId(slot6.heroId) then
			table.insert({}, slot7.uid)
		end
	end

	for slot5, slot6 in ipairs(slot0.supportHeros) do
		if HeroModel.instance:getByHeroId(slot6.heroId) then
			table.insert(slot1, slot7.uid)
		end
	end

	return slot1
end

function slot0.getGroupHeros(slot0)
	if not slot0:getCurGroupInfo() then
		return {}
	end

	for slot6, slot7 in ipairs(slot1.heroList) do
		slot9 = HeroSingleGroupMO.New()

		if HeroModel.instance:getById(slot7) then
			slot9.id = slot8.heroId
			slot9.heroUid = slot8.uid
		end

		table.insert(slot2, slot9)
	end

	return slot2
end

function slot0.getGroupLiveHeros(slot0)
	if not slot0:getCurGroupInfo() then
		return {}
	end

	for slot6, slot7 in ipairs(slot1.heroList) do
		slot9 = HeroSingleGroupMO.New()

		if HeroModel.instance:getById(slot7) and slot0:getHeroHp(slot8.heroId) and slot10.life > 0 then
			slot9.id = slot8.heroId
			slot9.heroUid = slot8.uid
		end

		table.insert(slot2, slot9)
	end

	return slot2
end

function slot0.getGroupEquips(slot0)
	if not slot0:getCurGroupInfo() then
		return {}
	end

	for slot6, slot7 in ipairs(slot1.equips) do
		slot2[slot6] = EquipModel.instance:getEquip(slot7.equipUid[1])
	end

	return slot2
end

function slot0.getFightHeros(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.fightHeros) do
		slot8 = HeroSingleGroupMO.New()

		if HeroModel.instance:getByHeroId(slot6.heroId) then
			slot8.id = slot7.heroId
			slot8.heroUid = slot7.uid
		end

		table.insert(slot1, slot8)
	end

	return slot1
end

function slot0.getSupportHeros(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.supportHeros) do
		if HeroModel.instance:getByHeroId(slot6.heroId) then
			slot8 = HeroSingleGroupMO.New()
			slot8.id = slot7.heroId
			slot8.heroUid = slot7.uid
			slot8._heroMO = slot7

			table.insert(slot1, slot8)
		end
	end

	return slot1
end

function slot0.getSupportLiveHeros(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.supportHeros) do
		if HeroModel.instance:getByHeroId(slot6.heroId) and slot0:getHeroHp(slot7.heroId) and slot8.life > 0 then
			slot9 = HeroSingleGroupMO.New()
			slot9.id = slot7.heroId
			slot9.heroUid = slot7.uid
			slot9._heroMO = slot7
			slot9._hp = slot8.life

			table.insert(slot1, slot9)
		end
	end

	return slot1
end

return slot0
