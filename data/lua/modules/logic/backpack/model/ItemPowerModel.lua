module("modules.logic.backpack.model.ItemPowerModel", package.seeall)

local var_0_0 = class("ItemPowerModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._powerItemList = {}
	arg_1_0._latestPushItemUids = {}
	arg_1_0._powerMakerInfo = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._powerItemList = {}
	arg_2_0._latestPushItemUids = {}
	arg_2_0._powerMakerInfo = {}
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

	arg_5_0:setPowerMakerItemsList()
	CurrencyController.instance:checkToUseExpirePowerItem()
end

function var_0_0.setPowerMakerItemsList(arg_6_0)
	local var_6_0 = var_0_0.instance:getPowerMakerInfo()

	if var_6_0 and var_6_0.powerMakerItems then
		if not arg_6_0._powerMakerItems then
			arg_6_0._powerMakerItems = {}
		end

		local var_6_1 = {}

		for iter_6_0, iter_6_1 in pairs(arg_6_0._powerItemList) do
			if iter_6_1.id ~= MaterialEnum.PowerId.OverflowPowerId then
				var_6_1[iter_6_0] = iter_6_1
			end
		end

		for iter_6_2 = 1, #var_6_0.powerMakerItems do
			local var_6_2 = var_6_0.powerMakerItems[iter_6_2]
			local var_6_3 = tonumber(var_6_2.uid)
			local var_6_4 = arg_6_0._powerMakerItems[var_6_3] or ItemPowerMo.New()

			var_6_4:init(var_6_2)

			var_6_1[var_6_3] = var_6_4
		end

		arg_6_0._powerItemList = var_6_1
	end
end

function var_0_0.changePowerItemList(arg_7_0, arg_7_1)
	if not arg_7_1 or #arg_7_1 < 1 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = tonumber(iter_7_1.uid)
		local var_7_1 = {
			itemid = iter_7_1.itemId,
			uid = var_7_0
		}

		table.insert(arg_7_0._latestPushItemUids, var_7_1)

		if not arg_7_0._powerItemList[var_7_0] then
			local var_7_2 = ItemPowerMo.New()

			var_7_2:init(iter_7_1)

			arg_7_0._powerItemList[var_7_0] = var_7_2
		else
			arg_7_0._powerItemList[var_7_0]:reset(iter_7_1)
		end
	end
end

function var_0_0.getLatestPowerChange(arg_8_0)
	return arg_8_0._latestPushItemUids
end

function var_0_0.getPowerItemCount(arg_9_0, arg_9_1)
	return arg_9_0._powerItemList[arg_9_1] and arg_9_0._powerItemList[arg_9_1].quantity or 0
end

function var_0_0.getPowerItemCountById(arg_10_0, arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0._powerItemList) do
		if iter_10_1.id == arg_10_1 then
			var_10_0 = var_10_0 + iter_10_1.quantity
		end
	end

	return var_10_0
end

function var_0_0.getPowerItemDeadline(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._powerItemList[arg_11_1]

	return var_11_0 and tonumber(var_11_0.expireTime) or 0
end

function var_0_0.getPowerItemCo(arg_12_0, arg_12_1)
	return arg_12_0._powerItemList[arg_12_1] and ItemConfig.instance:getPowerItemCo(arg_12_0._powerItemList[arg_12_1].id) or nil
end

function var_0_0.getPowerCount(arg_13_0, arg_13_1)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0._powerItemList) do
		if iter_13_1.id == arg_13_1 and (iter_13_1.expireTime == 0 or iter_13_1.expireTime > ServerTime.now()) then
			var_13_0 = var_13_0 + iter_13_1.quantity
		end
	end

	return var_13_0
end

function var_0_0.getPowerMinExpireTimeOffset(arg_14_0, arg_14_1)
	local var_14_0
	local var_14_1 = false
	local var_14_2 = ServerTime.now()

	for iter_14_0, iter_14_1 in pairs(arg_14_0._powerItemList) do
		if iter_14_1.id == arg_14_1 and iter_14_1.expireTime ~= 0 and iter_14_1.quantity > 0 then
			local var_14_3 = iter_14_1.expireTime - var_14_2

			if var_14_3 > 0 then
				if var_14_1 then
					if var_14_3 < var_14_0 then
						var_14_0 = var_14_3
					end
				else
					var_14_0 = var_14_3
				end

				var_14_1 = true
			end
		end
	end

	return var_14_1 and var_14_0 or 0
end

function var_0_0.getPowerByType(arg_15_0, arg_15_1)
	if arg_15_1 == MaterialEnum.PowerType.Small then
		local var_15_0 = arg_15_0:getExpirePower(MaterialEnum.PowerId.SmallPower_Expire)

		if not var_15_0 or var_15_0.quantity == 0 then
			var_15_0 = arg_15_0:getNoExpirePower(MaterialEnum.PowerId.SmallPower)
		end

		return var_15_0
	elseif arg_15_1 == MaterialEnum.PowerType.Big then
		local var_15_1 = arg_15_0:getExpirePower(MaterialEnum.PowerId.BigPower_Expire)

		if not var_15_1 or var_15_1.quantity == 0 then
			var_15_1 = arg_15_0:getNoExpirePower(MaterialEnum.PowerId.BigPower)
		end

		return var_15_1
	elseif arg_15_1 == MaterialEnum.PowerType.Overflow then
		local var_15_2 = arg_15_0:getExpirePower(MaterialEnum.PowerId.OverflowPowerId)

		if not var_15_2 or var_15_2.quantity == 0 then
			var_15_2 = arg_15_0:getNoExpirePower(MaterialEnum.PowerId.OverflowPowerId)
		end

		return var_15_2
	else
		return arg_15_0:getExpirePower(MaterialEnum.PowerId.ActPowerId)
	end
end

function var_0_0.getNoExpirePower(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._powerItemList) do
		if iter_16_1.id == arg_16_1 and iter_16_1.quantity > 0 and iter_16_1.expireTime == 0 then
			return iter_16_1
		end
	end

	return nil
end

function var_0_0.getExpirePower(arg_17_0, arg_17_1)
	local var_17_0
	local var_17_1 = ServerTime.now()

	for iter_17_0, iter_17_1 in pairs(arg_17_0._powerItemList) do
		if iter_17_1.id == arg_17_1 and iter_17_1.quantity > 0 and iter_17_1.expireTime ~= 0 and var_17_1 < iter_17_1.expireTime then
			if var_17_0 then
				if var_17_0.expireTime > iter_17_1.expireTime then
					var_17_0 = iter_17_1
				end
			else
				var_17_0 = iter_17_1
			end
		end
	end

	return var_17_0
end

function var_0_0.getUsePower(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = ServerTime.now()
	local var_18_1 = {}
	local var_18_2 = 0

	for iter_18_0, iter_18_1 in pairs(arg_18_0._powerItemList) do
		if iter_18_1.id == arg_18_1 and iter_18_1.quantity > 0 then
			if iter_18_1.expireTime == 0 then
				table.insert(var_18_1, iter_18_1)

				var_18_2 = var_18_2 + iter_18_1.quantity
			elseif var_18_0 < iter_18_1.expireTime then
				table.insert(var_18_1, iter_18_1)

				var_18_2 = var_18_2 + iter_18_1.quantity
			end
		end
	end

	local var_18_3 = {}

	if var_18_2 <= arg_18_2 then
		for iter_18_2, iter_18_3 in pairs(var_18_1) do
			table.insert(var_18_3, {
				uid = iter_18_3.uid,
				num = iter_18_3.quantity
			})
		end

		return var_18_3
	end

	local var_18_4 = 0

	table.sort(var_18_1, var_0_0.sortPowerMoFunc)

	for iter_18_4, iter_18_5 in pairs(var_18_1) do
		local var_18_5 = iter_18_5.quantity

		if arg_18_2 < var_18_4 + iter_18_5.quantity then
			var_18_5 = arg_18_2 - var_18_4
		end

		var_18_4 = var_18_4 + var_18_5

		table.insert(var_18_3, {
			uid = iter_18_5.uid,
			num = var_18_5
		})

		if arg_18_2 <= var_18_4 then
			break
		end
	end

	return var_18_3
end

function var_0_0.sortPowerMoFunc(arg_19_0, arg_19_1)
	if arg_19_0.expireTime == 0 and arg_19_1.expireTime == 0 then
		return false
	end

	if arg_19_0.expireTime == 0 then
		return false
	end

	if arg_19_1.expireTime == 0 then
		return true
	end

	return arg_19_0.expireTime < arg_19_1.expireTime
end

function var_0_0.onGetPowerMakerInfo(arg_20_0, arg_20_1)
	local var_20_0 = 0

	if arg_20_1.powerMakerItems then
		for iter_20_0 = 1, #arg_20_1.powerMakerItems do
			var_20_0 = var_20_0 + arg_20_1.powerMakerItems[iter_20_0].quantity
		end
	end

	arg_20_0._powerMakerInfo = {
		status = arg_20_1.status or 0,
		nextRemainSecond = arg_20_1.nextRemainSecond or 0,
		makeCount = arg_20_1.makeCount or 0,
		logoutSecond = arg_20_1.logoutSecond or 0,
		powerMakerItems = arg_20_1.powerMakerItems or {},
		itemTotalCount = var_20_0 or 0,
		nowTime = ServerTime.now() or 0
	}
end

function var_0_0.getPowerMakerInfo(arg_21_0)
	return arg_21_0._powerMakerInfo
end

var_0_0.instance = var_0_0.New()

return var_0_0
