module("modules.logic.playercard.model.PlayerCardThemeListModel", package.seeall)

local var_0_0 = class("PlayerCardThemeListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.PlayerBg)
	local var_1_2 = PlayerCardModel.instance:getCardInfo():getThemeId()

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_3 = PlayerCardSkinMo.New()

		var_1_3:init(iter_1_1)
		table.insert(var_1_0, var_1_3)

		if var_1_2 == var_1_3.id then
			PlayerCardModel.instance:setSelectSkinMO(var_1_3)
		end
	end

	local var_1_4 = PlayerCardSkinMo.New()

	var_1_4:setEmpty()
	table.insert(var_1_0, var_1_4)
	table.sort(var_1_0, var_0_0.sort)

	if #var_1_0 == 1 or var_1_2 == 0 then
		PlayerCardModel.instance:setSelectSkinMO(var_1_4)
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0.sort(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:checkIsUse() and 4 or arg_2_0:isUnLock() and 3 or arg_2_0:isEmpty() and 2 or 1
	local var_2_1 = arg_2_1:checkIsUse() and 4 or arg_2_1:isUnLock() and 3 or arg_2_1:isEmpty() and 2 or 1

	if var_2_0 ~= var_2_1 then
		return var_2_1 < var_2_0
	else
		return arg_2_0.id < arg_2_1.id
	end
end

function var_0_0.getMoById(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getList()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if arg_3_1 == iter_3_1.id then
			return iter_3_1
		end
	end
end

function var_0_0.getSelectIndex(arg_4_0)
	return arg_4_0._selectIndex or 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
