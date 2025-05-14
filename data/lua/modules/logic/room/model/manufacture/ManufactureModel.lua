module("modules.logic.room.model.manufacture.ManufactureModel", package.seeall)

local var_0_0 = class("ManufactureModel", BaseModel)
local var_0_1 = 1
local var_0_2 = 0

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0:setSelectedSlot()
	arg_3_0:setSelectedCritterSlot()
	arg_3_0:setSelectedCritterSeatSlot()
	arg_3_0:setSelectedTransportPath()
	arg_3_0:setNewRestCritter()
	arg_3_0:setIsJump2ManufactureBuildingList()
	arg_3_0:setTradeLevel()
	arg_3_0:clearCritterBuildingData()
	arg_3_0:setCameraRecord()

	arg_3_0._frozenMatDict = nil
	arg_3_0._needMatDict = nil
	arg_3_0._isPlayManufactureUnlock = nil
	arg_3_0._isExpandManufacture = nil
	arg_3_0._readFormulaDict = nil
	arg_3_0._recordOneKeyType = nil
end

function var_0_0.resetDataBeforeSetInfo(arg_4_0)
	arg_4_0:setTradeLevel()
	arg_4_0:clearCritterBuildingData()
	arg_4_0:clear()
end

function var_0_0.clearCritterBuildingData(arg_5_0)
	arg_5_0._buildingCritterMOList = {}
	arg_5_0._buildingCritterMODict = {}
end

function var_0_0.initNewManufactureFormulaCacheData(arg_6_0)
	if arg_6_0._readFormulaDict then
		return
	end

	local var_6_0 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.RoomManufactureReadFormula, "")

	if not string.nilorempty(var_6_0) then
		arg_6_0._readFormulaDict = cjson.decode(var_6_0)
	end

	arg_6_0._readFormulaDict = arg_6_0._readFormulaDict or {}
end

