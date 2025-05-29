module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightBuffMo", package.seeall)

local var_0_0 = pureTable("DiceHeroFightBuffMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.id = arg_1_1.id
	arg_1_0.layer = arg_1_1.layer
	arg_1_0.co = lua_dice_buff.configDict[arg_1_0.id]
end

return var_0_0
