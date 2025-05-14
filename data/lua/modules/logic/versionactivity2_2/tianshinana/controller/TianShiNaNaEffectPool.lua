module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaEffectPool", package.seeall)

local var_0_0 = class("TianShiNaNaEffectPool")

function var_0_0.ctor(arg_1_0)
	arg_1_0._effect = {}
	arg_1_0.root = nil
end

function var_0_0.setRoot(arg_2_0, arg_2_1)
	arg_2_0.root = arg_2_1
end

function var_0_0.getFromPool(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = table.remove(arg_3_0._effect) or TianShiNaNaPathEffect.Create(arg_3_0.root)

	var_3_0:initData(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)

	return var_3_0
end

function var_0_0.returnToPool(arg_4_0, arg_4_1)
	table.insert(arg_4_0._effect, arg_4_1)
end

function var_0_0.clear(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._effect) do
		iter_5_1:dispose()
	end

	arg_5_0._effect = {}
	arg_5_0.root = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
