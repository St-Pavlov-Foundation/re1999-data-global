module("modules.logic.fight.entity.comp.buff.FightBuffSaveFightRecord", package.seeall)

slot0 = class("FightBuffSaveFightRecord")

function slot0.onBuffStart(slot0, slot1, slot2)
	if FightStrUtil.instance:getSplitToNumberCache(slot2.actCommonParams, "#") then
		FightModel.instance:setRoundOffset(tonumber(slot3[2]))
		FightController.instance:dispatchEvent(FightEvent.RefreshUIRound)
	end
end

function slot0.clear(slot0)
end

function slot0.onBuffEnd(slot0)
	slot0:clear()
end

function slot0.dispose(slot0)
	slot0:clear()
end

return slot0
