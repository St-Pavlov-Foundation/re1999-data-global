module("modules.logic.room.model.RoomModel", package.seeall)

local var_0_0 = class("RoomModel", BaseModel)

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
	arg_4_0._eidtInfo = nil
	arg_4_0._obInfo = nil
	arg_4_0._visitParam = nil
	arg_4_0._enterParam = nil
	arg_4_0._gameMode = RoomEnum.GameMode.Ob
	arg_4_0._debugParam = nil
	arg_4_0._roomInfoDict = {}
	arg_4_0._buildingInfoDict = {}
	arg_4_0._buildingIdCountDict = {}
	arg_4_0._clickBuildingUidDict = {}
	arg_4_0._buildingInfoList = {}
	arg_4_0._formulaIdCountDict = {}
	arg_4_0._blockPackageIds = {}
	arg_4_0._specialBlockIds = {}
	arg_4_0._specialBlockInfoList = {}
	arg_4_0._themeItemMOListDict = {}
	arg_4_0._roomLevel = 0
	arg_4_0._interactionCount = 0
	arg_4_0._existInteractionDict = {}
	arg_4_0._characterPositionDict = {}
	arg_4_0._hasGetRoomThemes = {}
	arg_4_0._hasEdit = nil
	arg_4_0._roadInfoListDict = {}
	arg_4_0._atmosphereCacheData = nil

	if arg_4_0._characterModel then
		arg_4_0._characterModel:clear()
	else
		arg_4_0._characterModel = BaseModel.New()
	end
end

function var_0_0.setEditInfo(arg_5_0, arg_5_1)
	arg_5_0._eidtInfo = arg_5_1

	arg_5_0:_setInfoByMode(arg_5_1, RoomEnum.GameMode.Edit)

	if arg_5_1 and arg_5_1.blockPackages then
		arg_5_0:_addBlockPackageIdByPackageInfos(arg_5_1.blockPackages)
	end
end

function var_0_0.getEditInfo(arg_6_0)
	return arg_6_0._eidtInfo
end

function var_0_0.setObInfo(arg_7_0, arg_7_1)
	arg_7_0._obInfo = arg_7_1

	arg_7_0:_setInfoByMode(arg_7_1, RoomEnum.GameMode.Ob)

	if arg_7_1 and arg_7_1.blockPackages then
		arg_7_0:_addBlockPackageIdByPackageInfos(arg_7_1.blockPackages)
	end

	if arg_7_1 and arg_7_1.hasGetRoomThemes then
		arg_7_0:setGetThemeRewardIds(arg_7_1.hasGetRoomThemes)
	end
end

function var_0_0.getObInfo(arg_8_0)
	return arg_8_0._obInfo
end