function var_0_0.setManufactureInfo(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	arg_7_0:setTradeLevel(arg_7_1.tradeLevel)
	arg_7_0:setManuBuildingInfoList(arg_7_1.manuBuildingInfos)
	arg_7_0:setCritterBuildingInfoList(arg_7_1.restBuildingInfos)
	arg_7_0:setFrozenItemDict(arg_7_1.frozenItems2Count)
end

function var_0_0.setTradeLevel(arg_8_0, arg_8_1)
	arg_8_0._tradeLevel = arg_8_1
end

function var_0_0.setManuBuildingInfoList(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		arg_9_0:setManuBuildingInfo(iter_9_1)
	end

	arg_9_0:refreshAllNeedMat()
end

function var_0_0.setManuBuildingInfo(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return
	end

	local var_10_0 = false
	local var_10_1 = arg_10_0:getManufactureMOById(arg_10_1.buildingUid)

	if not var_10_1 then
		var_10_1 = RoomBuildingManufactureMO.New()
		var_10_0 = true
	end

	var_10_1:init(arg_10_1)

	if var_10_0 then
		arg_10_0:addAtLast(var_10_1)
	end

	if arg_10_2 then
		arg_10_0:refreshAllNeedMat()
	end
end

function var_0_0.setFrozenItemDict(arg_11_0, arg_11_1)
	arg_11_0._frozenMatDict = {}

	if arg_11_1 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			arg_11_0._frozenMatDict[iter_11_1.materialId] = iter_11_1.quantity + (arg_11_0._frozenMatDict[iter_11_1.materialId] or 0)
		end
	end
end

function var_0_0._isCanFrozenItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ManufactureConfig.instance:getManufactureItemListByItemId(arg_12_1)[1]

	if not var_12_0 then
		return false
	end

	if arg_12_2 > arg_12_0:getManufactureItemCount(var_12_0) then
		return false
	end

	if arg_12_0:getFrozenManufactureItemCount(var_12_0) + arg_12_2 < 0 then
		return false
	end

	return true
end

function var_0_0.clientCalAllFrozenItemDict(arg_13_0)
	arg_13_0._frozenMatDict = {}

	local var_13_0 = arg_13_0:getAllPlacedManufactureBuilding()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = iter_13_1:getAllUnlockedSlotIdList()

		for iter_13_2, iter_13_3 in ipairs(var_13_1) do
			if iter_13_1:getSlotState(iter_13_3, true) == RoomManufactureEnum.SlotState.Wait then
				local var_13_2 = {}
				local var_13_3 = iter_13_1:getSlotManufactureItemId(iter_13_3)
				local var_13_4 = ManufactureConfig.instance:getNeedMatItemList(var_13_3)

				for iter_13_4, iter_13_5 in ipairs(var_13_4) do
					local var_13_5 = ManufactureConfig.instance:getItemId(iter_13_5.id)
					local var_13_6 = iter_13_5.quantity

					if arg_13_0:_isCanFrozenItem(var_13_5, var_13_6) then
						var_13_2[var_13_5] = var_13_6
					else
						var_13_2 = {}

						break
					end
				end

				for iter_13_6, iter_13_7 in pairs(var_13_2) do
					arg_13_0._frozenMatDict[iter_13_6] = (arg_13_0._frozenMatDict[iter_13_6] or 0) + iter_13_7
				end
			end
		end
	end
end

function var_0_0.refreshAllNeedMat(arg_14_0)
	arg_14_0._needMatDict = {}

	local var_14_0 = arg_14_0:getList()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = iter_14_1:getNeedMatDict()

		for iter_14_2, iter_14_3 in pairs(var_14_1) do
			arg_14_0._needMatDict[iter_14_2] = iter_14_3 + (arg_14_0._needMatDict[iter_14_2] or 0)
		end
	end
end

function var_0_0.setWorkCritterInfo(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getManufactureMOById(arg_15_1)

	if var_15_0 then
		var_15_0:setWorkCritterInfo(arg_15_2)
	end
end

function var_0_0.setCritterBuildingInfoList(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return
	end

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		arg_16_0:setCritterBuildingInfo(iter_16_1)
	end
end

function var_0_0.setCritterBuildingInfo(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	local var_17_0 = false
	local var_17_1 = arg_17_1.buildingUid
	local var_17_2 = arg_17_0:getCritterBuildingMOById(var_17_1)

	if not var_17_2 then
		var_17_2 = RoomBuildingCritterMO.New()
		var_17_0 = true
	end

	var_17_2:init(arg_17_1)

	if var_17_0 then
		table.insert(arg_17_0._buildingCritterMOList, var_17_2)

		arg_17_0._buildingCritterMODict[var_17_1] = var_17_2
	end
end

function var_0_0.setPlayManufactureUnlock(arg_18_0, arg_18_1)
	arg_18_0._isPlayManufactureUnlock = arg_18_1 and var_0_1 or var_0_2

	local var_18_0 = arg_18_0:getManufacturePlayUnlockKey()

	PlayerPrefsHelper.setNumber(var_18_0, arg_18_0._isPlayManufactureUnlock)
end

function var_0_0.setExpandManufactureBtn(arg_19_0, arg_19_1)
	if arg_19_0._isExpandManufacture == arg_19_1 then
		return
	end

	arg_19_0._isExpandManufacture = arg_19_1

	local var_19_0 = arg_19_1 and var_0_1 or var_0_2

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.RoomExpandManufacture, var_19_0)
end

function var_0_0.setReadNewManufactureFormula(arg_20_0, arg_20_1)
	arg_20_0:initNewManufactureFormulaCacheData()

	local var_20_0 = arg_20_0._readFormulaDict[arg_20_1]

	if not var_20_0 then
		var_20_0 = {}
		arg_20_0._readFormulaDict[arg_20_1] = var_20_0
	end

	local var_20_1 = arg_20_0:getCanProduceManufactureItemDict(arg_20_1)

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		var_20_0[tostring(iter_20_0)] = true
	end

	local var_20_2 = cjson.encode(arg_20_0._readFormulaDict) or ""

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.RoomManufactureReadFormula, var_20_2)
end

function var_0_0.setRecordOneKeyType(arg_21_0, arg_21_1)
	if not LuaUtil.tableContains(RoomManufactureEnum.OneKeyType, arg_21_1) or arg_21_0._recordOneKeyType == arg_21_1 then
		return
	end

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.RoomManufactureOneKeyType, arg_21_1)

	arg_21_0._recordOneKeyType = arg_21_1
end

function var_0_0.setSelectedSlot(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._selectedSlotBuildingUid = arg_22_1
	arg_22_0._selectedSlotId = arg_22_2
end

function var_0_0.setSelectedCritterSlot(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._selectedCritterSlotBuildingUid = arg_23_1
	arg_23_0._selectedCritterSlotId = arg_23_2
end

function var_0_0.setSelectedCritterSeatSlot(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._selectedCritterSeatSlotBuildingUid = arg_24_1
	arg_24_0._selectedCritterSeatSlotId = arg_24_2
end

function var_0_0.setSelectedTransportPath(arg_25_0, arg_25_1)
	arg_25_0._selectedTransportPathId = arg_25_1
end

function var_0_0.setNewRestCritter(arg_26_0, arg_26_1)
	arg_26_0._newRestCritter = arg_26_1
end

function var_0_0.setIsJump2ManufactureBuildingList(arg_27_0, arg_27_1)
	arg_27_0._isJumpManuBuildingList = arg_27_1
end

function var_0_0.setCameraRecord(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0._recordCameraState = arg_28_1
	arg_28_0._recordCameraParam = arg_28_2
end

function var_0_0.getTradeLevel(arg_29_0)
	return arg_29_0._tradeLevel or 0
end

function var_0_0.getCritterWorkingBuilding(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return
	end

	local var_30_0
	local var_30_1 = arg_30_0:getList()

	for iter_30_0, iter_30_1 in ipairs(var_30_1) do
		if iter_30_1:getCritterWorkSlot(arg_30_1) then
			var_30_0 = iter_30_1.uid

			break
		end
	end

	return var_30_0
end

function var_0_0.getCritterRestingBuilding(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return
	end

	local var_31_0
	local var_31_1 = var_0_0.instance:getAllCritterBuildingMOList()

	for iter_31_0, iter_31_1 in ipairs(var_31_1) do
		if iter_31_1:isCritterInSeatSlot(arg_31_1) then
			var_31_0 = iter_31_1.uid

			break
		end
	end

	return var_31_0
end

function var_0_0.getManufactureItemCount(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	local var_32_0 = 0
	local var_32_1 = 0
	local var_32_2 = MaterialEnum.MaterialType.Item
	local var_32_3 = ManufactureConfig.instance:getItemId(arg_32_1)

	if var_32_3 then
		local var_32_4 = ItemModel.instance:getItemQuantity(var_32_2, var_32_3)
		local var_32_5 = arg_32_0:getFrozenManufactureItemCount(arg_32_1)

		var_32_0 = arg_32_4 and var_32_4 or var_32_4 - var_32_5
	end

	if arg_32_2 then
		var_32_1 = arg_32_0:getManufactureItemCountInSlotQueue(arg_32_1, false, arg_32_3)
	end

	return var_32_0, var_32_1
end

function var_0_0.getManufactureItemCountInSlotQueue(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = 0
	local var_33_1 = arg_33_0:getList()

	for iter_33_0, iter_33_1 in ipairs(var_33_1) do
		var_33_0 = var_33_0 + iter_33_1:getManufactureItemFinishCount(arg_33_1, arg_33_2, arg_33_3)
	end

	return var_33_0
end

function var_0_0.isManufactureUnlock(arg_34_0, arg_34_1)
	local var_34_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoomManufacture)

	if not var_34_0 and GuideModel.instance:isGuideFinish(CritterEnum.OppenFuncGuide.RoomManufacture) then
		var_34_0 = true
	end

	if not var_34_0 and arg_34_1 then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.RoomManufacture))
	end

	return var_34_0
end

function var_0_0.getManufacturePlayUnlockKey(arg_35_0)
	local var_35_0 = PlayerModel.instance:getPlayinfo().userId

	return string.format("%s_%s", PlayerPrefsKey.RoomManufactureEntrancePlayUnlockAnim, var_35_0)
end

function var_0_0.getPlayManufactureUnlock(arg_36_0)
	if arg_36_0._isPlayManufactureUnlock == nil then
		local var_36_0 = arg_36_0:getManufacturePlayUnlockKey()

		arg_36_0._isPlayManufactureUnlock = PlayerPrefsHelper.getNumber(var_36_0, var_0_2)
	end

	return arg_36_0._isPlayManufactureUnlock == var_0_1
end

function var_0_0.getExpandManufactureBtn(arg_37_0)
	if not arg_37_0._isExpandManufacture then
		arg_37_0._isExpandManufacture = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.RoomExpandManufacture, var_0_2) == var_0_1
	end

	return arg_37_0._isExpandManufacture
end

function var_0_0.getRecordOneKeyType(arg_38_0)
	local var_38_0 = RoomManufactureEnum.OneKeyType.ShortTime

	if not arg_38_0._recordOneKeyType then
		arg_38_0._recordOneKeyType = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.RoomManufactureOneKeyType, var_38_0)
	end

	if arg_38_0._recordOneKeyType == RoomManufactureEnum.OneKeyType.Customize and not OneKeyAddPopListModel.instance:getSelectedManufactureItem() then
		arg_38_0._recordOneKeyType = var_38_0
	end

	return arg_38_0._recordOneKeyType or var_38_0
end

function var_0_0.getManufactureMOById(arg_39_0, arg_39_1)
	return arg_39_0:getById(arg_39_1)
end

function var_0_0.getAllManufactureMOList(arg_40_0)
	return arg_40_0:getList()
end

local function var_0_3(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.config.buildingType
	local var_41_1 = arg_41_1.config.buildingType

	if var_41_0 ~= var_41_1 then
		return var_41_0 < var_41_1
	end

	local var_41_2 = arg_41_0.buildingId
	local var_41_3 = arg_41_1.buildingId

	if var_41_2 ~= var_41_3 then
		return var_41_2 < var_41_3
	end

	return arg_41_0.uid < arg_41_1.uid
end

function var_0_0.getAllPlacedManufactureBuilding(arg_42_0)
	local var_42_0 = {}
	local var_42_1 = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Collect)

	tabletool.addValues(var_42_0, var_42_1)

	local var_42_2 = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Process)

	tabletool.addValues(var_42_0, var_42_2)

	local var_42_3 = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Manufacture)

	tabletool.addValues(var_42_0, var_42_3)
	table.sort(var_42_0, var_0_3)

	return var_42_0
end

function var_0_0.getAllBuildingCanClaimProducts(arg_43_0)
	local var_43_0 = {}
	local var_43_1 = arg_43_0:getAllPlacedManufactureBuilding()

	for iter_43_0, iter_43_1 in ipairs(var_43_1) do
		if iter_43_1:isCanClaimProduction() then
			var_43_0[#var_43_0 + 1] = iter_43_1
		end
	end

	return var_43_0
end

function var_0_0.isMaxLevel(arg_44_0, arg_44_1)
	local var_44_0 = true
	local var_44_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_44_1)

	if var_44_1 then
		var_44_0 = ManufactureConfig.instance:getBuildingMaxLevel(var_44_1.buildingId) <= var_44_1.level
	end

	return var_44_0
end

function var_0_0.getManufactureLevelUpParam(arg_45_0, arg_45_1)
	local var_45_0 = {
		buildingUid = arg_45_1,
		extraCheckFunc = ManufactureController.checkTradeLevelCondition,
		extraCheckFuncObj = ManufactureController.instance
	}
	local var_45_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_45_1)
	local var_45_2 = var_45_1.buildingId
	local var_45_3 = ManufactureConfig.instance:getBuildingUpgradeGroup(var_45_2)

	if not var_45_3 or var_45_3 == 0 then
		return var_45_0
	end

	local var_45_4 = var_45_1.level
	local var_45_5 = var_45_4 + 1

	var_45_0.levelUpInfoList = {}

	local var_45_6 = {
		desc = luaLang("room_building_level_up_tip"),
		currentDesc = formatLuaLang("v1a5_aizila_level", var_45_4),
		nextDesc = formatLuaLang("v1a5_aizila_level", var_45_5)
	}

	table.insert(var_45_0.levelUpInfoList, var_45_6)

	local var_45_7 = ManufactureConfig.instance:getBuildingSlotCount(var_45_2, var_45_4)
	local var_45_8 = ManufactureConfig.instance:getBuildingSlotCount(var_45_2, var_45_5)

	if var_45_7 ~= var_45_8 then
		local var_45_9 = {
			desc = luaLang("room_manufacture_building_add_slot"),
			currentDesc = var_45_7,
			nextDesc = var_45_8
		}

		table.insert(var_45_0.levelUpInfoList, var_45_9)
	end

	local var_45_10 = {}
	local var_45_11 = {}
	local var_45_12 = ManufactureConfig.instance:getNewManufactureItemList(var_45_3, var_45_5)

	for iter_45_0, iter_45_1 in ipairs(var_45_12) do
		local var_45_13 = ManufactureConfig.instance:getItemId(iter_45_1)

		if not var_45_11[var_45_13] then
			var_45_10[#var_45_10 + 1] = {
				type = MaterialEnum.MaterialType.Item,
				id = var_45_13
			}
			var_45_11[var_45_13] = true
		end
	end

	local var_45_14 = {
		desc = luaLang("room_new_manufacture_item"),
		newItemInfoList = var_45_10
	}

	table.insert(var_45_0.levelUpInfoList, var_45_14)

	return var_45_0
end

function var_0_0.isAreaHasManufactureRunning(arg_46_0, arg_46_1)
	local var_46_0 = false
	local var_46_1 = RoomMapBuildingAreaModel.instance:getAreaMOByBType(arg_46_1)
	local var_46_2 = var_46_1 and var_46_1:getBuildingMOList(true)

	if var_46_2 then
		for iter_46_0, iter_46_1 in ipairs(var_46_2) do
			if iter_46_1:getManufactureState() == RoomManufactureEnum.ManufactureState.Running then
				var_46_0 = true

				break
			end
		end
	end

	return var_46_0
end

function var_0_0.getCanProduceManufactureItemDict(arg_47_0, arg_47_1)
	local var_47_0 = {}
	local var_47_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_47_1)

	if var_47_1 then
		local var_47_2 = var_47_1.buildingId
		local var_47_3 = var_47_1:getLevel()
		local var_47_4 = ManufactureConfig.instance:getAllManufactureItems(var_47_2)

		for iter_47_0, iter_47_1 in ipairs(var_47_4) do
			if var_47_3 >= ManufactureConfig.instance:getManufactureItemNeedLevel(var_47_2, iter_47_1) then
				var_47_0[iter_47_1] = true
			end
		end
	end

	return var_47_0
end

function var_0_0.hasNewManufactureFormula(arg_48_0, arg_48_1)
	local var_48_0 = false

	arg_48_0:initNewManufactureFormulaCacheData()

	local var_48_1 = arg_48_0._readFormulaDict[arg_48_1]
	local var_48_2 = arg_48_0:getCanProduceManufactureItemDict(arg_48_1)

	for iter_48_0, iter_48_1 in pairs(var_48_2) do
		local var_48_3 = tostring(iter_48_0)

		if not var_48_1 or not var_48_1[var_48_3] then
			var_48_0 = true

			break
		end
	end

	return var_48_0
end

function var_0_0.hasPathLinkedToThisBuildingType(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = false
	local var_49_1 = ManufactureConfig.instance:getManufactureItemBelongBuildingType(arg_49_1)

	if var_49_1 and arg_49_2 then
		local var_49_2 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_49_1, arg_49_2)

		if var_49_2 then
			local var_49_3 = var_49_2:isLinkFinish()
			local var_49_4 = var_49_2:hasCritterWorking()

			var_49_0 = var_49_3 and var_49_4
		end
	end

	return var_49_0
end

function var_0_0.getMaxCanProductCount(arg_50_0, arg_50_1)
	local var_50_0 = true

	if not arg_50_1 then
		return OneKeyAddPopListModel.MINI_COUNT, var_50_0
	end

	local var_50_1 = 0
	local var_50_2, var_50_3 = ManufactureConfig.instance:getManufactureItemUnitCountRange(arg_50_1)
	local var_50_4 = var_50_2 / var_50_3
	local var_50_5 = ManufactureConfig.instance:getManufactureItemBelongBuildingType(arg_50_1)
	local var_50_6 = RoomMapBuildingModel.instance:getBuildingListByType(var_50_5)

	if var_50_6 and #var_50_6 > 0 then
		for iter_50_0, iter_50_1 in ipairs(var_50_6) do
			if ManufactureConfig.instance:isManufactureItemBelongBuilding(iter_50_1.buildingId, arg_50_1) then
				local var_50_7 = 0
				local var_50_8 = iter_50_1:getEmptySlotIdList()

				if #var_50_8 > 0 then
					var_50_7 = #var_50_8 * var_50_4
				end

				var_50_1 = var_50_1 + var_50_7
			end
		end
	end

	local var_50_9 = var_50_1 == 0

	return math.max(var_50_1, OneKeyAddPopListModel.MINI_COUNT), var_50_9
end

function var_0_0.getManufactureWrongType(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_51_1)

	if (var_51_0 and var_51_0:getSlotState(arg_51_2)) ~= RoomManufactureEnum.SlotState.Stop then
		return
	end

	local var_51_1
	local var_51_2 = var_51_0:getSlotManufactureItemId(arg_51_2)
	local var_51_3 = ManufactureConfig.instance:getNeedMatItemList(var_51_2)
	local var_51_4 = var_51_0.config.buildingType

	for iter_51_0, iter_51_1 in ipairs(var_51_3) do
		local var_51_5 = iter_51_1.id
		local var_51_6 = iter_51_1.quantity
		local var_51_7, var_51_8 = arg_51_0:getManufactureItemCount(var_51_5, true, true, true)

		if var_51_7 < var_51_6 then
			if var_51_6 <= var_51_7 + var_51_8 then
				if arg_51_0:hasPathLinkedToThisBuildingType(var_51_5, var_51_4) then
					var_51_1 = RoomManufactureEnum.ManufactureWrongType.WaitPreMat
				else
					var_51_1 = RoomManufactureEnum.ManufactureWrongType.NoLinkPath
				end
			else
				var_51_1 = RoomManufactureEnum.ManufactureWrongType.LackPreMat
			end
		end

		if var_51_1 and var_51_1 ~= RoomManufactureEnum.ManufactureWrongType.WaitPreMat then
			break
		end
	end

	if not var_51_1 then
		local var_51_9 = var_51_0:getSlot2CritterDict()

		if not next(var_51_9) then
			var_51_1 = RoomManufactureEnum.ManufactureWrongType.NoCritter
		end
	end

	return var_51_1
end

function var_0_0.getManufactureWrongTipItemList(arg_52_0, arg_52_1)
	local var_52_0 = {}
	local var_52_1 = RoomMapBuildingModel.instance:getBuildingMOById(arg_52_1)

	if not var_52_1 then
		return var_52_0
	end

	local var_52_2 = {}
	local var_52_3 = var_52_1:getAllUnlockedSlotIdList()

	for iter_52_0, iter_52_1 in ipairs(var_52_3) do
		local var_52_4 = arg_52_0:getManufactureWrongType(arg_52_1, iter_52_1)

		if var_52_4 and var_52_4 ~= RoomManufactureEnum.ManufactureWrongType.WaitPreMat then
			local var_52_5 = var_52_1:getSlotManufactureItemId(iter_52_1)
			local var_52_6 = var_52_2[var_52_5]

			if not var_52_6 then
				var_52_6 = {}
				var_52_2[var_52_5] = var_52_6
			end

			var_52_6[#var_52_6 + 1] = iter_52_1
		end
	end

	for iter_52_2, iter_52_3 in pairs(var_52_2) do
		var_52_0[#var_52_0 + 1] = {
			manufactureItemId = iter_52_2,
			wrongSlotIdList = iter_52_3
		}
	end

	return var_52_0
end

function var_0_0.getAllWrongManufactureItemList(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	local var_53_0 = {}
	local var_53_1 = {}
	local var_53_2 = RoomMapBuildingModel.instance:getBuildingMOById(arg_53_1)

	if not var_53_2 then
		return var_53_0, var_53_1
	end

	local var_53_3 = {}
	local var_53_4 = var_53_2.config.buildingType
	local var_53_5 = ManufactureConfig.instance:getNeedMatItemList(arg_53_2)

	for iter_53_0, iter_53_1 in ipairs(var_53_5) do
		local var_53_6 = true
		local var_53_7 = iter_53_1.id
		local var_53_8 = iter_53_1.quantity * arg_53_3
		local var_53_9
		local var_53_10 = ManufactureConfig.instance:getManufactureItemBelongBuildingType(var_53_7)
		local var_53_11 = RoomMapBuildingModel.instance:getBuildingListByType(var_53_10)

		if var_53_11 and #var_53_11 > 0 then
			for iter_53_2, iter_53_3 in ipairs(var_53_11) do
				local var_53_12 = iter_53_3.buildingId

				if ManufactureConfig.instance:isManufactureItemBelongBuilding(var_53_12, var_53_7) then
					local var_53_13 = iter_53_3:getLevel()
					local var_53_14 = ManufactureConfig.instance:getManufactureItemNeedLevel(var_53_12, var_53_7)

					if var_53_14 and var_53_14 <= var_53_13 then
						var_53_6 = false

						break
					end
				end
			end
		end

		if var_53_6 then
			var_53_9 = RoomManufactureEnum.ManufactureWrongType.PreMatNotUnlock
		else
			local var_53_15, var_53_16 = arg_53_0:getManufactureItemCount(var_53_7, true, true)

			if var_53_15 < var_53_8 then
				local var_53_17 = arg_53_0:hasPathLinkedToThisBuildingType(var_53_7, var_53_4)

				if var_53_8 <= var_53_15 + var_53_16 then
					if not var_53_17 then
						var_53_9 = RoomManufactureEnum.ManufactureWrongType.NoLinkPath
					end
				else
					var_53_9 = RoomManufactureEnum.ManufactureWrongType.LackPreMat
				end
			end
		end

		if var_53_9 then
			local var_53_18 = var_53_3[var_53_9]

			if not var_53_18 then
				var_53_18 = {}
				var_53_3[var_53_9] = var_53_18
			end

			local var_53_19 = {
				manufactureItemId = var_53_7,
				buildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(var_53_7),
				needQuantity = var_53_8
			}

			var_53_18[#var_53_18 + 1] = var_53_19
		end
	end

	local var_53_20 = {}

	for iter_53_4, iter_53_5 in pairs(var_53_3) do
		for iter_53_6, iter_53_7 in ipairs(iter_53_5) do
			if iter_53_4 ~= RoomManufactureEnum.ManufactureWrongType.NoLinkPath or not var_53_20[iter_53_7.buildingType] then
				var_53_0[#var_53_0 + 1] = {
					manufactureItemId = iter_53_7.manufactureItemId,
					wrongType = iter_53_4,
					buildingType = iter_53_7.buildingType,
					needQuantity = iter_53_7.needQuantity
				}

				if iter_53_4 == RoomManufactureEnum.ManufactureWrongType.NoLinkPath then
					var_53_20[iter_53_7.buildingType] = true
				end
			end
		end

		var_53_1[#var_53_1 + 1] = iter_53_4
	end

	local var_53_21 = var_53_2:getSlot2CritterDict()

	if not next(var_53_21) then
		var_53_1[#var_53_1 + 1] = RoomManufactureEnum.ManufactureWrongType.NoCritter
	end

	return var_53_0, var_53_1
end

function var_0_0.getFrozenManufactureItemCount(arg_54_0, arg_54_1)
	local var_54_0 = ManufactureConfig.instance:getItemId(arg_54_1)

	return arg_54_0._frozenMatDict and arg_54_0._frozenMatDict[var_54_0] or 0
end

function var_0_0.getLackMatCount(arg_55_0, arg_55_1)
	local var_55_0, var_55_1 = arg_55_0:getManufactureItemCount(arg_55_1, true, true, true)
	local var_55_2 = var_55_0 + var_55_1
	local var_55_3 = true
	local var_55_4, var_55_5 = RoomTradeModel.instance:getTracedGoodsCount(arg_55_1)
	local var_55_6 = math.max(0, var_55_4 + var_55_5 - var_55_2)

	if var_55_6 <= 0 then
		var_55_3 = false

		local var_55_7 = arg_55_0:getNeedMatCount(arg_55_1)

		var_55_6 = math.max(0, var_55_7 + var_55_4 - var_55_2)
	end

	local var_55_8 = ManufactureConfig.instance:getItemId(arg_55_1)
	local var_55_9 = arg_55_0:getAllPlacedManufactureBuilding()

	for iter_55_0, iter_55_1 in ipairs(var_55_9) do
		local var_55_10 = iter_55_1:getSlotIdInProgress()
		local var_55_11 = iter_55_1:getSlotManufactureItemId(var_55_10)

		if var_55_11 then
			local var_55_12 = ManufactureConfig.instance:getNeedMatItemList(var_55_11)

			for iter_55_2, iter_55_3 in ipairs(var_55_12) do
				if ManufactureConfig.instance:getItemId(iter_55_3.id) == var_55_8 then
					var_55_6 = var_55_6 - iter_55_3.quantity
				end
			end
		end
	end

	return math.max(0, var_55_6), var_55_3
end

function var_0_0.getNeedMatCount(arg_56_0, arg_56_1)
	local var_56_0 = ManufactureConfig.instance:getItemId(arg_56_1)

	return arg_56_0._needMatDict and arg_56_0._needMatDict[var_56_0] or 0
end

function var_0_0.getCritterBuildingMOById(arg_57_0, arg_57_1)
	return arg_57_0._buildingCritterMODict[arg_57_1]
end

function var_0_0.getAllCritterBuildingMOList(arg_58_0)
	return arg_58_0._buildingCritterMOList
end

function var_0_0.getCritterBuildingListInOrder(arg_59_0)
	return (RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Rest, true))
end

function var_0_0.getSelectedSlot(arg_60_0)
	return arg_60_0._selectedSlotBuildingUid, arg_60_0._selectedSlotId
end

function var_0_0.getSelectedCritterSlot(arg_61_0)
	return arg_61_0._selectedCritterSlotBuildingUid, arg_61_0._selectedCritterSlotId
end

function var_0_0.getSelectedCritterSeatSlot(arg_62_0)
	return arg_62_0._selectedCritterSeatSlotBuildingUid, arg_62_0._selectedCritterSeatSlotId
end

function var_0_0.getSelectedTransportPath(arg_63_0)
	return arg_63_0._selectedTransportPathId
end

function var_0_0.getNewRestCritter(arg_64_0)
	return arg_64_0._newRestCritter
end

function var_0_0.getIsJump2ManufactureBuildingList(arg_65_0)
	return arg_65_0._isJumpManuBuildingList
end

function var_0_0.getCameraRecord(arg_66_0)
	return arg_66_0._recordCameraState, arg_66_0._recordCameraParam
end

function var_0_0.getTradeBuildingListInOrder(arg_67_0)
	return (RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Trade, true))
end

var_0_0.instance = var_0_0.New()

return var_0_0
