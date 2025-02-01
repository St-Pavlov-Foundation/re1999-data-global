module("modules.logic.seasonver.act123.model.Season123PickHeroEntryModel", package.seeall)

slot0 = class("Season123PickHeroEntryModel", BaseModel)

function slot0.release(slot0)
	slot0:clear()

	slot0._supportPosMO = nil
	slot0.stage = nil
	slot0._equipIdList = nil
	slot0._lastHeroList = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0.activityId = slot1
	slot0.stage = slot2

	slot0:initDatas()
	slot0:initFromLocal()
	slot0:clearLastSupportHero()
end

function slot0.initDatas(slot0)
	slot1 = {}

	for slot5 = 1, Activity123Enum.PickHeroCount do
		table.insert(slot1, Season123PickHeroEntryMO.New(slot5))

		if slot5 == Activity123Enum.SupportPosIndex then
			slot0._supportPosMO = slot6
		end
	end

	slot0:setList(slot1)
end

function slot0.initFromLocal(slot0)
	for slot5 = 1, #slot0:readSelectionFromLocal() do
		slot0:getByIndex(slot5):updateByHeroMO(HeroModel.instance:getById(slot1[slot5]), false)
	end
end

function slot0.savePickHeroDatas(slot0, slot1)
	if not slot0._supportPosMO then
		return
	end

	for slot5 = 1, Activity123Enum.PickHeroCount do
		slot6 = slot1[slot5]

		if slot0:getByIndex(slot5) == nil then
			logError("Season123PickHeroEntryModel entryMO is nil : " .. tostring(slot5))

			return
		end

		if slot6 then
			if slot0._supportPosMO.isSupport and slot6.heroId == slot0._supportPosMO.heroId then
				slot0._supportPosMO:setEmpty()
			end

			slot7:updateByPickMO(slot6)
		elseif not slot7.isSupport then
			slot7:setEmpty()
		end
	end
end

function slot0.setPickAssistData(slot0, slot1)
	if not slot0._supportPosMO then
		return
	end

	if slot1 == nil then
		if not slot0._supportPosMO:getIsEmpty() and slot0._supportPosMO.isSupport then
			slot0._supportPosMO:setEmpty()
		end
	else
		for slot6 = 1, Activity123Enum.PickHeroCount do
			slot7 = slot0:getList()[slot6]

			if slot1.heroMO and slot1.heroMO.heroId == slot7.heroId then
				slot7:setEmpty()
			end
		end

		slot0._supportPosMO:updateByPickAssistMO(slot1)
	end
end

function slot0.setMainEquips(slot0, slot1)
	slot0._equipIdList = slot1
end

function slot0.getSupportPosMO(slot0)
	return slot0._supportPosMO
end

function slot0.getSupporterHeroUid(slot0)
	if slot0._supportPosMO and slot0._supportPosMO.isSupport and not slot0._supportPosMO:getIsEmpty() then
		return slot0._supportPosMO.heroUid
	end
end

function slot0.getSelectCount(slot0)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if not slot7:getIsEmpty() then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getLimitCount(slot0)
	return Activity123Enum.PickHeroCount
end

function slot0.getHeroUidList(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		table.insert(slot2, slot7.heroUid)
	end

	return slot2
end

function slot0.getMainCardList(slot0)
	return slot0._equipIdList
end

function slot0.getMainCardItemMO(slot0, slot1)
	if slot0._equipIdList and slot0._equipIdList[slot1] and slot2 ~= Activity123Enum.EmptyUid then
		if not Season123Model.instance:getActInfo(slot0.activityId) then
			return
		end

		return slot3:getItemMO(slot2)
	end
end

function slot0.flushSelectionToLocal(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		if not slot7:getIsEmpty() and not slot7.isSupport then
			table.insert(slot2, slot7.heroUid)
		end
	end

	PlayerPrefsHelper.setString(slot0:getLocalKey(), cjson.encode(slot2))
end

function slot0.readSelectionFromLocal(slot0)
	slot1 = nil

	return (string.nilorempty(PlayerPrefsHelper.getString(slot0:getLocalKey(), "")) or cjson.decode(slot2)) and {}
end

function slot0.getLocalKey(slot0)
	return PlayerPrefsKey.Season123PickHeroList .. "#" .. tostring(slot0.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function slot0.getCutHeroList(slot0)
	slot1 = slot0._lastHeroList or slot0:readSelectionFromLocal()
	slot3 = {}

	for slot7 = 1, #slot1 do
		if HeroModel.instance:getById(slot1[slot7]) then
			table.insert({}, slot8.heroId)
		end
	end

	for slot7 = 1, Activity123Enum.PickHeroCount do
		if slot0:getByIndex(slot7) and not slot8:getIsEmpty() then
			if slot8.isSupport then
				if slot0._lastSupportHeroId ~= slot8.heroId then
					table.insert(slot3, slot7)
				end
			elseif slot2 then
				if not LuaUtil.tableContains(slot2, slot8.heroId) then
					table.insert(slot3, slot7)
				end
			else
				table.insert(slot3, slot7)
			end
		end
	end

	return slot3
end

function slot0.refeshLastHeroList(slot0)
	slot0._lastHeroList = {}

	for slot5, slot6 in ipairs(slot0:getList()) do
		if not slot6:getIsEmpty() then
			table.insert(slot0._lastHeroList, slot6.heroUid)
		end

		if slot6.isSupport then
			if slot6:getIsEmpty() then
				slot0:clearLastSupportHero()
			else
				slot0._lastSupportHeroId = slot6.heroId
			end
		end
	end
end

function slot0.clearLastSupportHero(slot0)
	slot0._lastSupportHeroId = nil
end

slot0.instance = slot0.New()

return slot0
