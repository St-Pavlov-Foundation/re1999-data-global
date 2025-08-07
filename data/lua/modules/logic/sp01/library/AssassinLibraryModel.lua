module("modules.logic.sp01.library.AssassinLibraryModel", package.seeall)

local var_0_0 = class("AssassinLibraryModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._statusMap = {}
	arg_1_0._hasReadLibraryIdMap = {}
	arg_1_0._hasReadLibraryIds = {}
	arg_1_0._hasPlayUnlockAnimList = nil
	arg_1_0._isLoadLocalData = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.loadHasReadLibraryIdsFromLocal(arg_3_0)
	if arg_3_0._isLoadLocalData then
		return
	end

	local var_3_0 = PlayerPrefsHelper.getString(arg_3_0:_getLibraryHasReadIdMapKey(), "")
	local var_3_1 = string.splitToNumber(var_3_0, "#")

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		arg_3_0:setLibraryStatus(iter_3_1, AssassinEnum.LibraryStatus.Unlocked)
	end

	arg_3_0._isLoadLocalData = true
end

function var_0_0.updateLibraryInfos(arg_4_0, arg_4_1)
	arg_4_0:loadHasReadLibraryIdsFromLocal()

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = arg_4_0:getLibraryStatus(iter_4_1)
		local var_4_1 = (var_4_0 == AssassinEnum.LibraryStatus.Locked or var_4_0 == AssassinEnum.LibraryStatus.New) and AssassinEnum.LibraryStatus.New or AssassinEnum.LibraryStatus.Unlocked

		arg_4_0:setLibraryStatus(iter_4_1, var_4_1)
	end
end

function var_0_0.switch(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._actId = arg_5_1
	arg_5_0._libType = arg_5_2
end

function var_0_0.getCurActId(arg_6_0)
	return arg_6_0._actId
end

function var_0_0.getCurLibType(arg_7_0)
	return arg_7_0._libType
end

function var_0_0.getLibraryStatus(arg_8_0, arg_8_1)
	return arg_8_0._statusMap[arg_8_1] or AssassinEnum.LibraryStatus.Locked
end

function var_0_0.setLibraryStatus(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 == AssassinEnum.LibraryStatus.Unlocked and not arg_9_0._hasReadLibraryIdMap[arg_9_1] then
		arg_9_0._hasReadLibraryIdMap[arg_9_1] = true

		table.insert(arg_9_0._hasReadLibraryIds, arg_9_1)
	end

	arg_9_0._statusMap[arg_9_1] = arg_9_2
end

function var_0_0.readLibrary(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getLibraryStatus(arg_10_1)

	if var_10_0 == AssassinEnum.LibraryStatus.Locked then
		return
	end

	arg_10_0:setLibraryStatus(arg_10_1, AssassinEnum.LibraryStatus.Unlocked)

	if var_10_0 == AssassinEnum.LibraryStatus.New then
		arg_10_0:saveLocalHasReadLibraryIds()
		AssassinController.instance:dispatchEvent(AssassinEvent.UpdateLibraryReddot)
	end
end

function var_0_0.readTypeLibrarys(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = AssassinConfig.instance:getLibraryConfigs(arg_11_1, arg_11_2)

	if not var_11_0 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		arg_11_0:readLibrary(iter_11_1.id)
	end
end

function var_0_0.saveLocalHasReadLibraryIds(arg_12_0)
	local var_12_0 = table.concat(arg_12_0._hasReadLibraryIds, "#")

	PlayerPrefsHelper.setString(arg_12_0:_getLibraryHasReadIdMapKey(), var_12_0)
end

function var_0_0._getLibraryHasReadIdMapKey(arg_13_0)
	return PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.AssassinLibraryHasReadIdMap)
end

function var_0_0.isAnyLibraryNewUnlock(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._statusMap) do
		if iter_14_1 == AssassinEnum.LibraryStatus.New then
			return true
		end
	end

	return false
end

function var_0_0.getNewUnlockLibraryIdMap(arg_15_0, arg_15_1)
	local var_15_0 = {}
	local var_15_1 = AssassinConfig.instance:getActLibraryConfigDict(arg_15_1)

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		var_15_0[iter_15_0] = false

		for iter_15_2, iter_15_3 in ipairs(iter_15_1) do
			if arg_15_0:getLibraryStatus(iter_15_3.id) == AssassinEnum.LibraryStatus.New then
				var_15_0[iter_15_0] = true

				break
			end
		end
	end

	return var_15_0
end

function var_0_0.isUnlockAllLibrarys(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = AssassinConfig.instance:getLibraryConfigs(arg_16_1, arg_16_2)

	for iter_16_0, iter_16_1 in ipairs(var_16_0 or {}) do
		if arg_16_0:getLibraryStatus(iter_16_1.id) == AssassinEnum.LibraryStatus.Locked then
			return false
		end
	end

	return true
end

function var_0_0.isLibraryNeedPlayUnlockAnim(arg_17_0, arg_17_1)
	if arg_17_0:getLibraryStatus(arg_17_1) == AssassinEnum.LibraryStatus.Locked then
		return
	end

	return not arg_17_0:_isUnlockAnimMapContains(arg_17_1)
end

function var_0_0._isUnlockAnimMapContains(arg_18_0, arg_18_1)
	if not arg_18_0._hasPlayUnlockAnimList then
		local var_18_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.AssassinLibraryHasPlayUnlockAnimIds)
		local var_18_1 = PlayerPrefsHelper.getString(var_18_0, "")

		arg_18_0._hasPlayUnlockAnimList = string.splitToNumber(var_18_1, "#")
	end

	return tabletool.indexOf(arg_18_0._hasPlayUnlockAnimList, arg_18_1) ~= nil
end

function var_0_0.markLibraryHasPlayUnlockAnim(arg_19_0, arg_19_1)
	if not arg_19_0:_isUnlockAnimMapContains(arg_19_1) then
		table.insert(arg_19_0._hasPlayUnlockAnimList, arg_19_1)

		local var_19_0 = table.concat(arg_19_0._hasPlayUnlockAnimList, "#")
		local var_19_1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.AssassinLibraryHasPlayUnlockAnimIds)

		PlayerPrefsHelper.setString(var_19_1, var_19_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
