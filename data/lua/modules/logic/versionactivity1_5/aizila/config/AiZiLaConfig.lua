module("modules.logic.versionactivity1_5.aizila.config.AiZiLaConfig", package.seeall)

slot0 = class("AiZiLaConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._actMap = nil
	slot0._episodeConfig = nil
	slot0._episodeListDict = {}
	slot0._storyConfig = nil
	slot0._storyListDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity144_episode",
		"activity144_story",
		"activity144_task",
		"activity144_equip",
		"activity144_round",
		"activity144_event",
		"activity144_item",
		"activity144_episode_showtarget",
		"activity144_option",
		"activity144_option_result",
		"activity144_record_event",
		"activity144_buff"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity144_episode" then
		slot0._episodeConfig = slot2
	elseif slot1 == "activity144_story" then
		slot0._storyConfig = slot2
	elseif slot1 == "activity144_task" then
		slot0._taskConfig = slot2
	elseif slot1 == "activity144_equip" then
		slot0._equipConfig = slot2

		slot0:_initEquipCfg()
	elseif slot1 == "activity144_round" then
		slot0._roundConfig = slot2
	elseif slot1 == "activity144_event" then
		slot0._eventConfig = slot2
	elseif slot1 == "activity144_item" then
		slot0._itemConfig = slot2
	elseif slot1 == "activity144_episode_showtarget" then
		slot0._eqisodeShowTargetConfig = slot2
	elseif slot1 == "activity144_option" then
		slot0._optionConfig = slot2
	elseif slot1 == "activity144_option_result" then
		slot0._optionResultConfig = slot2
	elseif slot1 == "activity144_buff" then
		slot0._buffConfig = slot2
	elseif slot1 == "activity144_record_event" then
		slot0._recordEventConfig = slot2
	end
end

function slot0._get2PrimarykeyCo(slot0, slot1, slot2, slot3)
	if slot1 and slot1.configDict then
		return slot1.configDict[slot2] and slot4[slot3]
	end

	return nil
end

function slot0._findListByActId(slot0, slot1, slot2)
	if slot1 and slot1.configList then
		slot3 = {}

		for slot7, slot8 in ipairs(slot1.configList) do
			if slot8.activityId == slot2 then
				table.insert(slot3, slot8)
			end
		end

		return slot3
	end

	return nil
end

function slot0.getTaskList(slot0, slot1)
	return slot0:_findListByActId(slot0._taskConfig, slot1)
end

function slot0.getItemList(slot0)
	return slot0._itemConfig and slot0._itemConfig.configList
end

function slot0._initEquipCfg(slot0)
	slot0._equipUpLevelDict = {}
	slot0._equipTypeListDict = {}

	for slot4, slot5 in ipairs(slot0._equipConfig.configList) do
		if slot5.preEquipId == 0 then
			if not slot0._equipTypeListDict[slot5.activityId] then
				slot0._equipTypeListDict[slot6] = {}
			end

			table.insert(slot0._equipTypeListDict[slot6], slot5)
		end
	end
end

function slot0.getEquipCo(slot0, slot1, slot2)
	return slot0:_get2PrimarykeyCo(slot0._equipConfig, slot1, slot2)
end

function slot0.getEquipCoByPreId(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot0._equipConfig.configList) do
		if slot8.activityId == slot1 and slot8.preEquipId == slot2 and (slot3 == nil or slot3 == slot8.typeId) then
			return slot8
		end
	end
end

function slot0.getEquipCoTypeList(slot0, slot1)
	return slot0._equipTypeListDict and slot0._equipTypeListDict[slot1]
end

function slot0.getItemCo(slot0, slot1)
	return slot0._itemConfig and slot0._itemConfig.configDict[slot1]
end

function slot0.getEpisodeShowTargetCo(slot0, slot1)
	return slot0._eqisodeShowTargetConfig and slot0._eqisodeShowTargetConfig.configDict[slot1]
end

function slot0.getEpisodeCo(slot0, slot1, slot2)
	return slot0:_get2PrimarykeyCo(slot0._episodeConfig, slot1, slot2)
end

function slot0.getRoundCo(slot0, slot1, slot2, slot3)
	for slot8, slot9 in ipairs(slot0._roundConfig.configList) do
		if slot9.activityId == slot1 and slot9.episodeId == slot2 and slot9.round == slot3 then
			return slot9
		end
	end
end

function slot0.getPassRoundCo(slot0, slot1, slot2)
	slot4 = nil

	for slot8, slot9 in ipairs(slot0._roundConfig.configList) do
		if slot9.activityId == slot1 and slot9.episodeId == slot2 and slot9.isPass == 1 and (not slot4 or slot4.round < slot9.round) then
			slot4 = slot9
		end
	end

	return slot4
end

function slot0.getRoundList(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in ipairs(slot0._roundConfig.configList) do
		if slot9.activityId == slot1 and slot9.episodeId == slot2 then
			table.insert(slot4, slot9)
		end
	end

	return slot4
end

function slot0.getBuffCo(slot0, slot1, slot2)
	if not slot0._buffConfig then
		logError("AiZiLaConfig:getBuffCo(actId, buffId)")
	end

	return slot0:_get2PrimarykeyCo(slot0._buffConfig, slot1, slot2)
end

function slot0.getRecordEventCo(slot0, slot1, slot2)
	return slot0:_get2PrimarykeyCo(slot0._recordEventConfig, slot1, slot2)
end

function slot0.getRecordEventList(slot0, slot1)
	return slot0:_findListByActId(slot0._recordEventConfig, slot1)
end

function slot0.getEventCo(slot0, slot1, slot2)
	return slot0:_get2PrimarykeyCo(slot0._eventConfig, slot1, slot2)
end

function slot0.getOptionCo(slot0, slot1, slot2)
	return slot0:_get2PrimarykeyCo(slot0._optionConfig, slot1, slot2)
end

function slot0.getOptionResultCo(slot0, slot1, slot2)
	return slot0:_get2PrimarykeyCo(slot0._optionResultConfig, slot1, slot2)
end

function slot0.getEpisodeList(slot0, slot1)
	if slot0._episodeListDict[slot1] then
		return slot0._episodeListDict[slot1]
	end

	slot0._episodeListDict[slot1] = {}

	if slot0._episodeConfig and slot0._episodeConfig.configDict[slot1] then
		for slot6, slot7 in pairs(slot0._episodeConfig.configDict[slot1]) do
			table.insert(slot2, slot7)
		end

		table.sort(slot2, uv0.sortEpisode)
	end

	return slot2
end

function slot0.sortEpisode(slot0, slot1)
	if slot0.episodeId ~= slot1.episodeId then
		return slot0.episodeId < slot1.episodeId
	end
end

function slot0.getStoryList(slot0, slot1)
	if slot0._storyListDict[slot1] then
		return slot0._storyListDict[slot1]
	end

	slot0._storyListDict[slot1] = {}

	if slot0._storyConfig and slot0._storyConfig.configDict[slot1] then
		for slot6, slot7 in pairs(slot0._storyConfig.configDict[slot1]) do
			table.insert(slot2, slot7)
		end

		table.sort(slot2, uv0.sortStory)
	end

	return slot2
end

function slot0.sortStory(slot0, slot1)
	if slot0.order ~= slot1.order then
		return slot0.order < slot1.order
	end
end

slot0.instance = slot0.New()

return slot0
