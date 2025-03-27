module("modules.logic.fight.FightUpdateItem", package.seeall)

slot0 = class("FightUpdateItem")

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.func = slot1
	slot0.handle = slot2
	slot0.param = slot3
end

function slot0.update(slot0, slot1)
	if slot0.isDone then
		return
	end

	xpcall(slot0.func, __G__TRACKBACK__, slot0.handle, slot1, slot0.param)
end

return slot0
