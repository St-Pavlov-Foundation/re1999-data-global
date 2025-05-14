module("modules.logic.bgmswitch.model.BGMSwitchModel", package.seeall)

local var_0_0 = class("BGMSwitchModel", BaseModel)

var_0_0.InvalidBgmId = -1
var_0_0.RandomBgmId = 0

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._playMode = BGMSwitchEnum.PlayMode.LoopOne
	arg_2_0._playingState = BGMSwitchEnum.PlayingState.FoldPlaying
	arg_2_0._selectType = BGMSwitchEnum.SelectType.All
	arg_2_0._bgmInfos = {}
	arg_2_0._filterTypes = {}
	arg_2_0._isFilteredAllListDirty = true
	arg_2_0._filteredAllBgmListSorted = {}
	arg_2_0._filteredAllBgmListRandom = {}
	arg_2_0._isUnfilteredAllListDirty = true
	arg_2_0._unfilteredAllBgmListSorted = {}
	arg_2_0._isFilteredFavoriteListDirty = true
	arg_2_0._filteredFavoriteBgmListSorted = {}
	arg_2_0._filteredFavoriteBgmListRandom = {}
	arg_2_0._isUnfilteredFavoriteListDirty = true
	arg_2_0._unfilteredFavoriteBgmListSorted = {}
	arg_2_0._curBgm = var_0_0.RandomBgmId
	arg_2_0._useBgmIdFromServer = var_0_0.RandomBgmId
	arg_2_0._curMechineGear = BGMSwitchEnum.Gear.On1
	arg_2_0._curAudioShowType = BGMSwitchEnum.BGMDetailShowType.Progress
	arg_2_0._recordBgmInfos = {}
	arg_2_0._pptEffectEgg2Id = nil
	arg_2_0._eggIsTrigger = false
	arg_2_0._egg2State = {
		false,
		false,
		false,
		false
	}
end

function var_0_0.setBgmInfos(arg_3_0, arg_3_1)
	arg_3_0._bgmInfos = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = BGMSwitchInfoMo.New()

		var_3_0:init(iter_3_1)

		if BGMSwitchConfig.instance:getBGMSwitchCO(iter_3_1.bgmId) then
			arg_3_0._bgmInfos[iter_3_1.bgmId] = var_3_0
		end
	end

	arg_3_0._isFilteredAllListDirty = true
	arg_3_0._isUnfilteredAllListDirty = true
	arg_3_0._isFilteredFavoriteListDirty = true
	arg_3_0._isUnfilteredFavoriteListDirty = true
end

function var_0_0.updateBgmInfos(arg_4_0, arg_4_1)
	if not arg_4_0._bgmInfos then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if arg_4_0._bgmInfos[iter_4_1.bgmId] then
			arg_4_0._bgmInfos[iter_4_1.bgmId]:reset(iter_4_1)
		else
			local var_4_0 = BGMSwitchInfoMo.New()

			var_4_0:init(iter_4_1)

			arg_4_0._bgmInfos[iter_4_1.bgmId] = var_4_0
		end
	end

	arg_4_0._isFilteredAllListDirty = true
	arg_4_0._isUnfilteredAllListDirty = true
	arg_4_0._isFilteredFavoriteListDirty = true
	arg_4_0._isUnfilteredFavoriteListDirty = true
end

function var_0_0.hasUnreadBgm(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._bgmInfos) do
		if not iter_5_1.isRead then
			return true
		end
	end

	return false
end

function var_0_0.getBgmInfo(arg_6_0, arg_6_1)
	return arg_6_0._bgmInfos[arg_6_1]
end

function var_0_0.updateFilteredAllBgmsList(arg_7_0)
	if not arg_7_0._isFilteredAllListDirty then
		return
	end

	arg_7_0._isFilteredAllListDirty = false
	arg_7_0._filteredAllBgmListSorted = {}
	arg_7_0._filteredAllBgmListRandom = {}

	if arg_7_0:isFilterMode() then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._bgmInfos) do
			local var_7_0 = BGMSwitchConfig.instance:getBGMSwitchCO(iter_7_1.bgmId)

			if arg_7_0._filterTypes[var_7_0.audioType] ~= nil and arg_7_0._filterTypes[var_7_0.audioType] == true then
				table.insert(arg_7_0._filteredAllBgmListSorted, iter_7_1.bgmId)
				table.insert(arg_7_0._filteredAllBgmListRandom, iter_7_1.bgmId)
			end
		end
	else
		for iter_7_2, iter_7_3 in pairs(arg_7_0._bgmInfos) do
			table.insert(arg_7_0._filteredAllBgmListSorted, iter_7_3.bgmId)
			table.insert(arg_7_0._filteredAllBgmListRandom, iter_7_3.bgmId)
		end
	end

	table.sort(arg_7_0._filteredAllBgmListSorted, var_0_0._sortBgm)
	arg_7_0:regenerateRandomList(arg_7_0._filteredAllBgmListRandom, true)
