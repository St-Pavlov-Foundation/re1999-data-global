module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroHeroBaseInfoMo", package.seeall)

local var_0_0 = pureTable("DiceHeroHeroBaseInfoMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.hp = tonumber(arg_1_1.hp) or 0
	arg_1_0.shield = tonumber(arg_1_1.shield) or 0
	arg_1_0.power = tonumber(arg_1_1.power) or 0
	arg_1_0.maxHp = tonumber(arg_1_1.maxHp) or 0
	arg_1_0.maxShield = tonumber(arg_1_1.maxShield) or 0
	arg_1_0.maxPower = tonumber(arg_1_1.maxPower) or 0
	arg_1_0.relicIds = arg_1_1.relicIds

	if arg_1_0.id ~= 0 then
		arg_1_0.co = lua_dice_character.configDict[arg_1_0.id]
	end
end

return var_0_0
