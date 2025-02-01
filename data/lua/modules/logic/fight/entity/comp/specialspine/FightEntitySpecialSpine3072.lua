module("modules.logic.fight.entity.comp.specialspine.FightEntitySpecialSpine3072", package.seeall)

slot0 = class("FightEntitySpecialSpine3072", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._entity = slot1
	slot0._maskEffect = FightEntitySpecialSpine3072_Mask.New(slot1)
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	slot0._maskEffect:playAnim(slot1, slot2, slot3)
end

function slot0.setFreeze(slot0, slot1)
	slot0._maskEffect:setFreeze(slot1)
end

function slot0.setTimeScale(slot0, slot1)
	slot0._maskEffect:setTimeScale(slot1)
end

function slot0.setLayer(slot0, slot1, slot2)
	slot0._maskEffect:setLayer(slot1, slot2)
end

function slot0.setRenderOrder(slot0, slot1, slot2)
	slot0._maskEffect:setRenderOrder(slot1, slot2)
end

function slot0.changeLookDir(slot0, slot1)
	slot0._maskEffect:changeLookDir(slot1)
end

function slot0._changeLookDir(slot0)
	slot0._maskEffect:_changeLookDir()
end

function slot0.setActive(slot0, slot1)
	slot0._maskEffect:setActive(slot1)
end

function slot0.setAnimation(slot0, slot1, slot2, slot3)
	slot0._maskEffect:setAnimation(slot1, slot2, slot3)
end

function slot0.releaseSelf(slot0)
	if slot0._maskEffect then
		slot0._maskEffect:releaseSelf()

		slot0._maskEffect = nil
	end

	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
