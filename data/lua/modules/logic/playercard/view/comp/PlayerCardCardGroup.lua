module("modules.logic.playercard.view.comp.PlayerCardCardGroup", package.seeall)

local var_0_0 = class("PlayerCardCardGroup", BasePlayerCardComp)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.items = {}

	for iter_1_0 = 1, 4 do
		arg_1_0.items[iter_1_0] = arg_1_0:createItem(iter_1_0)
	end
end

function var_0_0.createItem(arg_2_0, arg_2_1)
	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "#go_card")
	local var_2_1 = gohelper.clone(arg_2_0.itemRes, var_2_0, tostring(arg_2_1))

	return (MonoHelper.addNoUpdateLuaComOnceToGo(var_2_1, PlayerCardCardItem, {
		index = arg_2_1,
		compType = arg_2_0.compType
	}))
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.onRefreshView(arg_5_0)
	local var_5_0 = arg_5_0.cardInfo:getCardData()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.items) do
		local var_5_1 = PlayerCardConfig.instance:getCardConfig(var_5_0[iter_5_0])

		iter_5_1:refreshView(arg_5_0.cardInfo, var_5_1)
	end

	local var_5_2 = not arg_5_0:isSingle()

	arg_5_0.items[3]:setVisible(var_5_2)
	arg_5_0.items[4]:setVisible(var_5_2)
end

function var_0_0.isSingle(arg_6_0)
	if not arg_6_0.cardInfo then
		return
	end

	local var_6_0 = arg_6_0.cardInfo:getCardData()

	return var_6_0 and #var_6_0 < 3
end

function var_0_0.onDestroy(arg_7_0)
	return
end

return var_0_0
