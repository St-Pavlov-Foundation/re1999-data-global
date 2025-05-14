module("modules.logic.rouge.model.RougeCollectionModel", package.seeall)

local var_0_0 = class("RougeCollectionModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0:init()
end

function var_0_0.init(arg_2_0)
	arg_2_0._slotCellStateMap = {}
	arg_2_0._collectionPlaceMap = {}
	arg_2_0._collectionIdMap = {}
	arg_2_0._collectionRareMap = {}
	arg_2_0._enchants = {}
	arg_2_0._curSlotAreaSize = nil
	arg_2_0._slotCollections = BaseModel.New()
	arg_2_0._bagCollections = BaseModel.New()
	arg_2_0._allCollections = BaseModel.New()
	arg_2_0._effectTriggerTab = {}
	arg_2_0._tempCollectionAttrMap = nil
end

function var_0_0.getAllCollections(arg_3_0)
	return arg_3_0._allCollections:getList()
end

function var_0_0.getAllCollectionCount(arg_4_0)
	return arg_4_0._allCollections:getCount()
end

function var_0_0.onReceiveNewInfo2Slot(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_1 = RougeCollectionHelper.buildNewCollectionSlotMO(iter_5_1)

		table.insert(var_5_0, var_5_1.id)
		arg_5_0:tryAddCollection2SlotArea(var_5_1)
	end

	if RougeCollectionHelper.isNewGetCollection(arg_5_2) then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.GetNewCollections, var_5_0, arg_5_2, RougeEnum.CollectionPlaceArea.SlotArea)
	end
end

function var_0_0.tryAddCollection2SlotArea(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.id

	if arg_6_0._slotCollections:getById(var_6_0) then
		arg_6_0:tryRemoveSlotCollection(var_6_0)
	end

	arg_6_0._slotCollections:addAtLast(arg_6_1)
	arg_6_0._allCollections:addAtLast(arg_6_1)
	arg_6_0:markCollection2IdMap(arg_6_1)
	arg_6_0:markCollection2RareMap(arg_6_1)
	arg_6_0:markCollectionSlotArea(arg_6_1)
	arg_6_0:tryMarkCollection2EnchantList(arg_6_1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.PlaceCollection2SlotArea, arg_6_1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionAttr, var_6_0)
end

function var_0_0.tryMarkCollection2EnchantList(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_1.cfgId
	local var_7_1 = RougeCollectionConfig.instance:getCollectionCfg(var_7_0)

	if not var_7_1 then
		return
	end

	if var_7_1.type == RougeEnum.CollectionType.Enchant then
		table.insert(arg_7_0._enchants, arg_7_1)
	end
end

function var_0_0.tryRemoveCollectionEnchantList(arg_8_0, arg_8_1)
	if not arg_8_0._enchants then
		return
	end

	for iter_8_0 = #arg_8_0._enchants, 1, -1 do
		if arg_8_0._enchants[iter_8_0] and arg_8_0._enchants[iter_8_0].id == arg_8_1 then
			arg_8_0._enchants[iter_8_0] = nil

			return
		end
	end
end

function var_0_0.markCollection2IdMap(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_1.cfgId

	if not arg_9_0._collectionIdMap[var_9_0] then
		arg_9_0._collectionIdMap[var_9_0] = {}
	end

	table.insert(arg_9_0._collectionIdMap[var_9_0], arg_9_1)
end

function var_0_0.removeCollectionIdMap(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._collectionIdMap[arg_10_2]

	if not var_10_0 then
		return
	end

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if iter_10_1.id == arg_10_1 then
			table.remove(var_10_0, iter_10_0)

			return
		end
	end
end

function var_0_0.markCollection2RareMap(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	local var_11_0 = arg_11_1.cfgId
	local var_11_1 = RougeCollectionConfig.instance:getCollectionCfg(var_11_0)
	local var_11_2 = var_11_1 and var_11_1.showRare or 0

	if not arg_11_0._collectionRareMap[var_11_2] then
		arg_11_0._collectionRareMap[var_11_2] = {}
	end

	local var_11_3 = arg_11_1.id

	arg_11_0._collectionRareMap[var_11_2][var_11_3] = arg_11_1
end

function var_0_0.removeCollectionRareMap(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_12_2)
	local var_12_1 = var_12_0 and var_12_0.showRare or 0

	if not arg_12_0._collectionRareMap[var_12_1] then
		return
	end

	arg_12_0._collectionRareMap[var_12_1][arg_12_1] = nil
end

function var_0_0.getCollectionRareMap(arg_13_0)
	return arg_13_0._collectionRareMap
end

function var_0_0.markCollectionSlotArea(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	local var_14_0 = arg_14_1:getLeftTopPos()
	local var_14_1 = arg_14_1:getRotation()
	local var_14_2 = arg_14_1.id
	local var_14_3 = RougeCollectionConfig.instance:getShapeMatrix(arg_14_1.cfgId, var_14_1)

	if var_14_3 then
		for iter_14_0, iter_14_1 in ipairs(var_14_3) do
			for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
				if iter_14_3 and iter_14_3 > 0 then
					local var_14_4 = var_14_0.x + iter_14_2 - 1
					local var_14_5 = var_14_0.y + iter_14_0 - 1

					arg_14_0:markCollectionSlotCellState(var_14_2, var_14_4, var_14_5, true)
				end
			end
		end
	end
end

function var_0_0.markCollectionSlotCellState(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_0._slotCellStateMap = arg_15_0._slotCellStateMap or {}
	arg_15_0._slotCellStateMap[arg_15_2] = arg_15_0._slotCellStateMap[arg_15_2] or {}

	local var_15_0 = arg_15_0._slotCellStateMap[arg_15_2][arg_15_3]

	if var_15_0 and var_15_0 > 0 and var_15_0 ~= arg_15_1 then
		return
	end

	arg_15_0._slotCellStateMap[arg_15_2][arg_15_3] = arg_15_4 and arg_15_1 or 0
	arg_15_0._collectionPlaceMap[arg_15_1] = arg_15_0._collectionPlaceMap[arg_15_1] or {}
	arg_15_0._collectionPlaceMap[arg_15_1][arg_15_2] = arg_15_0._collectionPlaceMap[arg_15_1][arg_15_2] or {}
	arg_15_0._collectionPlaceMap[arg_15_1][arg_15_2][arg_15_3] = arg_15_4
end

function var_0_0.tryRemoveSlotCollection(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._slotCollections:getById(arg_16_1)

	if not var_16_0 then
		return
	end

	arg_16_0._slotCollections:remove(var_16_0)
	arg_16_0._allCollections:remove(var_16_0)
	arg_16_0:removeCollectionIdMap(var_16_0.id, var_16_0.cfgId)
	arg_16_0:removeCollectionRareMap(var_16_0.id, var_16_0.cfgId)
	arg_16_0:tryRemoveCollectionEnchantList(var_16_0.id)
	arg_16_0:releasePlaceCellState(arg_16_1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.DeleteSlotCollection, arg_16_1)
end

function var_0_0.onReceiveNewInfo2Bag(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_1 = RougeCollectionHelper.buildNewBagCollectionMO(iter_17_1)

		table.insert(var_17_0, var_17_1.id)
		arg_17_0:tryAddCollection2BagArea(var_17_1)
	end

	if RougeCollectionHelper.isNewGetCollection(arg_17_2) then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.GetNewCollections, var_17_0, arg_17_2, RougeEnum.CollectionPlaceArea.BagArea)
	end
end

function var_0_0.tryAddCollection2BagArea(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	local var_18_0 = arg_18_1.id

	arg_18_0:tryRemoveBagCollection(var_18_0)
	arg_18_0._bagCollections:addAtLast(arg_18_1)
	arg_18_0._allCollections:addAtLast(arg_18_1)
	arg_18_0:markCollection2IdMap(arg_18_1)
	arg_18_0:markCollection2RareMap(arg_18_1)
	arg_18_0:tryMarkCollection2EnchantList(arg_18_1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionBag)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionAttr, var_18_0)
end

function var_0_0.tryRemoveBagCollection(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._allCollections:getById(arg_19_1)

	if not var_19_0 then
		return
	end

	if arg_19_0:isCollectionPlaceInSlotArea(arg_19_1) then
		arg_19_0:tryRemoveSlotCollection(arg_19_1)
	else
		arg_19_0._bagCollections:remove(var_19_0)
	end

	arg_19_0._allCollections:remove(var_19_0)
	arg_19_0:tryRemoveCollectionEnchantList(var_19_0.id)
	arg_19_0:removeCollectionIdMap(var_19_0.id, var_19_0.cfgId)
	arg_19_0:removeCollectionRareMap(var_19_0.id, var_19_0.cfgId)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionBag)
end

function var_0_0.isSlotHasFilled(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getSlotFilledCollectionId(arg_20_1, arg_20_2)

	return var_20_0 and var_20_0 > 0
end

function var_0_0.getSlotFilledCollectionId(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._slotCellStateMap and arg_21_0._slotCellStateMap[arg_21_1]
	local var_21_1 = 0

	if var_21_0 and var_21_0[arg_21_2] then
		var_21_1 = var_21_0[arg_21_2] or 0
	end

	return var_21_1 or 0
end

function var_0_0.getCollectionByUid(arg_22_0, arg_22_1)
	return (arg_22_0._allCollections:getById(arg_22_1))
end

function var_0_0.getEnchants(arg_23_0)
	return arg_23_0._enchants
end

function var_0_0.getSlotAreaCollection(arg_24_0)
	return arg_24_0._slotCollections:getList()
end

function var_0_0.getBagAreaCollection(arg_25_0)
	return arg_25_0._bagCollections:getList()
end

function var_0_0.getBagAreaCollectionCount(arg_26_0)
	if arg_26_0._bagCollections then
		return arg_26_0._bagCollections:getCount()
	end

	return 0
end

function var_0_0.getSlotAreaCollectionCount(arg_27_0)
	if arg_27_0._slotCollections then
		return arg_27_0._slotCollections:getCount()
	end

	return 0
end

function var_0_0.releasePlaceCellState(arg_28_0, arg_28_1)
	if arg_28_0._collectionPlaceMap[arg_28_1] then
		for iter_28_0, iter_28_1 in pairs(arg_28_0._collectionPlaceMap[arg_28_1]) do
			for iter_28_2, iter_28_3 in pairs(iter_28_1) do
				arg_28_0:markCollectionSlotCellState(arg_28_1, iter_28_0, iter_28_2, false)
			end
		end
	end
end

function var_0_0.getCollectionCountById(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0._collectionIdMap and arg_29_0._collectionIdMap[arg_29_1]

	return var_29_0 and tabletool.len(var_29_0) or 0
end

function var_0_0.getCollectionByCfgId(arg_30_0, arg_30_1)
	return arg_30_0._collectionIdMap and arg_30_0._collectionIdMap[arg_30_1]
end

function var_0_0.rougeInlay(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if not arg_31_1 then
		return
	end

	local var_31_0 = tonumber(arg_31_1.id)

	arg_31_0:getCollectionByUid(var_31_0):updateInfo(arg_31_1)

	local var_31_1 = tonumber(arg_31_2.id)

	if var_31_1 > 0 then
		arg_31_0:getCollectionByUid(var_31_1):updateInfo(arg_31_2)
	end

	RougeCollectionEnchantController.instance:onRougeInlayInfoUpdate(var_31_0, var_31_1)
end

function var_0_0.rougeDemount(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1 then
		return
	end

	local var_32_0 = tonumber(arg_32_1.id)

	arg_32_0:getCollectionByUid(var_32_0):updateInfo(arg_32_1)
	RougeCollectionEnchantController.instance:onRougeInlayInfoUpdate(var_32_0)
end

function var_0_0.deleteSomeCollectionFromWarehouse(arg_33_0, arg_33_1)
	if not arg_33_1 then
		return
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		iter_33_1 = tonumber(iter_33_1)

		arg_33_0:tryRemoveBagCollection(iter_33_1)
	end
end

function var_0_0.deleteSomeCollectionFromSlot(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return
	end

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		iter_34_1 = tonumber(iter_34_1)

		arg_34_0:tryRemoveSlotCollection(iter_34_1)
	end
end

function var_0_0.isCollectionExist(arg_35_0, arg_35_1)
	return arg_35_0._allCollections:getById(arg_35_1) ~= nil
end

function var_0_0.isCollectionPlaceInBag(arg_36_0, arg_36_1)
	return arg_36_0._bagCollections:getById(arg_36_1) ~= nil
end

function var_0_0.isCollectionPlaceInSlotArea(arg_37_0, arg_37_1)
	return arg_37_0._slotCollections:getById(arg_37_1) ~= nil
end

function var_0_0.getCollectionPlaceArea(arg_38_0, arg_38_1)
	if arg_38_0:isCollectionPlaceInBag(arg_38_1) then
		return RougeEnum.CollectionPlaceArea.BagArea
	end

	if arg_38_0:isCollectionPlaceInSlotArea(arg_38_1) then
		return RougeEnum.CollectionPlaceArea.SlotArea
	end
end

function var_0_0.oneKeyPlace2SlotArea(arg_39_0, arg_39_1)
	if not arg_39_1 then
		return
	end

	arg_39_0:onReceiveNewInfo2Slot(arg_39_1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionBag)
end

function var_0_0.onKeyClearSlotArea(arg_40_0)
	if not arg_40_0._slotCollections then
		return
	end

	local var_40_0 = arg_40_0._slotCollections:getList()

	for iter_40_0 = #var_40_0, 1, -1 do
		local var_40_1 = var_40_0[iter_40_0].id

		arg_40_0:tryRemoveSlotCollection(var_40_1)
	end

	arg_40_0._slotCollections:clear()
end

function var_0_0.getCurSlotAreaSize(arg_41_0)
	if not arg_41_0._curSlotAreaSize then
		local var_41_0 = RougeController.instance:getStyleConfig()
		local var_41_1 = var_41_0 and var_41_0.layoutId
		local var_41_2 = RougeCollectionConfig.instance:getCollectionInitialBagSize(var_41_1)
		local var_41_3 = var_41_2 and var_41_2.col
		local var_41_4 = var_41_2 and var_41_2.row

		arg_41_0._curSlotAreaSize = {
			col = var_41_3,
			row = var_41_4
		}
	end

	return arg_41_0._curSlotAreaSize
end

function var_0_0.getCollectionActiveEffects(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:getCollectionByUid(arg_42_1)

	if var_42_0 and arg_42_0:isCollectionPlaceInSlotArea(arg_42_1) then
		return (var_42_0:getBaseEffects())
	end
end

function var_0_0.getCollectionActiveEffectMap(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0:getCollectionActiveEffects(arg_43_1)

	if var_43_0 then
		local var_43_1 = {}

		for iter_43_0, iter_43_1 in ipairs(var_43_0) do
			var_43_1[iter_43_1] = true
		end

		return var_43_1
	end
end

function var_0_0.checkIsCanCompositeCollection(arg_44_0, arg_44_1)
	local var_44_0 = RougeCollectionConfig.instance:getCollectionCompositeIds(arg_44_1)

	if not var_44_0 or #var_44_0 <= 0 then
		return false
	end

	local var_44_1 = {}

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		local var_44_2 = arg_44_0:getCollectionCountById(iter_44_1)
		local var_44_3 = var_44_1[iter_44_1] or 0

		if var_44_2 < var_44_3 + RougeEnum.CompositeCollectionCostCount then
			return false
		end

		var_44_1[iter_44_1] = var_44_3 + RougeEnum.CompositeCollectionCostCount
	end

	return true
end

function var_0_0.saveTmpCollectionTriggerEffectInfo(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	arg_45_0._effectTriggerMap = arg_45_0._effectTriggerMap or {}

	if arg_45_0._effectTriggerMap[arg_45_1.id] then
		for iter_45_0 = #arg_45_0._effectTriggerTab, 1, -1 do
			if arg_45_0._effectTriggerTab[iter_45_0].id == arg_45_1.id then
				arg_45_0._effectTriggerTab[iter_45_0] = nil
				arg_45_0._effectTriggerMap[arg_45_1.id] = nil
			end
		end
	end

	local var_45_0 = {
		trigger = arg_45_1,
		removeCollections = arg_45_2,
		add2SlotCollectionIds = arg_45_3,
		add2BagCollectionIds = arg_45_4,
		showType = arg_45_5,
		removeCollectionMap = {}
	}

	if arg_45_2 then
		for iter_45_1, iter_45_2 in ipairs(arg_45_2) do
			var_45_0.removeCollectionMap[iter_45_2.id] = iter_45_2
		end
	end

	arg_45_0._effectTriggerMap[arg_45_1.id] = true
	arg_45_0._effectTriggerTab = arg_45_0._effectTriggerTab or {}

	table.insert(arg_45_0._effectTriggerTab, var_45_0)
end

function var_0_0.getTmpCollectionTriggerEffectInfo(arg_46_0)
	return arg_46_0._effectTriggerTab
end

function var_0_0.clearTmpCollectionTriggerEffectInfo(arg_47_0)
	if arg_47_0._effectTriggerTab then
		tabletool.clear(arg_47_0._effectTriggerTab)
	end
end

function var_0_0.checkHasTmpTriggerEffectInfo(arg_48_0)
	return arg_48_0._effectTriggerTab and #arg_48_0._effectTriggerTab > 0
end

function var_0_0.updateCollectionItems(arg_49_0, arg_49_1)
	if not arg_49_1 then
		return
	end

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		local var_49_0 = tonumber(iter_49_1.id)
		local var_49_1 = arg_49_0:getCollectionByUid(var_49_0)

		if arg_49_0:isCollectionPlaceInSlotArea(var_49_0) then
			var_49_1:updateInfo(iter_49_1)
		else
			local var_49_2 = RougeCollectionHelper.buildNewBagCollectionMO(iter_49_1)

			arg_49_0:tryAddCollection2BagArea(var_49_2)
		end
	end
end

function var_0_0.switchCollectionInfoType(arg_50_0)
	arg_50_0._curInfoType = arg_50_0:getCurCollectionInfoType() == RougeEnum.CollectionInfoType.Complex and RougeEnum.CollectionInfoType.Simple or RougeEnum.CollectionInfoType.Complex

	RougeController.instance:dispatchEvent(RougeEvent.SwitchCollectionInfoType)
	arg_50_0:_saveCollectionInfoType(arg_50_0._curInfoType)
end

function var_0_0.getCurCollectionInfoType(arg_51_0)
	if not arg_51_0._curInfoType then
		local var_51_0 = arg_51_0:_getCollectionInfoTypeSaveKey()

		arg_51_0._curInfoType = tonumber(PlayerPrefsHelper.getNumber(var_51_0, RougeEnum.DefaultCollectionInfoType))
	end

	return arg_51_0._curInfoType
end

function var_0_0._saveCollectionInfoType(arg_52_0, arg_52_1)
	arg_52_1 = arg_52_1 or RougeEnum.DefaultCollectionInfoType

	local var_52_0 = arg_52_0:_getCollectionInfoTypeSaveKey()

	PlayerPrefsHelper.setNumber(var_52_0, arg_52_1)
end

function var_0_0._getCollectionInfoTypeSaveKey(arg_53_0)
	return (string.format("%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RougeCollectionInfoType))
end

var_0_0.instance = var_0_0.New()

return var_0_0
