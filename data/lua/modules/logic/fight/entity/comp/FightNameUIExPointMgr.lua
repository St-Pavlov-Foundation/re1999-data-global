module("modules.logic.fight.entity.comp.FightNameUIExPointMgr", package.seeall)

local var_0_0 = class("FightNameUIExPointMgr", UserDataDispose)
local var_0_1 = {
	[141102] = true
}

var_0_0.LineCount = 6
var_0_0.linePrefixX = 12
var_0_0.lineTopY = 16

function var_0_0.initMgr(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.goExPointContainer = arg_1_1
	arg_1_0.entity = arg_1_2
	arg_1_0.entityId = arg_1_0.entity.id
	arg_1_0.pointItemList = {}
	arg_1_0.hideExPoint = arg_1_0:checkNeedShieldExPoint()

	if arg_1_0.hideExPoint then
		gohelper.setActive(arg_1_1, false)

		return
	end

	local var_1_0 = arg_1_0.entity:getMO()

	arg_1_0.entityConfig = var_1_0:getCO()
	arg_1_0.totalMaxExPoint = var_1_0:getMaxExPoint()

	if not arg_1_0.entityConfig then
		logError(string.format("entity 找不到配置表: entityType = %s  modelId = %s", arg_1_0.entity:getMO().entityType, arg_1_0.entity:getMO().modelId))
	end

	arg_1_0:initGoPointPool()
	arg_1_0:initExPointLine()
	arg_1_0:initExPointItemList()
	arg_1_0:initExtraExPointItemList()
	arg_1_0:refreshPointItemCount()
	arg_1_0:addCustomEvents()
	arg_1_0:updateSelfExPoint()
end

local var_0_2 = {
	[10212131] = true,
	[10222111] = true,
	[10222131] = true,
	[10212111] = true,
	[10222121] = true,
	[10212121] = true
}

function var_0_0.checkNeedShieldExPoint(arg_2_0)
	local var_2_0 = arg_2_0.entity:getMO()
	local var_2_1 = var_2_0 and var_2_0.modelId

	if var_2_1 and var_0_2[var_2_1] then
		return false
	end

	if var_0_1[var_2_1] then
		return true
	end

	local var_2_2 = FightModel.instance:getCurMonsterGroupId()
	local var_2_3 = var_2_2 and lua_monster_group.configDict[var_2_2]
	local var_2_4 = var_2_3 and var_2_3.bossId
	local var_2_5 = var_2_4 and FightHelper.isBossId(var_2_4, var_2_1)

	return BossRushController.instance:isInBossRushFight() and var_2_5
end

function var_0_0.initGoPointPool(arg_3_0)
	arg_3_0.exPointItemPool = {}
	arg_3_0.extraPointItemPool = {}
	arg_3_0.goPoolContainer = gohelper.create2d(arg_3_0.goExPointContainer, "pointPool")

	gohelper.setActive(arg_3_0.goPoolContainer, false)
end

function var_0_0.initExPointLine(arg_4_0)
	arg_4_0.lineGroupList = arg_4_0:getUserDataTb_()
	arg_4_0.goLineGroupItem = gohelper.findChild(arg_4_0.goExPointContainer, "exPointLine")

	gohelper.setActive(arg_4_0.goLineGroupItem, false)

	arg_4_0.initLineGroupAnchorX, arg_4_0.initLineGroupAnchorY = recthelper.getAnchor(arg_4_0.goLineGroupItem.transform)
end

function var_0_0.addLineGroup(arg_5_0, arg_5_1)
	local var_5_0 = gohelper.cloneInPlace(arg_5_0.goLineGroupItem)

	gohelper.setActive(var_5_0, true)
	table.insert(arg_5_0.lineGroupList, arg_5_1, var_5_0)

	local var_5_1 = var_5_0:GetComponent(gohelper.Type_RectTransform)
	local var_5_2 = arg_5_0.initLineGroupAnchorX
	local var_5_3 = arg_5_0.initLineGroupAnchorY
	local var_5_4 = var_5_2 + (arg_5_1 - 1) * var_0_0.linePrefixX
	local var_5_5 = var_5_3 - (arg_5_1 - 1) * var_0_0.lineTopY

	recthelper.setAnchor(var_5_1, var_5_4, var_5_5)

	return var_5_0
end

function var_0_0.getLineGroup(arg_6_0, arg_6_1)
	if arg_6_1 < 1 then
		logError("激情点下标小于1 了？")

		return arg_6_0.lineGroupList[1]
	end

	arg_6_1 = math.ceil(arg_6_1 / var_0_0.LineCount)

	return arg_6_0.lineGroupList[arg_6_1] or arg_6_0:addLineGroup(arg_6_1)
end

function var_0_0.checkRemoveLineGroup(arg_7_0)
	local var_7_0 = #arg_7_0.pointItemList
	local var_7_1 = #arg_7_0.lineGroupList
	local var_7_2 = math.ceil(var_7_0 / var_0_0.LineCount)

	while var_7_2 < var_7_1 do
		local var_7_3 = arg_7_0.lineGroupList[var_7_1]

		table.remove(arg_7_0.lineGroupList)
		gohelper.destroy(var_7_3)

		var_7_1 = var_7_1 - 1
	end
end

function var_0_0.initExPointItemList(arg_8_0)
	arg_8_0.exPointItemList = {}
	arg_8_0.goPointItem = gohelper.findChild(arg_8_0.goExPointContainer, "empty")

	gohelper.setActive(arg_8_0.goPointItem, false)
end

function var_0_0.initExtraExPointItemList(arg_9_0)
	arg_9_0.extraExPointItemList = {}

	local var_9_0 = gohelper.findChild(arg_9_0.goExPointContainer, "extra")

	gohelper.setActive(var_9_0, false)

	arg_9_0.goExtraPointItem = var_9_0
end

function var_0_0.refreshPointItemCount(arg_10_0)
	arg_10_0:log(string.format("prePointCount : %s, exPointCount : %s, extraPointCount : %s", #arg_10_0.pointItemList, #arg_10_0.exPointItemList, #arg_10_0.extraExPointItemList))

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.pointItemList) do
		if iter_10_1:getType() == FightNameUIExPointBaseItem.ExPointType.Normal then
			table.insert(arg_10_0.exPointItemPool, iter_10_1)
		else
			table.insert(arg_10_0.extraPointItemPool, iter_10_1)
		end

		iter_10_1:recycle(arg_10_0.goPoolContainer)
	end

	tabletool.clear(arg_10_0.pointItemList)
	tabletool.clear(arg_10_0.exPointItemList)
	tabletool.clear(arg_10_0.extraExPointItemList)

	local var_10_0 = arg_10_0:getUniqueSkillNeedExPoint()

	arg_10_0:log(string.format("totalCount : %s, skillNeedPoint : %s, extraPointCount : %s", arg_10_0.totalMaxExPoint, var_10_0, arg_10_0.totalMaxExPoint - var_10_0))

	for iter_10_2 = 1, arg_10_0.totalMaxExPoint do
		if iter_10_2 <= var_10_0 then
			arg_10_0:addPointItem(iter_10_2)
		else
			arg_10_0:addExtraPointItem(iter_10_2)
		end
	end
end

function var_0_0.addPointItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getLineGroup(arg_11_1)
	local var_11_1

	if #arg_11_0.exPointItemPool > 0 then
		var_11_1 = table.remove(arg_11_0.exPointItemPool)

		gohelper.addChild(var_11_0, var_11_1:getPointGo())
	else
		local var_11_2 = gohelper.clone(arg_11_0.goPointItem, var_11_0)

		var_11_1 = FightNameUIExPointItem.GetExPointItem(var_11_2)
	end

	var_11_1.entityName = arg_11_0.entity:getMO():getEntityName()

	table.insert(arg_11_0.exPointItemList, var_11_1)
	table.insert(arg_11_0.pointItemList, var_11_1)
	var_11_1:setIndex(arg_11_1)
	var_11_1:setMgr(arg_11_0)
end

function var_0_0.removePointItem(arg_12_0)
	local var_12_0 = table.remove(arg_12_0.exPointItemList)

	arg_12_0:assetPointItem(var_12_0)

	if var_12_0 then
		var_12_0:recycle(arg_12_0.goPoolContainer)
		table.insert(arg_12_0.exPointItemPool, var_12_0)
	end

	tabletool.removeValue(arg_12_0.pointItemList, var_12_0)
	arg_12_0:checkRemoveLineGroup()
end

function var_0_0.addExtraPointItem(arg_13_0, arg_13_1)
	if arg_13_0.entity:getMO():hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		arg_13_0:addPointItem(arg_13_1)

		return
	end

	local var_13_0 = arg_13_0:getLineGroup(arg_13_1)
	local var_13_1

	if #arg_13_0.extraPointItemPool > 0 then
		var_13_1 = table.remove(arg_13_0.extraPointItemPool)

		gohelper.addChild(var_13_0, var_13_1:getPointGo())
	else
		local var_13_2 = gohelper.clone(arg_13_0.goExtraPointItem, var_13_0)

		var_13_1 = FightNameUIExPointExtraItem.GetExtraExPointItem(var_13_2)
	end

	var_13_1.entityName = arg_13_0.entity:getMO():getEntityName()

	table.insert(arg_13_0.extraExPointItemList, var_13_1)
	table.insert(arg_13_0.pointItemList, var_13_1)
	var_13_1:setIndex(arg_13_1)
	var_13_1:setMgr(arg_13_0)
end

function var_0_0.removeExtraPointItem(arg_14_0)
	if arg_14_0.entity:getMO():hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		arg_14_0:removePointItem()

		return
	end

	local var_14_0 = table.remove(arg_14_0.extraExPointItemList)

	arg_14_0:assetPointItem(var_14_0)

	if var_14_0 then
		var_14_0:recycle(arg_14_0.goPoolContainer)
		table.insert(arg_14_0.extraPointItemPool, var_14_0)
	end

	tabletool.removeValue(arg_14_0.pointItemList, var_14_0)
	arg_14_0:checkRemoveLineGroup()
end

function var_0_0.addCustomEvents(arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.AddPlayCardClientExPoint, arg_15_0.addPlayCardClientExPoint, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.UpdateExPoint, arg_15_0.updateExPoint, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnExpointMaxAdd, arg_15_0.onExPointMaxAdd, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_15_0.onBuffUpdate, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnExPointChange, arg_15_0.onExPointChange, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.MultiHpChange, arg_15_0.onMultiHpChange, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnExSkillPointChange, arg_15_0.onExSkillPointChange, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnStoreExPointChange, arg_15_0.onStoreExPointChange, arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.BeContract, arg_15_0.onBeContract, arg_15_0)
end

function var_0_0.onBeContract(arg_16_0, arg_16_1)
	if arg_16_0.entityId ~= arg_16_1 then
		return
	end

	AudioMgr.instance:trigger(20220175)

	local var_16_0 = gohelper.findChild(arg_16_0.goExPointContainer, "#go_tianshinana")

	gohelper.setActive(var_16_0, false)
	gohelper.setActive(var_16_0, true)
	gohelper.setAsLastSibling(var_16_0)
	arg_16_0:updateSelfExPoint()
	TaskDispatcher.cancelTask(arg_16_0.hideTsnnEffect, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0.hideTsnnEffect, arg_16_0, 1)
end

function var_0_0.hideTsnnEffect(arg_17_0)
	local var_17_0 = gohelper.findChild(arg_17_0.goExPointContainer, "#go_tianshinana")

	gohelper.setActive(var_17_0, false)
end

function var_0_0.getClientExPoint(arg_18_0)
	local var_18_0 = arg_18_0.entity:getMO()

	return var_18_0.exPoint + var_18_0.moveCardExPoint + var_18_0.playCardExPoint
end

function var_0_0.getServerExPoint(arg_19_0)
	return arg_19_0.entity:getMO().exPoint
end

function var_0_0.getUsedExPoint(arg_20_0)
	return FightHelper.getPredeductionExpoint(arg_20_0.entityId)
end

function var_0_0.getUniqueSkillNeedExPoint(arg_21_0)
	local var_21_0 = arg_21_0.entity:getMO():getUniqueSkillPoint()

	arg_21_0:log("大招需要激情点：" .. tostring(var_21_0))

	return var_21_0
end

function var_0_0.getStoredExPoint(arg_22_0)
	return arg_22_0.entity:getMO():getStoredExPoint()
end

function var_0_0.updateSelfExPoint(arg_23_0)
	if arg_23_0.hideExPoint then
		return
	end

	arg_23_0:updateExPoint(arg_23_0.entityId)
end

function var_0_0.getPointCurState(arg_24_0, arg_24_1)
	if arg_24_0:getUsedExPoint() > 0 then
		return arg_24_0:getUsedPointCurState(arg_24_1)
	else
		return arg_24_0:getNoUsePointCurState(arg_24_1)
	end
end

function var_0_0.getUsedPointCurState(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getStoredExPoint()
	local var_25_1 = arg_25_0:getUniqueSkillNeedExPoint()
	local var_25_2 = math.min(var_25_0, var_25_1)

	if arg_25_1 <= var_25_2 then
		return FightEnum.ExPointState.Stored
	end

	local var_25_3 = arg_25_0:getClientExPoint()
	local var_25_4 = arg_25_0:getServerExPoint()
	local var_25_5 = arg_25_0:getUsedExPoint()
	local var_25_6 = var_25_4 - var_25_5
	local var_25_7 = math.min(arg_25_0.totalMaxExPoint, var_25_2 + var_25_6)

	if arg_25_1 <= var_25_7 then
		return FightEnum.ExPointState.Server
	end

	local var_25_8 = var_25_3 - var_25_5
	local var_25_9 = math.min(arg_25_0.totalMaxExPoint, var_25_2 + var_25_8)

	if arg_25_1 <= var_25_9 then
		return FightEnum.ExPointState.Client
	end

	local var_25_10 = math.max(var_25_7, var_25_9)

	if arg_25_1 <= math.min(arg_25_0.totalMaxExPoint, var_25_10 + var_25_1) then
		return FightEnum.ExPointState.UsingUnique
	end

	return FightEnum.ExPointState.Empty
end

function var_0_0.getNoUsePointCurState(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getClientExPoint()
	local var_26_1 = arg_26_0:getServerExPoint()
	local var_26_2 = arg_26_0:getStoredExPoint()
	local var_26_3 = arg_26_0:getUniqueSkillNeedExPoint()

	if arg_26_1 <= math.min(var_26_2, var_26_3) then
		return FightEnum.ExPointState.Stored
	end

	local var_26_4 = arg_26_0.entity:getMO()

	if var_26_1 >= var_26_4:getMaxExPoint() then
		return FightEnum.ExPointState.ServerFull
	end

	if not FightHelper.canAddPoint(var_26_4) then
		if arg_26_1 <= var_26_1 then
			return FightEnum.ExPointState.Server
		end

		return FightEnum.ExPointState.Lock
	else
		if arg_26_1 <= var_26_1 then
			return FightEnum.ExPointState.Server
		end

		if arg_26_1 <= var_26_0 then
			return FightEnum.ExPointState.Client
		end

		return FightEnum.ExPointState.Empty
	end
end

function var_0_0.updateExPoint(arg_27_0, arg_27_1)
	if arg_27_0.entityId ~= arg_27_1 then
		return
	end

	arg_27_0:log("updateExPoint")

	if arg_27_0:getUsedExPoint() > 0 then
		arg_27_0:_updateUsedPointStatus()
	else
		arg_27_0:_updateNoUsedPointStatus()
	end

	arg_27_0.preClientExPoint = arg_27_0:getClientExPoint()
end

function var_0_0._updateUsedPointStatus(arg_28_0)
	local var_28_0 = arg_28_0:getClientExPoint()
	local var_28_1 = arg_28_0:getServerExPoint()
	local var_28_2 = arg_28_0:getUsedExPoint()
	local var_28_3 = arg_28_0:getStoredExPoint()
	local var_28_4 = arg_28_0:getUniqueSkillNeedExPoint()
	local var_28_5 = math.min(var_28_3, var_28_4)
	local var_28_6 = 0

	for iter_28_0 = 1, var_28_5 do
		var_28_6 = var_28_6 + 1

		local var_28_7 = arg_28_0.pointItemList[var_28_6]

		arg_28_0:assetPointItem(var_28_7)

		if var_28_7 then
			var_28_7:directSetState(FightEnum.ExPointState.Stored)
		end
	end

	local var_28_8 = var_28_1 - var_28_2
	local var_28_9 = math.min(arg_28_0.totalMaxExPoint, var_28_5 + var_28_8)

	for iter_28_1 = var_28_6 + 1, var_28_9 do
		var_28_6 = var_28_6 + 1

		local var_28_10 = arg_28_0.pointItemList[var_28_6]

		arg_28_0:assetPointItem(var_28_10)

		if var_28_10 then
			var_28_10:directSetState(FightEnum.ExPointState.Server)
		end
	end

	local var_28_11 = var_28_0 - var_28_2
	local var_28_12 = math.min(arg_28_0.totalMaxExPoint, var_28_5 + var_28_11)

	for iter_28_2 = var_28_6 + 1, var_28_12 do
		var_28_6 = var_28_6 + 1

		local var_28_13 = arg_28_0.pointItemList[var_28_6]

		arg_28_0:assetPointItem(var_28_13)

		if var_28_13 then
			var_28_13:directSetState(FightEnum.ExPointState.Client)
		end
	end

	local var_28_14 = math.min(arg_28_0.totalMaxExPoint, var_28_6 + var_28_4)

	for iter_28_3 = var_28_6 + 1, var_28_14 do
		var_28_6 = var_28_6 + 1

		local var_28_15 = arg_28_0.pointItemList[var_28_6]

		arg_28_0:assetPointItem(var_28_15)

		if var_28_15 then
			var_28_15:directSetState(FightEnum.ExPointState.UsingUnique)
		end
	end

	for iter_28_4 = var_28_6 + 1, arg_28_0.totalMaxExPoint do
		var_28_6 = var_28_6 + 1

		local var_28_16 = arg_28_0.pointItemList[iter_28_4]

		arg_28_0:assetPointItem(var_28_16)

		if var_28_16 then
			var_28_16:directSetState(FightEnum.ExPointState.Empty)
		end
	end
end

function var_0_0._updateNoUsedPointStatus(arg_29_0)
	local var_29_0 = arg_29_0:getClientExPoint()
	local var_29_1 = arg_29_0:getServerExPoint()
	local var_29_2 = arg_29_0:getStoredExPoint()
	local var_29_3 = arg_29_0:getUniqueSkillNeedExPoint()
	local var_29_4 = math.min(var_29_2, var_29_3)
	local var_29_5 = 0

	for iter_29_0 = 1, var_29_4 do
		var_29_5 = var_29_5 + 1

		local var_29_6 = arg_29_0.pointItemList[var_29_5]

		arg_29_0:assetPointItem(var_29_6)

		if var_29_6 then
			var_29_6:directSetState(FightEnum.ExPointState.Stored)
		end
	end

	for iter_29_1 = var_29_5 + 1, var_29_1 do
		var_29_5 = var_29_5 + 1

		local var_29_7 = arg_29_0.pointItemList[var_29_5]

		arg_29_0:assetPointItem(var_29_7)

		if var_29_7 then
			var_29_7:directSetState(FightEnum.ExPointState.Server)
		end
	end

	local var_29_8 = arg_29_0.entity:getMO()

	if var_29_1 >= arg_29_0.totalMaxExPoint then
		arg_29_0:playFullAnim()

		return
	end

	if not FightHelper.canAddPoint(var_29_8) then
		for iter_29_2 = var_29_5 + 1, arg_29_0.totalMaxExPoint do
			var_29_5 = var_29_5 + 1

			local var_29_9 = arg_29_0.pointItemList[var_29_5]

			arg_29_0:assetPointItem(var_29_9)

			if var_29_9 then
				var_29_9:directSetState(FightEnum.ExPointState.Lock)
			end
		end
	else
		for iter_29_3 = var_29_5 + 1, var_29_0 do
			var_29_5 = var_29_5 + 1

			local var_29_10 = arg_29_0.pointItemList[var_29_5]

			arg_29_0:assetPointItem(var_29_10)

			if var_29_10 then
				var_29_10:directSetState(FightEnum.ExPointState.Client)
			end
		end

		for iter_29_4 = var_29_5 + 1, arg_29_0.totalMaxExPoint do
			var_29_5 = var_29_5 + 1

			local var_29_11 = arg_29_0.pointItemList[var_29_5]

			arg_29_0:assetPointItem(var_29_11)

			if var_29_11 then
				var_29_11:directSetState(FightEnum.ExPointState.Empty)
			end
		end
	end
end

function var_0_0.onExPointMaxAdd(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.entityId ~= arg_30_1 then
		return
	end

	local var_30_0 = arg_30_0.entity:getMO():getMaxExPoint()

	if var_30_0 == #arg_30_0.pointItemList then
		return
	end

	arg_30_0:log("激情点上限增加")

	arg_30_0.totalMaxExPoint = var_30_0

	arg_30_0:refreshPointItemCount()
	arg_30_0:updateSelfExPoint()
end

function var_0_0.onBuffUpdate(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_1 ~= arg_31_0.entityId then
		return
	end

	arg_31_0:log("更新buff")
	arg_31_0:refreshPointLockStatus(arg_31_2, arg_31_3)
	arg_31_0:checkNeedRefreshPointCount(arg_31_2, arg_31_3)
end

function var_0_0.refreshPointLockStatus(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0

	if arg_32_1 == FightEnum.EffectType.BUFFADD then
		if FightBuffHelper.hasCantAddExPointFeature(arg_32_2) then
			var_32_0 = FightEnum.ExPointState.Lock
		end
	elseif arg_32_1 == FightEnum.EffectType.BUFFDEL then
		local var_32_1 = arg_32_0.entity:getMO()

		if FightBuffHelper.hasCantAddExPointFeature(arg_32_2) and FightHelper.canAddPoint(var_32_1) then
			var_32_0 = FightEnum.ExPointState.Empty
		end
	end

	if var_32_0 then
		local var_32_2 = arg_32_0.entity:getMO().exPoint
		local var_32_3 = arg_32_0:getStoredExPoint()

		for iter_32_0 = math.max(var_32_2, var_32_3) + 1, arg_32_0.totalMaxExPoint do
			local var_32_4 = arg_32_0.pointItemList[iter_32_0]

			arg_32_0:assetPointItem(var_32_4)

			if var_32_4 then
				var_32_4:switchToState(var_32_0)
			end
		end
	end
end

function var_0_0.checkNeedRefreshPointCount(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.entity:getMO()

	if arg_33_1 == FightEnum.EffectType.BUFFADD then
		local var_33_1 = var_33_0:getFeaturesSplitInfoByBuffId(arg_33_2)

		if var_33_1 then
			for iter_33_0, iter_33_1 in ipairs(var_33_1) do
				if iter_33_1[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					arg_33_0:refreshPointItemCount()
					arg_33_0:updateSelfExPoint()

					return
				end
			end
		end
	end

	if arg_33_1 == FightEnum.EffectType.BUFFDEL then
		local var_33_2 = var_33_0:getFeaturesSplitInfoByBuffId(arg_33_2)

		if var_33_2 then
			for iter_33_2, iter_33_3 in ipairs(var_33_2) do
				if iter_33_3[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					arg_33_0:refreshPointItemCount()
					arg_33_0:updateSelfExPoint()
				end
			end
		end
	end
end

function var_0_0.onExPointChange(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if arg_34_1 ~= arg_34_0.entityId then
		return
	end

	if arg_34_2 == arg_34_3 then
		return
	end

	arg_34_0:log(string.format("激情点改变 oldNum : %s, newNUm : %s", arg_34_2, arg_34_3))

	if arg_34_2 < arg_34_3 then
		arg_34_0:playAddPointEffect(arg_34_2, arg_34_3)
	else
		arg_34_0:playRemovePointEffect(arg_34_2, arg_34_3)
	end
end

function var_0_0.playAddPointEffect(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_2 >= arg_35_0.entity:getMO():getMaxExPoint()
	local var_35_1 = arg_35_0:getStoredExPoint()

	if var_35_0 then
		local var_35_2 = FightNameUIExPointBaseItem.AnimNameDuration[FightNameUIExPointBaseItem.AnimName.Add]

		for iter_35_0 = math.max(var_35_1 + 1, 1), arg_35_1 do
			local var_35_3 = arg_35_0.pointItemList[iter_35_0]

			arg_35_0:assetPointItem(var_35_3)

			if var_35_3 then
				var_35_3:delaySwitchToNextState(FightEnum.ExPointState.ServerFull, var_35_2 + 0.13 * (iter_35_0 - 1))
			end
		end

		for iter_35_1 = math.max(var_35_1 + 1, arg_35_1 + 1), arg_35_2 do
			local var_35_4 = arg_35_0.pointItemList[iter_35_1]

			arg_35_0:assetPointItem(var_35_4)

			if var_35_4 then
				var_35_4:playAddPointEffect(FightEnum.ExPointState.ServerFull, var_35_2 + 0.13 * (iter_35_1 - 1))
			end
		end
	else
		for iter_35_2 = math.max(var_35_1 + 1, arg_35_1 + 1), arg_35_2 do
			local var_35_5 = arg_35_0.pointItemList[iter_35_2]

			arg_35_0:assetPointItem(var_35_5)

			if var_35_5 then
				var_35_5:playAddPointEffect()
			end
		end
	end
end

function var_0_0.playRemovePointEffect(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 >= arg_36_0.entity:getMO():getMaxExPoint() then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0.pointItemList) do
			iter_36_1:updateExPoint()
		end
	end

	for iter_36_2 = arg_36_2 + 1, arg_36_1 do
		local var_36_0 = arg_36_0.pointItemList[iter_36_2]

		arg_36_0:assetPointItem(var_36_0)

		if var_36_0 then
			var_36_0:playAnim(FightNameUIExPointBaseItem.AnimName.Lost)
		end
	end
end

function var_0_0.playFullAnim(arg_37_0)
	local var_37_0 = arg_37_0.entity:getMO().exPoint
	local var_37_1 = arg_37_0:getStoredExPoint() + 1

	for iter_37_0 = var_37_1, var_37_0 do
		local var_37_2 = arg_37_0.pointItemList[arg_37_0.curPlayFullIndex]

		arg_37_0:assetPointItem(var_37_2)

		if var_37_2 then
			var_37_2:delaySwitchToNextState(FightEnum.ExPointState.ServerFull, 0.13 * (iter_37_0 - var_37_1))
		end
	end
end

function var_0_0.onMultiHpChange(arg_38_0)
	arg_38_0:log("onMultiHpChange")
	arg_38_0:updateSelfExPoint()
end

function var_0_0.onExSkillPointChange(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_0.entity and arg_39_1 == arg_39_0.entity.id then
		arg_39_0:log("大招需求激情变化")
		arg_39_0:refreshPointItemCount()
		arg_39_0:updateSelfExPoint()
	end
end

function var_0_0.addPlayCardClientExPoint(arg_40_0, arg_40_1)
	if arg_40_1 ~= arg_40_0.entityId then
		return
	end

	arg_40_0:log("增加客户端激情点")

	local var_40_0 = arg_40_0.entity:getMO():getMaxExPoint()

	if var_40_0 <= arg_40_0.preClientExPoint then
		arg_40_0:updateSelfExPoint()

		return
	end

	if arg_40_0:getClientExPoint() == var_40_0 then
		for iter_40_0, iter_40_1 in ipairs(arg_40_0.pointItemList) do
			iter_40_1:playAnim(FightNameUIExPointBaseItem.AnimName.Explosion)
		end
	else
		arg_40_0:updateSelfExPoint()
	end
end

function var_0_0.onStoreExPointChange(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_1 ~= arg_41_0.entityId then
		return
	end

	local var_41_0 = arg_41_0:getStoredExPoint()

	if arg_41_2 == var_41_0 then
		return
	end

	arg_41_0:log("溢出激情变化")

	if arg_41_2 < var_41_0 then
		FightAudioMgr.instance:playAudio(20211401)
		arg_41_0:playAddStoredPointEffect(arg_41_2, var_41_0)
	else
		FightAudioMgr.instance:playAudio(20211402)
		arg_41_0:playRemoveStoredPointEffect(arg_41_2, var_41_0)
	end
end

function var_0_0.playAddStoredPointEffect(arg_42_0, arg_42_1, arg_42_2)
	for iter_42_0 = arg_42_1 + 1, arg_42_2 do
		local var_42_0 = arg_42_0.pointItemList[iter_42_0]

		if var_42_0 then
			var_42_0:switchToState(FightEnum.ExPointState.Stored)
		end
	end
end

function var_0_0.playRemoveStoredPointEffect(arg_43_0, arg_43_1, arg_43_2)
	for iter_43_0 = arg_43_2 + 1, arg_43_1 do
		local var_43_0 = arg_43_0.pointItemList[iter_43_0]

		if var_43_0 then
			var_43_0:playRemoveStoredEffect()
		end
	end
end

function var_0_0.assetPointItem(arg_44_0, arg_44_1)
	return
end

function var_0_0.log(arg_45_0, arg_45_1)
	return
end

function var_0_0.beforeDestroy(arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0.hideTsnnEffect, arg_46_0)

	if arg_46_0.pointItemList then
		for iter_46_0, iter_46_1 in ipairs(arg_46_0.pointItemList) do
			iter_46_1:destroy()
		end
	end

	if arg_46_0.exPointItemPool then
		for iter_46_2, iter_46_3 in ipairs(arg_46_0.exPointItemPool) do
			iter_46_3:destroy()
		end
	end

	if arg_46_0.extraPointItemPool then
		for iter_46_4, iter_46_5 in ipairs(arg_46_0.extraPointItemPool) do
			iter_46_5:destroy()
		end
	end

	arg_46_0.pointItemList = nil
	arg_46_0.exPointItemList = nil
	arg_46_0.extraExPointItemList = nil
	arg_46_0.exPointItemPool = nil
	arg_46_0.extraPointItemPool = nil

	arg_46_0:__onDispose()
end

return var_0_0
