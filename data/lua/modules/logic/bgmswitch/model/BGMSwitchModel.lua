module("modules.logic.bgmswitch.model.BGMSwitchModel", package.seeall)

slot0 = class("BGMSwitchModel", BaseModel)
slot0.InvalidBgmId = -1
slot0.RandomBgmId = 0

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._playMode = BGMSwitchEnum.PlayMode.LoopOne
	slot0._playingState = BGMSwitchEnum.PlayingState.FoldPlaying
	slot0._selectType = BGMSwitchEnum.SelectType.All
	slot0._bgmInfos = {}
	slot0._filterTypes = {}
	slot0._isFilteredAllListDirty = true
	slot0._filteredAllBgmListSorted = {}
	slot0._filteredAllBgmListRandom = {}
	slot0._isUnfilteredAllListDirty = true
	slot0._unfilteredAllBgmListSorted = {}
	slot0._isFilteredFavoriteListDirty = true
	slot0._filteredFavoriteBgmListSorted = {}
	slot0._filteredFavoriteBgmListRandom = {}
	slot0._isUnfilteredFavoriteListDirty = true
	slot0._unfilteredFavoriteBgmListSorted = {}
	slot0._curBgm = uv0.RandomBgmId
	slot0._useBgmIdFromServer = uv0.RandomBgmId
	slot0._curMechineGear = BGMSwitchEnum.Gear.On1
	slot0._curAudioShowType = BGMSwitchEnum.BGMDetailShowType.Progress
	slot0._recordBgmInfos = {}
	slot0._pptEffectEgg2Id = nil
	slot0._eggIsTrigger = false
	slot0._egg2State = {
		false,
		false,
		false,
		false
	}
end

function slot0.setBgmInfos(slot0, slot1)
	slot0._bgmInfos = {}

	for slot5, slot6 in ipairs(slot1) do
		BGMSwitchInfoMo.New():init(slot6)

		if BGMSwitchConfig.instance:getBGMSwitchCO(slot6.bgmId) then
			slot0._bgmInfos[slot6.bgmId] = slot7
		end
	end

	slot0._isFilteredAllListDirty = true
	slot0._isUnfilteredAllListDirty = true
	slot0._isFilteredFavoriteListDirty = true
	slot0._isUnfilteredFavoriteListDirty = true
end

function slot0.updateBgmInfos(slot0, slot1)
	if not slot0._bgmInfos then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot0._bgmInfos[slot6.bgmId] then
			slot0._bgmInfos[slot6.bgmId]:reset(slot6)
		else
			slot7 = BGMSwitchInfoMo.New()

			slot7:init(slot6)

			slot0._bgmInfos[slot6.bgmId] = slot7
		end
	end

	slot0._isFilteredAllListDirty = true
	slot0._isUnfilteredAllListDirty = true
	slot0._isFilteredFavoriteListDirty = true
	slot0._isUnfilteredFavoriteListDirty = true
end

function slot0.hasUnreadBgm(slot0)
	for slot4, slot5 in pairs(slot0._bgmInfos) do
		if not slot5.isRead then
			return true
		end
	end

	return false
end

function slot0.getBgmInfo(slot0, slot1)
	return slot0._bgmInfos[slot1]
end

function slot0.updateFilteredAllBgmsList(slot0)
	if not slot0._isFilteredAllListDirty then
		return
	end

	slot0._isFilteredAllListDirty = false
	slot0._filteredAllBgmListSorted = {}
	slot0._filteredAllBgmListRandom = {}

	if slot0:isFilterMode() then
		for slot4, slot5 in pairs(slot0._bgmInfos) do
			if slot0._filterTypes[BGMSwitchConfig.instance:getBGMSwitchCO(slot5.bgmId).audioType] ~= nil and slot0._filterTypes[slot6.audioType] == true then
				table.insert(slot0._filteredAllBgmListSorted, slot5.bgmId)
				table.insert(slot0._filteredAllBgmListRandom, slot5.bgmId)
			end
		end
	else
		for slot4, slot5 in pairs(slot0._bgmInfos) do
			table.insert(slot0._filteredAllBgmListSorted, slot5.bgmId)
			table.insert(slot0._filteredAllBgmListRandom, slot5.bgmId)
		end
	end

	table.sort(slot0._filteredAllBgmListSorted, uv0._sortBgm)
	slot0:regenerateRandomList(slot0._filteredAllBgmListRandom, true)
