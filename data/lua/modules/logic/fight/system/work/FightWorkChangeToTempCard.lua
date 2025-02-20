module("modules.logic.fight.system.work.FightWorkChangeToTempCard", package.seeall)

slot0 = class("FightWorkChangeToTempCard", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	if #string.splitToNumber(slot0._actEffectMO.reserveStr, "#") > 0 then
		if FightCardModel.instance:getCardMO().cardGroup then
			for slot6, slot7 in ipairs(slot1) do
				if slot2[slot7] then
					slot2[slot7].tempCard = true

					FightController.instance:dispatchEvent(FightEvent.ChangeToTempCard, slot7)
				else
					logError("FightWorkChangeToTempCard error, card = nil, index = " .. slot7 .. " cardCount = " .. #slot2)

					break
				end
			end
		else
			logError("FightWorkChangeToTempCard error, cardGroup = nil")
		end
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
