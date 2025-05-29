module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroGameInfoMo", package.seeall)

local var_0_0 = pureTable("DiceHeroGameInfoMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.chapter = arg_1_1.chapter
	arg_1_0.heroBaseInfo = DiceHeroHeroBaseInfoMo.New()

	arg_1_0.heroBaseInfo:init(arg_1_1.heroBaseInfo)

	arg_1_0.rewardItems = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_1.panel.rewardItems) do
		arg_1_0.rewardItems[iter_1_0] = DiceHeroRewardMo.New()

		arg_1_0.rewardItems[iter_1_0]:init(iter_1_1)
	end

	arg_1_0.allLevelCos = DiceHeroConfig.instance:getLevelCos(arg_1_0.chapter)

	local var_1_0 = #arg_1_1.passLevelIds

	arg_1_0.co = arg_1_0.allLevelCos[var_1_0 + 1] or arg_1_0.allLevelCos[var_1_0] or arg_1_0.allLevelCos[1]
	arg_1_0.currLevel = arg_1_0.co and arg_1_0.co.id or 0
	arg_1_0.allPass = var_1_0 == #arg_1_0.allLevelCos
end

function var_0_0.hasReward(arg_2_0)
	return #arg_2_0.rewardItems > 0
end

return var_0_0
