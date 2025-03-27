module("modules.logic.character.controller.CharacterDestinyController", package.seeall)

slot0 = class("CharacterDestinyController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openCharacterDestinySlotView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterDestinySlotView, {
		heroMo = slot1
	})
end

function slot0.openCharacterDestinyStoneView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterDestinyStoneView, {
		heroMo = slot1
	})
end

function slot0.onRankUp(slot0, slot1)
	HeroRpc.instance:setDestinyRankUpRequest(slot1)
end

function slot0.onRankUpReply(slot0, slot1)
	slot0:dispatchEvent(CharacterDestinyEvent.OnRankUpReply, slot1)
end

function slot0.onLevelUp(slot0, slot1, slot2)
	HeroRpc.instance:setDestinyLevelUpRequest(slot1, slot2)
end

function slot0.onLevelUpReply(slot0, slot1, slot2)
	slot0:dispatchEvent(CharacterDestinyEvent.OnLevelUpReply, slot1, slot2)
end

function slot0.onUnlockStone(slot0, slot1, slot2)
	HeroRpc.instance:setDestinyStoneUnlockRequest(slot1, slot2)
end

function slot0.onUnlockStoneReply(slot0, slot1, slot2)
	slot0:dispatchEvent(CharacterDestinyEvent.OnUnlockStoneReply, slot1, slot2)
end

function slot0.onUseStone(slot0, slot1, slot2)
	HeroRpc.instance:setDestinyStoneUseRequest(slot1, slot2)
end

function slot0.onUseStoneReply(slot0, slot1, slot2)
	slot0:dispatchEvent(CharacterDestinyEvent.OnUseStoneReply, slot1, slot2)
end

function slot0.onHeroRedDotReadReply(slot0, slot1, slot2)
	slot0:dispatchEvent(CharacterDestinyEvent.OnHeroRedDotReadReply, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