end

function var_0_0.updateUnfilteredAllBgmsList(arg_8_0)
	if not arg_8_0._isUnfilteredAllListDirty then
		return
	end

	arg_8_0._isUnfilteredAllListDirty = false
	arg_8_0._unfilteredAllBgmListSorted = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0._bgmInfos) do
		table.insert(arg_8_0._unfilteredAllBgmListSorted, iter_8_1.bgmId)
	end

	table.sort(arg_8_0._unfilteredAllBgmListSorted, var_0_0._sortBgm)
end

function var_0_0.updateFilteredFavoriteBgmsList(arg_9_0)
	if not arg_9_0._isFilteredFavoriteListDirty then
		return
	end

	arg_9_0._isFilteredFavoriteListDirty = false
	arg_9_0._filteredFavoriteBgmListSorted = {}
	arg_9_0._filteredFavoriteBgmListRandom = {}

	if arg_9_0:isFilterMode() then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._bgmInfos) do
			if iter_9_1.favorite then
				local var_9_0 = BGMSwitchConfig.instance:getBGMSwitchCO(iter_9_1.bgmId)

				if arg_9_0._filterTypes[var_9_0.audioType] ~= nil and arg_9_0._filterTypes[var_9_0.audioType] == true then
					table.insert(arg_9_0._filteredFavoriteBgmListSorted, iter_9_1.bgmId)
					table.insert(arg_9_0._filteredFavoriteBgmListRandom, iter_9_1.bgmId)
				end
			end
		end
	else
		for iter_9_2, iter_9_3 in pairs(arg_9_0._bgmInfos) do
			if iter_9_3.favorite then
				table.insert(arg_9_0._filteredFavoriteBgmListSorted, iter_9_3.bgmId)
				table.insert(arg_9_0._filteredFavoriteBgmListRandom, iter_9_3.bgmId)
			end
		end
	end

	table.sort(arg_9_0._filteredFavoriteBgmListSorted, var_0_0._sortBgm)
	arg_9_0:regenerateRandomList(arg_9_0._filteredFavoriteBgmListRandom, true)
end

function var_0_0.regenerateRandomList(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = #arg_10_1

	if var_10_0 <= 0 then
		return nil
	end

	local var_10_1 = arg_10_1[1]
	local var_10_2 = arg_10_1[var_10_0]

	for iter_10_0 = 1, var_10_0 do
		local var_10_3 = math.random(var_10_0)

		arg_10_1[var_10_3], arg_10_1[iter_10_0] = arg_10_1[iter_10_0], arg_10_1[var_10_3]
	end

	if arg_10_2 and var_10_2 == arg_10_1[1] or not arg_10_2 and var_10_1 == arg_10_1[var_10_0] then
		arg_10_1[var_10_0], arg_10_1[1] = arg_10_1[1], arg_10_1[var_10_0]
	end

	return arg_10_1[1]
end

function var_0_0.updateUnfilteredFavoriteBgmsList(arg_11_0)
	if not arg_11_0._isUnfilteredFavoriteListDirty then
		return
	end

	arg_11_0._isUnfilteredFavoriteListDirty = false
	arg_11_0._unfilteredFavoriteBgmListSorted = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0._bgmInfos) do
		if iter_11_1.favorite then
			table.insert(arg_11_0._unfilteredFavoriteBgmListSorted, iter_11_1.bgmId)
		end
	end

	table.sort(arg_11_0._unfilteredFavoriteBgmListSorted, var_0_0._sortBgm)
end

function var_0_0.getFilteredAllBgmsSorted(arg_12_0)
	arg_12_0:updateFilteredAllBgmsList()

	return arg_12_0._filteredAllBgmListSorted
end

function var_0_0.getFilteredAllBgmsRandom(arg_13_0)
	arg_13_0:updateFilteredAllBgmsList()

	return arg_13_0._filteredAllBgmListRandom
