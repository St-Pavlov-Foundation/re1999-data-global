module("modules.logic.fight.system.work.FightWorkChangeToTempCard", package.seeall)

local var_0_0 = class("FightWorkChangeToTempCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0.actEffectData) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = string.splitToNumber(arg_1_0.actEffectData.reserveStr, "#")

	if #var_1_0 > 0 then
		local var_1_1 = FightDataHelper.handCardMgr.handCard

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			if var_1_1[iter_1_1] then
				FightController.instance:dispatchEvent(FightEvent.ChangeToTempCard, iter_1_1)
			end
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