function var_0_0.setInfoByMode(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 == RoomEnum.GameMode.Ob then
		arg_9_0:setObInfo(arg_9_1)
	elseif arg_9_2 == RoomEnum.GameMode.Edit then
		arg_9_0:setEditInfo(arg_9_1)
	else
		arg_9_0:_setInfoByMode(arg_9_1, arg_9_2)
	end
end

function var_0_0._setInfoByMode(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._roomInfoDict[arg_10_2] = arg_10_1

	arg_10_0:setRoadInfoListByMode(arg_10_1 and arg_10_1.roadInfos, arg_10_2)
end

function var_0_0.getRoadInfoListByMode(arg_11_0, arg_11_1)
	return arg_11_0._roadInfoListDict[arg_11_1]
end

function var_0_0.setRoadInfoListByMode(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	arg_12_0._roadInfoListDict[arg_12_2] = var_12_0

	if arg_12_1 then
		for iter_12_0 = 1, #arg_12_1 do
			table.insert(var_12_0, RoomTransportHelper.serverRoadInfo2Info(arg_12_1[iter_12_0]))
		end
	end
end

function var_0_0.removeRoadInfoByIdsMode(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._roadInfoListDict[arg_13_2]

	if var_13_0 then
		for iter_13_0 = #var_13_0, 1, -1 do
			local var_13_1 = var_13_0[iter_13_0]

			if tabletool.indexOf(arg_13_1, var_13_1.id) then
				table.remove(var_13_0, iter_13_0)
			end
		end
	end
end

function var_0_0.getInfoByMode(arg_14_0, arg_14_1)
	return arg_14_0._roomInfoDict[arg_14_1]
end

function var_0_0.setGameMode(arg_15_0, arg_15_1)
	arg_15_0._gameMode = arg_15_1
end

function var_0_0.getGameMode(arg_16_0)
	return arg_16_0._gameMode
end

function var_0_0.setEnterParam(arg_17_0, arg_17_1)
	arg_17_0._enterParam = arg_17_1
end

function var_0_0.getEnterParam(arg_18_0)
	return arg_18_0._enterParam
end

function var_0_0.setVisitParam(arg_19_0, arg_19_1)
	arg_19_0._visitParam = arg_19_1
end

function var_0_0.getVisitParam(arg_20_0)
	return arg_20_0._visitParam
end

function var_0_0.setDebugParam(arg_21_0, arg_21_1)
	arg_21_0._debugParam = arg_21_1
end

function var_0_0.getDebugParam(arg_22_0)
	return arg_22_0._debugParam
end

function var_0_0.getBuildingInfoList(arg_23_0)
	return arg_23_0._buildingInfoList
end

function var_0_0.resetBuildingInfos(arg_24_0)
	local var_24_0 = arg_24_0._buildingInfoList

	for iter_24_0 = 1, #var_24_0 do
		var_24_0[iter_24_0].use = false
	end
end

function var_0_0.setBuildingInfos(arg_25_0, arg_25_1)
	arg_25_0._buildingIdCountDict = {}
	arg_25_0._buildingInfoList = {}
	arg_25_0._buildingInfoDict = {}

	arg_25_0:updateBuildingInfos(arg_25_1)
end

function var_0_0.updateBuildingInfos(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		local var_26_0 = iter_26_1.defineId
		local var_26_1 = arg_26_0._buildingInfoDict[iter_26_1.uid]

		if not var_26_1 then
			var_26_1 = {}
			arg_26_0._buildingInfoDict[iter_26_1.uid] = var_26_1
			var_26_1.uid = iter_26_1.uid
			var_26_1.buildingId = var_26_0
			var_26_1.defineId = var_26_0

			table.insert(arg_26_0._buildingInfoList, var_26_1)

			arg_26_0._buildingIdCountDict[var_26_0] = (arg_26_0._buildingIdCountDict[var_26_0] or 0) + 1
		end

		var_26_1.use = iter_26_1.use or false
		var_26_1.x = iter_26_1.x or 0
		var_26_1.y = iter_26_1.y or 0
		var_26_1.rotate = iter_26_1.rotate or 0
		var_26_1.level = iter_26_1.level or 0
	end
end

function var_0_0.getBuildingCount(arg_27_0, arg_27_1)
	return arg_27_0._buildingIdCountDict[arg_27_1] or 0
end

function var_0_0.getBuildingInfoByBuildingUid(arg_28_0, arg_28_1)
	return arg_28_0._buildingInfoDict[arg_28_1]
end

function var_0_0.blockPackageGainPush(arg_29_0, arg_29_1)
	arg_29_0:_addBlockPackageIdByPackageInfos(arg_29_1.blockPackages)
end

function var_0_0._addBlockPackageIdByPackageInfos(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return
	end

	for iter_30_0 = 1, #arg_30_1 do
		arg_30_0:_addBlockPackageId(arg_30_1[iter_30_0].blockPackageId)
	end
end

function var_0_0._addBlockPackageId(arg_31_0, arg_31_1)
	if not arg_31_0:isHasBlockPackageById(arg_31_1) then
		table.insert(arg_31_0._blockPackageIds, arg_31_1)
	end
end

function var_0_0.setGetThemeRewardIds(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return
	end

	arg_32_0._hasGetRoomThemes = {}

	for iter_32_0 = 1, #arg_32_1 do
		table.insert(arg_32_0._hasGetRoomThemes, arg_32_1[iter_32_0])
	end
end

function var_0_0.addGetThemeRewardId(arg_33_0, arg_33_1)
	table.insert(arg_33_0._hasGetRoomThemes, arg_33_1)
end

function var_0_0.isHasBlockPackageById(arg_34_0, arg_34_1)
	return tabletool.indexOf(arg_34_0._blockPackageIds, arg_34_1) and true or false
end

function var_0_0.isHasBlockById(arg_35_0, arg_35_1)
	if tabletool.indexOf(arg_35_0._specialBlockIds, arg_35_1) then
		return true
	end

	local var_35_0 = RoomConfig.instance:getBlock(arg_35_1)

	if var_35_0 and var_35_0.ownType == RoomBlockEnum.OwnType.Package and tabletool.indexOf(arg_35_0._blockPackageIds, var_35_0.packageId) then
		return true
	end

	return false
end

function var_0_0.isHasRoomThemeById(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getThemeItemMOListById(arg_36_1)

	if var_36_0 == nil or #var_36_0 < 1 then
		return false
	end

	for iter_36_0 = 1, #var_36_0 do
		local var_36_1 = var_36_0[iter_36_0]

		if var_36_1.itemNum > var_36_1:getItemQuantity() then
			return false
		end
	end

	return true
end

function var_0_0.setBlockPackageIds(arg_37_0, arg_37_1)
	local var_37_0 = {}

	tabletool.addValues(var_37_0, arg_37_1)

	arg_37_0._blockPackageIds = var_37_0
end

function var_0_0.setSpecialBlockInfoList(arg_38_0, arg_38_1)
	local var_38_0 = {}

	tabletool.addValues(var_38_0, arg_38_1)

	arg_38_0._specialBlockInfoList = var_38_0
	arg_38_0._specialBlockIds = {}

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		table.insert(arg_38_0._specialBlockIds, iter_38_1.blockId)
	end
end

function var_0_0.addSpecialBlockIds(arg_39_0, arg_39_1)
	local var_39_0 = ServerTime.now()

	for iter_39_0 = 1, #arg_39_1 do
		local var_39_1 = arg_39_1[iter_39_0]

		if var_39_1 and tabletool.indexOf(arg_39_0._specialBlockIds, var_39_1) == nil then
			table.insert(arg_39_0._specialBlockIds, var_39_1)
			table.insert(arg_39_0._specialBlockInfoList, {
				blockId = var_39_1,
				createTime = var_39_0
			})
		end
	end
end

function var_0_0.getBlockPackageIds(arg_40_0)
	return arg_40_0._blockPackageIds
end

function var_0_0.getSpecialBlockIds(arg_41_0)
	return arg_41_0._specialBlockIds
end

function var_0_0.getSpecialBlockInfoList(arg_42_0)
	return arg_42_0._specialBlockInfoList
end

function var_0_0.setFormulaInfos(arg_43_0, arg_43_1)
	arg_43_0._formulaIdCountDict = {}

	arg_43_0:addFormulaInfos(arg_43_1)
end

function var_0_0.addFormulaInfos(arg_44_0, arg_44_1)
	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		local var_44_0 = iter_44_1.id

		arg_44_0._formulaIdCountDict[var_44_0] = (arg_44_0._formulaIdCountDict[var_44_0] or 0) + 1
	end
end

function var_0_0.getFormulaCount(arg_45_0, arg_45_1)
	return arg_45_0._formulaIdCountDict[arg_45_1] or 0
end

function var_0_0.updateRoomLevel(arg_46_0, arg_46_1)
	arg_46_0._roomLevel = arg_46_1
end

function var_0_0.getRoomLevel(arg_47_0)
	return arg_47_0._roomLevel
end

function var_0_0.setCharacterList(arg_48_0, arg_48_1)
	local var_48_0 = {}

	if arg_48_1 then
		for iter_48_0, iter_48_1 in ipairs(arg_48_1) do
			local var_48_1 = RoomCharacterMO.New()

			var_48_1:init(RoomInfoHelper.serverInfoToCharacterInfo(iter_48_1))
			table.insert(var_48_0, var_48_1)
		end
	end

	arg_48_0._characterModel:setList(var_48_0)
end

function var_0_0.getCharacterList(arg_49_0)
	return arg_49_0._characterModel:getList()
end

function var_0_0.removeCharacterById(arg_50_0, arg_50_1)
	arg_50_0._characterModel:remove(arg_50_0._characterModel:getById(arg_50_1))
end

function var_0_0.getCharacterById(arg_51_0, arg_51_1)
	return arg_51_0._characterModel:getById(arg_51_1)
end

function var_0_0.getThemeItemMO(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = arg_52_0:getThemeItemMOListById(arg_52_1)

	if not var_52_0 then
		for iter_52_0 = 1, #var_52_0 do
			local var_52_1 = var_52_0[iter_52_0]

			if var_52_1.id == arg_52_2 and var_52_1.materialType == arg_52_3 then
				return var_52_1
			end
		end
	end

	return nil
end

function var_0_0.getThemeItemMOListById(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0._themeItemMOListDict[arg_53_1]

	if not var_53_0 then
		local var_53_1 = RoomConfig.instance:getThemeConfig(arg_53_1)

		if var_53_1 then
			var_53_0 = {}

			arg_53_0:_addThemeMOToListByStr(var_53_1.packages, var_53_0, MaterialEnum.MaterialType.BlockPackage)
			arg_53_0:_addThemeMOToListByStr(var_53_1.building, var_53_0, MaterialEnum.MaterialType.Building)

			arg_53_0._themeItemMOListDict[arg_53_1] = var_53_0
		end
	end

	return var_53_0
end

function var_0_0.findHasGetThemeRewardThemeId(arg_54_0)
	local var_54_0 = RoomConfig.instance:getThemeConfigList()

	for iter_54_0 = 1, #var_54_0 do
		local var_54_1 = var_54_0[iter_54_0].id

		if arg_54_0:isHasGetThemeRewardById(var_54_1) then
			return var_54_1
		end
	end
end

function var_0_0.isGetThemeRewardById(arg_55_0, arg_55_1)
	return tabletool.indexOf(arg_55_0._hasGetRoomThemes, arg_55_1)
end

function var_0_0.isHasGetThemeRewardById(arg_56_0, arg_56_1)
	if tabletool.indexOf(arg_56_0._hasGetRoomThemes, arg_56_1) then
		return false
	end

	local var_56_0 = RoomConfig.instance:getThemeCollectionRewards(arg_56_1)

	if not var_56_0 or #var_56_0 < 1 then
		return false
	end

	local var_56_1 = arg_56_0:getThemeItemMOListById(arg_56_1)

	if not var_56_1 or #var_56_1 < 1 then
		return false
	end

	for iter_56_0 = 1, #var_56_1 do
		local var_56_2 = var_56_1[iter_56_0]
		local var_56_3 = var_56_2:getItemQuantity()

		for iter_56_1, iter_56_2 in ipairs(var_56_0) do
			if #iter_56_2 >= 3 and iter_56_2[1] == var_56_2.materialType and iter_56_2[2] == var_56_2.itemId then
				var_56_3 = iter_56_2[3] + var_56_3
			end
		end

		if var_56_3 < var_56_2.itemNum then
			return false
		end
	end

	return true
end

function var_0_0.isFinshThemeById(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:getThemeItemMOListById(arg_57_1)

	if not var_57_0 or #var_57_0 < 1 then
		return false
	end

	for iter_57_0 = 1, #var_57_0 do
		local var_57_1 = var_57_0[iter_57_0]

		if var_57_1:getItemQuantity() < var_57_1.itemNum then
			return false
		end
	end

	return true
end

function var_0_0._addThemeMOToListByStr(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	arg_58_2 = arg_58_2 or {}

	local var_58_0 = GameUtil.splitString2(arg_58_1, true)

	for iter_58_0, iter_58_1 in ipairs(var_58_0) do
		local var_58_1 = RoomThemeItemMO.New()
		local var_58_2 = iter_58_1[1]
		local var_58_3 = ItemModel.instance:getItemConfig(arg_58_3, var_58_2)
		local var_58_4 = var_58_3 and var_58_3.numLimit or 1

		var_58_1:init(var_58_2, var_58_4, arg_58_3)
		table.insert(arg_58_2, var_58_1)
	end

	return arg_58_2
end

function var_0_0.updateInteraction(arg_59_0, arg_59_1)
	arg_59_0._interactionCount = arg_59_1.interactionCount
	arg_59_0._existInteractionDict = {}

	for iter_59_0, iter_59_1 in ipairs(arg_59_1.infos) do
		if RoomConfig.instance:getCharacterInteractionConfig(iter_59_1.id) then
			arg_59_0._existInteractionDict[iter_59_1.id] = iter_59_1.finish and RoomCharacterEnum.InteractionState.Complete or RoomCharacterEnum.InteractionState.Start
		end
	end
end

function var_0_0.getExistInteractionDict(arg_60_0)
	return arg_60_0._existInteractionDict
end

function var_0_0.getInteractionCount(arg_61_0)
	return arg_61_0._interactionCount
end

function var_0_0.getInteractionState(arg_62_0, arg_62_1)
	return arg_62_0._existInteractionDict[arg_62_1] or RoomCharacterEnum.InteractionState.None
end

function var_0_0.interactStart(arg_63_0, arg_63_1)
	arg_63_0._interactionCount = arg_63_0._interactionCount + 1
	arg_63_0._existInteractionDict[arg_63_1] = RoomCharacterEnum.InteractionState.Start
end

function var_0_0.interactComplete(arg_64_0, arg_64_1)
	arg_64_0._existInteractionDict[arg_64_1] = RoomCharacterEnum.InteractionState.Complete
end

function var_0_0.updateCharacterPoint(arg_65_0)
	arg_65_0._characterPositionDict = {}

	local var_65_0 = RoomCharacterModel.instance:getList()

	for iter_65_0, iter_65_1 in ipairs(var_65_0) do
		local var_65_1 = iter_65_1.currentPosition

		arg_65_0._characterPositionDict[iter_65_1.heroId] = var_65_1
	end
end

function var_0_0.getCharacterPosition(arg_66_0, arg_66_1)
	return arg_66_0._characterPositionDict[arg_66_1]
end

function var_0_0.setEditFlag(arg_67_0)
	arg_67_0._hasEdit = true
end

function var_0_0.clearEditFlag(arg_68_0)
	arg_68_0._hasEdit = nil
end

function var_0_0.hasEdit(arg_69_0)
	return arg_69_0._hasEdit
end

function var_0_0.getOpenAndEndAtmosphereList(arg_70_0, arg_70_1)
	local var_70_0 = {}
	local var_70_1 = {}
	local var_70_2 = RoomConfig.instance:getBuildingAtmospheres(arg_70_1)
	local var_70_3 = ServerTime.now()

	for iter_70_0, iter_70_1 in ipairs(var_70_2) do
		local var_70_4 = RoomConfig.instance:getAtmosphereOpenTime(iter_70_1)
		local var_70_5 = var_70_4 + RoomConfig.instance:getAtmosphereDurationDay(iter_70_1) * TimeUtil.OneDaySecond

		if var_70_4 <= var_70_3 and var_70_3 <= var_70_5 then
			local var_70_6, var_70_7 = arg_70_0:isAtmosphereTrigger(iter_70_1)

			if var_70_6 then
				var_70_0[#var_70_0 + 1] = iter_70_1
			elseif var_70_7 then
				var_70_1[#var_70_1 + 1] = iter_70_1
			end
		else
			var_70_1[#var_70_1 + 1] = iter_70_1
		end
	end

	return var_70_0, var_70_1
end

function var_0_0.getAtmosphereCacheData(arg_71_0)
	if not arg_71_0._atmosphereCacheData then
		arg_71_0._atmosphereCacheData = {}

		local var_71_0 = GameUtil.playerPrefsGetStringByUserId(RoomEnum.AtmosphereCacheKey, "")

		if not string.nilorempty(var_71_0) then
			local var_71_1 = GameUtil.splitString2(var_71_0, true) or {}

			for iter_71_0, iter_71_1 in ipairs(var_71_1) do
				if iter_71_1 and #iter_71_1 > 1 then
					arg_71_0._atmosphereCacheData[iter_71_1[1]] = iter_71_1[2]
				end
			end
		end
	end

	return arg_71_0._atmosphereCacheData
end

function var_0_0.setAtmosphereHasPlay(arg_72_0, arg_72_1)
	local var_72_0

	var_72_0[arg_72_1], var_72_0 = ServerTime.now(), arg_72_0:getAtmosphereCacheData()

	local var_72_1 = ""
	local var_72_2 = true

	for iter_72_0, iter_72_1 in pairs(var_72_0) do
		if var_72_2 then
			var_72_2 = false
			var_72_1 = iter_72_0 .. "#" .. iter_72_1
		else
			var_72_1 = var_72_1 .. "|" .. iter_72_0 .. "#" .. iter_72_1
		end
	end

	GameUtil.playerPrefsSetStringByUserId(RoomEnum.AtmosphereCacheKey, var_72_1)
end

local function var_0_1()
	return false
end

local function var_0_2(arg_74_0, arg_74_1)
	local var_74_0 = false

	if not var_0_0._checkAtmospherCdTime(arg_74_0, arg_74_1) then
		return var_74_0
	end

	local var_74_1 = RoomConfig.instance:getAtmosphereOpenTime(arg_74_0)
	local var_74_2 = var_74_1 + RoomConfig.instance:getAtmosphereDurationDay(arg_74_0) * TimeUtil.OneDaySecond

	if arg_74_1 < var_74_1 or var_74_2 < arg_74_1 then
		var_74_0 = true
	end

	return var_74_0
end

local function var_0_3(arg_75_0, arg_75_1)
	local var_75_0 = false
	local var_75_1 = ServerTime.now()
	local var_75_2 = math.modf((var_75_1 + TimeUtil.OneMinuteSecond) / TimeUtil.OneHourSecond) * TimeUtil.OneHourSecond
	local var_75_3 = var_75_2 - TimeUtil.OneMinuteSecond
	local var_75_4 = var_75_2 + TimeUtil.OneMinuteSecond
	local var_75_5 = var_75_3 <= var_75_1 and var_75_1 <= var_75_4
	local var_75_6 = var_75_3 <= arg_75_1 and arg_75_1 <= var_75_4

	if var_75_5 and not var_75_6 and var_0_0._checkAtmospherCdTime(arg_75_0, arg_75_1) then
		var_75_0 = true
	end

	local var_75_7 = not var_75_0

	return var_75_0, var_75_7
end

function var_0_0._isCdTimeAtmosphereTrigger(arg_76_0, arg_76_1)
	local var_76_0 = false

	if not var_0_0._checkAtmospherCdTime(arg_76_0, arg_76_1) then
		return var_76_0
	end

	local var_76_1 = RoomConfig.instance:getAtmosphereOpenTime(arg_76_0)
	local var_76_2 = RoomConfig.instance:getAtmosphereDurationDay(arg_76_0)
	local var_76_3 = ServerTime.now()
	local var_76_4 = var_76_1 + var_76_2 * TimeUtil.OneDaySecond

	if var_76_1 <= var_76_3 and var_76_3 <= var_76_4 then
		var_76_0 = true
	end

	return var_76_0
end

function var_0_0._checkAtmospherCdTime(arg_77_0, arg_77_1)
	local var_77_0 = RoomConfig.instance:getAtmosphereCfg(arg_77_0)
	local var_77_1 = var_77_0 and var_77_0.cdtimes or 0

	if var_77_1 and var_77_1 ~= 0 and var_77_1 > ServerTime.now() - arg_77_1 then
		return false
	end

	return true
end

local var_0_4 = {
	[RoomEnum.AtmosphereTriggerType.None] = var_0_1,
	[RoomEnum.AtmosphereTriggerType.Disposable] = var_0_2,
	[RoomEnum.AtmosphereTriggerType.IntegralPoint] = var_0_3,
	[RoomEnum.AtmosphereTriggerType.CDTime] = var_0_0._isCdTimeAtmosphereTrigger
}

function var_0_0.isAtmosphereTrigger(arg_78_0, arg_78_1)
	local var_78_0 = false
	local var_78_1 = false
	local var_78_2 = RoomConfig.instance:getAtmosphereTriggerType(arg_78_1)
	local var_78_3 = var_0_4[var_78_2]

	if var_78_3 then
		local var_78_4 = arg_78_0:getAtmosphereCacheData()[arg_78_1] or 0

		var_78_0, var_78_1 = var_78_3(arg_78_1, var_78_4)
	else
		logError(string.format("RoomModel:isAtmosphereTrigger error atmosphereId:%s triggerType:%s not defined", arg_78_1, var_78_2))
	end

	return var_78_0, var_78_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
