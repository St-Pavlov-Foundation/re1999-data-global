module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaMapModel", package.seeall)

local var_0_0 = class("NuoDiKaMapModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._mapDict = {}
	arg_2_0._curMapId = 0
	arg_2_0._curSelectNode = 0
end

function var_0_0.setCurSelectNode(arg_3_0, arg_3_1)
	arg_3_0._curSelectNode = arg_3_1
end

function var_0_0.isNodeSelected(arg_4_0, arg_4_1)
	return arg_4_0._curSelectNode == arg_4_1
end

function var_0_0.getCurSelectNode(arg_5_0)
	return arg_5_0._curSelectNode
end

function var_0_0.initMap(arg_6_0, arg_6_1)
	arg_6_0._curMapId = arg_6_1

	if not arg_6_0._mapDict[arg_6_1] then
		arg_6_0._mapDict[arg_6_1] = NuoDiKaMapMo.New()
	end

	local var_6_0 = NuoDiKaConfig.instance:getMapCo(arg_6_1)

	arg_6_0._mapDict[arg_6_1]:init(var_6_0)
end

function var_0_0.resetMap(arg_7_0, arg_7_1)
	arg_7_0:reInit()
	arg_7_0:initMap(arg_7_1)
end

function var_0_0.getMap(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or arg_8_0._curMapId

	if not arg_8_0._mapDict[arg_8_1] then
		arg_8_0:initMap(arg_8_1)
	end

	return arg_8_0._mapDict[arg_8_1]
end

function var_0_0.setCurMapId(arg_9_0, arg_9_1)
	arg_9_0._curMapId = arg_9_1
end

function var_0_0.getCurMapId(arg_10_0)
	return arg_10_0._curMapId
end

function var_0_0.getMapNodes(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or arg_11_0._curMapId

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0._mapDict[arg_11_1].nodeDict) do
		table.insert(var_11_0, iter_11_1)
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		if arg_12_0.y ~= arg_12_1.y then
			return arg_12_0.y < arg_12_1.y
		else
			return arg_12_0.x < arg_12_1.x
		end
	end)

	return var_11_0
end

function var_0_0.getMapNode(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2 = arg_13_2 or arg_13_0._curMapId

	return arg_13_0._mapDict[arg_13_2].nodeDict[arg_13_1]
end

function var_0_0.getMapLineCount(arg_14_0, arg_14_1)
	arg_14_1 = arg_14_1 or arg_14_0._curMapId

	return arg_14_0._mapDict[arg_14_1].lineCount
end

function var_0_0.getMapRowCount(arg_15_0, arg_15_1)
	arg_15_1 = arg_15_1 or arg_15_0._curMapId

	return arg_15_0._mapDict[arg_15_1].rowCount
end

function var_0_0.getAllEmptyNodes(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or arg_16_0._curMapId

	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0._mapDict[arg_16_1].nodeDict) do
		if not iter_16_1:getEvent() then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_0.getAllUnlockEnemyNodes(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or arg_17_0._curMapId

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0._mapDict[arg_17_1].nodeDict) do
		if iter_17_1:isNodeUnlock() and iter_17_1:isNodeHasEnemy() then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function var_0_0.isAllEnemyDead(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 or arg_18_0._curMapId

	for iter_18_0, iter_18_1 in pairs(arg_18_0._mapDict[arg_18_1].nodeDict) do
		if iter_18_1:isNodeUnlock() then
			local var_18_0 = iter_18_1:getEvent()

			if var_18_0 and var_18_0.eventType == NuoDiKaEnum.EventType.Enemy then
				return false
			end
		else
			local var_18_1 = iter_18_1:getInitEvent()

			if var_18_1 and var_18_1.eventType == NuoDiKaEnum.EventType.Enemy then
				return false
			end
		end
	end

	return true
end

function var_0_0.isSpEventUnlock(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or arg_19_0._curMapId

	for iter_19_0, iter_19_1 in pairs(arg_19_0._mapDict[arg_19_1].nodeDict) do
		if iter_19_1:isNodeHasItem() then
			if iter_19_1:getEvent().eventId == NuoDiKaEnum.UnlockEventId and iter_19_1:isNodeUnlock() then
				return iter_19_1
			end
		else
			local var_19_0 = iter_19_1:getInitEvent()

			if var_19_0 then
				local var_19_1 = NuoDiKaConfig.instance:getEnemyCo(var_19_0.eventParam)

				if var_19_1 and var_19_1.eventID > 0 and not iter_19_1:getEvent() then
					return iter_19_1
				end
			end
		end
	end

	return false
end

function var_0_0.getMapEnemys(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or arg_20_0._curMapId

	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_0._mapDict[arg_20_1].nodeDict) do
		if iter_20_1:isNodeHasEnemy() then
			local var_20_1 = NuoDiKaConfig.instance:getEnemyCo(iter_20_1:getEvent().eventParam)

			table.insert(var_20_0, var_20_1)
		end
	end

	return var_20_0
end

function var_0_0.getMapItems(arg_21_0, arg_21_1)
	arg_21_1 = arg_21_1 or arg_21_0._curMapId

	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(arg_21_0._mapDict[arg_21_1].nodeDict) do
		if iter_21_1:isNodeHasItem() then
			local var_21_1 = NuoDiKaConfig.instance:getItemCo(iter_21_1:getEvent().eventParam)

			table.insert(var_21_0, var_21_1)
		end
	end

	return var_21_0
end

function var_0_0.setNodeUnlock(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2 = arg_22_2 or arg_22_0._curMapId

	arg_22_0._mapDict[arg_22_2].nodeDict[arg_22_1]:setNodeUnlock(true)
end

function var_0_0.resetNode(arg_23_0, arg_23_1)
	arg_23_1 = arg_23_1 or arg_23_0._curMapId

	for iter_23_0, iter_23_1 in pairs(arg_23_0._mapDict[arg_23_1].nodeDict) do
		return iter_23_1:resetNode()
	end
end

function var_0_0.isNodeUnlock(arg_24_0, arg_24_1, arg_24_2)
	arg_24_2 = arg_24_2 or arg_24_0._curMapId

	for iter_24_0, iter_24_1 in pairs(arg_24_0._mapDict[arg_24_2].nodeDict) do
		if iter_24_1.id == arg_24_1 then
			return iter_24_1:isNodeUnlock()
		end
	end

	return false
end

function var_0_0.isNodeEnemyLock(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2 = arg_25_2 or arg_25_0._curMapId

	local var_25_0 = arg_25_0._mapDict[arg_25_2].nodeDict[arg_25_1]

	if var_25_0:isNodeUnlock() then
		return false
	end

	for iter_25_0 = var_25_0.x - 1, var_25_0.x + 1 do
		for iter_25_1 = var_25_0.y - 1, var_25_0.y + 1 do
			if iter_25_0 ~= var_25_0.x or iter_25_1 ~= var_25_0.y then
				local var_25_1 = 100 * iter_25_0 + iter_25_1
				local var_25_2 = arg_25_0._mapDict[arg_25_2].nodeDict[var_25_1]

				if var_25_2 and var_25_2:isNodeUnlock() and var_25_2:isNodeHasEnemy() then
					return true
				end
			end
		end
	end
end

function var_0_0.isNodeCouldUnlock(arg_26_0, arg_26_1, arg_26_2)
	arg_26_2 = arg_26_2 or arg_26_0._curMapId

	local var_26_0 = arg_26_0._mapDict[arg_26_2].nodeDict[arg_26_1]

	if var_26_0:isNodeUnlock() then
		return false
	end

	if var_26_0.x > 1 then
		local var_26_1 = 100 * (var_26_0.x - 1) + var_26_0.y

		if arg_26_0._mapDict[arg_26_2].nodeDict[var_26_1]:isNodeUnlock() then
			return true
		end
	end

	if var_26_0.x < arg_26_0._mapDict[arg_26_2].rowCount then
		local var_26_2 = 100 * (var_26_0.x + 1) + var_26_0.y

		if arg_26_0._mapDict[arg_26_2].nodeDict[var_26_2]:isNodeUnlock() then
			return true
		end
	end

	if var_26_0.y > 1 then
		local var_26_3 = 100 * var_26_0.x + (var_26_0.y - 1)

		if arg_26_0._mapDict[arg_26_2].nodeDict[var_26_3]:isNodeUnlock() then
			return true
		end
	end

	if var_26_0.y < arg_26_0._mapDict[arg_26_2].lineCount then
		local var_26_4 = 100 * var_26_0.x + (var_26_0.y + 1)

		if arg_26_0._mapDict[arg_26_2].nodeDict[var_26_4]:isNodeUnlock() then
			return true
		end
	end

	return false
end

function var_0_0.getAllGetItems(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or arg_27_0._curMapId

	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(arg_27_0._mapDict[arg_27_1].nodeDict) do
		if iter_27_1:isNodeUnlock() and iter_27_1:isNodeItemGet() then
			table.insert(var_27_0, iter_27_1:getNodeItem())
		end
	end

	return var_27_0
end

function var_0_0.getMaxHpNode(arg_28_0, arg_28_1)
	arg_28_1 = arg_28_1 or arg_28_0._curMapId

	local var_28_0 = arg_28_0:getAllUnlockEnemyNodes(arg_28_1)

	if #var_28_0 < 1 then
		return
	end

	local var_28_1

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		local var_28_2 = NuoDiKaConfig.instance:getEnemyCo(iter_28_1:getEvent().eventParam)

		if NuoDiKaConfig.instance:getSkillCo(var_28_2.skillID).effect ~= NuoDiKaEnum.SkillType.Halo then
			if var_28_1 then
				if var_28_1.hp < iter_28_1.hp then
					var_28_1 = iter_28_1 or var_28_1
				end
			else
				var_28_1 = iter_28_1
			end
		end
	end

	return var_28_1
end

function var_0_0.getStartNodes(arg_29_0, arg_29_1)
	arg_29_1 = arg_29_1 or arg_29_0._curMapId

	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0._mapDict[arg_29_1].nodeDict) do
		local var_29_1 = iter_29_1:getEvent()

		if var_29_1 and var_29_1.initVisible > 0 then
			table.insert(var_29_0, iter_29_1)
		end
	end

	return var_29_0
end

function var_0_0.getMapMainRole(arg_30_0, arg_30_1)
	arg_30_1 = arg_30_1 or arg_30_0._curMapId

	local var_30_0 = NuoDiKaConfig.instance:getMainRoleList()

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if iter_30_1.mapID == arg_30_1 then
			return iter_30_1
		end
	end
end

function var_0_0.getMainRoleBuffCos(arg_31_0, arg_31_1, arg_31_2)
	arg_31_2 = arg_31_2 or arg_31_0._curMapId

	return {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
