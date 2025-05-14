module("modules.logic.battlepass.model.BpBonusMO", package.seeall)

local var_0_0 = pureTable("BpBonusMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.level
	arg_1_0.level = arg_1_1.level
	arg_1_0.hasGetfreeBonus = arg_1_1.hasGetfreeBonus
	arg_1_0.hasGetPayBonus = arg_1_1.hasGetPayBonus
	arg_1_0.hasGetSpfreeBonus = arg_1_1.hasGetSpfreeBonus
	arg_1_0.hasGetSpPayBonus = arg_1_1.hasGetSpPayBonus
end

function var_0_0.updateServerInfo(arg_2_0, arg_2_1)
	if arg_2_1:HasField("hasGetfreeBonus") then
		arg_2_0.hasGetfreeBonus = arg_2_1.hasGetfreeBonus
	end

	if arg_2_1:HasField("hasGetPayBonus") then
		arg_2_0.hasGetPayBonus = arg_2_1.hasGetPayBonus
	end

	if arg_2_1:HasField("hasGetSpfreeBonus") then
		arg_2_0.hasGetSpfreeBonus = arg_2_1.hasGetSpfreeBonus
	end

	if arg_2_1:HasField("hasGetSpPayBonus") then
		arg_2_0.hasGetSpPayBonus = arg_2_1.hasGetSpPayBonus
	end
end

return var_0_0
