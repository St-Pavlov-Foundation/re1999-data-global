module("modules.logic.room.model.map.RoomCharacterModel", package.seeall)

local var_0_0 = class("RoomCharacterModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	arg_4_0._tempCharacterMO = nil
	arg_4_0._canConfirmPlaceDict = nil
	arg_4_0._allNodePositionList = nil
	arg_4_0._cantWadeNodePositionList = nil
	arg_4_0._canDragCharacter = false
	arg_4_0._waterNodePositions = nil
	arg_4_0._hideFaithFullMap = {}
	arg_4_0._emptyBlockPositions = nil
	arg_4_0._showBirthdayToastTipCache = nil
end

function var_0_0.initCharacter(arg_5_0, arg_5_1)
	arg_5_0:clear()

	if not arg_5_1 or #arg_5_1 <= 0 then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = RoomInfoHelper.serverInfoToCharacterInfo(iter_5_1)
		local var_5_1 = RoomModel.instance:getCharacterPosition(var_5_0.heroId)

		if var_5_1 then
			var_5_0.currentPosition = RoomCharacterHelper.reCalculateHeight(var_5_1)
		end

		local var_5_2 = RoomCharacterMO.New()

		var_5_2:init(var_5_0)

		if RoomConfig.instance:getRoomCharacterConfig(var_5_2.skinId) then
			arg_5_0:_addCharacterMO(var_5_2)
		end
	end

	arg_5_0:_initHideFithData()
end

function var_0_0.addTempCharacterMO(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0._tempCharacterMO then
		return
	end

	arg_6_0._tempCharacterMO = RoomCharacterMO.New()

	local var_6_0 = RoomInfoHelper.generateTempCharacterInfo(arg_6_1, arg_6_2, arg_6_3)

	arg_6_0._tempCharacterMO:init(var_6_0)
	RoomCharacterController.instance:correctCharacterHeight(arg_6_0._tempCharacterMO)
	arg_6_0:_addCharacterMO(arg_6_0._tempCharacterMO)
	arg_6_0:clearCanConfirmPlaceDict()

	return arg_6_0._tempCharacterMO
end

function var_0_0.getTempCharacterMO(arg_7_0)
	return arg_7_0._tempCharacterMO
end

function var_0_0.changeTempCharacterMO(arg_8_0, arg_8_1)
	if not arg_8_0._tempCharacterMO then
		return
	end

	arg_8_0._tempCharacterMO:setPosition(RoomCharacterHelper.reCalculateHeight(arg_8_1))
end

function var_0_0.removeTempCharacterMO(arg_9_0)
	if not arg_9_0._tempCharacterMO then
		return
	end

	arg_9_0:_removeCharacterMO(arg_9_0._tempCharacterMO)

	arg_9_0._tempCharacterMO = nil

	arg_9_0:clearCanConfirmPlaceDict()
end

function var_0_0.placeTempCharacterMO(arg_10_0)
	if not arg_10_0._tempCharacterMO then
		return
	end

	RoomCharacterController.instance:correctCharacterHeight(arg_10_0._tempCharacterMO)

	arg_10_0._tempCharacterMO.characterState = RoomCharacterEnum.CharacterState.Map
	arg_10_0._tempCharacterMO = nil

	arg_10_0:clearCanConfirmPlaceDict()
end

function var_0_0.revertTempCharacterMO(arg_11_0, arg_11_1)
	if arg_11_0._tempCharacterMO then
		return
	end

	arg_11_0._tempCharacterMO = arg_11_0:getCharacterMOById(arg_11_1)

	if not arg_11_0._tempCharacterMO then
		return
	end

	arg_11_0._tempCharacterMO.characterState = RoomCharacterEnum.CharacterState.Revert
	arg_11_0._revertPosition = arg_11_0._tempCharacterMO.currentPosition

	arg_11_0:clearCanConfirmPlaceDict()

	return arg_11_0._tempCharacterMO
end

function var_0_0.removeRevertCharacterMO(arg_12_0)
	if not arg_12_0._tempCharacterMO then
		return
	end

	local var_12_0 = arg_12_0._tempCharacterMO.heroId

	arg_12_0._tempCharacterMO:setPosition(RoomCharacterHelper.reCalculateHeight(arg_12_0._revertPosition))

	arg_12_0._tempCharacterMO.characterState = RoomCharacterEnum.CharacterState.Map
	arg_12_0._tempCharacterMO = nil

	arg_12_0:clearCanConfirmPlaceDict()

	return var_12_0, arg_12_0._revertPosition
end

function var_0_0.unUseRevertCharacterMO(arg_13_0)
	if not arg_13_0._tempCharacterMO then
		return
	end

	arg_13_0:_removeCharacterMO(arg_13_0._tempCharacterMO)

	arg_13_0._tempCharacterMO = nil

	arg_13_0:clearCanConfirmPlaceDict()
end

function var_0_0.getRevertPosition(arg_14_0)
	return arg_14_0._revertPosition
end

function var_0_0.resetCharacterMO(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getById(arg_15_1)

	if not var_15_0 then
		return
	end

	var_15_0:endMove()
	var_15_0:setPosition(RoomCharacterHelper.reCalculateHeight(arg_15_2))
end

function var_0_0.deleteCharacterMO(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getById(arg_16_1)

	if not var_16_0 then
		return
	end

	arg_16_0:_removeCharacterMO(var_16_0)
	arg_16_0:setHideFaithFull(arg_16_1, false)
end

function var_0_0.endAllMove(arg_17_0)
	local var_17_0 = arg_17_0:getList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		iter_17_1:endMove()
	end
end

function var_0_0.getConfirmCharacterCount(arg_18_0)
	local var_18_0 = arg_18_0:getList()
	local var_18_1 = 0

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if (iter_18_1.characterState == RoomCharacterEnum.CharacterState.Map or iter_18_1.characterState == RoomCharacterEnum.CharacterState.Revert) and iter_18_1:isPlaceSourceState() then
			var_18_1 = var_18_1 + 1
		end
	end

	return var_18_1
end

function var_0_0.getMaxCharacterCount(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2 or RoomMapModel.instance:getRoomLevel()
	local var_19_1 = RoomConfig.instance:getRoomLevelConfig(var_19_0)
	local var_19_2 = var_19_1 and var_19_1.characterLimit or 0
	local var_19_3 = arg_19_1 or RoomMapModel.instance:getAllBuildDegree()

	return var_19_2 + RoomConfig.instance:getCharacterLimitAddByBuildDegree(var_19_3)
end

function var_0_0.refreshCanConfirmPlaceDict(arg_20_0)
	if not arg_20_0._tempCharacterMO then
		arg_20_0._canConfirmPlaceDict = {}
	else
		arg_20_0._canConfirmPlaceDict = RoomCharacterHelper.getCanConfirmPlaceDict(arg_20_0._tempCharacterMO.heroId, arg_20_0._tempCharacterMO.skinId)
	end
end

function var_0_0.isCanConfirm(arg_21_0, arg_21_1)
	if not arg_21_0._canConfirmPlaceDict then
		arg_21_0:refreshCanConfirmPlaceDict()
	end

	return arg_21_0._canConfirmPlaceDict[arg_21_1.x] and arg_21_0._canConfirmPlaceDict[arg_21_1.x][arg_21_1.y]
end

function var_0_0.getCanConfirmPlaceDict(arg_22_0)
	if not arg_22_0._canConfirmPlaceDict then
		arg_22_0:refreshCanConfirmPlaceDict()
	end

	return arg_22_0._canConfirmPlaceDict
end

function var_0_0.clearCanConfirmPlaceDict(arg_23_0)
	arg_23_0._canConfirmPlaceDict = nil
end

function var_0_0._refreshNodePositionList(arg_24_0)
	arg_24_0._allNodePositionList = {}

	local var_24_0 = ZProj.AStarPathBridge.GetNodePositions(RoomCharacterHelper.getTag(true))

	RoomHelper.cArrayToLuaTable(var_24_0, arg_24_0._allNodePositionList)

	arg_24_0._cantWadeNodePositionList = {}

	local var_24_1 = ZProj.AStarPathBridge.GetNodePositions(RoomCharacterHelper.getTag(false))

	RoomHelper.cArrayToLuaTable(var_24_1, arg_24_0._cantWadeNodePositionList)
end

function var_0_0.getNodePositionList(arg_25_0, arg_25_1)
	if not arg_25_0._allNodePositionList or not arg_25_0._cantWadeNodePositionList then
		arg_25_0:_refreshNodePositionList()
	end

	return arg_25_1 and arg_25_0._allNodePositionList or arg_25_0._cantWadeNodePositionList
end

function var_0_0.clearNodePositionList(arg_26_0)
	arg_26_0._cantWadeNodePositionList = nil
	arg_26_0._allNodePositionList = nil
end

function var_0_0._addCharacterMO(arg_27_0, arg_27_1)
	arg_27_0:addAtLast(arg_27_1)
end

function var_0_0._removeCharacterMO(arg_28_0, arg_28_1)
	arg_28_0:remove(arg_28_1)
end

function var_0_0.editRemoveCharacterMO(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getById(arg_29_1)

	if var_29_0 then
		arg_29_0:_removeCharacterMO(var_29_0)
	end
end

function var_0_0.getCharacterMOById(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getById(arg_30_1)

	if not var_30_0 and arg_30_0._trainTempMO and arg_30_0._trainTempMO.id == arg_30_1 then
		return arg_30_0._trainTempMO
	end

	return var_30_0
end

function var_0_0.updateCharacterFaith(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
		local var_31_0 = arg_31_0:getCharacterMOById(iter_31_1.heroId)

		if var_31_0 then
			var_31_0.currentFaith = iter_31_1.currentFaith
			var_31_0.currentMinute = iter_31_1.currentMinute
			var_31_0.nextRefreshTime = iter_31_1.nextRefreshTime
		end
	end
end

function var_0_0.setCanDragCharacter(arg_32_0, arg_32_1)
	arg_32_0._canDragCharacter = arg_32_1
end

function var_0_0.canDragCharacter(arg_33_0)
	return arg_33_0._canDragCharacter
end

function var_0_0._refreshWaterNodePositions(arg_34_0)
	arg_34_0._waterNodePositions = {}

	local var_34_0 = ZProj.AStarPathBridge.GetNodePositions(bit.lshift(1, RoomEnum.AStarLayerTag.Water))

	if var_34_0 then
		local var_34_1 = var_34_0:GetEnumerator()

		while var_34_1:MoveNext() do
			table.insert(arg_34_0._waterNodePositions, var_34_1.Current)
		end
	end
end

function var_0_0.getWaterNodePositions(arg_35_0)
	if not arg_35_0._waterNodePositions then
		arg_35_0:_refreshWaterNodePositions()
	end

	return arg_35_0._waterNodePositions
end

function var_0_0.setHideFaithFull(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_2 and not arg_36_0._hideFaithFullMap[arg_36_1] then
		return
	end

	local var_36_0 = arg_36_2 and true or false

	if var_36_0 ~= arg_36_0._hideFaithFullMap[arg_36_1] then
		arg_36_0._hideFaithFullMap[arg_36_1] = var_36_0

		arg_36_0:_saveFaithFullData(arg_36_0._hideFaithFullMap)
	end
end

function var_0_0.isShowFaithFull(arg_37_0, arg_37_1)
	if arg_37_0._hideFaithFullMap[arg_37_1] then
		return false
	end

	return true
end

function var_0_0._getFaithFullPrefsKey(arg_38_0)
	return "room_character_faithfull_role#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function var_0_0._initHideFithData(arg_39_0)
	arg_39_0._hideFaithFullMap = {}

	if arg_39_0:_canUseFaithFull() then
		local var_39_0 = PlayerPrefsHelper.getString(arg_39_0:_getFaithFullPrefsKey(), "")
		local var_39_1 = string.splitToNumber(var_39_0, "#") or {}
		local var_39_2 = false

		for iter_39_0, iter_39_1 in ipairs(var_39_1) do
			if arg_39_0:getById(iter_39_1) then
				arg_39_0._hideFaithFullMap[iter_39_1] = true
			else
				var_39_2 = true
			end
		end

		if var_39_2 then
			arg_39_0:_saveFaithFullData(arg_39_0._hideFaithFullMap)
		end
	end
end

function var_0_0._saveFaithFullData(arg_40_0, arg_40_1)
	if not arg_40_0:_canUseFaithFull() or not arg_40_1 then
		return
	end

	local var_40_0 = ""
	local var_40_1 = true

	for iter_40_0, iter_40_1 in pairs(arg_40_1) do
		if iter_40_1 == true then
			if var_40_1 then
				var_40_1 = false
				var_40_0 = tostring(iter_40_0)
			else
				var_40_0 = var_40_0 .. "#" .. tostring(iter_40_0)
			end
		end
	end

	PlayerPrefsHelper.setString(arg_40_0:_getFaithFullPrefsKey(), var_40_0)
end

function var_0_0._canUseFaithFull(arg_41_0)
	local var_41_0 = RoomModel.instance:getGameMode()

	return var_41_0 == RoomEnum.GameMode.Ob or var_41_0 == RoomEnum.GameMode.Edit
end

function var_0_0.getEmptyBlockPositions(arg_42_0)
	if not arg_42_0._emptyBlockPositions then
		arg_42_0._emptyBlockPositions = {}

		local var_42_0 = RoomMapBlockModel.instance:getEmptyBlockMOList()

		for iter_42_0, iter_42_1 in ipairs(var_42_0) do
			if iter_42_1.hexPoint then
				table.insert(arg_42_0._emptyBlockPositions, HexMath.hexToPosition(iter_42_1.hexPoint, RoomBlockEnum.BlockSize))
			end
		end
	end

	return arg_42_0._emptyBlockPositions
end

function var_0_0.isOnBirthday(arg_43_0, arg_43_1)
	local var_43_0 = false
	local var_43_1 = arg_43_1 and HeroConfig.instance:getHeroCO(arg_43_1)
	local var_43_2 = var_43_1 and var_43_1.roleBirthday

	if not string.nilorempty(var_43_2) then
		local var_43_3 = SignInModel.instance:getCurDate()
		local var_43_4 = string.splitToNumber(var_43_1.roleBirthday, "/")
		local var_43_5 = {
			hour = 5,
			min = 0,
			sec = 0,
			year = var_43_3.year,
			month = var_43_4[1],
			day = var_43_4[2]
		}
		local var_43_6 = os.time(var_43_5) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
		local var_43_7 = var_43_6 + CommonConfig.instance:getConstNum(ConstEnum.RoomBirthdayDurationDay) * TimeUtil.OneDaySecond
		local var_43_8 = ServerTime.now()

		if var_43_6 <= var_43_8 and var_43_8 < var_43_7 then
			var_43_0 = true
		end
	end

	return var_43_0
end

function var_0_0.initShowBirthdayToastTipCache(arg_44_0)
	local var_44_0 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.RoomBirthdayToastKey, "")

	if not string.nilorempty(var_44_0) then
		arg_44_0._showBirthdayToastTipCache = cjson.decode(var_44_0)
	end

	arg_44_0._showBirthdayToastTipCache = arg_44_0._showBirthdayToastTipCache or {}
end

function var_0_0.isNeedShowBirthdayToastTip(arg_45_0, arg_45_1)
	local var_45_0 = false

	if not arg_45_1 then
		return var_45_0
	end

	local var_45_1 = false

	if not arg_45_0._showBirthdayToastTipCache then
		arg_45_0:initShowBirthdayToastTipCache()
	end

	local var_45_2 = tostring(arg_45_1)
	local var_45_3 = arg_45_0._showBirthdayToastTipCache[var_45_2]

	if var_45_3 then
		local var_45_4 = ServerTime.now()

		var_45_1 = TimeUtil.isSameDay(var_45_3, var_45_4 - TimeDispatcher.DailyRefreshSecond)
	end

	return arg_45_0:isOnBirthday(arg_45_1) and not var_45_1
end

function var_0_0.getPlaceCount(arg_46_0)
	local var_46_0 = 0
	local var_46_1 = arg_46_0:getList()

	for iter_46_0, iter_46_1 in ipairs(var_46_1) do
		if iter_46_1:isPlaceSourceState() then
			var_46_0 = var_46_0 + 1
		end
	end

	return var_46_0
end

function var_0_0.setHasShowBirthdayToastTip(arg_47_0, arg_47_1)
	if not arg_47_1 then
		return
	end

	if not arg_47_0._showBirthdayToastTipCache then
		arg_47_0:initShowBirthdayToastTipCache()
	end

	local var_47_0 = ServerTime.now() - TimeDispatcher.DailyRefreshSecond
	local var_47_1 = tostring(arg_47_1)

	arg_47_0._showBirthdayToastTipCache[var_47_1] = var_47_0

	local var_47_2 = cjson.encode(arg_47_0._showBirthdayToastTipCache)

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.RoomBirthdayToastKey, var_47_2)
end

function var_0_0.getTrainTempMO(arg_48_0)
	if not arg_48_0._trainTempMO then
		arg_48_0._trainTempMO = RoomCharacterMO.New()
	end

	return arg_48_0._trainTempMO
end

var_0_0.instance = var_0_0.New()

return var_0_0
