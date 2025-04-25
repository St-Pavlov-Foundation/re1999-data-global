module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBase", package.seeall)

slot0 = class("FightEntitySpecialEffectBase", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._entity = slot1
	slot0._internalEffects = {}
	slot0._internalClass = {}

	slot0:initClass()
end

function slot0.initClass(slot0)
end

function slot0.newClass(slot0, slot1)
	table.insert(slot0._internalClass, slot1.New(slot0._entity))
end

function slot0.addHangEffect(slot0, ...)
	slot1 = slot0._entity:addHangEffect(...)
	slot0._internalEffects[slot1.uniqueId] = slot1

	return slot1
end

function slot0.addGlobalEffect(slot0, ...)
	slot1 = slot0._entity:addGlobalEffect(...)
	slot0._internalEffects[slot1.uniqueId] = slot1

	return slot1
end

function slot0.removeEffect(slot0, slot1)
	slot0._internalEffects[slot1.uniqueId] = nil

	slot0._entity.effect:removeEffect(slot1)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot1)
end

function slot0.setEffectActive(slot0, slot1)
	if slot0._internalClass then
		for slot5, slot6 in ipairs(slot0._internalClass) do
			if slot6.setEffectActive then
				slot6:setEffectActive(slot1)
			end
		end
	end

	if slot0._internalEffects then
		for slot5, slot6 in pairs(slot0._internalEffects) do
			slot6:setActive(slot1, "FightEntitySpecialEffectBase")
		end
	end
end

function slot0.releaseSelf(slot0)
end

function slot0.disposeSelf(slot0)
	for slot4, slot5 in ipairs(slot0._internalClass) do
		slot5:disposeSelf()
	end

	for slot4, slot5 in pairs(slot0._internalEffects) do
		slot0:removeEffect(slot5)
	end

	slot0:releaseSelf()

	slot0._internalClass = nil
	slot0._internalEffects = nil
	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
