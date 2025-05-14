module("modules.logic.backpack.model.ItemPowerModel", package.seeall)

local var_0_0 = class("ItemPowerModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._powerItemList = {}
	arg_1_0._latestPushItemUids = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._powerItemList = {}
	arg_2_0._latestPushItemUids = {}
end

function var_0_0.getPowerItem(arg_3_0, arg_3_1)
	return arg_3_0._powerItemList[tonumber(arg_3_1)]
end

function var_0_0.getPowerItemList(arg_4_0)
	return arg_4_0._powerItemList
end

function var_0_0.setPowerItemList(arg_5_0, arg_5_1)
	arg_5_0._powerItemList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = ItemPowerMo.New()

		var_5_0:init(iter_5_1)

		arg_5_0._powerItemList[tonumber(iter_5_1.uid)] = var_5_0
	end

	CurrencyController.instance:checkToUseExpirePowerItem()
end

function var_0_0.changePowerItemList(arg_6_0, arg_6_1)
	if not arg_6_1 or #arg_6_1 < 1 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = tonumber(iter_6_1.uid)
		local var_6_1 = {
			itemid = iter_6_1.itemId,
			uid = var_6_0
		}

		table.insert(arg_6_0._latestPushItemUids, var_6_1)

		if not arg_6_0._powerItemList[var_6_0] then
			local var_6_2 = ItemPowerMo.New()

			var_6_2:init(iter_6_1)

			arg_6_0._powerItemList[var_6_0] = var_6_2
		else
			arg_6_0._powerItemList[var_6_0]:reset(iter_6_1)
		end
	end
end

function var_0_0.getLatestPowerChange(arg_7_0)
	return arg_7_0._latestPushItemUids
end

function var_0_0.getPowerItemCount(arg_8_0, arg_8_1)
	return arg_8_0._powerItemList[arg_8_1] and arg_8_0._powerItemList[arg_8_1].quantity or 0
end

function var_0_0.getPowerItemCountById(arg_9_0, arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_0._powerItemList) do
		if iter_9_1.id == arg_9_1 then
			var_9_0 = var_9_0 + iter_9_1.quantity
		end
	end

	return var_9_0
end

function var_0_0.getPowerItemDeadline(arg_10_0, arg_10_1)
	return arg_10_0._powerItemList[arg_10_1] and tonumber(arg_10_0._powerItemList[arg_10_1].expireTime) or 0
end

function var_0_0.getPowerItemCo(arg_11_0, arg_11_1)
	return arg_11_0._powerItemList[arg_11_1] and ItemConfig.instance:getPowerItemCo(arg_11_0._powerItemList[arg_11_1].id) or nil
end

function var_0_0.getPowerCount(arg_12_0, arg_12_1)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0._powerItemList) do
		if iter_12_1.id == arg_12_1 and (iter_12_1.expireTime == 0 or iter_12_1.expireTime > ServerTime.now()) then
			var_12_0 = var_12_0 + iter_12_1.quantity
		end
	end

	return var_12_0
end

function var_0_0.getPowerMinExpireTimeOffset(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1 = false
	local var_13_2 = ServerTime.now()

	for iter_13_0, iter_13_1 in pairs(arg_13_0._powerItemList) do
		if iter_13_1.id == arg_13_1 and iter_13_1.expireTime ~= 0 and iter_13_1.quantity > 0 then
			local var_13_3 = iter_13_1.expireTime - var_13_2

			if var_13_3 > 0 then
				if var_13_1 then
					if var_13_3 < var_13_0 then
						var_13_0 = var_13_3
					end
				else
					var_13_0 = var_13_3
				end

				var_13_1 = true
			end
		end
	end

	return var_13_1 and var_13_0 or 0
end

function var_0_0.getPowerByType(arg_14_0, arg_14_1)
	if arg_14_1 == MaterialEnum.PowerType.Small then
		local var_14_0 = arg_14_0:getExpirePower(MaterialEnum.PowerId.SmallPower_Expire)

		if not var_14_0 or var_14_0.quantity == 0 then
			var_14_0 = arg_14_0:getNoExpirePower(MaterialEnum.PowerId.SmallPower)
		end

		return var_14_0
	elseif arg_14_1 == MaterialEnum.PowerType.Big then
		local var_14_1 = arg_14_0:getExpirePower(MaterialEnum.PowerId.BigPower_Expire)

		if not var_14_1 or var_14_1.quantity == 0 then
			var_14_1 = arg_14_0:getNoExpirePower(MaterialEnum.PowerId.BigPower)
		end

		return var_14_1
	else
		return arg_14_0:getExpirePower(MaterialEnum.PowerId.ActPowerId)
	end
end

function var_0_0.getNoExpirePower(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._powerItemList) do
		if iter_15_1.id == arg_15_1 and iter_15_1.expireTime == 0 then
			return iter_15_1
		end
	end

	return nil
end

function var_0_0.getExpirePower(arg_16_0, arg_16_1)
	local var_16_0
	local var_16_1 = ServerTime.now()

	for iter_16_0, iter_16_1 in pairs(arg_16_0._powerItemList) do
		if iter_16_1.id == arg_16_1 and iter_16_1.quantity > 0 and iter_16_1.expireTime ~= 0 and var_16_1 < iter_16_1.expireTime then
			if var_16_0 then
				if var_16_0.expireTime > iter_16_1.expireTime then
					var_16_0 = iter_16_1
				end
			else
				var_16_0 = iter_16_1
			end
		end
	end

	return var_16_0
end

function var_0_0.getUsePower(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = ServerTime.now()
	local var_17_1 = {}
	local var_17_2 = 0

	for iter_17_0, iter_17_1 in pairs(arg_17_0._powerItemList) do
		if iter_17_1.id == arg_17_1 and iter_17_1.quantity > 0 then
			if iter_17_1.expireTime == 0 then
				table.insert(var_17_1, iter_17_1)

				var_17_2 = var_17_2 + iter_17_1.quantity
			elseif var_17_0 < iter_17_1.expireTime then
				table.insert(var_17_1, iter_17_1)

				var_17_2 = var_17_2 + iter_17_1.quantity
			end
		end
	end

	local var_17_3 = {}

	if var_17_2 <= arg_17_2 then
		for iter_17_2, iter_17_3 in pairs(var_17_1) do
			table.insert(var_17_3, {
				uid = iter_17_3.uid,
				num = iter_17_3.quantity
			})
		end

		return var_17_3
	end

	local var_17_4 = 0

	table.sort(var_17_1, var_0_0.sortPowerMoFunc)

	for iter_17_4, iter_17_5 in pairs(var_17_1) do
		local var_17_5 = iter_17_5.quantity

		if arg_17_2 < var_17_4 + iter_17_5.quantity then
			var_17_5 = arg_17_2 - var_17_4
		end

		var_17_4 = var_17_4 + var_17_5

		table.insert(var_17_3, {
			uid = iter_17_5.uid,
			num = var_17_5
		})

		if arg_17_2 <= var_17_4 then
			break
		end
	end

	return var_17_3
end

function var_0_0.sortPowerMoFunc(arg_18_0, arg_18_1)
	if arg_18_0.expireTime == 0 and arg_18_1.expireTime == 0 then
		return false
	end

	if arg_18_0.expireTime == 0 then
		return false
	end

	if arg_18_1.expireTime == 0 then
		return true
	end

	return arg_18_0.expireTime < arg_18_1.expireTime
end

var_0_0.instance = var_0_0.New()

return var_0_0
