module("modules.ugui.CommonItem", package.seeall)

local var_0_0 = class("CommonItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)
	logNormal("CommonItem:init...")

	arg_1_0._gameObj = arg_1_1
end

function LuaCompBase.addEventListeners(arg_2_0)
	logNormal("CommonItem:addEventListeners...")
end

function LuaCompBase.removeEventListeners(arg_3_0)
	logNormal("CommonItem:removeEventListeners...")
end

function var_0_0.onStart(arg_4_0)
	logNormal("CommonItem:onStart...")

	arg_4_0._updateCount = 0
end

function var_0_0.onUpdate(arg_5_0)
	arg_5_0._updateCount = arg_5_0._updateCount + 1

	logNormal("CommonItem:onUpdate... self._updateCount = " .. arg_5_0._updateCount)

	if arg_5_0._updateCount >= 10 then
		MonoHelper.removeLuaComFromGo(arg_5_0._gameObj, var_0_0)
		logNormal("CommonItem:onUpdate remove CommonItem-----")
	end
end

function var_0_0.onDestroy(arg_6_0)
	logNormal("CommonItem:onDestroy...")
end

return var_0_0
