module("modules.logic.fight.system.work.FightWorkChangeToTempCard", package.seeall)

local var_0_0 = class("FightWorkChangeToTempCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = string.splitToNumber(arg_1_0._actEffectMO.reserveStr, "#")

	if #var_1_0 > 0 then
		local var_1_1 = FightCardModel.instance:getCardMO().cardGroup

		if var_1_1 then
			for iter_1_0, iter_1_1 in ipairs(var_1_0) do
				if var_1_1[iter_1_1] then
					var_1_1[iter_1_1].tempCard = true

					FightController.instance:dispatchEvent(FightEvent.ChangeToTempCard, iter_1_1)
				else
					logError("FightWorkChangeToTempCard error, card = nil, index = " .. iter_1_1 .. " cardCount = " .. #var_1_1)

					break
				end
			end
		else
			logError("FightWorkChangeToTempCard error, cardGroup = nil")
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
