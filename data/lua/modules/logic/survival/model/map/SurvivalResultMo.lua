﻿module("modules.logic.survival.model.map.SurvivalResultMo", package.seeall)

local var_0_0 = pureTable("SurvivalResultMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.isWin = arg_1_1.isWin
	arg_1_0.copyId = arg_1_1.copyId
	arg_1_0.mapId = arg_1_1.mapId
	arg_1_0.percentageLoss = arg_1_1.percentageLoss / 10
	arg_1_0.totalGameTime = arg_1_1.totalGameTime
	arg_1_0.reason = arg_1_1.reason
	arg_1_0.teamInfo = SurvivalTeamInfoMo.New()

	arg_1_0.teamInfo:init(arg_1_1.teamInfo)

	local var_1_0 = SurvivalMapModel.instance:getSceneMo().bag

	arg_1_0.firstItems = {}
	arg_1_0.firstNpcs = {}

	local var_1_1 = {}
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.items) do
		if iter_1_1.co.isDestroy ~= 1 or not string.nilorempty(iter_1_1.co.exchange) then
			iter_1_1.source = SurvivalEnum.ItemSource.None

			if iter_1_1:isNPC() then
				table.insert(arg_1_0.firstNpcs, iter_1_1)
			elseif iter_1_1:isCurrency() then
				-- block empty
			else
				table.insert(arg_1_0.firstItems, iter_1_1)
			end
		end
	end

	SurvivalBagSortHelper.sortItems(arg_1_0.firstItems, SurvivalEnum.ItemSortType.Result, true)

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.firstItems) do
		var_1_1[iter_1_3.uid] = iter_1_2
	end

	for iter_1_4, iter_1_5 in ipairs(arg_1_0.firstNpcs) do
		var_1_2[iter_1_5.uid] = iter_1_4
	end

	arg_1_0.beforeChanges = {}
	arg_1_0.beforeCurrencyItems = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.beforeChangeItem) do
		local var_1_3 = SurvivalBagItemMo.New()

		var_1_3:init(iter_1_7)

		if var_1_3:isNPC() then
			if var_1_2[var_1_3.uid] then
				var_1_2[var_1_3.uid] = nil
			else
				logError("结算的时候，多出来一个NPC:" .. var_1_3.co.name)
				table.insert(arg_1_0.firstNpcs, var_1_3)
			end
		elseif var_1_3:isCurrency() then
			arg_1_0.beforeCurrencyItems[var_1_3.id] = var_1_3.count
		else
			local var_1_4 = var_1_1[var_1_3.uid]

			if var_1_4 then
				local var_1_5 = arg_1_0.firstItems[var_1_4]

				if var_1_5.count ~= var_1_3.count then
					arg_1_0.beforeChanges[var_1_5.uid] = var_1_3
				end

				var_1_1[var_1_3.uid] = nil
			else
				logError("结算的时候，多出来一个道具:" .. var_1_3.co.name)
				table.insert(arg_1_0.firstItems, var_1_3)
			end
		end
	end

	for iter_1_8, iter_1_9 in pairs(var_1_2) do
		arg_1_0.beforeChanges[iter_1_8] = SurvivalBagItemMo.Empty
	end

	for iter_1_10, iter_1_11 in pairs(var_1_1) do
		arg_1_0.beforeChanges[iter_1_10] = SurvivalBagItemMo.Empty
	end

	arg_1_0.haveChange1 = next(arg_1_0.beforeChanges) and true or false
	arg_1_0.beforeItems = arg_1_0.firstItems
	arg_1_0.beforeNpcs = arg_1_0.firstNpcs

	if arg_1_0.haveChange1 then
		arg_1_0.beforeItems = {}
		arg_1_0.beforeNpcs = {}

		for iter_1_12, iter_1_13 in ipairs(arg_1_0.firstItems) do
			local var_1_6 = arg_1_0.beforeChanges[iter_1_13.uid]

			if not var_1_6 then
				table.insert(arg_1_0.beforeItems, iter_1_13)
			elseif not var_1_6:isEmpty() then
				table.insert(arg_1_0.beforeItems, var_1_6)
			end
		end

		for iter_1_14, iter_1_15 in ipairs(arg_1_0.firstNpcs) do
			local var_1_7 = arg_1_0.beforeChanges[iter_1_15.uid]

			if not var_1_7 then
				table.insert(arg_1_0.beforeNpcs, iter_1_15)
			elseif not var_1_7:isEmpty() then
				table.insert(arg_1_0.beforeNpcs, var_1_7)
			end
		end
	end

	local var_1_8 = {}
	local var_1_9 = {}

	for iter_1_16, iter_1_17 in ipairs(arg_1_0.beforeItems) do
		var_1_9[iter_1_17.uid] = iter_1_16
	end

	for iter_1_18, iter_1_19 in ipairs(arg_1_0.beforeNpcs) do
		var_1_8[iter_1_19.uid] = iter_1_18
	end

	arg_1_0.afterChanges = {}
	arg_1_0.afterItems = {}
	arg_1_0.afterNpcs = {}
	arg_1_0.afterCurrencyItems = {}

	local var_1_10 = {}

	for iter_1_20, iter_1_21 in ipairs(arg_1_1.afterChangeItem) do
		local var_1_11 = SurvivalBagItemMo.New()

		var_1_11:init(iter_1_21)

		if var_1_11:isNPC() then
			if var_1_8[var_1_11.uid] then
				var_1_8[var_1_11.uid] = nil
			else
				logError("转换货币的时候，多出来一个NPC:" .. var_1_11.co.name)
			end
		elseif var_1_11:isCurrency() then
			arg_1_0.afterCurrencyItems[var_1_11.id] = var_1_11.count
		else
			local var_1_12 = var_1_9[var_1_11.uid]

			if var_1_12 then
				local var_1_13 = arg_1_0.beforeItems[var_1_12]

				if var_1_13.count ~= var_1_11.count then
					arg_1_0.afterChanges[var_1_13.uid] = var_1_11
				end

				var_1_9[var_1_11.uid] = nil
			else
				logError("转换货币的时候，多出来一个道具:" .. var_1_11.co.name)
				table.insert(var_1_10, var_1_11)
			end
		end
	end

	for iter_1_22, iter_1_23 in pairs(var_1_8) do
		arg_1_0.afterChanges[iter_1_22] = SurvivalBagItemMo.Empty
	end

	for iter_1_24, iter_1_25 in pairs(var_1_9) do
		arg_1_0.afterChanges[iter_1_24] = SurvivalBagItemMo.Empty
	end

	arg_1_0.haveChange2 = next(arg_1_0.afterChanges) and true or false
	arg_1_0.afterItems = arg_1_0.beforeItems
	arg_1_0.afterNpcs = arg_1_0.beforeNpcs

	if arg_1_0.haveChange2 then
		arg_1_0.afterItems = {}
		arg_1_0.afterNpcs = {}

		for iter_1_26, iter_1_27 in ipairs(arg_1_0.beforeItems) do
			local var_1_14 = arg_1_0.afterChanges[iter_1_27.uid]

			if not var_1_14 then
				table.insert(arg_1_0.afterItems, iter_1_27)
			elseif not var_1_14:isEmpty() then
				table.insert(arg_1_0.afterItems, var_1_14)
			end
		end

		for iter_1_28, iter_1_29 in ipairs(arg_1_0.beforeNpcs) do
			local var_1_15 = arg_1_0.afterChanges[iter_1_29.uid]

			if not var_1_15 then
				table.insert(arg_1_0.afterNpcs, iter_1_29)
			elseif not var_1_15:isEmpty() then
				table.insert(arg_1_0.afterNpcs, var_1_15)
			end
		end
	end

	tabletool.addValues(arg_1_0.afterItems, var_1_10)
	SurvivalHelper.instance:makeArrFull(arg_1_0.firstItems, SurvivalBagItemMo.Empty, #arg_1_0.firstNpcs > 0 and 4 or 5, 5)
	SurvivalHelper.instance:makeArrFull(arg_1_0.beforeItems, SurvivalBagItemMo.Empty, #arg_1_0.firstNpcs > 0 and 4 or 5, 5)
	SurvivalHelper.instance:makeArrFull(arg_1_0.afterItems, SurvivalBagItemMo.Empty, #arg_1_0.firstNpcs > 0 and 4 or 5, 5)
end

return var_0_0
