module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateDiceBoxWork", package.seeall)

local var_0_0 = class("DiceHeroUpdateDiceBoxWork", DiceHeroBaseEffectWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	DiceHeroFightModel.instance:getGameData().diceBox:init(arg_1_0._effectMo.diceBox)
	arg_1_0:onDone(true)
end

return var_0_0
