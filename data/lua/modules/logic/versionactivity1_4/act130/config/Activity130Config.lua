module("modules.logic.versionactivity1_4.act130.config.Activity130Config", package.seeall)

slot0 = class("Activity130Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._act130EpisodeConfig = nil
	slot0._act130DecryptConfig = nil
	slot0._act130OperGroupConfig = nil
	slot0._act130ElementConfig = nil
	slot0._act130DialogList = nil
	slot0._act130TaskConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity130_episode",
		"activity130_decrypt",
		"activity130_oper_group",
		"activity130_element",
		"activity130_dialog",
		"activity130_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity130_episode" then
		slot0._act130EpisodeConfig = slot2
	elseif slot1 == "activity130_decrypt" then
		slot0._act130DecryptConfig = slot2
	elseif slot1 == "activity130_oper_group" then
		slot0._act130OperGroupConfig = slot2
	elseif slot1 == "activity130_element" then
		slot0._act130ElementConfig = slot2
	elseif slot1 == "activity130_dialog" then
		slot0:_initDialog()
	elseif slot1 == "activity130_task" then
		slot0._act130TaskConfig = slot2
	end
end

function slot0.getActivity130EpisodeCos(slot0, slot1)
	return slot0._act130EpisodeConfig.configDict[slot1]
end

function slot0.getActivity130EpisodeCo(slot0, slot1, slot2)
	return slot0._act130EpisodeConfig.configDict[slot1][slot2]
end

function slot0.getActivity130DecryptCos(slot0, slot1)
	return slot0._act130DecryptConfig.configDict[slot1]
end

function slot0.getActivity130DecryptCo(slot0, slot1, slot2)
	return slot0._act130DecryptConfig.configDict[slot1][slot2]
end

function slot0.getActivity130OperateGroupCos(slot0, slot1, slot2)
	return slot0._act130OperGroupConfig.configDict[slot1][slot2]
end

function slot0.getActivity130ElementCo(slot0, slot1, slot2)
	return slot0._act130ElementConfig.configDict[slot1][slot2]
end

function slot0.getActivity130DialogCo(slot0, slot1, slot2)
	return lua_activity130_dialog.configDict[slot1][slot2]
end

function slot0._initDialog(slot0)
	slot0._act130DialogList = {}
	slot1 = nil

	for slot6, slot7 in ipairs(lua_activity130_dialog.configList) do
		if not slot0._act130DialogList[slot7.id] then
			slot1 = "0"
			slot0._act130DialogList[slot7.id] = {
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
	return slot0._act130DialogList[slot1] and slot3[slot2]
end

function slot0.getOptionParamList(slot0, slot1)
	return slot0._act130DialogList[slot1] and slot2.optionParamList
end

function slot0.getActivity130TaskCo(slot0, slot1)
	return slot0._act130TaskConfig.configDict[slot1]
end

function slot0.getTaskByActId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._act130TaskConfig.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getOperGroup(slot0, slot1, slot2)
	return slot0._act130OperGroupConfig.configDict[slot1][slot2]
end

slot0.instance = slot0.New()

return slot0
