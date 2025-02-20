module("modules.logic.fight.entity.comp.buff.FightBuffStoredExPoint", package.seeall)

slot0 = class("FightBuffStoredExPoint")

function slot0.ctor(slot0)
	slot0.type = nil
end

function slot0.onBuffStart(slot0, slot1, slot2)
	slot0.entity = slot1

	if not slot2.actCommonParams then
		return
	end

	if lua_buff_act.configDict[FightStrUtil.instance:getSplitToNumberCache(slot3, "#")[1]] and slot6.type == FightEnum.BuffType_ExPointOverflowBank and slot1:getMO() then
		slot7:setStoredExPoint(slot4[2])
		FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, slot7.id, slot7:getStoredExPoint())
	end
end

function slot0.onBuffEnd(slot0)
	if not slot0.entity then
		return
	end

	if slot0.entity:getMO() then
		slot1:setStoredExPoint(0)
		FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, slot1.id, slot1:getStoredExPoint())
	end
end

function slot0.reset(slot0)
	slot0.entity = nil
end

function slot0.dispose(slot0)
	slot0.entity = nil
end

return slot0