end

function var_0_0.getUnfilteredAllBgmsSorted(arg_14_0)
	arg_14_0:updateUnfilteredAllBgmsList()

	return arg_14_0._unfilteredAllBgmListSorted
end

function var_0_0.getFilteredFavoriteBgmsSorted(arg_15_0)
	arg_15_0:updateFilteredFavoriteBgmsList()

	return arg_15_0._filteredFavoriteBgmListSorted
end

function var_0_0.getFilteredFavoriteBgmsRandom(arg_16_0)
	arg_16_0:updateFilteredFavoriteBgmsList()

	return arg_16_0._filteredFavoriteBgmListRandom
end

function var_0_0.getUnfilteredFavoriteBgmsSorted(arg_17_0)
	arg_17_0:updateUnfilteredFavoriteBgmsList()

	return arg_17_0._unfilteredFavoriteBgmListSorted
end

function var_0_0.getCurrentUsingBgmList(arg_18_0)
	if arg_18_0:isRandomMode() then
		if arg_18_0:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
			return arg_18_0:getFilteredAllBgmsRandom()
		else
			return arg_18_0:getFilteredFavoriteBgmsRandom()
		end
	elseif arg_18_0:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
		return arg_18_0:getFilteredAllBgmsSorted()
	else
		return arg_18_0:getFilteredFavoriteBgmsSorted()
	end

	return {}
end

function var_0_0.getCurrentServerUsingBgmList(arg_19_0)
	local var_19_0 = arg_19_0:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	if arg_19_0:isRandomMode() then
		if var_19_0 == BGMSwitchEnum.SelectType.All then
			return arg_19_0:getFilteredAllBgmsRandom()
		else
			return arg_19_0:getFilteredFavoriteBgmsRandom()
		end
	elseif var_19_0 == BGMSwitchEnum.SelectType.All then
		return arg_19_0:getFilteredAllBgmsSorted()
	else
		return arg_19_0:getFilteredFavoriteBgmsSorted()
	end

	return {}
end

function var_0_0.getReportBgmAudioLength(arg_20_0, arg_20_1)
	if arg_20_1 == nil then
		return 0
	end

	local var_20_0 = arg_20_1.audioLength

	if arg_20_1.isReport == 1 then
		local var_20_1 = WeatherController.instance:getCurrReport()

		if var_20_1 ~= nil then
			var_20_0 = var_20_1.audioLength
		end
	end

	return var_20_0
end

function var_0_0.getPlayingState(arg_21_0)
	return arg_21_0._playingState
end

function var_0_0.setPlayingState(arg_22_0, arg_22_1)
	arg_22_0._playingState = arg_22_1
end

function var_0_0.setEggHideState(arg_23_0, arg_23_1)
	arg_23_0._eggShowState = arg_23_1
end

function var_0_0.getEggHideState(arg_24_0)
	return arg_24_0._eggShowState
end

