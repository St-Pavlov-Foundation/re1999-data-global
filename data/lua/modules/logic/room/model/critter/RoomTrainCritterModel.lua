module("modules.logic.room.model.critter.RoomTrainCritterModel", package.seeall)

slot0 = class("RoomTrainCritterModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._selectOptionInfos = {}
	slot0._totalSelectCount = 0
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

function slot0.clearSelectOptionInfos(slot0)
	slot0._totalSelectCount = 0
	slot0._selectOptionInfos = {}
end

function slot0.getSelectOptionInfos(slot0)
	if not slot0._selectOptionInfos or not next(slot0._selectOptionInfos) then
		slot0._selectOptionInfos = {
			{
				optionId = 1,
				count = 0
			},
			{
				optionId = 2,
				count = 0
			},
			{
				optionId = 3,
				count = 0
			}
		}
	end

	return slot0._selectOptionInfos
end

function slot0.addSelectOptionCount(slot0, slot1)
	if not slot0._selectOptionInfos[slot1] then
		slot0:getSelectOptionInfos()
	end

	slot0._selectOptionInfos[slot1].count = slot0._selectOptionInfos[slot1].count + 1
end

function slot0.cancelSelectOptionCount(slot0, slot1)
	if not slot0._selectOptionInfos[slot1] then
		slot0:getSelectOptionInfos()
	end

	if slot0._selectOptionInfos[slot1].count < 1 then
		return
	end

	slot0._selectOptionInfos[slot1].count = slot0._selectOptionInfos[slot1].count - 1
end

function slot0.getSelectOptionCount(slot0, slot1)
	if not slot0._selectOptionInfos[slot1] then
		slot0:getSelectOptionInfos()
	end

	return slot0._selectOptionInfos[slot1].count
end

function slot0.getSelectOptionTotalCount(slot0)
	for slot5, slot6 in pairs(slot0._selectOptionInfos) do
		slot1 = 0 + slot6.count
	end

	return slot1
end

function slot0.setOptionsSelectTotalCount(slot0, slot1)
	slot0._totalSelectCount = slot1
end

function slot0.getOptionsSelectTotalCount(slot0)
	return slot0._totalSelectCount
end

function slot0.getSelectOptionLimitCount(slot0)
	if slot0._totalSelectCount - slot0:getSelectOptionTotalCount() <= 0 then
		return 0
	end

	return slot0._totalSelectCount - slot1
end

function slot0.getProductGood(slot0, slot1)
	if #StoreConfig.instance:getRoomCritterProductGoods(slot1) < 1 then
		return nil
	end

	for slot6, slot7 in pairs(slot2) do
		slot8 = StoreModel.instance:getGoodsMO(slot7.id)

		if slot8.buyCount < slot8.config.maxBuyCount then
			return slot8
		end
	end

	for slot6, slot7 in pairs(slot2) do
		if StoreModel.instance:getGoodsMO(slot7.id).config.maxBuyCount == 0 then
			return slot8
		end
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
