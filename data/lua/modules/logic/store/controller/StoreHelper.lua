module("modules.logic.store.controller.StoreHelper", package.seeall)

local var_0_0 = class("StoreHelper", BaseController)

function var_0_0.getRecommendStoreSecondTabConfig()
	local var_1_0 = StoreModel.instance:getRecommendSecondTabs(StoreEnum.RecommendStore, true)
	local var_1_1 = {}
	local var_1_2 = {}

	if var_1_0 and #var_1_0 > 0 then
		local var_1_3 = SummonMainModel.getValidPools()
		local var_1_4 = {}

		for iter_1_0, iter_1_1 in ipairs(var_1_3) do
			var_1_4[iter_1_1.id] = iter_1_1
		end

		for iter_1_2 = 1, #var_1_0 do
			local var_1_5 = StoreConfig.instance:getStoreRecommendConfig(var_1_0[iter_1_2].id)

			if var_1_5 == nil then
				table.insert(var_1_1, var_1_0[iter_1_2])
			elseif var_0_0._inOpenTime(var_1_5) then
				local var_1_6, var_1_7, var_1_8 = var_0_0._checkRelations(var_1_5.relations, var_1_0, var_1_4)

				for iter_1_3, iter_1_4 in pairs(var_1_8) do
					var_1_2[iter_1_3] = true
				end

				if var_1_6 then
					table.insert(var_1_1, var_1_0[iter_1_2])
				end
			end
		end
	end

	local var_1_9 = {}

	for iter_1_5, iter_1_6 in pairs(var_1_2) do
		table.insert(var_1_9, iter_1_5)
	end

	return var_1_1, var_1_9
end

function var_0_0._inOpenTime(arg_2_0)
	local var_2_0 = ServerTime.now()
	local var_2_1 = TimeUtil.stringToTimestamp(arg_2_0.onlineTime)
	local var_2_2 = TimeUtil.stringToTimestamp(arg_2_0.offlineTime)
	local var_2_3 = string.nilorempty(arg_2_0.onlineTime) and var_2_0 or var_2_1
	local var_2_4 = string.nilorempty(arg_2_0.offlineTime) and var_2_0 or var_2_2

	return arg_2_0.isOffline == 0 and var_2_3 <= var_2_0 and var_2_0 <= var_2_4
end

function var_0_0._inRecommendGroupBTopTime(arg_3_0)
	local var_3_0 = ServerTime.now()
	local var_3_1 = string.nilorempty(arg_3_0.onlineTime) and var_3_0 or TimeUtil.stringToTimestamp(arg_3_0.onlineTime) - ServerTime.clientToServerOffset()

	if var_3_1 <= ServerTime.timeInLocal(PlayerModel.instance:getPlayerRegisterTime() / 1000) then
		return false
	end

	local var_3_2 = TurnbackModel.instance:getCurTurnbackMo()

	if var_3_2 and var_3_2:isInOpenTime() and var_3_1 <= ServerTime.timeInLocal(var_3_2.startTime) then
		return false
	end

	local var_3_3 = var_3_1 + (arg_3_0.topDay == nil and 0 or arg_3_0.topDay * TimeUtil.OneDaySecond)

	return arg_3_0.isOffline == 0 and var_3_1 <= var_3_0 and var_3_0 <= var_3_3
end

function var_0_0.getRecommendStoreGroup(arg_4_0, arg_4_1)
	if arg_4_1 then
		local var_4_0 = arg_4_0.topType

		if var_4_0 == StoreEnum.AdjustOrderType.MonthCard then
			local var_4_1 = StoreModel.instance:getMonthCardInfo()

			if var_4_1 ~= nil and var_4_1:getRemainDay() >= StoreEnum.MonthCardStatus.NotPurchase then
				return StoreEnum.GroupOrderType.GroupD
			end
		elseif var_4_0 == StoreEnum.AdjustOrderType.BattlePass and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
			return StoreEnum.GroupOrderType.GroupD
		end
	end

	if arg_4_0.topDay < 0 then
		return StoreEnum.GroupOrderType.GroupA
	elseif arg_4_0.topDay == 0 then
		return StoreEnum.GroupOrderType.GroupC
	elseif not var_0_0._inRecommendGroupBTopTime(arg_4_0) then
		return StoreEnum.GroupOrderType.GroupC
	end

	return StoreEnum.GroupOrderType.GroupB
end

