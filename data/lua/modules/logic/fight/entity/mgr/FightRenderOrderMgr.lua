module("modules.logic.fight.entity.mgr.FightRenderOrderMgr", package.seeall)

local var_0_0 = class("FightRenderOrderMgr")

var_0_0.MaxOrder = 20 * FightEnum.OrderRegion
var_0_0.MinOrder = 0
var_0_0.LYEffect = 1
var_0_0.AssistBossOrder = 2
var_0_0.MinSpecialOrder = 2

function var_0_0.init(arg_1_0)
	arg_1_0._registIdList = {}
	arg_1_0._entityId2OrderSort = {}
	arg_1_0._entityId2OrderFixed = {}
	arg_1_0._entityId2WrapList = {}
	arg_1_0._renderOrderType = FightEnum.RenderOrderType.StandPos
	arg_1_0._entityMgr = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr
end

function var_0_0.setSortType(arg_2_0, arg_2_1)
	arg_2_0._renderOrderType = arg_2_1

	arg_2_0:refreshRenderOrder()
end

function var_0_0.refreshRenderOrder(arg_3_0, arg_3_1)
	arg_3_0._entityId2OrderSort = var_0_0.sortOrder(arg_3_0._renderOrderType, arg_3_0._registIdList, arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._registIdList) do
		arg_3_0:_resetRenderOrder(iter_3_1)
	end
end

function var_0_0.dispose(arg_4_0)
	arg_4_0._registIdList = nil
	arg_4_0._entityId2OrderSort = nil
	arg_4_0._entityId2OrderFixed = nil
	arg_4_0._entityId2WrapList = nil

	TaskDispatcher.cancelTask(arg_4_0.refreshRenderOrder, arg_4_0)
end

function var_0_0.register(arg_5_0, arg_5_1)
	TaskDispatcher.cancelTask(arg_5_0.refreshRenderOrder, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0.refreshRenderOrder, arg_5_0, 0.1)
	table.insert(arg_5_0._registIdList, arg_5_1)
end

function var_0_0.unregister(arg_6_0, arg_6_1)
	if arg_6_0._registIdList then
		tabletool.removeValue(arg_6_0._registIdList, arg_6_1)
	end

	if arg_6_0._entityId2OrderFixed then
		arg_6_0._entityId2OrderFixed[arg_6_1] = nil
	end
end

function var_0_0.onAddEffectWrap(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._entityId2WrapList then
		return
	end

	if not arg_7_0._entityId2WrapList[arg_7_1] then
		arg_7_0._entityId2WrapList[arg_7_1] = {}
	end

	table.insert(arg_7_0._entityId2WrapList[arg_7_1], arg_7_2)

	local var_7_0 = arg_7_0:getOrder(arg_7_1)

	arg_7_2:setRenderOrder(var_7_0)
end

function var_0_0.addEffectWrapByOrder(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0._entityId2WrapList then
		return
	end

	if not arg_8_0._entityId2WrapList[arg_8_1] then
		arg_8_0._entityId2WrapList[arg_8_1] = {}
	end

	table.insert(arg_8_0._entityId2WrapList[arg_8_1], arg_8_2)

	arg_8_3 = arg_8_3 or FightEnum.OrderRegion

	arg_8_2:setRenderOrder(arg_8_3)
end

function var_0_0.onRemoveEffectWrap(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._entityId2WrapList and arg_9_0._entityId2WrapList[arg_9_1] then
		tabletool.removeValue(arg_9_0._entityId2WrapList[arg_9_1], arg_9_2)
	end

	arg_9_2:setRenderOrder(0)
end

function var_0_0.setEffectOrder(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:setRenderOrder(arg_10_2 * FightEnum.OrderRegion)
end

function var_0_0.setOrder(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._entityId2OrderFixed[arg_11_1] = arg_11_2

	arg_11_0:_resetRenderOrder(arg_11_1)
end

function var_0_0.cancelOrder(arg_12_0, arg_12_1)
	if arg_12_0._entityId2OrderFixed and arg_12_0._entityId2OrderFixed[arg_12_1] then
		arg_12_0._entityId2OrderFixed[arg_12_1] = nil

		arg_12_0:_resetRenderOrder(arg_12_1)
	end
end

function var_0_0._resetRenderOrder(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getOrder(arg_13_1)
	local var_13_1 = arg_13_0._entityMgr:getEntity(arg_13_1)

	if var_13_1 then
		var_13_1:setRenderOrder(var_13_0)
	end

	local var_13_2 = arg_13_0._entityId2WrapList[arg_13_1]

	if var_13_2 then
		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			iter_13_1:setRenderOrder(var_13_0)
		end
	end
end

function var_0_0.getOrder(arg_14_0, arg_14_1)
	local var_14_0 = 1

	if arg_14_0._entityId2OrderFixed[arg_14_1] then
		var_14_0 = arg_14_0._entityId2OrderFixed[arg_14_1]
	elseif arg_14_0._entityId2OrderSort[arg_14_1] then
		var_14_0 = arg_14_0._entityId2OrderSort[arg_14_1]
	end

	return var_14_0 * FightEnum.OrderRegion
end

function var_0_0.sortOrder(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	if arg_15_0 == FightEnum.RenderOrderType.SameOrder then
		return var_15_0
	end

	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_2 = FightHelper.getEntity(iter_15_1)
		local var_15_3

		if arg_15_2 and arg_15_2[iter_15_1] then
			var_15_3 = arg_15_2[iter_15_1]
		end

		if var_15_2 then
			if arg_15_0 == FightEnum.RenderOrderType.StandPos then
				local var_15_4, var_15_5, var_15_6 = FightHelper.getEntityStandPos(var_15_2:getMO())

				table.insert(var_15_1, {
					iter_15_1,
					var_15_6,
					var_15_3
				})
			elseif arg_15_0 == FightEnum.RenderOrderType.ZPos then
				local var_15_7, var_15_8, var_15_9 = transformhelper.getPos(var_15_2.go.transform)

				table.insert(var_15_1, {
					iter_15_1,
					var_15_9,
					var_15_3
				})
			end
		end
	end

	table.sort(var_15_1, function(arg_16_0, arg_16_1)
		if arg_16_0[2] ~= arg_16_1[2] then
			return arg_16_0[2] > arg_16_1[2]
		elseif arg_16_0[3] and arg_16_1[3] and arg_16_0[3] ~= arg_16_1[3] then
			return arg_16_0[3] > arg_16_1[3]
		else
			return tonumber(arg_16_0[1]) < tonumber(arg_16_1[1])
		end
	end)

	local var_15_10 = 1

	for iter_15_2, iter_15_3 in ipairs(var_15_1) do
		var_15_0[iter_15_3[1]] = var_15_10
		var_15_10 = var_15_10 + 1
	end

	local var_15_11

	for iter_15_4, iter_15_5 in pairs(var_15_0) do
		local var_15_12 = FightHelper.getEntity(iter_15_4)

		if FightHelper.isAssembledMonster(var_15_12) then
			var_15_11 = var_15_11 or iter_15_5
			var_15_0[iter_15_4] = var_15_11
		end
	end

	local var_15_13 = var_0_0.MinSpecialOrder

	for iter_15_6, iter_15_7 in pairs(var_15_0) do
		var_15_0[iter_15_6] = iter_15_7 + var_15_13
	end

	for iter_15_8, iter_15_9 in pairs(var_15_0) do
		if FightDataHelper.entityMgr:isAssistBoss(iter_15_8) then
			var_15_0[iter_15_8] = var_0_0.AssistBossOrder
		end
	end

	return var_15_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
