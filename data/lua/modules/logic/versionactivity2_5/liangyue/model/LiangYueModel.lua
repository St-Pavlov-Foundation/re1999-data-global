module("modules.logic.versionactivity2_5.liangyue.model.LiangYueModel", package.seeall)

slot0 = class("LiangYueModel", BaseModel)

function slot0.onInit(slot0)
	slot0._actInfoDic = {}
	slot0._afterGameEpisodeDic = {}
end

function slot0.reInit(slot0)
	slot0._actInfoDic = {}
end

function slot0.onGetActInfo(slot0, slot1)
	slot3 = nil

	if not slot0._actInfoDic[slot1.activityId] then
		slot0._actInfoDic[slot2] = {}
	else
		tabletool.clear(slot0._actInfoDic[slot2])
	end

	if not slot1.episodes or #slot4 <= 0 then
		return
	end

	for slot8, slot9 in ipairs(slot4) do
		slot10 = nil

		if LiangYueConfig.instance:getEpisodeConfigByActAndId(slot2, slot9.episodeId) == nil then
			logError("episodeConfig not exist id: " .. slot9.episodeId)
		elseif slot3[slot9.episodeId] then
			logError("episodeId has exist id: " .. slot9.episodeId)
		else
			slot10 = LiangYueInfoMo.New()

			slot10:init(slot2, slot9.episodeId, slot9.isFinished, slot9.puzzle)

			slot3[slot9.episodeId] = slot10
		end
	end
end

function slot0.onActInfoPush(slot0, slot1)
	slot3 = nil

	if not slot0._actInfoDic[slot1.activityId] then
		slot0._actInfoDic[slot2] = {}
	else
		slot3 = slot0._actInfoDic[slot2]
	end

	if not slot1.episodes or #slot4 <= 0 then
		return
	end

	for slot8, slot9 in ipairs(slot4) do
		slot10 = nil

		if slot3[slot9.episodeId] then
			slot3[slot9.episodeId]:updateMO(slot9.isFinished, slot9.puzzle)
		else
			slot10 = LiangYueInfoMo.New()

			slot10:init(slot2, slot9.episodeId, slot9.isFinished, slot9.puzzle)

			slot3[slot9.episodeId] = slot10
		end
	end
end

function slot0.getEpisodeInfoMo(slot0, slot1, slot2)
	if not slot0._actInfoDic[slot1] then
		return nil
	end

	return slot0._actInfoDic[slot1][slot2]
end

function slot0.getActInfoDic(slot0, slot1)
	return slot0._actInfoDic[slot1]
end

function slot0.setEpisodeInfo(slot0, slot1)
	if slot0:getActInfoDic(slot1.activityId) == nil then
		return
	end

	if not slot2[slot1.episodeId] then
		LiangYueInfoMo.New():init(slot1.activityId, slot1.episodeId, true, slot1.puzzle)

		return
	end

	slot3:updateMO(true, slot1.puzzle)
end

function slot0.isEpisodeFinish(slot0, slot1, slot2)
	if not slot0:getEpisodeInfoMo(slot1, slot2) then
		return false
	end

	return slot3.isFinish
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId
end

function slot0.setCurActId(slot0, slot1)
	slot0._curActId = slot1
end

function slot0.getCurActId(slot0)
	return slot0._curActId
end

slot0.instance = slot0.New()

return slot0
