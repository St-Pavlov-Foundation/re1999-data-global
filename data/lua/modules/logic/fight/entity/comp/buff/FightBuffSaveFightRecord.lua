module("modules.logic.fight.entity.comp.buff.FightBuffSaveFightRecord", package.seeall)

local var_0_0 = class("FightBuffSaveFightRecord")

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = FightStrUtil.instance:getSplitToNumberCache(arg_1_2.actCommonParams, "#")

	if var_1_0 then
		FightModel.instance:setRoundOffset(tonumber(var_1_0[2]))
		FightController.instance:dispatchEvent(FightEvent.RefreshUIRound)
	end
end

function var_0_0.clear(arg_2_0)
	return
end

function var_0_0.onBuffEnd(arg_3_0)
	arg_3_0:clear()
end

function var_0_0.dispose(arg_4_0)
	arg_4_0:clear()
end

return var_0_0
