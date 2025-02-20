module("modules.logic.versionactivity1_4.act131.model.Activity131Model", package.seeall)

slot0 = class("Activity131Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._curEpisodeId = 0
	slot0._interactInfos = {}
	slot0.curMaplogDic = {}
end

function slot0.updateInfo(slot0, slot1)
	slot0:initInfo(slot1)
end

function slot0.setInfos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = Activity131LevelInfoMo.New()

		slot7:init(slot6)

		slot0._interactInfos[slot6.episodeId] = slot7
	end
end

function slot0.resetInfos(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		slot8 = Activity131LevelInfoMo.New()

		slot8:init(slot7)

		slot0._interactInfos[slot7.episodeId] = slot8
	end
end

function slot0.updateInfos(slot0, slot1)
	if slot0._interactInfos[slot1.episodeId] then
		slot0._interactInfos[slot1.episodeId]:updateInfo(slot1)
	else
		slot2 = Activity131LevelInfoMo.New()

		slot2:init(slot1)

		slot0._interactInfos[slot1.episodeId] = slot2
	end
end

function slot0.updateProgress(slot0, slot1, slot2)
	if slot0._interactInfos and slot0._interactInfos[slot1] then
		slot0._interactInfos[slot1].progress = slot2 < Activity131Enum.ProgressType.Finished and slot2 or Activity131Enum.ProgressType.Finished

		return
	end

	logError("请求了不存在的关卡进度!")
end

function slot0.refreshLogDics(slot0)
	slot2 = 0

	if slot0:getCurMapInfo() then
		slot0.curMaplogDic = {}

		for slot6, slot7 in ipairs(slot1.act131Elements) do
			if slot7.index ~= 0 then
				for slot12 = 1, slot8 do
					if slot7.typeList[slot12] == Activity131Enum.ElementType.LogStart then
						if not slot0.curMaplogDic[slot7.paramList[slot12]] then
							slot0.curMaplogDic[slot2] = {}
						end
					elseif slot13 == Activity131Enum.ElementType.Dialog then
						if slot2 ~= 0 and slot0.curMaplogDic[slot2] then
							slot20 = slot14

							for slot19, slot20 in pairs(Activity131Config.instance:getActivity131DialogGroup(tonumber(slot20))) do
								table.insert(slot0.curMaplogDic[slot2], slot20)
							end
						end
					elseif slot13 == Activity131Enum.ElementType.LogEnd then
						if slot0.curMaplogDic[slot2] then
							table.sort(slot0.curMaplogDic[slot2], function (slot0, slot1)
								if slot0.id ~= slot1.id then
									return slot0.id < slot1.id
								else
									return slot0.stepId < slot1.stepId
								end
							end)
						end

						slot2 = 0
					end
				end
			end
		end
	end
end

function slot0.getLogCategortList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.curMaplogDic) do
		table.insert(slot1, {
			logType = slot5
		})
	end

	return slot1
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

	return slot0._interactInfos[slot1].progress == Activity131Enum.ProgressType.Finished
end

function slot0.getEpisodeProgress(slot0, slot1)
	if not slot0._interactInfos or not slot0._interactInfos[slot1] then
		return Activity131Enum.ProgressType.BeforeStory
	end

	return slot0._interactInfos[slot1].progress
end

function slot0.getEpisodeElements(slot0, slot1)
	if not slot0._interactInfos or not slot0._interactInfos[slot1] then
		return {}
	end

	return slot0._interactInfos[slot1].act131Elements
end

function slot0.getEpisodeCurSceneIndex(slot0, slot1)
	slot2 = 1

	for slot7, slot8 in ipairs(slot0:getInfo(slot1).act131Elements) do
		if slot8.isFinish and slot8.typeList[slot8.index] == Activity131Enum.ElementType.ChangeScene then
			slot2 = tonumber(string.split(slot8.config.param, "#")[slot8.index])
		end
	end

	return slot2
end

function slot0.getCurMapId(slot0)
	return slot0:getCurMapConfig().mapId
end

function slot0.getCurMapConfig(slot0)
	return Activity131Config.instance:getActivity131EpisodeCo(VersionActivity1_4Enum.ActivityId.Role6, slot0._curEpisodeId)
end

function slot0.isEpisodeUnlock(slot0, slot1)
	return slot0:getInfo(slot1) and next(slot2)
end

function slot0.getEpisodeState(slot0, slot1)
	if not slot0._interactInfos or not slot0._interactInfos[slot1] then
		return 0
	end

	return slot0._interactInfos[slot1].state
end

function slot0.getCurMapInfo(slot0)
	return slot0:getInfo(slot0._curEpisodeId)
end

function slot0.getCurMapElementInfo(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getCurMapInfo().act131Elements) do
		if slot7.elementId == slot1 then
			return slot7
		end
	end
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId
end

function slot0.getEpisodeTaskTip(slot0, slot1)
	slot3 = 0
	slot4 = 0
	slot5 = 0

	for slot9, slot10 in ipairs(slot0:getInfo(slot1).act131Elements) do
		for slot14, slot15 in ipairs(slot10.typeList) do
			if slot15 == Activity131Enum.ElementType.TaskTip and slot14 <= slot10.index then
				slot17 = string.splitToNumber(string.split(slot10.config.param, "#")[slot14], "_")

				if slot5 < slot10.elementId then
					slot5 = slot10.elementId
					slot3 = slot17[1]
					slot4 = slot17[2]
				end
			end
		end
	end

	return slot3, slot4
end

function slot0.getMaxEpisode(slot0)
	slot3 = 0

	for slot7, slot8 in pairs(Activity131Config.instance:getActivity131EpisodeCos(VersionActivity1_4Enum.ActivityId.Role6)) do
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

function slot0.setSelectLogType(slot0, slot1)
	slot0.curSelectLogType = slot1

	Activity131Controller.instance:dispatchEvent(Activity131Event.SelectCategory)
end

function slot0.getSelectLogType(slot0)
	return slot0.curSelectLogType
end

function slot0.getLog(slot0)
	if slot0.curSelectLogType and slot0.curSelectLogType ~= 0 then
		return slot0.curMaplogDic and slot0.curMaplogDic[slot0.curSelectLogType] or {}
	end

	return {}
end

function slot0.getTotalEpisodeCount(slot0)
	return #Activity131Config.instance:getActivity131EpisodeCos(VersionActivity1_4Enum.ActivityId.Role6)
end

slot0.instance = slot0.New()

return slot0
