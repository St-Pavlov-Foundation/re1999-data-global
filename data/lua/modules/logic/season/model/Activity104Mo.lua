module("modules.logic.season.model.Activity104Mo", package.seeall)

slot0 = pureTable("Activity104Mo")

function slot0.ctor(slot0)
	slot0.activityId = 0
	slot0.activity104Items = {}
	slot0.episodes = {}
	slot0.retails = {}
	slot0.specials = {}
	slot0.unlockEquipIndexs = {}
	slot0.optionalEquipCount = 0
	slot0.heroGroupSnapshot = {}
	slot0.tempHeroGroupSnapshot = {}
	slot0.heroGroupSnapshotSubId = 1
	slot0.retailStage = 1
	slot0.unlockActivity104EquipIds = {}
	slot0.activity104ItemCountDict = {}
	slot0.trialId = 0
	slot0.isPopSummary = true
	slot0.lastMaxLayer = 0
end

function slot0.init(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.activity104Items = slot0:_buildItems(slot1.activity104Items)
	slot0.episodes = slot0:_buildEpisodes(slot1.episodes)
	slot0.retails = slot0:_buildRetails(slot1.retails)
	slot0.specials = slot0:_buildSpecials(slot1.specials)
	slot0.unlockEquipIndexs = slot0:_buildList(slot1.unlockEquipIndexs)
	slot0.optionalEquipCount = slot1.optionalEquipCount
	slot0.heroGroupSnapshot = slot0:_buildSnapshot(slot1.heroGroupSnapshot)
	slot0.heroGroupSnapshotSubId = slot1.heroGroupSnapshotSubId
	slot0.retailStage = slot1.retailStage

	slot0:setUnlockActivity104EquipIds(slot1.unlockActivity104EquipIds)

	slot0.readActivity104Story = slot1.readActivity104Story
	slot0.trialId = slot1.trial.id
	slot0.isPopSummary = slot1.preSummary.isPopSummary
	slot0.lastMaxLayer = slot1.preSummary.maxLayer

	slot0:refreshItemCount()
end

function slot0.reset(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.trialId = slot1.trial.id

	slot0:_addUnlockEquipIndexs(slot1.unlockEquipIndexs)

	slot0.optionalEquipCount = slot1.optionalEquipCount

	for slot5, slot6 in ipairs(slot1.updateEpisodes) do
		if not slot0.episodes[slot6.layer] then
			slot0.episodes[slot6.layer] = Activity104EpisodeMo.New()

			slot0.episodes[slot6.layer]:init(slot6)
		else
			slot0.episodes[slot6.layer]:reset(slot6)
		end
	end

	slot0.retails = slot0:_buildRetails(slot1.retails)

	for slot5, slot6 in ipairs(slot1.updateSpecials) do
		if not slot0.specials[slot6.layer] then
			slot0.specials[slot6.layer] = Activity104SpecialMo.New()

			slot0.specials[slot6.layer]:init(slot6)
		else
			slot0.specials[slot6.layer]:reset(slot6)
		end
	end
end

function slot0._addUnlockEquipIndexs(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.unlockEquipIndexs, slot6)
	end
end

function slot0.updateItems(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.activity104Items) do
		if slot0.activity104Items[slot6.uid] then
			slot0.activity104Items[slot6.uid]:reset(slot6)
		else
			slot7 = Activity104ItemMo.New()

			slot7:init(slot6)

			slot0.activity104Items[slot6.uid] = slot7
		end
	end

	for slot5, slot6 in ipairs(slot1.deleteItems) do
		if slot0.activity104Items[slot6.uid] then
			slot0.activity104Items[slot6.uid] = nil
		end
	end

	slot0:refreshItemCount()
end

function slot0._buildEpisodes(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		Activity104EpisodeMo.New():init(slot7)
	end

	return {
		[slot8.layer] = slot8
	}
end

function slot0._buildRetails(slot0, slot1)
	slot0.lastRetails = slot0.retails
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = Activity104RetailMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot2
end

function slot0._buildSpecials(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = Activity104SpecialMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.layer < slot1.layer
	end)

	return slot2
end

function slot0._buildItems(slot0, slot1)
	slot2 = {
		[slot7.uid] = slot8
	}

	for slot6, slot7 in ipairs(slot1) do
		Activity104ItemMo.New():init(slot7)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.itemId < slot1.itemId
	end)

	return slot2
end

function slot0._buildList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, slot7)
	end

	return slot2
end

function slot0._buildSnapshot(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = HeroGroupMO.New()
		slot9 = true

		for slot13, slot14 in ipairs(slot7.heroList) do
			if tonumber(slot14) ~= 0 then
				slot9 = false
			end

			break
		end

		if slot9 then
			slot10 = HeroGroupModel.instance:getById(1)

			if slot7.groupId == 1 and slot10 then
				slot8.id = slot7.groupId
				slot8.groupId = slot7.groupId
				slot8.name = slot10.name
				slot8.heroList = LuaUtil.deepCopy(slot10.heroList)
				slot8.aidDict = LuaUtil.deepCopy(slot10.aidDict)
				slot8.clothId = slot10.clothId
				slot8.equips = LuaUtil.deepCopy(slot10.equips)
				slot8.activity104Equips = LuaUtil.deepCopy(slot10.activity104Equips)
			else
				slot8.id = slot7.groupId
				slot8.groupId = slot7.groupId
				slot8.name = ""
				slot8.heroList = {
					"0",
					"0",
					"0",
					"0"
				}
				slot8.clothId = slot10.clothId
				slot8.equips = {}

				for slot14 = 0, 3 do
					slot8:updatePosEquips({
						index = slot14,
						equipUid = {
							"0"
						}
					})
				end

				slot8.activity104Equips = {}

				for slot14 = 0, 3 do
					slot8:updatePosEquips({
						index = slot14,
						equipUid = {
							"0"
						}
					})
				end

				slot11 = HeroGroupActivity104EquipMo.New()

				slot11:init({
					index = 4,
					equipUid = {
						"0"
					}
				})

				slot8.activity104Equips[4] = slot11
			end
		else
			slot8:init(slot7)
		end

		slot8:clearAidHero()

		slot2[slot7.groupId] = slot8
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.groupId < slot1.groupId
	end)

	return slot2
end

function slot0.replaceRetails(slot0, slot1)
	slot0.retails = slot0:_buildRetails(slot1)
end

function slot0.getLastRetails(slot0)
	slot0.lastRetails = nil

	return slot0.lastRetails
end

function slot0.setUnlockActivity104EquipIds(slot0, slot1)
	slot0.unlockActivity104EquipIds = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.unlockActivity104EquipIds[slot6] = slot6
	end
end

function slot0.markStory(slot0, slot1)
	slot0.readActivity104Story = slot1
end

function slot0.markEpisodeAfterStory(slot0, slot1)
	if slot0.episodes[slot1] then
		slot2:markStory(true)
	end
end

function slot0.setBattleFinishLayer(slot0, slot1)
	if slot1 > 0 then
		slot0.battleFinishLayer = slot1
	end
end

function slot0.getBattleFinishLayer(slot0)
	return slot0.battleFinishLayer
end

function slot0.refreshItemCount(slot0)
	slot0.activity104ItemCountDict = {}

	if slot0.activity104Items then
		for slot4, slot5 in pairs(slot0.activity104Items) do
			if slot0.activity104ItemCountDict[slot5.itemId] then
				slot0.activity104ItemCountDict[slot5.itemId] = slot0.activity104ItemCountDict[slot5.itemId] + 1
			else
				slot0.activity104ItemCountDict[slot5.itemId] = 1
			end
		end
	end
end

function slot0.getItemCount(slot0, slot1)
	return slot0.activity104ItemCountDict[slot1] or 0
end

function slot0.getSnapshotHeroGroupBySubId(slot0, slot1)
	slot2 = slot0.heroGroupSnapshot[slot1 or slot0.heroGroupSnapshotSubId]

	if HeroGroupModel.instance.battleConfig and (#string.splitToNumber(slot3.aid, "#") > 0 or slot3.trialLimit > 0) then
		return slot0.tempHeroGroupSnapshot[slot1]
	end

	return slot2
end

function slot0.getRealHeroGroupBySubId(slot0, slot1)
	return slot0.heroGroupSnapshot[slot1 or slot0.heroGroupSnapshotSubId]
end

function slot0.getIsPopSummary(slot0)
	return slot0.isPopSummary
end

function slot0.setIsPopSummary(slot0, slot1)
	slot0.isPopSummary = slot1
end

function slot0.getLastMaxLayer(slot0)
	return slot0.lastMaxLayer
end

function slot0.getTrialId(slot0)
	return slot0.trialId
end

function slot0.buildHeroGroup(slot0)
	if HeroGroupModel.instance.battleConfig and (#string.splitToNumber(slot1.aid, "#") > 0 or slot1.trialLimit > 0) then
		slot0.tempHeroGroupSnapshot = {}

		for slot6, slot7 in ipairs(slot0.heroGroupSnapshot) do
			slot0.tempHeroGroupSnapshot[slot6] = HeroGroupModel.instance:generateTempGroup(slot7)

			slot0.tempHeroGroupSnapshot[slot6]:setTemp(false)
		end
	end
end

return slot0
