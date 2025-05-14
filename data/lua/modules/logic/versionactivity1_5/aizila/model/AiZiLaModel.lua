module("modules.logic.versionactivity1_5.aizila.model.AiZiLaModel", package.seeall)

local var_0_0 = class("AiZiLaModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._epsiodeItemModelDict = {}

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
	arg_4_0._curEpisodeId = 0
	arg_4_0._curActivityId = VersionActivity1_5Enum.ActivityId.AiZiLa
	arg_4_0._unlockEventIds = {}
	arg_4_0._optionEventIds = {}
	arg_4_0._selectEventIds = {}
	arg_4_0._collectItemIds = {}

	arg_4_0:_clearModel()
end

function var_0_0._clearModel(arg_5_0)
	arg_5_0._itemModel = arg_5_0:_clearOrCreateModel(arg_5_0._itemModel)
	arg_5_0._equipModel = arg_5_0:_clearOrCreateModel(arg_5_0._equipModel)
	arg_5_0._episodeModel = arg_5_0:_clearOrCreateModel(arg_5_0._episodeModel)
	arg_5_0._epsiodeItemModelDict = arg_5_0._epsiodeItemModelDict or {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._epsiodeItemModelDict) do
		iter_5_1:clear()
	end
end

function var_0_0._clearOrCreateModel(arg_6_0, arg_6_1)
	return AiZiLaHelper.clearOrCreateModel(arg_6_1)
end

function var_0_0.setCurEpisodeId(arg_7_0, arg_7_1)
	arg_7_0._curEpisodeId = arg_7_1
end

function var_0_0.getCurEpisodeId(arg_8_0)
	return arg_8_0._curEpisodeId
end

function var_0_0.getCurActivityID(arg_9_0)
	return arg_9_0._curActivityId
end

function var_0_0.isEpisodeClear(arg_10_0, arg_10_1)
	return false
end

function var_0_0.isEpisodeLock(arg_11_0, arg_11_1)
	return arg_11_0:getEpisodeMO(arg_11_1) == nil
end

function var_0_0.getEquipMO(arg_12_0, arg_12_1)
	return arg_12_0._equipModel:getById(arg_12_1)
end

function var_0_0.getEquipMOList(arg_13_0)
	return arg_13_0._equipModel:getList()
end

function var_0_0.getEpisodeMO(arg_14_0, arg_14_1)
	return arg_14_0._episodeModel:getById(arg_14_1)
end

function var_0_0.getRecordMOList(arg_15_0)
	if not arg_15_0._recordMOList then
		arg_15_0._recordMOList = {}

		local var_15_0 = AiZiLaConfig.instance:getRecordEventList(VersionActivity1_5Enum.ActivityId.AiZiLa) or {}

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_1 = AiZiLaRecordMO.New()

			var_15_1:init(iter_15_1)
			table.insert(arg_15_0._recordMOList, var_15_1)
		end
	end

	return arg_15_0._recordMOList
end

function var_0_0.getHandbookMOList(arg_16_0)
	if not arg_16_0._handbookMOList then
		arg_16_0._handbookMOList = {}

		local var_16_0 = AiZiLaConfig.instance:getItemList() or {}

		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			local var_16_1 = AiZiLaHandbookMO.New()

			var_16_1:init(iter_16_1.id)
			table.insert(arg_16_0._handbookMOList, var_16_1)
		end
	end

	return arg_16_0._handbookMOList
end

function var_0_0._updateIdDict(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 and #arg_17_2 > 0 then
		for iter_17_0, iter_17_1 in ipairs(arg_17_2) do
			if arg_17_1[iter_17_1] == nil then
				arg_17_1[iter_17_1] = true
			end
		end
	end
end

function var_0_0._isHasIdDict(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1[arg_18_2] then
		return true
	end

	return false
end

function var_0_0._updateMOModel(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	return AiZiLaHelper.updateMOModel(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
end

function var_0_0._updateEpsiodeModel(arg_20_0, arg_20_1)
	arg_20_0:_updateMOModel(AiZiLaEpsiodeMO, arg_20_0._episodeModel, arg_20_1.episodeId, arg_20_1)
end

function var_0_0._updateItemModel(arg_21_0, arg_21_1)
	return arg_21_0:_updateMOModel(AiZiLaItemMO, arg_21_0._itemModel, arg_21_1.uid, arg_21_1)
end

function var_0_0._updateEquipModel(arg_22_0, arg_22_1)
	local var_22_0 = AiZiLaConfig.instance:getEquipCo(VersionActivity1_5Enum.ActivityId.AiZiLa, arg_22_1)

	if not var_22_0 then
		logError(string.format("[144_爱兹拉角色活动 export_装备] 找不到装备 id:%s", arg_22_1))

		return arg_22_0._equipModel
	end

	local var_22_1 = arg_22_0:_updateMOModel(AiZiLaEquipMO, arg_22_0._equipModel, var_22_0.typeId, arg_22_1)

	arg_22_0:_checkEquipUpLevelRed()

	return var_22_1
end

function var_0_0.getItemQuantity(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._itemModel:getList()
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if iter_23_1.itemId == arg_23_1 then
			var_23_1 = var_23_1 + iter_23_1.quantity
		end
	end

	return var_23_1
end

function var_0_0.isSelectOptionId(arg_24_0, arg_24_1)
	return arg_24_0:_isHasIdDict(arg_24_0._optionEventIds, arg_24_1)
end

function var_0_0.isSelectEventId(arg_25_0, arg_25_1)
	return arg_25_0:_isHasIdDict(arg_25_0._selectEventIds, arg_25_1)
end

function var_0_0.isUnlockEventId(arg_26_0, arg_26_1)
	return arg_26_0:_isHasIdDict(arg_26_0._unlockEventIds, arg_26_1)
end

function var_0_0.isCollectItemId(arg_27_0, arg_27_1)
	return arg_27_0:_isHasIdDict(arg_27_0._collectItemIds, arg_27_1)
end

function var_0_0.getInfosReply(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.Act144InfoNO

	arg_28_0:_clearData()

	local var_28_1 = var_28_0.act144Episodes or {}

	for iter_28_0, iter_28_1 in ipairs(var_28_1) do
		arg_28_0:_updateEpsiodeModel(iter_28_1)
	end

	local var_28_2 = var_28_0.act144Items or {}

	for iter_28_2, iter_28_3 in ipairs(var_28_2) do
		arg_28_0:_updateItemModel(iter_28_3)
	end

	local var_28_3 = var_28_0.equipIds or {}

	for iter_28_4, iter_28_5 in ipairs(var_28_3) do
		arg_28_0:_updateEquipModel(iter_28_5)
	end

	arg_28_0:_updateIdDict(arg_28_0._optionEventIds, var_28_0.optionIds)
	arg_28_0:_updateIdDict(arg_28_0._unlockEventIds, var_28_0.unlockEventIds)
	arg_28_0:_updateIdDict(arg_28_0._selectEventIds, var_28_0.selectEventIds)
	arg_28_0:_updateIdDict(arg_28_0._collectItemIds, var_28_0.collectItemIds)
	arg_28_0:checkItemRed()
	arg_28_0:checkRecordRed()
end

function var_0_0.enterEpisodeReply(arg_29_0, arg_29_1)
	return
end

function var_0_0.selectOptionReply(arg_30_0, arg_30_1)
	arg_30_0:_updateIdDict(arg_30_0._optionEventIds, arg_30_1.optionIds)
	arg_30_0:_updateIdDict(arg_30_0._unlockEventIds, arg_30_1.unlockEventIds)
	arg_30_0:_updateIdDict(arg_30_0._selectEventIds, arg_30_1.selectEventIds)
	arg_30_0:checkRecordRed()
end

function var_0_0.settleEpisodeReply(arg_31_0, arg_31_1)
	return
end

function var_0_0.settlePush(arg_32_0, arg_32_1)
	arg_32_0:_updateIdDict(arg_32_0._collectItemIds, arg_32_1.collectItemIds)
	arg_32_0:checkItemRed()
end

function var_0_0.nextDayReply(arg_33_0, arg_33_1)
	return
end

function var_0_0.upgradeEquipReply(arg_34_0, arg_34_1)
	arg_34_0:_updateEquipModel(arg_34_1.newEquipId)
end

function var_0_0.episodePush(arg_35_0, arg_35_1)
	arg_35_0:_updateEpsiodeModel(arg_35_1.act144Episode)
end

function var_0_0.itemChangePush(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.deleteAct144Items or {}

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		arg_36_0._itemModel:remove(arg_36_0._itemModel:getById(iter_36_1.uid))
	end

	local var_36_1 = arg_36_1.updateAct144Items or {}

	for iter_36_2, iter_36_3 in ipairs(var_36_1) do
		arg_36_0:_updateItemModel(iter_36_3)
	end

	arg_36_0:_checkEquipUpLevelRed()
end

function var_0_0.isHasEquipUpLevel(arg_37_0)
	local var_37_0 = arg_37_0._equipModel:getList()

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		if iter_37_1:isCanUpLevel() then
			return true
		end
	end

	return false
end

function var_0_0._checkEquipUpLevelRed(arg_38_0)
	local var_38_0 = {}

	table.insert(var_38_0, {
		id = RedDotEnum.DotNode.V1a5AiZiLaEquip,
		value = arg_38_0:isHasEquipUpLevel() and 1 or 0
	})
	RedDotRpc.instance:clientAddRedDotGroupList(var_38_0, true)
end

function var_0_0.checkItemRed(arg_39_0)
	local var_39_0 = {}

	arg_39_0:_addRedMOList(RedDotEnum.DotNode.V1a5AiZiLaHandbookNew, arg_39_0:getHandbookMOList(), RedDotEnum.DotNode.V1a5AiZiLaHandbook, var_39_0)
	RedDotRpc.instance:clientAddRedDotGroupList(var_39_0, true)
end

function var_0_0.finishItemRed(arg_40_0)
	local var_40_0 = arg_40_0:getHandbookMOList()

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		if iter_40_1:isHasRed() then
			iter_40_1:finishRed()
		end
	end

	arg_40_0:checkItemRed()
end

function var_0_0.checkRecordRed(arg_41_0)
	local var_41_0 = {}
	local var_41_1 = arg_41_0:getRecordMOList()

	for iter_41_0, iter_41_1 in ipairs(var_41_1) do
		arg_41_0:_addRedMOList(RedDotEnum.DotNode.V1a5AiZiLaRecordEventNew, iter_41_1:getEventMOList(), nil, var_41_0)
	end

	arg_41_0:_addRedMOList(RedDotEnum.DotNode.V1a5AiZiLaRecordNew, var_41_1, RedDotEnum.DotNode.V1a5AiZiLaRecord, var_41_0)
	RedDotRpc.instance:clientAddRedDotGroupList(var_41_0, true)
end

function var_0_0._addRedMOList(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = arg_42_4 or {}
	local var_42_1 = false

	for iter_42_0, iter_42_1 in ipairs(arg_42_2) do
		local var_42_2 = iter_42_1:isHasRed()
		local var_42_3 = iter_42_1:getRedUid()

		if var_42_2 then
			var_42_1 = true
		end

		table.insert(var_42_0, {
			id = arg_42_1,
			uid = var_42_3,
			value = var_42_2 and 1 or 0
		})
	end

	if arg_42_3 then
		table.insert(var_42_0, {
			id = arg_42_3,
			value = var_42_1 and 1 or 0
		})
	end

	return var_42_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
