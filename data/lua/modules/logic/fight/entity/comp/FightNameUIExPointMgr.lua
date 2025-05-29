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

	arg_1_0.totalMaxExPoint = 0
	arg_1_0.entityConfig = arg_1_0.entity:getMO():getCO()

	if not arg_1_0.entityConfig then
		logError(string.format("entity 找不到配置表: entityType = %s  modelId = %s", arg_1_0.entity:getMO().entityType, arg_1_0.entity:getMO().modelId))
	end

	arg_1_0.configMaxPoint = arg_1_0.entityConfig and arg_1_0.entityConfig.uniqueSkill_point or 5

	arg_1_0:initExPointLine()
	arg_1_0:createExPointItemList()
	arg_1_0:createExtraExPointItemList()
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

function var_0_0.initExPointLine(arg_3_0)
	arg_3_0.lineGroupList = arg_3_0:getUserDataTb_()
	arg_3_0.goLineGroupItem = gohelper.findChild(arg_3_0.goExPointContainer, "exPointLine")

	gohelper.setActive(arg_3_0.goLineGroupItem, false)

	arg_3_0.initLineGroupAnchorX, arg_3_0.initLineGroupAnchorY = recthelper.getAnchor(arg_3_0.goLineGroupItem.transform)
end

function var_0_0.addLineGroup(arg_4_0, arg_4_1)
	local var_4_0 = gohelper.cloneInPlace(arg_4_0.goLineGroupItem)

	gohelper.setActive(var_4_0, true)
	table.insert(arg_4_0.lineGroupList, arg_4_1, var_4_0)

	local var_4_1 = var_4_0:GetComponent(gohelper.Type_RectTransform)
	local var_4_2 = arg_4_0.initLineGroupAnchorX
	local var_4_3 = arg_4_0.initLineGroupAnchorY
	local var_4_4 = var_4_2 + (arg_4_1 - 1) * var_0_0.linePrefixX
	local var_4_5 = var_4_3 - (arg_4_1 - 1) * var_0_0.lineTopY

	recthelper.setAnchor(var_4_1, var_4_4, var_4_5)

	return var_4_0
end

function var_0_0.getLineGroup(arg_5_0, arg_5_1)
	if arg_5_1 < 1 then
		logError("激情点下标小于1 了？")

		return arg_5_0.lineGroupList[1]
	end

	arg_5_1 = math.ceil(arg_5_1 / var_0_0.LineCount)

	return arg_5_0.lineGroupList[arg_5_1] or arg_5_0:addLineGroup(arg_5_1)
end

function var_0_0.checkRemoveLineGroup(arg_6_0)
	local var_6_0 = #arg_6_0.pointItemList
	local var_6_1 = #arg_6_0.lineGroupList
	local var_6_2 = math.ceil(var_6_0 / var_0_0.LineCount)

	while var_6_2 < var_6_1 do
		local var_6_3 = arg_6_0.lineGroupList[var_6_1]

		table.remove(arg_6_0.lineGroupList)
		gohelper.destroy(var_6_3)

		var_6_1 = var_6_1 - 1
	end
end

function var_0_0.createExPointItemList(arg_7_0)
	arg_7_0.exPointItemList = {}
	arg_7_0.maxExPoint = arg_7_0.configMaxPoint
	arg_7_0.goPointItem = gohelper.findChild(arg_7_0.goExPointContainer, "empty")

	gohelper.setActive(arg_7_0.goPointItem, false)

	if arg_7_0.maxExPoint <= 0 then
		return
	end

	arg_7_0.totalMaxExPoint = arg_7_0.totalMaxExPoint + arg_7_0.maxExPoint

	for iter_7_0 = 1, arg_7_0.maxExPoint do
		arg_7_0:addPointItem()
	end
end

