module("modules.logic.fight.entity.mgr.FightRenderOrderMgr", package.seeall)

local var_0_0 = class("FightRenderOrderMgr")
local var_0_1 = -1

local function var_0_2()
	var_0_1 = var_0_1 + 1

	return var_0_1
end

var_0_0.MaxOrder = 20 * FightEnum.OrderRegion
var_0_0.MinOrder = var_0_2()
var_0_0.LYEffect = var_0_2()
var_0_0.AssistBossOrder = var_0_2()
var_0_0.Act191Boss = var_0_2()
var_0_0.NuoDiKa = var_0_2()
var_0_0.MinSpecialOrder = var_0_1

function var_0_0.init(arg_2_0)
	arg_2_0._registIdList = {}
	arg_2_0._entityId2OrderSort = {}
	arg_2_0._entityId2OrderFixed = {}
	arg_2_0._entityId2WrapList = {}
	arg_2_0._renderOrderType = FightEnum.RenderOrderType.StandPos
	arg_2_0._entityMgr = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr
end

function var_0_0.setSortType(arg_3_0, arg_3_1)
	arg_3_0._renderOrderType = arg_3_1

	arg_3_0:refreshRenderOrder()
end

function var_0_0.refreshRenderOrder(arg_4_0, arg_4_1)
	arg_4_0._entityId2OrderSort = var_0_0.sortOrder(arg_4_0._renderOrderType, arg_4_0._registIdList, arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._registIdList) do
		arg_4_0:_resetRenderOrder(iter_4_1)
	end
end

function var_0_0.dispose(arg_5_0)
	arg_5_0._registIdList = nil
	arg_5_0._entityId2OrderSort = nil
	arg_5_0._entityId2OrderFixed = nil
	arg_5_0._entityId2WrapList = nil

	TaskDispatcher.cancelTask(arg_5_0.refreshRenderOrder, arg_5_0)
end

function var_0_0.register(arg_6_0, arg_6_1)
	TaskDispatcher.cancelTask(arg_6_0.refreshRenderOrder, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.refreshRenderOrder, arg_6_0, 0.1)
	table.insert(arg_6_0._registIdList, arg_6_1)
end

function var_0_0.unregister(arg_7_0, arg_7_1)
	if arg_7_0._registIdList then
		tabletool.removeValue(arg_7_0._registIdList, arg_7_1)
	end

	if arg_7_0._entityId2OrderFixed then
		arg_7_0._entityId2OrderFixed[arg_7_1] = nil
	end
end

