module("modules.logic.versionactivity1_2.yaxian.model.YaXianModel", package.seeall)

slot0 = class("YaXianModel", BaseModel)

function slot0.onInit(slot0)
	slot0.actId = nil
	slot0.hasGetBonusIdDict = nil
end

function slot0.reInit(slot0)
	slot0.actId = nil
	slot0.hasGetBonusIdDict = nil
end

function slot0.updateInfo(slot0, slot1)
	slot0.actId = slot1.activityId

	slot0:updateGetBonusId(slot1.hasGetBonusIds)
	slot0:updateEpisodeInfo(slot1.episodes)

	if slot1:HasField("map") then
		slot0:updateCurrentMapInfo(slot1.map)
	else
		slot0.currentMapMo = nil
	end
end

function slot0.updateCurrentMapInfo(slot0, slot1)
	slot0.currentMapMo = YaXianMapMo.New()

	slot0.currentMapMo:init(slot0.actId, slot1)
end

function slot0.getCurrentMapInfo(slot0)
	return slot0.currentMapMo
end

function slot0.sortEpisodeMoFunc(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.updateEpisodeInfo(slot0, slot1)
	slot0.episodeList = slot0.episodeList or {}
	slot0.chapterId2EpisodeListDict = slot0.chapterId2EpisodeListDict or {}

	for slot5, slot6 in ipairs(slot1) do
		if slot0:getEpisodeMo(slot6.id) then
			slot7:updateData(slot6)
		else
			slot7 = YaXianEpisodeMo.New()

			slot7:init(slot0.actId, slot6)
			slot0:addToChapterId2EpisodeListDict(slot7)
			table.insert(slot0.episodeList, slot7)
		end
	end

	table.sort(slot0.episodeList, uv0.sortEpisodeMoFunc)

	for slot5, slot6 in pairs(slot0.chapterId2EpisodeListDict) do
		table.sort(slot6, uv0.sortEpisodeMoFunc)
	end

	slot0:updateScore()
	slot0:calculateLastCanFightEpisodeMo()
	slot0:updateTrialMaxTemplateId()
	YaXianController.instance:dispatchEvent(YaXianEvent.OnUpdateEpisodeInfo)
end

function slot0.addToChapterId2EpisodeListDict(slot0, slot1)
	if not slot0.chapterId2EpisodeListDict[slot1.config.chapterId] then
		slot0.chapterId2EpisodeListDict[slot2] = {}
	end

	table.insert(slot0.chapterId2EpisodeListDict[slot2], slot1)
end

function slot0.calculateLastCanFightEpisodeMo(slot0)
	for slot4, slot5 in ipairs(slot0.episodeList) do
		if slot5.star == 0 then
			slot0.lastCanFightEpisodeMo = slot5

			return
		end
	end

	slot0.lastCanFightEpisodeMo = slot0.episodeList[#slot0.episodeList]
end

function slot0.getLastCanFightEpisodeMo(slot0, slot1)
	if not slot1 then
		return slot0.lastCanFightEpisodeMo
	end

	slot3 = nil

	for slot7 = #slot0.chapterId2EpisodeListDict[slot1], 1, -1 do
		if slot2[slot7].star == 0 then
			slot3 = slot8
		elseif slot3 then
			return slot3
		else
			return slot8
		end
	end

	return slot3
end

function slot0.getEpisodeMo(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.episodeList) do
		if slot6.id == slot1 then
			return slot6
		end
	end
end

function slot0.getEpisodeList(slot0, slot1)
	return slot0.chapterId2EpisodeListDict[slot1]
end

function slot0.getChapterFirstEpisodeMo(slot0, slot1)
	return slot0:getEpisodeList(slot1) and slot2[1]
end

function slot0.chapterIsUnlock(slot0, slot1)
	return slot0:getEpisodeList(slot1) and slot2[1].id <= slot0:getLastCanFightEpisodeMo().id
end

function slot0.getScore(slot0)
	return slot0.score or 0
end

function slot0.updateGetBonusId(slot0, slot1)
	slot0.hasGetBonusIdDict = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.hasGetBonusIdDict[slot6] = true
	end

	YaXianController.instance:dispatchEvent(YaXianEvent.OnUpdateBonus)
end

function slot0.hasGetBonus(slot0, slot1)
	return slot0.hasGetBonusIdDict[slot1]
end

function slot0.updateScore(slot0)
	slot0.score = 0

	for slot4, slot5 in ipairs(slot0.episodeList) do
		slot0.score = slot0.score + slot5.star
	end
end

function slot0.updateTrialMaxTemplateId(slot0)
	slot0.maxTrialTemplateId = 1

	for slot4, slot5 in ipairs(slot0.episodeList) do
		if slot5.star > 0 and slot0.maxTrialTemplateId < slot5.config.trialTemplate then
			slot0.maxTrialTemplateId = slot5.config.trialTemplate
		end
	end
end

function slot0.getMaxTrialTemplateId(slot0)
	return slot0.maxTrialTemplateId
end

function slot0.getHeroIdAndSkinId(slot0)
	slot1 = lua_hero_trial.configDict[YaXianEnum.HeroTrialId][slot0.maxTrialTemplateId]

	return slot1.heroId, slot1.skin
end

function slot0.hadTooth(slot0, slot1)
	if slot1 == 0 then
		return true
	end

	if not YaXianConfig.instance:getToothUnlockEpisode(slot1) then
		logError("ya xian tooth unlock episode id not exist")

		return true
	end

	if not slot0:getEpisodeMo(slot2) then
		return false
	end

	return slot3.star > 0
end

function slot0.getHadToothCount(slot0)
	for slot5, slot6 in ipairs(lua_activity115_tooth.configList) do
		if slot0:hadTooth(slot6.id) then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.isFirstEpisode(slot0, slot1)
	for slot5, slot6 in pairs(slot0.chapterId2EpisodeListDict) do
		if slot6[1].id == slot1 then
			return true
		end
	end

	return false
end

function slot0.setPlayingClickAnimation(slot0, slot1)
	slot0.isPlayingClickAnimation = slot1

	YaXianController.instance:dispatchEvent(YaXianEvent.OnPlayingClickAnimationValueChange)
end

function slot0.checkIsPlayingClickAnimation(slot0)
	return slot0.isPlayingClickAnimation
end

slot0.instance = slot0.New()

return slot0
