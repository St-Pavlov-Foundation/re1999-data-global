module("modules.logic.explore.map.unit.comp.ExploreUnitClickComp", package.seeall)

slot0 = class("ExploreUnitClickComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
	slot0.enable = true
end

function slot0.setup(slot0, slot1)
	slot0.colliderList = slot1:GetComponentsInChildren(typeof(UnityEngine.Collider))

	if slot0.colliderList == nil or slot0.colliderList.Length == 0 then
		return
	end

	for slot5 = 0, slot0.colliderList.Length - 1 do
		slot6 = slot0.colliderList[slot5]

		tolua.setpeer(slot6, slot0)

		slot6.enabled = slot0.enable
	end
end

function slot0.click(slot0)
	if not slot0.enable then
		return false
	end

	if slot0.unit.mo.triggerByClick then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnClickUnit, slot0.unit.mo)
	end

	return slot0.unit.mo.triggerByClick
end

function slot0.setEnable(slot0, slot1)
	slot0.enable = slot1

	if slot0.colliderList then
		for slot5 = 0, slot0.colliderList.Length - 1 do
			slot0.colliderList[slot5].enabled = slot1
		end
	end
end

function slot0.beforeDestroy(slot0)
end

function slot0.clear(slot0)
	if slot0.colliderList then
		for slot4 = 0, slot0.colliderList.Length - 1 do
			tolua.setpeer(slot0.colliderList[slot4], nil)
		end
	end

	slot0.colliderList = nil
end

function slot0.onDestroy(slot0)
	slot0:clear()
end

return slot0