function var_0_0.addPointItem(arg_8_0)
	local var_8_0 = arg_8_0:getLineGroup(#arg_8_0.pointItemList + 1)
	local var_8_1 = gohelper.clone(arg_8_0.goPointItem, var_8_0)
	local var_8_2 = FightNameUIExPointItem.GetExPointItem(var_8_1)

	var_8_2.entityName = arg_8_0.entity:getMO():getEntityName()

	table.insert(arg_8_0.exPointItemList, var_8_2)
	table.insert(arg_8_0.pointItemList, var_8_2)
	var_8_2:setIndex(#arg_8_0.pointItemList)
	var_8_2:setMgr(arg_8_0)
end

function var_0_0.removePointItem(arg_9_0)
	local var_9_0 = table.remove(arg_9_0.exPointItemList)

	arg_9_0:assetPointItem(var_9_0)

	if var_9_0 then
		var_9_0:destroy()
	end

	tabletool.removeValue(arg_9_0.pointItemList, var_9_0)
	arg_9_0:checkRemoveLineGroup()
end

function var_0_0.createExtraExPointItemList(arg_10_0)
	arg_10_0.extraExPointItemList = {}

	local var_10_0 = gohelper.findChild(arg_10_0.goExPointContainer, "extra")

	gohelper.setActive(var_10_0, false)

	arg_10_0.goExtraPointItem = var_10_0
	arg_10_0.extraMaxExPoint = arg_10_0.entity:getMO().expointMaxAdd or 0

	if arg_10_0.extraMaxExPoint <= 0 then
		return
	end

	arg_10_0.totalMaxExPoint = arg_10_0.totalMaxExPoint + arg_10_0.extraMaxExPoint

	for iter_10_0 = 1, arg_10_0.extraMaxExPoint do
		arg_10_0:addExtraPointItem()
	end
end

function var_0_0.addExtraPointItem(arg_11_0)
	if arg_11_0.entity:getMO():hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		arg_11_0:addPointItem()

		return
	end

	local var_11_0 = arg_11_0:getLineGroup(#arg_11_0.pointItemList + 1)
	local var_11_1 = gohelper.clone(arg_11_0.goExtraPointItem, var_11_0)
	local var_11_2 = FightNameUIExPointExtraItem.GetExtraExPointItem(var_11_1)

	var_11_2.entityName = arg_11_0.entity:getMO():getEntityName()

	table.insert(arg_11_0.extraExPointItemList, var_11_2)
	table.insert(arg_11_0.pointItemList, var_11_2)
	var_11_2:setIndex(#arg_11_0.pointItemList)
	var_11_2:setMgr(arg_11_0)
end

function var_0_0.removeExtraPointItem(arg_12_0)
	if arg_12_0.entity:getMO():hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		arg_12_0:removePointItem()

		return
	end

	local var_12_0 = table.remove(arg_12_0.extraExPointItemList)

	arg_12_0:assetPointItem(var_12_0)

	if var_12_0 then
		var_12_0:destroy()
	end

	tabletool.removeValue(arg_12_0.pointItemList, var_12_0)
	arg_12_0:checkRemoveLineGroup()
end

function var_0_0.addCustomEvents(arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.AddPlayCardClientExPoint, arg_13_0.addPlayCardClientExPoint, arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.UpdateExPoint, arg_13_0.updateExPoint, arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.OnExpointMaxAdd, arg_13_0.onExPointMaxAdd, arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_13_0.onBuffUpdate, arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.OnExPointChange, arg_13_0.onExPointChange, arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.MultiHpChange, arg_13_0.onMultiHpChange, arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.OnExSkillPointChange, arg_13_0.onExSkillPointChange, arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.OnStoreExPointChange, arg_13_0.onStoreExPointChange, arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.BeContract, arg_13_0.onBeContract, arg_13_0)
end

function var_0_0.onBeContract(arg_14_0, arg_14_1)
	if arg_14_0.entityId ~= arg_14_1 then
		return
	end

	AudioMgr.instance:trigger(20220175)

	local var_14_0 = gohelper.findChild(arg_14_0.goExPointContainer, "#go_tianshinana")

	gohelper.setActive(var_14_0, false)
	gohelper.setActive(var_14_0, true)
	gohelper.setAsLastSibling(var_14_0)
	arg_14_0:updateSelfExPoint()
	TaskDispatcher.cancelTask(arg_14_0.hideTsnnEffect, arg_14_0)
	TaskDispatcher.runDelay(arg_14_0.hideTsnnEffect, arg_14_0, 1)
end

function var_0_0.hideTsnnEffect(arg_15_0)
	local var_15_0 = gohelper.findChild(arg_15_0.goExPointContainer, "#go_tianshinana")

	gohelper.setActive(var_15_0, false)
end

function var_0_0.getClientExPoint(arg_16_0)
	local var_16_0 = arg_16_0.entity:getMO()

	return var_16_0.exPoint + var_16_0.moveCardExPoint + var_16_0.playCardExPoint
end

function var_0_0.getServerExPoint(arg_17_0)
	return arg_17_0.entity:getMO().exPoint
end

function var_0_0.getUsedExPoint(arg_18_0)
	return FightHelper.getPredeductionExpoint(arg_18_0.entityId)
end

function var_0_0.getUniqueSkillNeedExPoint(arg_19_0)
	arg_19_0:log("大招需要激情点：" .. arg_19_0.entity:getMO():getUniqueSkillPoint())

	return arg_19_0.entity:getMO():getUniqueSkillPoint()
end

function var_0_0.getStoredExPoint(arg_20_0)
	return arg_20_0.entity:getMO():getStoredExPoint()
end

function var_0_0.updateSelfExPoint(arg_21_0)
	if arg_21_0.hideExPoint then
		return
	end

	arg_21_0:updateExPoint(arg_21_0.entityId)
end

function var_0_0.getPointCurState(arg_22_0, arg_22_1)
	if arg_22_0:getUsedExPoint() > 0 then
		return arg_22_0:getUsedPointCurState(arg_22_1)
	else
		return arg_22_0:getNoUsePointCurState(arg_22_1)
	end
end

function var_0_0.getUsedPointCurState(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getStoredExPoint()
	local var_23_1 = arg_23_0:getUniqueSkillNeedExPoint()
	local var_23_2 = math.min(var_23_0, var_23_1)

	if arg_23_1 <= var_23_2 then
		return FightEnum.ExPointState.Stored
	end

	local var_23_3 = arg_23_0:getClientExPoint()
	local var_23_4 = arg_23_0:getServerExPoint()
	local var_23_5 = arg_23_0:getUsedExPoint()
	local var_23_6 = var_23_4 - var_23_5
	local var_23_7 = math.min(arg_23_0.totalMaxExPoint, var_23_2 + var_23_6)

	if arg_23_1 <= var_23_7 then
		return FightEnum.ExPointState.Server
	end

	local var_23_8 = var_23_3 - var_23_5
	local var_23_9 = math.min(arg_23_0.totalMaxExPoint, var_23_2 + var_23_8)

	if arg_23_1 <= var_23_9 then
		return FightEnum.ExPointState.Client
	end

	local var_23_10 = math.max(var_23_7, var_23_9)

	if arg_23_1 <= math.min(arg_23_0.totalMaxExPoint, var_23_10 + var_23_1) then
		return FightEnum.ExPointState.UsingUnique
	end

	return FightEnum.ExPointState.Empty
end

function var_0_0.getNoUsePointCurState(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getClientExPoint()
	local var_24_1 = arg_24_0:getServerExPoint()
	local var_24_2 = arg_24_0:getStoredExPoint()
	local var_24_3 = arg_24_0:getUniqueSkillNeedExPoint()

	if arg_24_1 <= math.min(var_24_2, var_24_3) then
		return FightEnum.ExPointState.Stored
	end

	local var_24_4 = arg_24_0.entity:getMO()

	if var_24_1 >= var_24_4:getMaxExPoint() then
		return FightEnum.ExPointState.ServerFull
	end

	if not FightHelper.canAddPoint(var_24_4) then
		if arg_24_1 <= var_24_1 then
			return FightEnum.ExPointState.Server
		end

		return FightEnum.ExPointState.Lock
	else
		if arg_24_1 <= var_24_1 then
			return FightEnum.ExPointState.Server
		end

		if arg_24_1 <= var_24_0 then
			return FightEnum.ExPointState.Client
		end

		return FightEnum.ExPointState.Empty
	end
end

function var_0_0.updateExPoint(arg_25_0, arg_25_1)
	if arg_25_0.entityId ~= arg_25_1 then
		return
	end

	arg_25_0:log("updateExPoint")

	if arg_25_0:getUsedExPoint() > 0 then
		arg_25_0:_updateUsedPointStatus()
	else
		arg_25_0:_updateNoUsedPointStatus()
	end

	arg_25_0.preClientExPoint = arg_25_0:getClientExPoint()
end

function var_0_0._updateUsedPointStatus(arg_26_0)
	local var_26_0 = arg_26_0:getClientExPoint()
	local var_26_1 = arg_26_0:getServerExPoint()
	local var_26_2 = arg_26_0:getUsedExPoint()
	local var_26_3 = arg_26_0:getStoredExPoint()
	local var_26_4 = arg_26_0:getUniqueSkillNeedExPoint()
	local var_26_5 = math.min(var_26_3, var_26_4)
	local var_26_6 = 0

	for iter_26_0 = 1, var_26_5 do
		var_26_6 = var_26_6 + 1

		local var_26_7 = arg_26_0.pointItemList[var_26_6]

		arg_26_0:assetPointItem(var_26_7)

		if var_26_7 then
			var_26_7:directSetState(FightEnum.ExPointState.Stored)
		end
	end

	local var_26_8 = var_26_1 - var_26_2
	local var_26_9 = math.min(arg_26_0.totalMaxExPoint, var_26_5 + var_26_8)

	for iter_26_1 = var_26_6 + 1, var_26_9 do
		var_26_6 = var_26_6 + 1

		local var_26_10 = arg_26_0.pointItemList[var_26_6]

		arg_26_0:assetPointItem(var_26_10)

		if var_26_10 then
			var_26_10:directSetState(FightEnum.ExPointState.Server)
		end
	end

	local var_26_11 = var_26_0 - var_26_2
	local var_26_12 = math.min(arg_26_0.totalMaxExPoint, var_26_5 + var_26_11)

	for iter_26_2 = var_26_6 + 1, var_26_12 do
		var_26_6 = var_26_6 + 1

		local var_26_13 = arg_26_0.pointItemList[var_26_6]

		arg_26_0:assetPointItem(var_26_13)

		if var_26_13 then
			var_26_13:directSetState(FightEnum.ExPointState.Client)
		end
	end

	local var_26_14 = math.min(arg_26_0.totalMaxExPoint, var_26_6 + var_26_4)

	for iter_26_3 = var_26_6 + 1, var_26_14 do
		var_26_6 = var_26_6 + 1

		local var_26_15 = arg_26_0.pointItemList[var_26_6]

		arg_26_0:assetPointItem(var_26_15)

		if var_26_15 then
			var_26_15:directSetState(FightEnum.ExPointState.UsingUnique)
		end
	end

	for iter_26_4 = var_26_6 + 1, arg_26_0.totalMaxExPoint do
		var_26_6 = var_26_6 + 1

		local var_26_16 = arg_26_0.pointItemList[iter_26_4]

		arg_26_0:assetPointItem(var_26_16)

		if var_26_16 then
			var_26_16:directSetState(FightEnum.ExPointState.Empty)
		end
	end
end

function var_0_0._updateNoUsedPointStatus(arg_27_0)
	local var_27_0 = arg_27_0:getClientExPoint()
	local var_27_1 = arg_27_0:getServerExPoint()
	local var_27_2 = arg_27_0:getStoredExPoint()
	local var_27_3 = arg_27_0:getUniqueSkillNeedExPoint()
	local var_27_4 = math.min(var_27_2, var_27_3)
	local var_27_5 = 0

	for iter_27_0 = 1, var_27_4 do
		var_27_5 = var_27_5 + 1

		local var_27_6 = arg_27_0.pointItemList[var_27_5]

		arg_27_0:assetPointItem(var_27_6)

		if var_27_6 then
			var_27_6:directSetState(FightEnum.ExPointState.Stored)
		end
	end

	for iter_27_1 = var_27_5 + 1, var_27_1 do
		var_27_5 = var_27_5 + 1

		local var_27_7 = arg_27_0.pointItemList[var_27_5]

		arg_27_0:assetPointItem(var_27_7)

		if var_27_7 then
			var_27_7:directSetState(FightEnum.ExPointState.Server)
		end
	end

	local var_27_8 = arg_27_0.entity:getMO()

	if var_27_1 >= arg_27_0.totalMaxExPoint then
		arg_27_0:playFullAnim()

		return
	end

	if not FightHelper.canAddPoint(var_27_8) then
		for iter_27_2 = var_27_5 + 1, arg_27_0.totalMaxExPoint do
			var_27_5 = var_27_5 + 1

			local var_27_9 = arg_27_0.pointItemList[var_27_5]

			arg_27_0:assetPointItem(var_27_9)

			if var_27_9 then
				var_27_9:directSetState(FightEnum.ExPointState.Lock)
			end
		end
	else
		for iter_27_3 = var_27_5 + 1, var_27_0 do
			var_27_5 = var_27_5 + 1

			local var_27_10 = arg_27_0.pointItemList[var_27_5]

			arg_27_0:assetPointItem(var_27_10)

			if var_27_10 then
				var_27_10:directSetState(FightEnum.ExPointState.Client)
			end
		end

		for iter_27_4 = var_27_5 + 1, arg_27_0.totalMaxExPoint do
			var_27_5 = var_27_5 + 1

			local var_27_11 = arg_27_0.pointItemList[var_27_5]

			arg_27_0:assetPointItem(var_27_11)

			if var_27_11 then
				var_27_11:directSetState(FightEnum.ExPointState.Empty)
			end
		end
	end
end

function var_0_0.onExPointMaxAdd(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0.entityId ~= arg_28_1 then
		return
	end

	local var_28_0 = arg_28_0.entity:getMO():getMaxExPoint()
	local var_28_1 = #arg_28_0.pointItemList

	if var_28_0 == var_28_1 then
		return
	end

	arg_28_0:log("激情点上限增加")

	arg_28_0.totalMaxExPoint = var_28_0

	if var_28_1 < var_28_0 then
		for iter_28_0 = var_28_1 + 1, var_28_0 do
			if iter_28_0 > arg_28_0.configMaxPoint then
				arg_28_0:addExtraPointItem()
			else
				arg_28_0:addPointItem()
			end
		end
	else
		for iter_28_1 = var_28_1, var_28_0 + 1, -1 do
			if iter_28_1 > arg_28_0.configMaxPoint then
				arg_28_0:removeExtraPointItem()
			else
				arg_28_0:removePointItem()
			end
		end
	end

	arg_28_0:updateSelfExPoint()
end

function var_0_0.onBuffUpdate(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_1 ~= arg_29_0.entityId then
		return
	end

	arg_29_0:log("更新buff")

	local var_29_0

	if arg_29_2 == FightEnum.EffectType.BUFFADD then
		if FightBuffHelper.hasCantAddExPointFeature(arg_29_3) then
			var_29_0 = FightEnum.ExPointState.Lock
		end
	elseif arg_29_2 == FightEnum.EffectType.BUFFDEL then
		local var_29_1 = arg_29_0.entity:getMO()

		if FightBuffHelper.hasCantAddExPointFeature(arg_29_3) and FightHelper.canAddPoint(var_29_1) then
			var_29_0 = FightEnum.ExPointState.Empty
		end
	end

	if var_29_0 then
		local var_29_2 = arg_29_0.entity:getMO().exPoint
		local var_29_3 = arg_29_0:getStoredExPoint()

		for iter_29_0 = math.max(var_29_2, var_29_3) + 1, arg_29_0.totalMaxExPoint do
			local var_29_4 = arg_29_0.pointItemList[iter_29_0]

			arg_29_0:assetPointItem(var_29_4)

			if var_29_4 then
				var_29_4:switchToState(var_29_0)
			end
		end
	end
end

function var_0_0.onExPointChange(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_1 ~= arg_30_0.entityId then
		return
	end

	if arg_30_2 == arg_30_3 then
		return
	end

	arg_30_0:log(string.format("激情点改变 oldNum : %s, newNUm : %s", arg_30_2, arg_30_3))

	if arg_30_2 < arg_30_3 then
		arg_30_0:playAddPointEffect(arg_30_2, arg_30_3)
	else
		arg_30_0:playRemovePointEffect(arg_30_2, arg_30_3)
	end
end

function var_0_0.playAddPointEffect(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_2 >= arg_31_0.entity:getMO():getMaxExPoint()
	local var_31_1 = arg_31_0:getStoredExPoint()

	if var_31_0 then
		local var_31_2 = FightNameUIExPointBaseItem.AnimNameDuration[FightNameUIExPointBaseItem.AnimName.Add]

		for iter_31_0 = math.max(var_31_1 + 1, 1), arg_31_1 do
			local var_31_3 = arg_31_0.pointItemList[iter_31_0]

			arg_31_0:assetPointItem(var_31_3)

			if var_31_3 then
				var_31_3:delaySwitchToNextState(FightEnum.ExPointState.ServerFull, var_31_2 + 0.13 * (iter_31_0 - 1))
			end
		end

		for iter_31_1 = math.max(var_31_1 + 1, arg_31_1 + 1), arg_31_2 do
			local var_31_4 = arg_31_0.pointItemList[iter_31_1]

			arg_31_0:assetPointItem(var_31_4)

			if var_31_4 then
				var_31_4:playAddPointEffect(FightEnum.ExPointState.ServerFull, var_31_2 + 0.13 * (iter_31_1 - 1))
			end
		end
	else
		for iter_31_2 = math.max(var_31_1 + 1, arg_31_1 + 1), arg_31_2 do
			local var_31_5 = arg_31_0.pointItemList[iter_31_2]

			arg_31_0:assetPointItem(var_31_5)

			if var_31_5 then
				var_31_5:playAddPointEffect()
			end
		end
	end
end

function var_0_0.playRemovePointEffect(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 >= arg_32_0.entity:getMO():getMaxExPoint() then
		for iter_32_0, iter_32_1 in ipairs(arg_32_0.pointItemList) do
			iter_32_1:updateExPoint()
		end
	end

	for iter_32_2 = arg_32_2 + 1, arg_32_1 do
		local var_32_0 = arg_32_0.pointItemList[iter_32_2]

		arg_32_0:assetPointItem(var_32_0)

		if var_32_0 then
			var_32_0:playAnim(FightNameUIExPointBaseItem.AnimName.Lost)
		end
	end
end

function var_0_0.playFullAnim(arg_33_0)
	local var_33_0 = arg_33_0.entity:getMO().exPoint
	local var_33_1 = arg_33_0:getStoredExPoint() + 1

	for iter_33_0 = var_33_1, var_33_0 do
		local var_33_2 = arg_33_0.pointItemList[arg_33_0.curPlayFullIndex]

		arg_33_0:assetPointItem(var_33_2)

		if var_33_2 then
			var_33_2:delaySwitchToNextState(FightEnum.ExPointState.ServerFull, 0.13 * (iter_33_0 - var_33_1))
		end
	end
end

function var_0_0.onMultiHpChange(arg_34_0)
	arg_34_0:log("onMultiHpChange")
	arg_34_0:updateSelfExPoint()
end

function var_0_0.onExSkillPointChange(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if arg_35_0.entity and arg_35_1 == arg_35_0.entity.id then
		arg_35_0:log("大招需求激情变化")
		arg_35_0:updateSelfExPoint()
	end
end

function var_0_0.addPlayCardClientExPoint(arg_36_0, arg_36_1)
	if arg_36_1 ~= arg_36_0.entityId then
		return
	end

	arg_36_0:log("增加客户端激情点")

	local var_36_0 = arg_36_0.entity:getMO():getMaxExPoint()

	if var_36_0 <= arg_36_0.preClientExPoint then
		arg_36_0:updateSelfExPoint()

		return
	end

	if arg_36_0:getClientExPoint() == var_36_0 then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0.pointItemList) do
			iter_36_1:playAnim(FightNameUIExPointBaseItem.AnimName.Explosion)
		end
	else
		arg_36_0:updateSelfExPoint()
	end
end

function var_0_0.onStoreExPointChange(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 ~= arg_37_0.entityId then
		return
	end

	local var_37_0 = arg_37_0:getStoredExPoint()

	if arg_37_2 == var_37_0 then
		return
	end

	arg_37_0:log("溢出激情变化")

	if arg_37_2 < var_37_0 then
		FightAudioMgr.instance:playAudio(20211401)
		arg_37_0:playAddStoredPointEffect(arg_37_2, var_37_0)
	else
		FightAudioMgr.instance:playAudio(20211402)
		arg_37_0:playRemoveStoredPointEffect(arg_37_2, var_37_0)
	end
end

function var_0_0.playAddStoredPointEffect(arg_38_0, arg_38_1, arg_38_2)
	for iter_38_0 = arg_38_1 + 1, arg_38_2 do
		local var_38_0 = arg_38_0.pointItemList[iter_38_0]

		if var_38_0 then
			var_38_0:switchToState(FightEnum.ExPointState.Stored)
		end
	end
end

function var_0_0.playRemoveStoredPointEffect(arg_39_0, arg_39_1, arg_39_2)
	for iter_39_0 = arg_39_2 + 1, arg_39_1 do
		local var_39_0 = arg_39_0.pointItemList[iter_39_0]

		if var_39_0 then
			var_39_0:playRemoveStoredEffect()
		end
	end
end

function var_0_0.assetPointItem(arg_40_0, arg_40_1)
	return
end

function var_0_0.log(arg_41_0, arg_41_1)
	return
end

function var_0_0.beforeDestroy(arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0.hideTsnnEffect, arg_42_0)

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.pointItemList) do
		iter_42_1:destroy()
	end

	arg_42_0.exPointItemList = nil
	arg_42_0.extraExPointItemList = nil

	arg_42_0:__onDispose()
end

return var_0_0
