module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaEffectPool", package.seeall)

slot0 = class("TianShiNaNaEffectPool")

function slot0.ctor(slot0)
	slot0._effect = {}
	slot0.root = nil
end

function slot0.setRoot(slot0, slot1)
	slot0.root = slot1
end

function slot0.getFromPool(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = table.remove(slot0._effect) or TianShiNaNaPathEffect.Create(slot0.root)

	slot6:initData(slot1, slot2, slot3, slot4, slot5)

	return slot6
end

function slot0.returnToPool(slot0, slot1)
	table.insert(slot0._effect, slot1)
end

function slot0.clear(slot0)
	for slot4, slot5 in pairs(slot0._effect) do
		slot5:dispose()
	end

	slot0._effect = {}
	slot0.root = nil
end

slot0.instance = slot0.New()

return slot0
