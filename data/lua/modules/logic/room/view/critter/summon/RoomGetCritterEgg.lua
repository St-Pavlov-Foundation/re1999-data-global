module("modules.logic.room.view.critter.summon.RoomGetCritterEgg", package.seeall)

slot0 = class("RoomGetCritterEgg", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot1)
end

function slot0.playIdleAnim(slot0, slot1, slot2)
	slot0._animatorPlayer:Play("idle", slot1, slot2)
end

function slot0.playOpenAnim(slot0, slot1, slot2)
	slot0._animatorPlayer:Play("open", slot1, slot2)
end

return slot0