end

function slot0.updateUnfilteredAllBgmsList(slot0)
	if not slot0._isUnfilteredAllListDirty then
		return
	end

	slot0._isUnfilteredAllListDirty = false
	slot0._unfilteredAllBgmListSorted = {}

	for slot4, slot5 in pairs(slot0._bgmInfos) do
		table.insert(slot0._unfilteredAllBgmListSorted, slot5.bgmId)
	end

	table.sort(slot0._unfilteredAllBgmListSorted, uv0._sortBgm)
end

function slot0.updateFilteredFavoriteBgmsList(slot0)
	if not slot0._isFilteredFavoriteListDirty then
		return
	end

	slot0._isFilteredFavoriteListDirty = false
	slot0._filteredFavoriteBgmListSorted = {}
	slot0._filteredFavoriteBgmListRandom = {}

	if slot0:isFilterMode() then
		for slot4, slot5 in pairs(slot0._bgmInfos) do
			if slot5.favorite and slot0._filterTypes[BGMSwitchConfig.instance:getBGMSwitchCO(slot5.bgmId).audioType] ~= nil and slot0._filterTypes[slot6.audioType] == true then
				table.insert(slot0._filteredFavoriteBgmListSorted, slot5.bgmId)
				table.insert(slot0._filteredFavoriteBgmListRandom, slot5.bgmId)
			end
		end
	else
		for slot4, slot5 in pairs(slot0._bgmInfos) do
			if slot5.favorite then
				table.insert(slot0._filteredFavoriteBgmListSorted, slot5.bgmId)
				table.insert(slot0._filteredFavoriteBgmListRandom, slot5.bgmId)
			end
		end
	end

	table.sort(slot0._filteredFavoriteBgmListSorted, uv0._sortBgm)
	slot0:regenerateRandomList(slot0._filteredFavoriteBgmListRandom, true)
end

function slot0.regenerateRandomList(slot0, slot1, slot2)
	if #slot1 <= 0 then
		return nil
	end

	slot4 = slot1[1]
	slot5 = slot1[slot3]

	for slot9 = 1, slot3 do
		slot10 = math.random(slot3)
		slot1[slot9] = slot1[slot10]
		slot1[slot10] = slot1[slot9]
	end

	if slot2 and slot5 == slot1[1] or not slot2 and slot4 == slot1[slot3] then
		slot1[1] = slot1[slot3]
		slot1[slot3] = slot1[1]
	end

	return slot1[1]
end

function slot0.updateUnfilteredFavoriteBgmsList(slot0)
	if not slot0._isUnfilteredFavoriteListDirty then
		return
	end

	slot0._isUnfilteredFavoriteListDirty = false
	slot0._unfilteredFavoriteBgmListSorted = {}

	for slot4, slot5 in pairs(slot0._bgmInfos) do
		if slot5.favorite then
			table.insert(slot0._unfilteredFavoriteBgmListSorted, slot5.bgmId)
		end
	end

	table.sort(slot0._unfilteredFavoriteBgmListSorted, uv0._sortBgm)
end

function slot0.getFilteredAllBgmsSorted(slot0)
	slot0:updateFilteredAllBgmsList()

	return slot0._filteredAllBgmListSorted
end

function slot0.getFilteredAllBgmsRandom(slot0)
	slot0:updateFilteredAllBgmsList()

	return slot0._filteredAllBgmListRandom
end

function slot0.getUnfilteredAllBgmsSorted(slot0)
	slot0:updateUnfilteredAllBgmsList()

	return slot0._unfilteredAllBgmListSorted
end

function slot0.getFilteredFavoriteBgmsSorted(slot0)
	slot0:updateFilteredFavoriteBgmsList()

	return slot0._filteredFavoriteBgmListSorted
end

function slot0.getFilteredFavoriteBgmsRandom(slot0)
	slot0:updateFilteredFavoriteBgmsList()

	return slot0._filteredFavoriteBgmListRandom
end

function slot0.getUnfilteredFavoriteBgmsSorted(slot0)
	slot0:updateUnfilteredFavoriteBgmsList()

	return slot0._unfilteredFavoriteBgmListSorted
end

