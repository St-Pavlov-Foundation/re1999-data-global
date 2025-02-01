module("modules.logic.versionactivity1_4.act133.config.Activity133Config", package.seeall)

slot0 = class("Activity133Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._act133taskList = {}
	slot0._act133bonusList = {}
	slot0._finalBonus = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity133_bonus",
		"activity133_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity133_task" then
		for slot6, slot7 in ipairs(slot2.configList) do
			slot8 = slot7.id

			table.insert(slot0._act133taskList, slot7)
		end
	elseif slot1 == "activity133_bonus" then
		for slot6, slot7 in ipairs(slot2.configList) do
			slot8 = slot7.id

			if slot7.finalBonus == 1 then
				slot0._finalBonus = slot7.bonus
			else
				slot0._act133bonusList[slot8] = slot0._act133bonusList[slot8] or {}

				table.insert(slot0._act133bonusList[slot8], slot7)
			end
		end
	end
end

function slot0.getFinalBonus(slot0)
	return slot0._finalBonus
end

function slot0.getBonusCoList(slot0)
	return slot0._act133bonusList
end

function slot0.getNeedFixNum(slot0)
	return #slot0._act133bonusList
end

function slot0.getTaskCoList(slot0)
	return slot0._act133taskList
end

function slot0.getTaskCo(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._act133taskList) do
		if slot6.id == slot1 then
			return slot6
		end
	end

	return slot0._act133taskList[slot1]
end

function slot0.getBonusCo(slot0, slot1)
	return slot0._act133bonusList[slot1]
end

function slot0.IsActivityTask(slot0, slot1)
	if slot0._act133taskList[slot1].orActivity == "1" then
		return true
	end

	return false
end

slot0.instance = slot0.New()

return slot0
