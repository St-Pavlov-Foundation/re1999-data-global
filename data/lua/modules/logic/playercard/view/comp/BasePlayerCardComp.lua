module("modules.logic.playercard.view.comp.BasePlayerCardComp", package.seeall)

local var_0_0 = class("BasePlayerCardComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	if arg_1_1 then
		for iter_1_0, iter_1_1 in pairs(arg_1_1) do
			arg_1_0[iter_1_0] = iter_1_1
		end
	end
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0.goSelect = gohelper.setActive(arg_2_1, "#go_select")

	arg_2_0:setEditMode(false)
	arg_2_0:onInitView()
end

function var_0_0.refreshView(arg_3_0, arg_3_1)
	arg_3_0.cardInfo = arg_3_1

	arg_3_0:onRefreshView()
end

function var_0_0.isPlayerSelf(arg_4_0)
	return arg_4_0.cardInfo and arg_4_0.cardInfo:isSelf()
end

function var_0_0.getPlayerInfo(arg_5_0)
	return arg_5_0.cardInfo and arg_5_0.cardInfo:getPlayerInfo()
end

function var_0_0.onInitView(arg_6_0)
	return
end

function var_0_0.onRefreshView(arg_7_0)
	return
end

function var_0_0.addEventListeners(arg_8_0)
	return
end

function var_0_0.removeEventListeners(arg_9_0)
	return
end

function var_0_0.setEditMode(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0.goSelect, arg_10_1)
end

return var_0_0
