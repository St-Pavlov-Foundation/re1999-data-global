module("modules.logic.playercard.view.comp.PlayerCardAssit", package.seeall)

local var_0_0 = class("PlayerCardAssit", BasePlayerCardComp)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(PlayerController.instance, PlayerEvent.SetShowHero, arg_2_0.onRefreshView, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(PlayerController.instance, PlayerEvent.SetShowHero, arg_3_0.onRefreshView, arg_3_0)
end

function var_0_0.onRefreshView(arg_4_0)
	local var_4_0 = arg_4_0:getPlayerInfo()

	arg_4_0:_initPlayerShowCard(var_4_0.showHeros)
end

function var_0_0._initPlayerShowCard(arg_5_0, arg_5_1)
	for iter_5_0 = 1, 3 do
		arg_5_0:getOrCreateItem(iter_5_0):setData(arg_5_1[iter_5_0], arg_5_0:isPlayerSelf(), arg_5_0.compType)
	end
end

function var_0_0.getOrCreateItem(arg_6_0, arg_6_1)
	if not arg_6_0.items then
		arg_6_0.items = {}
	end

	local var_6_0 = arg_6_0.items[arg_6_1]

	if not var_6_0 then
		local var_6_1 = gohelper.findChild(arg_6_0.viewGO, "layout/#go_assithero" .. arg_6_1)

		var_6_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, PlayerCardAssitItem)
		arg_6_0.items[arg_6_1] = var_6_0
	end

	return var_6_0
end

function var_0_0.onDestroy(arg_7_0)
	return
end

return var_0_0
