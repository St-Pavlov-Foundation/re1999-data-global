module("modules.logic.explore.map.light.ExploreMapLightItem", package.seeall)

slot0 = class("ExploreMapLightItem")
slot0._itemPool = nil

function slot0.getPool()
	if not uv0._itemPool then
		uv0._itemPool = LuaObjPool.New(100, uv0._poolNew, uv0._poolRelease, uv0._poolReset)
	end

	return uv0._itemPool
end

function slot0._poolNew()
	return uv0.New()
end

function slot0._poolRelease(slot0)
	slot0:release()
end

function slot0._poolReset(slot0)
	slot0:reset()
end

function slot0.release(slot0)
	if slot0._cloneGo then
		gohelper.destroy(slot0._cloneGo)

		slot0._cloneGo = nil
	end

	slot0._trans = nil
	slot0._lightCenter = nil
	slot0._lightLast = nil
end

function slot0.reset(slot0)
	slot0._trans:SetParent(nil)
	transformhelper.setLocalScale(slot0._trans, 0, 0, 0)
end

function slot0.ctor(slot0)
	slot0._cloneGo = nil
end

function slot0.init(slot0, slot1, slot2, slot3)
	if not slot0._cloneGo then
		slot0._cloneGo = gohelper.clone(slot3, slot2)
		slot0._trans = slot0._cloneGo.transform
		slot0._lightCenter = slot0._trans:Find("zhong")
		slot0._lightLast = slot0._trans:Find("wei")
	else
		slot0._trans:SetParent(slot2.transform)
	end

	slot0:updateLightMO(slot1)
end

function slot0.updateLightMO(slot0, slot1)
	slot3 = slot1.lightLen

	transformhelper.setLocalPos(slot0._trans, 0, 1, 0)
	transformhelper.setLocalRotation(slot0._trans, 0, slot1.dir, 0)
	transformhelper.setLocalScale(slot0._trans, 1, 1, 1)
	transformhelper.setLocalScale(slot0._lightCenter, 3, 0.2, slot3 - 0.5)
	transformhelper.setLocalPos(slot0._lightLast, 0, 0, slot3 - 0.1)
end

return slot0
