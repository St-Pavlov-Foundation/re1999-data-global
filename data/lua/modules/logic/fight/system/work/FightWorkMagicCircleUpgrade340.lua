module("modules.logic.fight.system.work.FightWorkMagicCircleUpgrade340", package.seeall)

local var_0_0 = class("FightWorkMagicCircleUpgrade340", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getMagicCircleInfo()

	if var_1_0 then
		var_1_0:refreshData(arg_1_0.actEffectData.magicCircle)
		FightController.instance:dispatchEvent(FightEvent.UpgradeMagicCircile, var_1_0)
	end

	arg_1_0:onDone(true)
end

return var_0_0
