module("modules.logic.versionactivity2_2.eliminate.model.EliminateMapModel", package.seeall)

slot0 = class("EliminateMapModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.isPlayingClickAnimation = false
end

function slot0.getChapterStatus(slot0, slot1)
	if not slot0:checkChapterIsUnlock(slot1) then
		return EliminateMapEnum.ChapterStatus.Lock
	end

	return EliminateMapEnum.ChapterStatus.Normal
end

function slot0.isFirstEpisode(slot0, slot1)
	return EliminateOutsideModel.instance:getChapterList()[lua_eliminate_episode.configDict[slot1].chapterId][1].id == slot1
end

function slot0.getEpisodeConfig(slot0, slot1)
	return lua_eliminate_episode.configDict[slot1]
end

function slot0.getLastCanFightEpisodeMo(slot0, slot1)
	for slot7, slot8 in ipairs(EliminateOutsideModel.instance:getChapterList()[slot1]) do
		if slot8.star == 0 then
			return slot8
		end
	end

	return slot3[#slot3]
end

function slot0.getEpisodeList(slot0, slot1)
	return EliminateOutsideModel.instance:getChapterList()[slot1]
end

function slot0.checkChapterIsUnlock(slot0, slot1)
	if not EliminateOutsideModel.instance:getChapterList()[slot1] or #slot3 == 0 then
		return false
	end

	return slot3[1].config.preEpisode == 0 or EliminateOutsideModel.instance:hasPassedEpisode(slot4.preEpisode)
end

function slot0.getLastCanFightChapterId(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(EliminateOutsideModel.instance:getChapterList()) do
		if slot0:checkChapterIsUnlock(slot6) then
			slot1 = slot6
		end
	end

	return slot1
end

function slot0.getChapterNum()
	return #uv0.getChapterConfigList()
end

function slot0.getChapterConfigList()
	return EliminateConfig.instance:getNormalChapterList()
end

function slot0.setPlayingClickAnimation(slot0, slot1)
	slot0.isPlayingClickAnimation = slot1
end

function slot0.checkIsPlayingClickAnimation(slot0)
	return slot0.isPlayingClickAnimation
end

slot0.instance = slot0.New()

return slot0
