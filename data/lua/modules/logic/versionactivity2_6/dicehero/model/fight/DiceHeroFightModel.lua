module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightModel", package.seeall)

local var_0_0 = class("DiceHeroFightModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.finishResult = DiceHeroEnum.GameStatu.None
	arg_1_0.tempRoundEnd = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.setGameData(arg_3_0, arg_3_1)
	if not arg_3_0._gameData then
		arg_3_0._gameData = DiceHeroFightData.New(arg_3_1)
	else
		arg_3_0._gameData:init(arg_3_1)
	end

	arg_3_0._gameData.initHp = arg_3_0._gameData.allyHero and arg_3_0._gameData.allyHero.hp or 0
end

function var_0_0.getGameData(arg_4_0)
	return arg_4_0._gameData
end

var_0_0.instance = var_0_0.New()

return var_0_0
