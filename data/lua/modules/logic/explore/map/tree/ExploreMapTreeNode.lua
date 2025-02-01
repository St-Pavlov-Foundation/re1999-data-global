module("modules.logic.explore.map.tree.ExploreMapTreeNode", package.seeall)

slot0 = class("ExploreMapTreeNode")

function slot0.ctor(slot0, slot1, slot2)
	slot0.preloadComp = slot2
	slot0.bound = Bounds.New(Vector3.New(slot1.bound.center[1], slot1.bound.center[2], slot1.bound.center[3]), Vector3.New(slot1.bound.size[1], 4, slot1.bound.size[3]))
	slot6 = slot1.bound.size[1]
	slot7 = 2
	slot0._drawBound = Bounds.New(Vector3.New(slot1.bound.center[1], slot1.bound.center[2], slot1.bound.center[3]), Vector3.New(slot6, slot7, slot1.bound.size[3]))
	slot0.centerX = slot0.bound.center.x
	slot0.centerZ = slot0.bound.center.z
	slot0.extentsX = slot0.bound.extents.x
	slot0.extentsZ = slot0.bound.extents.z
	slot0.childList = {}
	slot0.isShow = false

	for slot6, slot7 in ipairs(slot1.child) do
		table.insert(slot0.childList, uv0.New(slot1.child[slot6], slot2))
	end

	slot0.objList = {}

	for slot6, slot7 in ipairs(slot1.objList) do
		table.insert(slot0.objList, slot1.objList[slot6])
	end
end

function slot0.triggerMove(slot0, slot1, slot2, slot3, slot4)
	slot0.isShow = true

	for slot8, slot9 in ipairs(slot0.objList) do
		slot4[slot9] = 1
	end

	for slot8, slot9 in ipairs(slot0.childList) do
		if slot0.childList[slot8]:checkBound(slot1, slot2, slot3) then
			slot0.childList[slot8]:triggerMove(slot1, slot2, slot3, slot4)
		else
			slot0.childList[slot8]:hide()
		end
	end
end

function slot0.hide(slot0)
	if slot0.isShow then
		for slot4, slot5 in ipairs(slot0.childList) do
			slot0.childList[slot4]:hide()
		end
	end

	slot0.isShow = false
end

function slot0.checkBound(slot0, slot1, slot2, slot3)
	if slot0:_checkRage(slot1) then
		return true
	elseif slot3 == ExploreEnum.SceneCheckMode.Camera then
		return slot0:_checkCamera(slot2)
	elseif slot3 == ExploreEnum.SceneCheckMode.Planes then
		return slot0:_checkInplanes(slot2)
	else
		return false
	end
end

function slot0._checkCamera(slot0, slot1)
	return ZProj.ExploreHelper.CheckBoundIsInCamera(slot0.bound, slot1)
end

function slot0._checkInplanes(slot0, slot1)
	return ZProj.ExploreHelper.CheckBoundIsInplanes(slot0.bound, slot1)
end

function slot0._checkRage(slot0, slot1)
	return math.abs(slot0.centerX - slot1.x) <= math.abs(slot0.extentsX + slot1.z) and math.abs(slot0.centerZ - slot1.y) <= math.abs(slot0.extentsZ + slot1.w)
end

function slot0.drawBound(slot0)
	if slot0.isShow then
		for slot4, slot5 in ipairs(slot0.childList) do
			slot0.childList[slot4]:drawBound()
		end

		ZProj.ExploreHelper.DrawBound(slot0._drawBound)
	end
end

function slot0.onDestroy(slot0)
	slot0.preloadComp = nil

	if slot0.childList then
		for slot4, slot5 in pairs(slot0.childList) do
			slot5:onDestroy()
		end
	end

	slot0.childList = nil
	slot0.objList = nil
end

return slot0
