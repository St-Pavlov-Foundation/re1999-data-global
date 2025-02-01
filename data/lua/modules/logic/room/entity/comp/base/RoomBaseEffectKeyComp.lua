module("modules.logic.room.entity.comp.base.RoomBaseEffectKeyComp", package.seeall)

slot0 = class("RoomBaseEffectKeyComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectKey = slot1:getMainEffectKey()
end

function slot0.setEffectKey(slot0, slot1)
	slot0._effectKey = slot1
end

function slot0.onRebuildEffectGO(slot0)
end

function slot0.onReturnEffectGO(slot0)
end

function slot0.onEffectReturn(slot0, slot1, slot2)
	if slot0._effectKey == slot1 then
		slot0:onReturnEffectGO()
	end
end

function slot0.onEffectRebuild(slot0)
	if slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) and not slot1:isSameResByKey(slot0._effectKey, slot0._effectRes) then
		slot0._effectRes = slot1:getEffectRes(slot0._effectKey)

		slot0:onRebuildEffectGO()
	end
end

return slot0
