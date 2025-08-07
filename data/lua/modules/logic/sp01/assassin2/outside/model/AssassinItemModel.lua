module("modules.logic.sp01.assassin2.outside.model.AssassinItemModel", package.seeall)

local var_0_0 = class("AssassinItemModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)

	arg_3_0._itemTypeDict = {}
end

function var_0_0.updateAllInfo(arg_4_0, arg_4_1)
	arg_4_0:clear()

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = iter_4_1.itemId
		local var_4_1 = AssassinConfig.instance:getAssassinItemType(var_4_0)
		local var_4_2 = arg_4_0._itemTypeDict[var_4_1]

		if var_4_2 then
			local var_4_3 = var_4_2:getId()

			logError(string.format("AssassinItemModel:updateAllInfo error, item type repeated, itemType:%s, item1:%s, item2:%s", var_4_1, var_4_3, var_4_0))
		elseif var_4_1 then
			local var_4_4 = AssassinItemMO.New(iter_4_1)

			arg_4_0._itemTypeDict[var_4_1] = var_4_4

			arg_4_0:addAtLast(var_4_4)
		end
	end
end

function var_0_0.unlockNewItems(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = iter_5_1.itemId
		local var_5_1 = AssassinConfig.instance:getAssassinItemType(var_5_0)
		local var_5_2 = arg_5_0._itemTypeDict[var_5_1]

		if var_5_2 then
			arg_5_0:remove(var_5_2)

			arg_5_0._itemTypeDict[var_5_1] = nil
		end

		local var_5_3 = AssassinItemMO.New(iter_5_1)

		arg_5_0._itemTypeDict[var_5_1] = var_5_3

		arg_5_0:addAtLast(var_5_3)
	end
end

function var_0_0.getAssassinItemMoList(arg_6_0)
	return arg_6_0:getList()
end

function var_0_0.getAssassinItemMo(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getById(arg_7_1)

	if not var_7_0 and arg_7_2 then
		logError(string.format("AssassinItemModel:getAssassinItemMo error, not find assassinHeroMo, itemId:%s", arg_7_1))
	end

	return var_7_0
end

function var_0_0.getAssassinItemCount(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getAssassinItemMo(arg_8_1)

	return var_8_0 and var_8_0:getCount() or 0
end

function var_0_0.getItemIdByItemType(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._itemTypeDict[arg_9_1]

	return var_9_0 and var_9_0:getId()
end

var_0_0.instance = var_0_0.New()

return var_0_0
