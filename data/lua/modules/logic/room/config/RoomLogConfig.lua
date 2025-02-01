module("modules.logic.room.config.RoomLogConfig", package.seeall)

slot0 = class("RoomLogConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._logList = nil
	slot0._logDict = nil
	slot0._logTagList = nil
	slot0._logTagDict = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"log_room_character",
		"log_room_tag"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "log_room_character" then
		slot0._logList = slot2.configList
		slot0._logDict = slot2.configDict

		for slot6, slot7 in ipairs(slot0._logList) do
			slot0._logDict[slot7.id] = slot7
		end
	elseif slot1 == "log_room_tag" then
		slot0._logTagList = slot2.configList
		slot0._logTagDict = slot2.configDict
	end
end

function slot0.getLogList(slot0)
	return slot0._logList
end

function slot0.getLogConfigById(slot0, slot1)
	return slot0._logDict[slot1]
end

function slot0.getLogTagList(slot0)
	return slot0._logTagList
end

function slot0.getLogTagConfigById(slot0, slot1)
	return slot0._logTagDict[slot1]
end

slot0.instance = slot0.New()

return slot0
