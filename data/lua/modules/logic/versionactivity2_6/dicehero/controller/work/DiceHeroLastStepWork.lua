module("modules.logic.versionactivity2_6.dicehero.controller.work.DiceHeroLastStepWork", package.seeall)

local var_0_0 = class("DiceHeroLastStepWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fight = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	DiceHeroFightModel.instance:getGameData():init(arg_2_0.fight)

	DiceHeroFightModel.instance.tempRoundEnd = true

	local var_2_0 = DiceHeroFightModel.instance.finishResult == DiceHeroEnum.GameStatu.None

	arg_2_0:onDone(true)

	if var_2_0 then
		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.RoundEnd)
	end

	DiceHeroFightModel.instance.tempRoundEnd = false
end

return var_0_0