function var_0_0.onAddEffectWrap(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._entityId2WrapList then
		return
	end

	if not arg_8_0._entityId2WrapList[arg_8_1] then
		arg_8_0._entityId2WrapList[arg_8_1] = {}
	end

	table.insert(arg_8_0._entityId2WrapList[arg_8_1], arg_8_2)

	local var_8_0 = arg_8_0:getOrder(arg_8_1)

	arg_8_2:setRenderOrder(var_8_0)
end

function var_0_0.addEffectWrapByOrder(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0._entityId2WrapList then
		return
	end

	if not arg_9_0._entityId2WrapList[arg_9_1] then
		arg_9_0._entityId2WrapList[arg_9_1] = {}
	end

	table.insert(arg_9_0._entityId2WrapList[arg_9_1], arg_9_2)

	arg_9_3 = arg_9_3 or FightEnum.OrderRegion

	arg_9_2:setRenderOrder(arg_9_3)
end

function var_0_0.onRemoveEffectWrap(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._entityId2WrapList and arg_10_0._entityId2WrapList[arg_10_1] then
		tabletool.removeValue(arg_10_0._entityId2WrapList[arg_10_1], arg_10_2)
	end

	arg_10_2:setRenderOrder(0)
end

function var_0_0.setEffectOrder(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1:setRenderOrder(arg_11_2 * FightEnum.OrderRegion)
end

function var_0_0.setOrder(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._entityId2OrderFixed[arg_12_1] = arg_12_2

	arg_12_0:_resetRenderOrder(arg_12_1)
end

function var_0_0.cancelOrder(arg_13_0, arg_13_1)
	if arg_13_0._entityId2OrderFixed and arg_13_0._entityId2OrderFixed[arg_13_1] then
		arg_13_0._entityId2OrderFixed[arg_13_1] = nil

		arg_13_0:_resetRenderOrder(arg_13_1)
	end
end

function var_0_0._resetRenderOrder(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getOrder(arg_14_1)
	local var_14_1 = arg_14_0._entityMgr:getEntity(arg_14_1)

	if var_14_1 then
		var_14_1:setRenderOrder(var_14_0)
	end

	local var_14_2 = arg_14_0._entityId2WrapList[arg_14_1]

	if var_14_2 then
		for iter_14_0, iter_14_1 in ipairs(var_14_2) do
			iter_14_1:setRenderOrder(var_14_0)
		end
	end
end

function var_0_0.getOrder(arg_15_0, arg_15_1)
	local var_15_0 = 1

	if arg_15_0._entityId2OrderFixed[arg_15_1] then
		var_15_0 = arg_15_0._entityId2OrderFixed[arg_15_1]
	elseif arg_15_0._entityId2OrderSort[arg_15_1] then
		var_15_0 = arg_15_0._entityId2OrderSort[arg_15_1]
	end

	return var_15_0 * FightEnum.OrderRegion
end

function var_0_0.sortOrder(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}

	if arg_16_0 == FightEnum.RenderOrderType.SameOrder then
		return var_16_0
	end

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_2 = FightHelper.getEntity(iter_16_1)
		local var_16_3

		if arg_16_2 and arg_16_2[iter_16_1] then
			var_16_3 = arg_16_2[iter_16_1]
		end

		if var_16_2 then
			if arg_16_0 == FightEnum.RenderOrderType.StandPos then
				local var_16_4, var_16_5, var_16_6 = FightHelper.getEntityStandPos(var_16_2:getMO())

				table.insert(var_16_1, {
					iter_16_1,
					var_16_6,
					var_16_3
				})
			elseif arg_16_0 == FightEnum.RenderOrderType.ZPos then
				local var_16_7, var_16_8, var_16_9 = transformhelper.getPos(var_16_2.go.transform)

				table.insert(var_16_1, {
					iter_16_1,
					var_16_9,
					var_16_3
				})
			end
		end
	end

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		if arg_17_0[2] ~= arg_17_1[2] then
			return arg_17_0[2] > arg_17_1[2]
		elseif arg_17_0[3] and arg_17_1[3] and arg_17_0[3] ~= arg_17_1[3] then
			return arg_17_0[3] > arg_17_1[3]
		else
			return tonumber(arg_17_0[1]) < tonumber(arg_17_1[1])
		end
	end)

	local var_16_10 = 1

	for iter_16_2, iter_16_3 in ipairs(var_16_1) do
		var_16_0[iter_16_3[1]] = var_16_10
		var_16_10 = var_16_10 + 1
	end

	local var_16_11

	for iter_16_4, iter_16_5 in pairs(var_16_0) do
		local var_16_12 = FightHelper.getEntity(iter_16_4)

		if FightHelper.isAssembledMonster(var_16_12) then
			var_16_11 = var_16_11 or iter_16_5
			var_16_0[iter_16_4] = var_16_11
		end
	end

	local var_16_13 = var_0_0.MinSpecialOrder

	for iter_16_6, iter_16_7 in pairs(var_16_0) do
		var_16_0[iter_16_6] = iter_16_7 + var_16_13
	end

	for iter_16_8, iter_16_9 in pairs(var_16_0) do
		local var_16_14 = FightDataHelper.entityMgr:getById(iter_16_8)

		if FightDataHelper.entityMgr:isAssistBoss(iter_16_8) then
			var_16_0[iter_16_8] = var_0_0.AssistBossOrder
		end

		if var_16_14.entityType == FightEnum.EntityType.Act191Boss then
			var_16_0[iter_16_8] = var_0_0.Act191Boss
		end
	end

	return var_16_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
