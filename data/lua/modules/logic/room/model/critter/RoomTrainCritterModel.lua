module("modules.logic.room.model.critter.RoomTrainCritterModel", package.seeall)

slot0 = class("RoomTrainCritterModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._storyPlayedList = {}

	if not LuaUtil.isEmptyStr(PlayerPrefsHelper.getString(PlayerPrefsKey.RoomCritterTrainStoryPlayed, "")) then
		if #string.split(slot1, "#") > 1 and TimeUtil.isSameDay(tonumber(slot3[1]), ServerTime.now()) then
			for slot7 = 2, #slot3 do
				table.insert(slot0._storyPlayedList, tonumber(slot3[slot7]))
			end
		end
	end
end

function slot0.isEventTrainStoryPlayed(slot0, slot1)
	for slot5, slot6 in pairs(slot0._storyPlayedList) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.setEventTrainStoryPlayed(slot0, slot1)
	if slot0:isEventTrainStoryPlayed(slot1) then
		return
	end

	table.insert(slot0._storyPlayedList, slot1)

	for slot6, slot7 in ipairs(slot0._storyPlayedList) do
		slot2 = string.format("%s#%s", tostring(ServerTime.now()), slot7)
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.RoomCritterTrainStoryPlayed, slot2)
end

function slot0.isCritterTrainStory(slot0, slot1)
	if #tostring(slot1) ~= 9 then
		return false
	end

	slot2 = slot1 % 100000

	for slot6, slot7 in pairs(lua_critter_train_event.configDict) do
		if slot7.type == CritterEnum.EventType.ActiveTime and (slot2 == slot7.initStoryId or slot2 == slot7.normalStoryId or slot2 == slot7.skilledStoryId) then
			return true
		end
	end

	return false
end

function slot0.getCritterTrainStory(slot0, slot1, slot2)
	return 100000 * slot1 + slot2
end

slot0.instance = slot0.New()

return slot0
