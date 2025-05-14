module("modules.logic.explore.map.ExploreMapWhirl", package.seeall)

local var_0_0 = class("ExploreMapWhirl")

function var_0_0.ctor(arg_1_0)
	arg_1_0._whirlDict = {}
	arg_1_0.typeToCls = {
		[ExploreEnum.WhirlType.Rune] = ExploreWhirlRune
	}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._mapGo = arg_2_1
	arg_2_0._whirlRoot = gohelper.create3d(arg_2_1, "whirl")

	ExploreController.instance:registerCallback(ExploreEvent.UseItemChanged, arg_2_0._onUseItemChange, arg_2_0)
	arg_2_0:_onUseItemChange(ExploreModel.instance:getUseItemUid())
end

function var_0_0._onUseItemChange(arg_3_0, arg_3_1)
	local var_3_0 = ExploreBackpackModel.instance:getById(arg_3_1)

	if var_3_0 and var_3_0.config.type == ExploreEnum.BackPackItemType.Rune then
		arg_3_0:addWhirl(ExploreEnum.WhirlType.Rune)
	else
		arg_3_0:removeWhirl(ExploreEnum.WhirlType.Rune)
	end
end

function var_0_0.addWhirl(arg_4_0, arg_4_1)
	if arg_4_0._whirlDict[arg_4_1] then
		return arg_4_0._whirlDict[arg_4_1]
	end

	local var_4_0 = arg_4_0.typeToCls[arg_4_1] or ExploreWhirlBase

	arg_4_0._whirlDict[arg_4_1] = var_4_0.New(arg_4_0._whirlRoot, arg_4_1)

	return arg_4_0._whirlDict[arg_4_1]
end

function var_0_0.removeWhirl(arg_5_0, arg_5_1)
	if arg_5_0._whirlDict[arg_5_1] then
		arg_5_0._whirlDict[arg_5_1]:destroy()

		arg_5_0._whirlDict[arg_5_1] = nil
	end
end

function var_0_0.getWhirl(arg_6_0, arg_6_1)
	return arg_6_0._whirlDict[arg_6_1] or nil
end

function var_0_0.unloadMap(arg_7_0)
	arg_7_0:destroy()
end

function var_0_0.destroy(arg_8_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UseItemChanged, arg_8_0._onUseItemChange, arg_8_0)

	for iter_8_0, iter_8_1 in pairs(arg_8_0._whirlDict) do
		iter_8_1:destroy()
	end

	arg_8_0._whirlDict = {}
	arg_8_0._mapGo = nil
end

return var_0_0
