module("modules.logic.versionactivity1_5.peaceulu.config.PeaceUluConfig", package.seeall)

slot0 = class("PeaceUluConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._act145taskList = {}
	slot0._act145bonusList = {}
	slot0._act145voiceList = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity145_task",
		"activity145_task_bonus",
		"activity145_game",
		"activity145_const",
		"activity145_movement"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity145_task_bonus" then
		for slot6, slot7 in ipairs(slot2.configList) do
			table.insert(slot0._act145bonusList, slot7)
		end
	elseif slot1 == "activity145_task" then
		for slot6, slot7 in ipairs(slot2.configList) do
			table.insert(slot0._act145taskList, slot7)
		end
	elseif slot1 == "activity145_movement" then
		for slot6, slot7 in ipairs(slot2.configList) do
			table.insert(slot0._act145voiceList, slot7)
		end
	end
end

function slot0.getBonusCoList(slot0)
	return slot0._act145bonusList
end

function slot0.getBonusCount(slot0)
	return #slot0._act145bonusList
end

function slot0.getVoiceList(slot0)
	return slot0._act145voiceList
end

function slot0.getVoiceConfigByType(slot0, slot1)
	for slot5, slot6 in pairs(slot0._act145voiceList) do
		if slot1 == slot6.type then
			return slot6
		end
	end
end

function slot0.getMaxProgress(slot0)
	return string.split(slot0._act145bonusList[#slot0._act145bonusList].needProgress, "#")[3]
end

function slot0.getProgressByIndex(slot0, slot1)
	if slot1 < 1 and slot1 > #slot0._act145bonusList then
		return
	end

	return tonumber(string.split(slot0._act145bonusList[slot1].needProgress, "#")[3])
end

function slot0.getTaskCoList(slot0)
	return slot0._act145taskList
end

function slot0.getTaskCo(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._act145taskList) do
		if slot6.id == slot1 then
			return slot6
		end
	end

	return slot0._act145taskList[slot1]
end

function slot0.getGameTimes(slot0)
	return 3
end

slot0.instance = slot0.New()

return slot0
