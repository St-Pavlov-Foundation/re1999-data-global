module("modules.logic.versionactivity1_4.act131.config.Activity131Config", package.seeall)

slot0 = class("Activity131Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._act131EpisodeConfig = nil
	slot0._act131ElementConfig = nil
	slot0._act131DialogConfig = nil
	slot0._act131DialogList = nil
	slot0._act131TaskConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity131_episode",
		"activity131_element",
		"activity131_dialog",
		"activity131_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity131_episode" then
		slot0._act131EpisodeConfig = slot2
	elseif slot1 == "activity131_element" then
		slot0._act131ElementConfig = slot2
	elseif slot1 == "activity131_dialog" then
		slot0._act131DialogConfig = slot2

		slot0:_initDialog()
	elseif slot1 == "activity131_task" then
		slot0._act131TaskConfig = slot2
	end
end

function slot0.getActivity131EpisodeCos(slot0, slot1)
	return slot0._act131EpisodeConfig.configDict[slot1]
end

function slot0.getActivity131EpisodeCo(slot0, slot1, slot2)
	return slot0._act131EpisodeConfig.configDict[slot1][slot2]
end

function slot0.getActivity131ElementCo(slot0, slot1, slot2)
	return slot0._act131ElementConfig.configDict[slot1][slot2]
end

function slot0.getActivity131DialogCo(slot0, slot1, slot2)
	return slot0._act131DialogConfig.configDict[slot1][slot2]
end

function slot0.getActivity131DialogGroup(slot0, slot1)
	return slot0._act131DialogConfig.configDict[slot1]
end

function slot0._initDialog(slot0)
	slot0._act131DialogList = {}
	slot1 = nil

	for slot6, slot7 in ipairs(slot0._act131DialogConfig.configList) do
		if not slot0._act131DialogList[slot7.id] then
			slot1 = "0"
			slot0._act131DialogList[slot7.id] = {
				optionParamList = {}
			}
		end

		if not string.nilorempty(slot7.option_param) then
			table.insert(slot8.optionParamList, tonumber(slot7.option_param))
		end

		if slot7.type == "selector" then
			slot8[slot1] = slot8[slot7.param] or {}
			slot8[slot1].type = slot7.type
			slot8[slot1].option_param = slot7.option_param
		elseif slot7.type == "selectorend" then
			slot1 = slot2
		elseif slot7.type == "random" then
			slot8[slot9] = slot8[slot7.param] or {}
			slot8[slot9].type = slot7.type
			slot8[slot9].option_param = slot7.option_param

			table.insert(slot8[slot9], slot7)
		else
			slot8[slot1] = slot8[slot1] or {}

			table.insert(slot8[slot1], slot7)
		end
	end
end

function slot0.getDialog(slot0, slot1, slot2)
	return slot0._act131DialogList[slot1] and slot3[slot2]
end

function slot0.getOptionParamList(slot0, slot1)
	return slot0._act131DialogList[slot1] and slot2.optionParamList
end

function slot0.getActivity131TaskCo(slot0, slot1)
	return slot0._act131TaskConfig.configDict[slot1]
end

function slot0.getTaskByActId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._act131TaskConfig.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