function slot0.getCurrentUsingBgmList(slot0)
	if slot0:isRandomMode() then
		if slot0:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
			return slot0:getFilteredAllBgmsRandom()
		else
			return slot0:getFilteredFavoriteBgmsRandom()
		end
	elseif slot0:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
		return slot0:getFilteredAllBgmsSorted()
	else
		return slot0:getFilteredFavoriteBgmsSorted()
	end

	return {}
end

function slot0.getCurrentServerUsingBgmList(slot0)
	if slot0:isRandomMode() then
		if slot0:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType) == BGMSwitchEnum.SelectType.All then
			return slot0:getFilteredAllBgmsRandom()
		else
			return slot0:getFilteredFavoriteBgmsRandom()
		end
	elseif slot1 == BGMSwitchEnum.SelectType.All then
		return slot0:getFilteredAllBgmsSorted()
	else
		return slot0:getFilteredFavoriteBgmsSorted()
	end

	return {}
end

function slot0.getReportBgmAudioLength(slot0, slot1)
	if slot1 == nil then
		return 0
	end

	slot2 = slot1.audioLength

	if slot1.isReport == 1 and WeatherController.instance:getCurrReport() ~= nil then
		slot2 = slot3.audioLength
	end

	return slot2
end

function slot0.getPlayingState(slot0)
	return slot0._playingState
end

function slot0.setPlayingState(slot0, slot1)
	slot0._playingState = slot1
end

function slot0.setEggHideState(slot0, slot1)
	slot0._eggShowState = slot1
end

function slot0.getEggHideState(slot0)
	return slot0._eggShowState
end

function slot0.setBgmFavorite(slot0, slot1, slot2)
	if slot0._bgmInfos[slot1] then
		slot0._bgmInfos[slot1].favorite = slot2 or not slot0._bgmInfos[slot1].favorite
		slot0._isFilteredFavoriteListDirty = true
		slot0._isUnfilteredFavoriteListDirty = true
	end
end

function slot0.isBgmFavorite(slot0, slot1)
	return slot0._bgmInfos[slot1] and slot0._bgmInfos[slot1].favorite or false
end

function slot0._sortBgm(slot0, slot1)
	return BGMSwitchConfig.instance:getBGMSwitchCO(slot0).sort < BGMSwitchConfig.instance:getBGMSwitchCO(slot1).sort
end

function slot0.setBGMSelectType(slot0, slot1)
	slot0._selectType = slot1

	slot0:recordInfoByType(BGMSwitchEnum.RecordInfoType.ListType, slot0._selectType, false)
end

function slot0.getBGMSelectType(slot0)
	slot0._selectType = slot0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	return slot0._selectType
end

function slot0.setCurBgm(slot0, slot1)
	if slot1 == uv0.RandomBgmId then
		if slot0._playMode ~= BGMSwitchEnum.PlayMode.Random then
			slot0._playMode = BGMSwitchEnum.PlayMode.Random
			slot0._curBgm = slot0:getNextBgm(1, false)
		end
	else
		slot0._playMode = BGMSwitchEnum.PlayMode.LoopOne
		slot0._curBgm = slot1
	end
end

function slot0.getCurBgm(slot0)
	return slot0._curBgm
end

function slot0.nextBgm(slot0, slot1, slot2)
	slot0._curBgm = slot0:getNextBgm(slot1, slot2)
	slot3 = slot0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
	slot4 = slot0:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	if slot2 and slot4 ~= nil then
		slot3 = slot4
	end

	slot5 = slot0:isRandomMode()

	if slot2 then
		slot5 = slot0:isRandomBgmId(slot0:getUsedBgmIdFromServer())
	end

	if slot5 and slot3 == BGMSwitchEnum.SelectType.Loved and #slot0:getFilteredFavoriteBgmsRandom() == 0 then
		slot3 = BGMSwitchEnum.SelectType.All
	end

	if slot5 then
		slot6 = -1
		slot7 = -1

		if slot3 == BGMSwitchEnum.SelectType.All then
			slot6 = LuaUtil.indexOfElement(slot0:getFilteredAllBgmsRandom(), slot0._curBgm)
			slot7 = #slot0:getFilteredAllBgmsRandom()
		else
			slot6 = LuaUtil.indexOfElement(slot0:getFilteredFavoriteBgmsRandom(), slot0._curBgm)
			slot7 = #slot0:getFilteredFavoriteBgmsRandom()
		end

		if slot6 == 1 and slot1 >= 1 then
			if slot3 == BGMSwitchEnum.SelectType.All then
				slot0._curBgm = slot0:regenerateRandomList(slot0:getFilteredAllBgmsRandom(), true)
			else
				slot0._curBgm = slot0:regenerateRandomList(slot0:getFilteredFavoriteBgmsRandom(), true)
			end
		elseif slot6 == slot7 and slot1 <= -1 then
			if slot3 == BGMSwitchEnum.SelectType.All then
				slot0._curBgm = slot0:regenerateRandomList(slot0:getFilteredAllBgmsRandom(), false)
			else
				slot0._curBgm = slot0:regenerateRandomList(slot0:getFilteredFavoriteBgmsRandom(), false)
			end
		end
	end

	return slot0._curBgm