function var_0_0.getRecommendStoreGroupAndOrder(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.getRecommendStoreGroup(arg_5_0, arg_5_1)

	if not string.nilorempty(arg_5_0.adjustOrder) then
		local var_5_1 = string.split(arg_5_0.adjustOrder, "|")

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			local var_5_2 = string.split(iter_5_1, "#")

			if var_5_0 == tonumber(var_5_2[2]) then
				return var_5_0, tonumber(var_5_2[1])
			end
		end
	end

	return var_5_0, arg_5_0.order
end

function var_0_0.checkMonthCardLevelUpTagOpen()
	local var_6_0 = ServerTime.now()
	local var_6_1 = CommonConfig.instance:getConstStr(ConstEnum.MonthCardLevelUpTime)

	return var_6_0 <= (string.nilorempty(var_6_1) and var_6_0 or TimeUtil.stringToTimestamp(var_6_1))
end

function var_0_0.checkNewMatUpTagOpen(arg_7_0)
	if not arg_7_0 then
		return false
	end

	local var_7_0 = CommonConfig.instance:getConstStr(ConstEnum.StorePackageNewMatChargeGoodIds)

	if string.nilorempty(var_7_0) then
		return false
	end

	local var_7_1 = false
	local var_7_2 = string.split(var_7_0, "#")

	for iter_7_0, iter_7_1 in ipairs(var_7_2 or {}) do
		if tonumber(iter_7_1) == arg_7_0 then
			var_7_1 = true

			break
		end
	end

	if not var_7_1 then
		return false
	end

	local var_7_3 = CommonConfig.instance:getConstStr(ConstEnum.StorePackageNewMatTime)

	if string.nilorempty(var_7_3) then
		return false
	end

	return ServerTime.now() <= TimeUtil.stringToTimestamp(var_7_3)
end

function var_0_0._checkRelations(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = GameUtil.splitString2(arg_8_0, true)
	local var_8_1 = false
	local var_8_2 = false
	local var_8_3 = {}

	if string.nilorempty(arg_8_0) == false and var_8_0 and #var_8_0 > 0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			local var_8_4 = true
			local var_8_5 = iter_8_1[1]
			local var_8_6 = iter_8_1[2]

			if var_8_5 == StoreEnum.RecommendRelationType.Summon then
				if arg_8_2[var_8_6] == nil then
					var_8_4 = false
				end
			elseif var_8_5 == StoreEnum.RecommendRelationType.PackageStoreGoods then
				local var_8_7 = StoreModel.instance:getGoodsMO(var_8_6)

				if var_8_7 == nil or var_8_7:isSoldOut() then
					var_8_4 = false
				end

				var_8_1 = true
			elseif var_8_5 == StoreEnum.RecommendRelationType.StoreGoods then
				local var_8_8 = StoreModel.instance:getGoodsMO(var_8_6)

				if var_8_8 == nil or var_8_8:isSoldOut() or var_8_8:alreadyHas() then
					var_8_4 = false
				end

				local var_8_9 = StoreConfig.instance:getGoodsConfig(var_8_6)

				if var_8_9 then
					var_8_3[var_8_9.storeId] = true
				end
			elseif var_8_5 == StoreEnum.RecommendRelationType.OtherRecommendClose then
				local var_8_10 = StoreConfig.instance:getStoreRecommendConfig(var_8_6)

				if var_0_0._inOpenTime(var_8_10) and var_0_0._checkRelations(var_8_10.relations, arg_8_1, arg_8_2) then
					var_8_4 = false
				end
			elseif var_8_5 == StoreEnum.RecommendRelationType.BattlePass then
				if BpModel.instance:isEnd() then
					var_8_4 = false
				end
			elseif var_8_5 == StoreEnum.RecommendRelationType.PackageStoreGoodsNoBuy then
				local var_8_11 = StoreModel.instance:getGoodsMO(var_8_6)

				if var_8_11 and not var_8_11:isSoldOut() then
					var_8_2 = false
					var_8_4 = false

					break
				end
			end

			var_8_2 = var_8_2 or var_8_4
		end
	else
		var_8_2 = true
	end

	return var_8_2, var_8_1, var_8_3
end

function var_0_0.getRemainExpireTime(arg_9_0)
	local var_9_0 = arg_9_0.endTime

	if type(var_9_0) == "string" and not string.nilorempty(var_9_0) then
		var_9_0 = TimeUtil.stringToTimestamp(var_9_0)

		return var_9_0 - ServerTime.now()
	elseif type(var_9_0) == "number" then
		return var_9_0 * 0.001 - ServerTime.now()
	end

	return 0
end

function var_0_0.getRemainExpireTimeDeep(arg_10_0)
	local var_10_0 = var_0_0.getRemainExpireTime(arg_10_0)

	if var_10_0 == 0 then
		local var_10_1 = StoreModel.instance:getSecondTabs(arg_10_0.id, true, true)

		for iter_10_0 = 1, #var_10_1 do
			local var_10_2 = var_0_0.getRemainExpireTime(var_10_1[iter_10_0])

			if var_10_2 > 0 then
				var_10_0 = math.max(var_10_2, var_10_0)
			end
		end
	end

	return var_10_0
end

function var_0_0.checkIsShowCoBrandedTag(arg_11_0)
	if not arg_11_0 then
		return false
	end

	local var_11_0 = CommonConfig.instance:getConstStr(ConstEnum.StorePackageShowCoBradedTagGoodIds)

	if string.nilorempty(var_11_0) then
		return false
	end

	local var_11_1 = string.split(var_11_0, "#")

	for iter_11_0, iter_11_1 in ipairs(var_11_1 or {}) do
		if tonumber(iter_11_1) == arg_11_0 then
			return true
		end
	end

	return false
end

return var_0_0
