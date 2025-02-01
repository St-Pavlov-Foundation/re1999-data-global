module("modules.logic.seasonver.act166.model.Season166MO", package.seeall)

slot0 = pureTable("Season166MO")

function slot0.updateInfo(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.isFinishTeach = slot1.isFinishTeach

	slot0:updateSpotsInfo(slot1.bases)
	slot0:updateTrainsInfo(slot1.trains)
	slot0:updateTeachsInfo(slot1.teachs)
	slot0:updateInfomation(slot1.information)
	slot0:initTalentInfo(slot1.talents)

	slot0.spotHeroGroupSnapshot = Season166HeroGroupUtils.buildSnapshotHeroGroups(slot1.baseHeroGroupSnapshot)
	slot0.trainHeroGroupSnapshot = Season166HeroGroupUtils.buildSnapshotHeroGroups(slot1.trainHeroGroupSnapshot)
end

function slot0.updateInfomation(slot0, slot1)
	slot0.infoBonusDict = {}
	slot0.informationDict = {}

	for slot5 = 1, #slot1.bonusIds do
		slot0.infoBonusDict[slot1.bonusIds[slot5]] = 1
	end

	slot0:updateInfos(slot1.infos)
end

function slot0.updateInfos(slot0, slot1)
	slot2 = false

	for slot6 = 1, #slot1 do
		if not slot0.informationDict[slot1[slot6].id] then
			slot8 = Season166InfoMO.New()

			slot8:init(slot0.activityId)

			slot0.informationDict[slot7.id] = slot8
			slot2 = true
		end

		slot8:setData(slot7)
	end

	return slot2
end

function slot0.updateAnalyInfoStage(slot0, slot1, slot2)
	if slot0.informationDict[slot1] then
		slot3.stage = slot2
	end
end

function slot0.updateInfoBonus(slot0, slot1, slot2)
	if slot0.informationDict[slot1] then
		slot3.bonusStage = slot2
	end
end

function slot0.onReceiveInformationBonus(slot0, slot1)
	for slot5 = 1, #slot1 do
		slot0.infoBonusDict[slot1[slot5]] = 1
	end
end

function slot0.updateSpotsInfo(slot0, slot1)
	slot0.baseSpotInfoMap = {}

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot7 = Season166BaseSpotMO.New()

		slot7:setData(slot6)

		slot0.baseSpotInfoMap[slot6.id] = slot7
	end
end

function slot0.updateMaxScore(slot0, slot1, slot2)
	if slot0.baseSpotInfoMap[slot1] then
		slot3.maxScore = slot2
	end
end

function slot0.updateTrainsInfo(slot0, slot1)
	slot0.trainInfoMap = {}

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot7 = Season166TrainMO.New()

		slot7:setData(slot6)

		slot0.trainInfoMap[slot6.id] = slot7
	end
end

function slot0.updateTeachsInfo(slot0, slot1)
	slot0.teachInfoMap = {}

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot7 = Season166TeachMO.New()

		slot7:setData(slot6)

		slot0.teachInfoMap[slot6.id] = slot7
	end
end

function slot0.getHeroGroupSnapShot(slot0, slot1)
	if slot1 == DungeonEnum.EpisodeType.Season166Base then
		return slot0.spotHeroGroupSnapshot
	elseif slot1 == DungeonEnum.EpisodeType.Season166Train then
		return slot0.trainHeroGroupSnapshot
	end
end

function slot0.getInformationMO(slot0, slot1)
	return slot0.informationDict[slot1]
end

function slot0.isBonusGet(slot0, slot1)
	return slot0.infoBonusDict[slot1] == 1
end

function slot0.getBonusNum(slot0)
	slot2 = #(Season166Config.instance:getSeasonInfoBonuss(slot0.activityId) or {})

	for slot8, slot9 in ipairs(slot1) do
		if slot9.analyCount <= slot0:getInfoAnalyCount() then
			slot3 = 0 + 1
		end
	end

	return slot3, slot2
end

function slot0.getInfoAnalyCount(slot0)
	for slot5, slot6 in pairs(slot0.informationDict) do
		if slot6:hasAnaly() then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.initTalentInfo(slot0, slot1)
	slot0.talentMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0.talentMap[slot6.id] or Season166TalentMO.New()

		slot7:setData(slot6)

		slot0.talentMap[slot6.id] = slot7
	end
end

function slot0.updateTalentInfo(slot0, slot1)
	if not slot0.talentMap[slot1.id] then
		logError("talent not init" .. slot1.id)
	end

	slot2:setData(slot1)
end

function slot0.setTalentSkillIds(slot0, slot1, slot2)
	slot3 = slot0:getTalentMO(slot1)

	slot3:updateSkillIds(slot2)

	return #slot3.skillIds < #slot2
end

function slot0.getTalentMO(slot0, slot1)
	if not slot0.talentMap[slot1] then
		logError("dont exist TalentMO" .. slot1)
	end

	return slot2
end

function slot0.isTrainPass(slot0, slot1)
	if slot0.trainInfoMap[slot1] then
		return slot2.passCount > 0
	end

	return false
end

function slot0.setSpotBaseEnter(slot0, slot1, slot2)
	if slot0.baseSpotInfoMap[slot1] then
		slot3.isEnter = slot2
	end
end

return slot0