end

function slot0.setUsedBgmIdFromServer(slot0, slot1)
	slot0._useBgmIdFromServer = slot1
end

function slot0.getUsedBgmIdFromServer(slot0)
	return slot0._useBgmIdFromServer
end

function slot0.getBgmIdByDistance(slot0, slot1, slot2, slot3)
	if #slot1 == 0 then
		return uv0.InvalidBgmId
	end

	if LuaUtil.indexOfElement(slot1, slot2) == -1 then
		return slot1[1]
	end

	if (slot5 + slot3) % slot4 == 0 then
		slot5 = slot4
	elseif slot5 < 0 then
		slot5 = slot5 + slot4
	end

	return slot1[slot5]
end

function slot0.getNextBgm(slot0, slot1, slot2)
	slot3 = slot0._curBgm
	slot4 = 0
	slot5 = slot0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
	slot6 = slot0:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	if slot2 and slot6 ~= nil then
		slot5 = slot6
	end

	slot7 = slot0:isRandomMode()

	if slot2 then
		slot7 = slot0:isRandomBgmId(slot0:getUsedBgmIdFromServer())
	end

	if slot7 and slot5 == BGMSwitchEnum.SelectType.Loved and #slot0:getFilteredFavoriteBgmsRandom() == 0 then
		slot5 = BGMSwitchEnum.SelectType.All
	end

	return (slot5 ~= BGMSwitchEnum.SelectType.All or (not slot7 or slot0:getBgmIdByDistance(slot0:getFilteredAllBgmsRandom(), slot3, slot1)) and slot0:getBgmIdByDistance(slot0:getFilteredAllBgmsSorted(), slot3, slot1)) and (not slot7 or slot0:getBgmIdByDistance(slot0:getFilteredFavoriteBgmsRandom(), slot3, slot1)) and slot0:getBgmIdByDistance(slot0:getFilteredFavoriteBgmsSorted(), slot3, slot1)
end

function slot0.isRandomMode(slot0)
	return slot0._playMode == BGMSwitchEnum.PlayMode.Random
end

function slot0.isLoopOneMode(slot0)
	return slot0._playMode == BGMSwitchEnum.PlayMode.LoopOne
end

function slot0.isLocalRemoteListTypeMatched(slot0)
	return slot0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType) == slot0:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
end

function slot0.isLocalRemoteBgmIdMatched(slot0)
	slot1 = slot0:getCurBgm()

	if slot0:isRandomMode() then
		slot1 = uv0.RandomBgmId
	end

	return slot1 == slot0:getUsedBgmIdFromServer()
end

function slot0.isValidBgmId(slot0, slot1)
	return slot1 ~= nil and slot1 ~= uv0.RandomBgmId and slot1 ~= uv0.InvalidBgmId
end

function slot0.isRandomBgmId(slot0, slot1)
	return slot1 == uv0.RandomBgmId
end

function slot0.getBGMPlayMode(slot0)
	return slot0._playMode
end

function slot0.setMechineGear(slot0, slot1)
	slot0._curMechineGear = slot1

	slot0:recordInfoByType(BGMSwitchEnum.RecordInfoType.BGMSwitchGear, slot0._curMechineGear, true)
end

function slot0.getMechineGear(slot0)
	slot0._curMechineGear = slot0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.BGMSwitchGear)

	return slot0._curMechineGear
end

function slot0.machineGearIsNeedPlayBgm(slot0)
	return slot0._curMechineGear == BGMSwitchEnum.Gear.On1
end

function slot0.machineGearIsInSnowflakeScene(slot0)
	return slot0._curMechineGear == BGMSwitchEnum.Gear.On2 or slot0._curMechineGear == BGMSwitchEnum.Gear.On3