function var_0_0.setBgmFavorite(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0._bgmInfos[arg_25_1] then
		arg_25_0._bgmInfos[arg_25_1].favorite = arg_25_2 or not arg_25_0._bgmInfos[arg_25_1].favorite
		arg_25_0._isFilteredFavoriteListDirty = true
		arg_25_0._isUnfilteredFavoriteListDirty = true
	end
end

function var_0_0.isBgmFavorite(arg_26_0, arg_26_1)
	return arg_26_0._bgmInfos[arg_26_1] and arg_26_0._bgmInfos[arg_26_1].favorite or false
end

function var_0_0._sortBgm(arg_27_0, arg_27_1)
	local var_27_0 = BGMSwitchConfig.instance:getBGMSwitchCO(arg_27_0)
	local var_27_1 = BGMSwitchConfig.instance:getBGMSwitchCO(arg_27_1)

	return var_27_0.sort < var_27_1.sort
end

function var_0_0.setBGMSelectType(arg_28_0, arg_28_1)
	arg_28_0._selectType = arg_28_1

	arg_28_0:recordInfoByType(BGMSwitchEnum.RecordInfoType.ListType, arg_28_0._selectType, false)
end

function var_0_0.getBGMSelectType(arg_29_0)
	arg_29_0._selectType = arg_29_0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	return arg_29_0._selectType
end

function var_0_0.setCurBgm(arg_30_0, arg_30_1)
	if arg_30_1 == var_0_0.RandomBgmId then
		if arg_30_0._playMode ~= BGMSwitchEnum.PlayMode.Random then
			arg_30_0._playMode = BGMSwitchEnum.PlayMode.Random
			arg_30_0._curBgm = arg_30_0:getNextBgm(1, false)
		end
	else
		arg_30_0._playMode = BGMSwitchEnum.PlayMode.LoopOne
		arg_30_0._curBgm = arg_30_1
	end
end

function var_0_0.getCurBgm(arg_31_0)
	return arg_31_0._curBgm
end

function var_0_0.nextBgm(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0._curBgm = arg_32_0:getNextBgm(arg_32_1, arg_32_2)

	local var_32_0 = arg_32_0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
	local var_32_1 = arg_32_0:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	if arg_32_2 and var_32_1 ~= nil then
		var_32_0 = var_32_1
	end

	local var_32_2 = arg_32_0:isRandomMode()

	if arg_32_2 then
		var_32_2 = arg_32_0:isRandomBgmId(arg_32_0:getUsedBgmIdFromServer())
	end

	if var_32_2 and var_32_0 == BGMSwitchEnum.SelectType.Loved and #arg_32_0:getFilteredFavoriteBgmsRandom() == 0 then
		var_32_0 = BGMSwitchEnum.SelectType.All
	end

	if var_32_2 then
		local var_32_3 = -1
		local var_32_4 = -1

		if var_32_0 == BGMSwitchEnum.SelectType.All then
			var_32_3 = LuaUtil.indexOfElement(arg_32_0:getFilteredAllBgmsRandom(), arg_32_0._curBgm)
			var_32_4 = #arg_32_0:getFilteredAllBgmsRandom()
		else
			var_32_3 = LuaUtil.indexOfElement(arg_32_0:getFilteredFavoriteBgmsRandom(), arg_32_0._curBgm)
			var_32_4 = #arg_32_0:getFilteredFavoriteBgmsRandom()
		end

		if var_32_3 == 1 and arg_32_1 >= 1 then
			if var_32_0 == BGMSwitchEnum.SelectType.All then
				arg_32_0._curBgm = arg_32_0:regenerateRandomList(arg_32_0:getFilteredAllBgmsRandom(), true)
			else
				arg_32_0._curBgm = arg_32_0:regenerateRandomList(arg_32_0:getFilteredFavoriteBgmsRandom(), true)
			end
		elseif var_32_3 == var_32_4 and arg_32_1 <= -1 then
			if var_32_0 == BGMSwitchEnum.SelectType.All then
				arg_32_0._curBgm = arg_32_0:regenerateRandomList(arg_32_0:getFilteredAllBgmsRandom(), false)
			else
				arg_32_0._curBgm = arg_32_0:regenerateRandomList(arg_32_0:getFilteredFavoriteBgmsRandom(), false)
			end
		end
	end

	return arg_32_0._curBgm
end

function var_0_0.setUsedBgmIdFromServer(arg_33_0, arg_33_1)
	arg_33_0._useBgmIdFromServer = arg_33_1
end

function var_0_0.getUsedBgmIdFromServer(arg_34_0)
	return arg_34_0._useBgmIdFromServer
end

function var_0_0.getBgmIdByDistance(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = #arg_35_1

	if var_35_0 == 0 then
		return var_0_0.InvalidBgmId
	end

	local var_35_1 = LuaUtil.indexOfElement(arg_35_1, arg_35_2)

	if var_35_1 == -1 then
		return arg_35_1[1]
	end

	local var_35_2 = (var_35_1 + arg_35_3) % var_35_0

	if var_35_2 == 0 then
		var_35_2 = var_35_0
	elseif var_35_2 < 0 then
		var_35_2 = var_35_2 + var_35_0
	end

	return arg_35_1[var_35_2]
end

function var_0_0.getNextBgm(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0._curBgm
	local var_36_1 = 0
	local var_36_2 = arg_36_0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
	local var_36_3 = arg_36_0:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)

	if arg_36_2 and var_36_3 ~= nil then
		var_36_2 = var_36_3
	end

	local var_36_4 = arg_36_0:isRandomMode()

	if arg_36_2 then
		var_36_4 = arg_36_0:isRandomBgmId(arg_36_0:getUsedBgmIdFromServer())
	end

	if var_36_4 and var_36_2 == BGMSwitchEnum.SelectType.Loved and #arg_36_0:getFilteredFavoriteBgmsRandom() == 0 then
		var_36_2 = BGMSwitchEnum.SelectType.All
	end

	if var_36_2 == BGMSwitchEnum.SelectType.All then
		if var_36_4 then
			var_36_1 = arg_36_0:getBgmIdByDistance(arg_36_0:getFilteredAllBgmsRandom(), var_36_0, arg_36_1)
		else
			var_36_1 = arg_36_0:getBgmIdByDistance(arg_36_0:getFilteredAllBgmsSorted(), var_36_0, arg_36_1)
		end
	elseif var_36_4 then
		var_36_1 = arg_36_0:getBgmIdByDistance(arg_36_0:getFilteredFavoriteBgmsRandom(), var_36_0, arg_36_1)
	else
		var_36_1 = arg_36_0:getBgmIdByDistance(arg_36_0:getFilteredFavoriteBgmsSorted(), var_36_0, arg_36_1)
	end

	return var_36_1
end

function var_0_0.isRandomMode(arg_37_0)
	return arg_37_0._playMode == BGMSwitchEnum.PlayMode.Random
end

function var_0_0.isLoopOneMode(arg_38_0)
	return arg_38_0._playMode == BGMSwitchEnum.PlayMode.LoopOne
end

function var_0_0.isLocalRemoteListTypeMatched(arg_39_0)
	return arg_39_0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType) == arg_39_0:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
end

function var_0_0.isLocalRemoteBgmIdMatched(arg_40_0)
	local var_40_0 = arg_40_0:getCurBgm()

	if arg_40_0:isRandomMode() then
		var_40_0 = var_0_0.RandomBgmId
	end

	return var_40_0 == arg_40_0:getUsedBgmIdFromServer()
end

function var_0_0.isValidBgmId(arg_41_0, arg_41_1)
	return arg_41_1 ~= nil and arg_41_1 ~= var_0_0.RandomBgmId and arg_41_1 ~= var_0_0.InvalidBgmId
end

function var_0_0.isRandomBgmId(arg_42_0, arg_42_1)
	return arg_42_1 == var_0_0.RandomBgmId
end

function var_0_0.getBGMPlayMode(arg_43_0)
	return arg_43_0._playMode
end

function var_0_0.setMechineGear(arg_44_0, arg_44_1)
	arg_44_0._curMechineGear = arg_44_1

	arg_44_0:recordInfoByType(BGMSwitchEnum.RecordInfoType.BGMSwitchGear, arg_44_0._curMechineGear, true)
end

function var_0_0.getMechineGear(arg_45_0)
	arg_45_0._curMechineGear = arg_45_0:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.BGMSwitchGear)

	return arg_45_0._curMechineGear
end

function var_0_0.machineGearIsNeedPlayBgm(arg_46_0)
	return arg_46_0._curMechineGear == BGMSwitchEnum.Gear.On1
end

function var_0_0.machineGearIsInSnowflakeScene(arg_47_0)
	return arg_47_0._curMechineGear == BGMSwitchEnum.Gear.On2 or arg_47_0._curMechineGear == BGMSwitchEnum.Gear.On3
end

function var_0_0.setAudioCurShowType(arg_48_0, arg_48_1)
	arg_48_0._curAudioShowType = arg_48_1
end

function var_0_0.getAudioCurShowType(arg_49_0)
	return arg_49_0._curAudioShowType
end

function var_0_0.setEggIsTrigger(arg_50_0, arg_50_1)
	arg_50_0._eggIsTrigger = arg_50_1
end

function var_0_0.getEggIsTrigger(arg_51_0)
	return arg_51_0._eggIsTrigger
end

function var_0_0.setPPtEffectEgg2Id(arg_52_0, arg_52_1)
	arg_52_0._pptEffectEgg2Id = arg_52_1
end

function var_0_0.getPPtEffectEgg2Id(arg_53_0)
	return arg_53_0._pptEffectEgg2Id
end

function var_0_0.setFilterType(arg_54_0, arg_54_1, arg_54_2)
	arg_54_0._filterTypes[arg_54_1] = arg_54_2
	arg_54_0._isFilteredAllListDirty = true
	arg_54_0._isFilteredFavoriteListDirty = true
end

function var_0_0.getFilterTypeSelectState(arg_55_0, arg_55_1)
	return arg_55_0._filterTypes[arg_55_1]
end

function var_0_0.clearFilterTypes(arg_56_0)
	arg_56_0._filterTypes = {}
	arg_56_0._isFilteredAllListDirty = true
	arg_56_0._isFilteredFavoriteListDirty = true
end

function var_0_0.isFilterMode(arg_57_0)
	for iter_57_0, iter_57_1 in pairs(arg_57_0._filterTypes) do
		if iter_57_1 ~= nil and iter_57_1 == true then
			return true
		end
	end

	return false
end

function var_0_0.getEggType2Sates(arg_58_0)
	return arg_58_0._egg2State
end

function var_0_0.getEggType2SateByIndex(arg_59_0, arg_59_1)
	return arg_59_0._egg2State[arg_59_1]
end

function var_0_0.setEggType2State(arg_60_0, arg_60_1, arg_60_2)
	arg_60_0._egg2State[arg_60_1] = arg_60_2
end

function var_0_0.recordInfoByType(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	arg_61_0._recordBgmInfos[arg_61_1] = arg_61_2

	if arg_61_3 then
		arg_61_0:_recordInfo(arg_61_1, arg_61_2)
	end
end

function var_0_0._recordInfo(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = {}

	for iter_62_0, iter_62_1 in pairs(arg_62_0._recordBgmInfos) do
		local var_62_1 = arg_62_0:getServerRecordInfoByType(iter_62_0)

		if var_62_1 then
			var_62_0[iter_62_0] = var_62_1
		else
			var_62_0[iter_62_0] = iter_62_1
		end
	end

	var_62_0[arg_62_1] = arg_62_2

	local var_62_2 = arg_62_0:encodeRecordInfo(var_62_0)

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.BGMViewInfo, var_62_2)
end

function var_0_0.encodeRecordInfo(arg_63_0, arg_63_1)
	local var_63_0 = ""

	for iter_63_0, iter_63_1 in pairs(arg_63_1) do
		var_63_0 = var_63_0 .. iter_63_0 .. ":" .. iter_63_1 .. "|"
	end

	return var_63_0
end

function var_0_0.decodeRecordInfo(arg_64_0, arg_64_1)
	local var_64_0 = {}
	local var_64_1 = string.split(arg_64_1, "|")

	for iter_64_0 = 1, #var_64_1 do
		if var_64_1[iter_64_0] then
			local var_64_2 = string.split(var_64_1[iter_64_0], ":")

			if var_64_2 and #var_64_2 > 1 then
				var_64_0[tonumber(var_64_2[1])] = tonumber(var_64_2[2])
			end
		end
	end

	return var_64_0
end

function var_0_0.getRecordInfoByType(arg_65_0, arg_65_1)
	if arg_65_0._recordBgmInfos and #arg_65_0._recordBgmInfos <= 0 and not arg_65_0._recordBgmInfos[arg_65_1] then
		local var_65_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.BGMViewInfo)

		if var_65_0 then
			arg_65_0._recordBgmInfos = arg_65_0:decodeRecordInfo(var_65_0)
		end
	end

	if not arg_65_0._recordBgmInfos[arg_65_1] then
		if arg_65_1 == BGMSwitchEnum.RecordInfoType.ListType then
			return BGMSwitchEnum.SelectType.All
		end

		if arg_65_1 == BGMSwitchEnum.RecordInfoType.BGMSwitchGear then
			return BGMSwitchEnum.Gear.On1
		end
	end

	return arg_65_0._recordBgmInfos[arg_65_1]
end

function var_0_0.getServerRecordInfoByType(arg_66_0, arg_66_1)
	local var_66_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.BGMViewInfo)

	if var_66_0 then
		local var_66_1 = arg_66_0:decodeRecordInfo(var_66_0)

		if var_66_1[arg_66_1] then
			return var_66_1[arg_66_1]
		end
	end

	if arg_66_1 == BGMSwitchEnum.RecordInfoType.ListType then
		return BGMSwitchEnum.SelectType.All
	end

	if arg_66_1 == BGMSwitchEnum.RecordInfoType.BGMSwitchGear then
		return BGMSwitchEnum.Gear.On1
	end
end

function var_0_0.markRead(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0._bgmInfos[arg_67_1]

	if var_67_0 then
		var_67_0.isRead = true
	end
end

function var_0_0.getUnReadCount(arg_68_0)
	local var_68_0 = 0

	for iter_68_0, iter_68_1 in pairs(arg_68_0._bgmInfos) do
		if not iter_68_1.isRead then
			var_68_0 = var_68_0 + 1
		end
	end

	return var_68_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
