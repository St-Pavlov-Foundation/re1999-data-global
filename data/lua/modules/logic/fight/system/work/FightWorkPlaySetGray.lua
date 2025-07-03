module("modules.logic.fight.system.work.FightWorkPlaySetGray", package.seeall)

local var_0_0 = class("FightWorkPlaySetGray", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0.actEffectData) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_0.actEffectData.effectNum
	local var_1_1 = FightPlayCardModel.instance:getUsedCards()[var_1_0]

	if var_1_1 then
		var_1_1:init(arg_1_0.actEffectData.cardInfo)
		FightController.instance:dispatchEvent(FightEvent.PlayCardAroundSetGray, var_1_0)
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