end

function slot0.setAudioCurShowType(slot0, slot1)
	slot0._curAudioShowType = slot1
end

function slot0.getAudioCurShowType(slot0)
	return slot0._curAudioShowType
end

function slot0.setEggIsTrigger(slot0, slot1)
	slot0._eggIsTrigger = slot1
end

function slot0.getEggIsTrigger(slot0)
	return slot0._eggIsTrigger
end

function slot0.setPPtEffectEgg2Id(slot0, slot1)
	slot0._pptEffectEgg2Id = slot1
end

function slot0.getPPtEffectEgg2Id(slot0)
	return slot0._pptEffectEgg2Id
end

function slot0.setFilterType(slot0, slot1, slot2)
	slot0._filterTypes[slot1] = slot2
	slot0._isFilteredAllListDirty = true
	slot0._isFilteredFavoriteListDirty = true
end

function slot0.getFilterTypeSelectState(slot0, slot1)
	return slot0._filterTypes[slot1]
end

function slot0.clearFilterTypes(slot0)
	slot0._filterTypes = {}
	slot0._isFilteredAllListDirty = true
	slot0._isFilteredFavoriteListDirty = true
end

function slot0.isFilterMode(slot0)
	for slot4, slot5 in pairs(slot0._filterTypes) do
		if slot5 ~= nil and slot5 == true then
			return true
		end
	end

	return false
end

function slot0.getEggType2Sates(slot0)
	return slot0._egg2State
end

function slot0.getEggType2SateByIndex(slot0, slot1)
	return slot0._egg2State[slot1]
end

function slot0.setEggType2State(slot0, slot1, slot2)
	slot0._egg2State[slot1] = slot2
end

function slot0.recordInfoByType(slot0, slot1, slot2, slot3)
	slot0._recordBgmInfos[slot1] = slot2

	if slot3 then
		slot0:_recordInfo(slot1, slot2)
	end
end

function slot0._recordInfo(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0._recordBgmInfos) do
		if slot0:getServerRecordInfoByType(slot7) then
			-- Nothing
		else
			slot3[slot7] = slot8
		end
	end

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.BGMViewInfo, slot0:encodeRecordInfo({
		[slot7] = slot9,
		[slot1] = slot2
	}))
end

function slot0.encodeRecordInfo(slot0, slot1)
	for slot6, slot7 in pairs(slot1) do
		slot2 = "" .. slot6 .. ":" .. slot7 .. "|"
	end

	return slot2
end

function slot0.decodeRecordInfo(slot0, slot1)
	for slot7 = 1, #string.split(slot1, "|") do
		if slot3[slot7] and string.split(slot3[slot7], ":") and #slot8 > 1 then
			-- Nothing
		end
	end

	return {
		[tonumber(slot8[1])] = tonumber(slot8[2])
	}
end

function slot0.getRecordInfoByType(slot0, slot1)
	if slot0._recordBgmInfos and #slot0._recordBgmInfos <= 0 and not slot0._recordBgmInfos[slot1] and PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.BGMViewInfo) then
		slot0._recordBgmInfos = slot0:decodeRecordInfo(slot2)
	end

	if not slot0._recordBgmInfos[slot1] then
		if slot1 == BGMSwitchEnum.RecordInfoType.ListType then
			return BGMSwitchEnum.SelectType.All
		end

		if slot1 == BGMSwitchEnum.RecordInfoType.BGMSwitchGear then
			return BGMSwitchEnum.Gear.On1
		end
	end

	return slot0._recordBgmInfos[slot1]
end

function slot0.getServerRecordInfoByType(slot0, slot1)
	if PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.BGMViewInfo) and slot0:decodeRecordInfo(slot2)[slot1] then
		return slot3[slot1]
	end

	if slot1 == BGMSwitchEnum.RecordInfoType.ListType then
		return BGMSwitchEnum.SelectType.All
	end

	if slot1 == BGMSwitchEnum.RecordInfoType.BGMSwitchGear then
		return BGMSwitchEnum.Gear.On1
	end
end

function slot0.markRead(slot0, slot1)
	if slot0._bgmInfos[slot1] then
		slot2.isRead = true
	end
end

function slot0.getUnReadCount(slot0)
	for slot5, slot6 in pairs(slot0._bgmInfos) do
		if not slot6.isRead then
			slot1 = 0 + 1
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
