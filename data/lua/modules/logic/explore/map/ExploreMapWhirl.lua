module("modules.logic.explore.map.ExploreMapWhirl", package.seeall)

slot0 = class("ExploreMapWhirl")

function slot0.ctor(slot0)
	slot0._whirlDict = {}
	slot0.typeToCls = {
		[ExploreEnum.WhirlType.Rune] = ExploreWhirlRune
	}
end

function slot0.init(slot0, slot1)
	slot0._mapGo = slot1
	slot0._whirlRoot = gohelper.create3d(slot1, "whirl")

	ExploreController.instance:registerCallback(ExploreEvent.UseItemChanged, slot0._onUseItemChange, slot0)
	slot0:_onUseItemChange(ExploreModel.instance:getUseItemUid())
end

function slot0._onUseItemChange(slot0, slot1)
	if ExploreBackpackModel.instance:getById(slot1) and slot2.config.type == ExploreEnum.BackPackItemType.Rune then
		slot0:addWhirl(ExploreEnum.WhirlType.Rune)
	else
		slot0:removeWhirl(ExploreEnum.WhirlType.Rune)
	end
end

function slot0.addWhirl(slot0, slot1)
	if slot0._whirlDict[slot1] then
		return slot0._whirlDict[slot1]
	end

	slot0._whirlDict[slot1] = (slot0.typeToCls[slot1] or ExploreWhirlBase).New(slot0._whirlRoot, slot1)

	return slot0._whirlDict[slot1]
end

function slot0.removeWhirl(slot0, slot1)
	if slot0._whirlDict[slot1] then
		slot0._whirlDict[slot1]:destroy()

		slot0._whirlDict[slot1] = nil
	end
end

function slot0.getWhirl(slot0, slot1)
	return slot0._whirlDict[slot1] or nil
end

function slot0.unloadMap(slot0)
	slot0:destroy()
end

function slot0.destroy(slot0)
	slot4 = slot0._onUseItemChange
	slot5 = slot0

	ExploreController.instance:unregisterCallback(ExploreEvent.UseItemChanged, slot4, slot5)

	for slot4, slot5 in pairs(slot0._whirlDict) do
		slot5:destroy()
	end

	slot0._whirlDict = {}
	slot0._mapGo = nil
end

return slot0
