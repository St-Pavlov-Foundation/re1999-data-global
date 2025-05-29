module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroDiceBoxFullWork", package.seeall)

local var_0_0 = class("DiceHeroDiceBoxFullWork", DiceHeroBaseEffectWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	GameFacade.showToast(ToastEnum.DiceHeroDiceBoxFull)
	arg_1_0:onDone(true)
end

return var_0_0
