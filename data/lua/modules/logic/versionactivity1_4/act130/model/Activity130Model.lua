module("modules.logic.versionactivity1_4.act130.model.Activity130Model", package.seeall)

slot0 = class("Activity130Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._curEpisodeId = 0
	slot0._interactInfos = {}
	slot0._collectRewardSates = {}
end

function slot0.updateInfo(slot0, slot1)
	slot0:initInfo(slot1)
end

function slot0.setInfos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = Activity130LevelInfoMo.New()

		slot7:init(slot6)

		slot0._interactInfos[slot6.episodeId] = slot7
	end
end

function slot0.resetInfos(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		slot8 = Activity130LevelInfoMo.New()

		slot8:init(slot7)

		slot0._interactInfos[slot7.episodeId] = slot8
	end
end

function slot0.updateInfos(slot0, slot1)
	if slot0._interactInfos[slot1.episodeId] then
		slot0._interactInfos[slot1.episodeId]:updateInfo(slot1)
	else
		slot2 = Activity130LevelInfoMo.New()

		slot2:init(slot1)

		slot0._interactInfos[slot1.episodeId] = slot2
	end
end

function slot0.updateProgress(slot0, slot1, slot2)
	if slot0._interactInfos and slot0._interactInfos[slot1] then
		slot0._interactInfos[slot1].progress = slot2 < Activity130Enum.ProgressType.Finished and slot2 or Activity130Enum.ProgressType.Finished

		return
	end

	logError("请求了不存在的关卡进度!")
end

function slot0.getInfos(slot0)
	return slot0._interactInfos
end

function slot0.getInfo(slot0, slot1)
	if not slot0._interactInfos then
		return {}
	end

	return slot0._interactInfos[slot1]
end

function slot0.isEpisodeFinished(slot0, slot1)
	if not slot0._interactInfos or not slot0._interactInfos[slot1] then
		return false
	end

	return slot0._interactInfos[slot1].progress == Activity130Enum.ProgressType.Finished
end

function slot0.getEpisodeState(slot0, slot1)
	if not slot0._interactInfos or not slot0._interactInfos[slot1] then
		return 0
	end

	return slot0._interactInfos[slot1].state
end

function slot0.getEpisodeProgress(slot0, slot1)
	if not slot0._interactInfos or not slot0._interactInfos[slot1] then
		return Activity130Enum.ProgressType.BeforeStory
	end

	return slot0._interactInfos[slot1].progress
end

function slot0.getEpisodeElements(slot0, slot1)
	if not slot0._interactInfos or not slot0._interactInfos[slot1] then
		return {}
	end

	return slot0._interactInfos[slot1].act130Elements
end

function slot0.getEpisodeCurSceneIndex(slot0, slot1)
	slot2 = 1

	for slot7, slot8 in ipairs(slot0:getInfo(slot1).act130Elements) do
		if slot8.isFinish and slot8.typeList[slot8.index] == Activity130Enum.ElementType.ChangeScene then
			slot2 = tonumber(string.split(slot8.config.param, "#")[slot8.index])
		end
	end

	return slot2
end

function slot0.getCurMapId(slot0)
	return slot0:getCurMapConfig().mapId
end

function slot0.getCurMapConfig(slot0)
	return Activity130Config.instance:getActivity130EpisodeCo(VersionActivity1_4Enum.ActivityId.Role37, slot0._curEpisodeId)
end

function slot0.isEpisodeUnlock(slot0, slot1)
	return slot0:getInfo(slot1) and next(slot2)
end

function slot0.getCurMapInfo(slot0)
	return slot0:getInfo(slot0._curEpisodeId)
end

function slot0.getCurMapElementInfo(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getCurMapInfo().act130Elements) do
		if slot7.elementId == slot1 then
			return slot7
		end
	end
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId or 0
end

function slot0.getEpisodeOperGroupId(slot0, slot1)
	slot3 = 0

	for slot7, slot8 in ipairs(slot0:getInfo(slot1).act130Elements) do
		for slot12, slot13 in ipairs(slot8.typeList) do
			if slot13 == Activity130Enum.ElementType.SetValue and slot12 <= slot8.index then
				slot3 = tonumber(string.splitToNumber(string.split(slot8.config.param, "#")[slot12], "_")[1])
			end
		end
	end

	return slot3
end

function slot0.getEpisodeDecryptId(slot0, slot1)
	slot3 = 0
	slot4 = false

	for slot8, slot9 in ipairs(slot0:getInfo(slot1).act130Elements) do
		for slot13, slot14 in ipairs(slot9.typeList) do
			if slot14 == Activity130Enum.ElementType.UnlockDecrypt then
				if slot13 <= slot9.index then
					slot3 = tonumber(string.split(slot9.config.param, "#")[slot13])
					slot4 = true
				elseif slot13 == slot9.index + 1 and slot3 == 0 then
					slot3 = tonumber(string.split(slot9.config.param, "#")[slot13])
				end
			end
		end
	end

	return slot3, slot4
end

function slot0.getEpisodeTaskTip(slot0, slot1)
	slot2 = slot0:getInfo(slot1)
	slot3 = slot2.tipsElementId
	slot4 = 0
	slot5 = 0
	slot6 = 0

	for slot10, slot11 in ipairs(slot2.act130Elements) do
		if slot11.elementId == slot3 or slot3 == 0 then
			for slot15, slot16 in ipairs(slot11.typeList) do
				if slot16 == Activity130Enum.ElementType.TaskTip and slot15 <= slot11.index then
					slot18 = string.splitToNumber(string.split(slot11.config.param, "#")[slot15], "_")
					slot4 = slot18[1]
					slot5 = slot18[2]
				end
			end
		end
	end

	return slot4, slot5
end

function slot0.getCollects(slot0, slot1)
	if slot0:getEpisodeOperGroupId(slot0:getCurEpisodeId()) == 0 then
		return {}
	end

	slot10 = slot4

	for slot10, slot11 in pairs(Activity130Config.instance:getActivity130OperateGroupCos(VersionActivity1_4Enum.ActivityId.Role37, slot10)) do
		if slot0:isCollectUnlock(slot3, slot11.operType) then
			table.insert(slot2, slot11.operType)
		end
	end

	return slot2
end

function slot0.isCollectUnlock(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0:getInfo(slot1).act130Elements) do
		for slot12, slot13 in ipairs(slot8.typeList) do
			if slot13 == Activity130Enum.ElementType.SetValue and slot12 <= slot8.index and slot2 == tonumber(string.splitToNumber(string.split(slot8.config.param, "#")[slot12], "_")[2]) then
				return true
			end
		end
	end

	return false
end

function slot0.getDecryptIdByGroupId(slot0, slot1)
	for slot7, slot8 in pairs(Activity130Config.instance:getActivity130DecryptCos(VersionActivity1_4Enum.ActivityId.Role37)) do
		if slot8.operGroupId == slot1 then
			return slot8.puzzleId
		end
	end

	return 0
end

function slot0.getElementInfoByDecryptId(slot0, slot1, slot2)
	slot3 = slot2 and slot2 or slot0:getCurEpisodeId()

	for slot8, slot9 in pairs(slot0:getInfo(slot2).act130Elements) do
		for slot13, slot14 in pairs(slot9.typeList) do
			if slot14 == Activity130Enum.ElementType.UnlockDecrypt then
				return slot9
			end
		end
	end
end

function slot0.getMaxEpisode(slot0)
	slot3 = 0

	for slot7, slot8 in pairs(Activity130Config.instance:getActivity130EpisodeCos(VersionActivity1_4Enum.ActivityId.Role37)) do
		slot3 = slot8.episodeId < slot3 and slot3 or slot8.episodeId
	end

	return slot3
end

function slot0.getMaxUnlockEpisode(slot0)
	slot1 = slot0:getCurEpisodeId()

	for slot5, slot6 in pairs(slot0._interactInfos) do
		slot1 = slot6.episodeId < slot1 and slot1 or slot6.episodeId
	end

	return slot1
end

function slot0.getTotalEpisodeCount(slot0)
	return #Activity130Config.instance:getActivity130EpisodeCos(VersionActivity1_4Enum.ActivityId.Role37)
end

function slot0.setNewFinishEpisode(slot0, slot1)
	slot0._newFinishEpisode = slot1
end

function slot0.getNewFinishEpisode(slot0)
	return slot0._newFinishEpisode or -1
end

function slot0.getNewUnlockEpisode(slot0)
	return slot0._newUnlockEpisode or -1
end

function slot0.setNewUnlockEpisode(slot0, slot1)
	slot0._newUnlockEpisode = slot1
end

function slot0.setNewCollect(slot0, slot1, slot2)
	slot0._collectRewardSates[slot1] = slot2
end

function slot0.getNewCollectState(slot0, slot1)
	return slot0._collectRewardSates[slot1]
end

function slot0.getGameChallengeNum(slot0, slot1)
	return slot0:getInfo(slot1).challengeNum
end

function slot0.updateChallengeNum(slot0, slot1, slot2)
	if slot0:getInfo(slot1) and slot3.updateChallengeNum then
		slot3:updateChallengeNum(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
