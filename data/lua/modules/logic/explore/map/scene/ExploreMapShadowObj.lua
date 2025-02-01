module("modules.logic.explore.map.scene.ExploreMapShadowObj", package.seeall)

slot0 = class("ExploreMapShadowObj", UserDataDispose)
slot1 = typeof(UnityEngine.MeshRenderer)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._container = slot1
	slot0.isActive = false
	slot0._go = nil
	slot0.ishide = true
end

function slot0.setData(slot0, slot1)
	slot0.id = slot1.id
	slot0.path = slot1.path
	slot0.areaId = slot1.areaId
	slot0.pos = slot1.pos
	slot0.scale = slot1.scale
	slot0.rotation = slot1.rotation
	slot0.bounds = Bounds.New(Vector3.New(slot1.bounds.center[1], slot1.bounds.center[2], slot1.bounds.center[3]), Vector3.New(slot1.bounds.size[1], slot1.bounds.size[2], slot1.bounds.size[3]))
end

function slot0.show(slot0)
	slot0.isActive = true
	slot0.ishide = false

	if not slot0._go then
		slot0._assetId = ResMgr.getAbAsset(slot0.path, slot0._loadedCb, slot0, slot0._assetId)
	end

	TaskDispatcher.cancelTask(slot0.release, slot0)
end

function slot0.markShow(slot0)
	slot0.ishide = false
end

function slot0.hide(slot0)
	if slot0._go and slot0.isActive == true then
		TaskDispatcher.runDelay(slot0.release, slot0, ExploreConstValue.CHECK_INTERVAL.MapShadowObjDestory)
	end

	ResMgr.removeCallBack(slot0._assetId)

	slot0.isActive = false
	slot0.ishide = true

	return slot0.ishide ~= true
end

function slot0._loadedCb(slot0, slot1)
	if slot0._go == nil and slot0.isActive then
		slot0._go = slot1:getInstance(nil, , slot0._container)
		slot2 = slot0._go.transform

		transformhelper.setPos(slot2, slot0.pos[1], slot0.pos[2], slot0.pos[3])
		transformhelper.setLocalScale(slot2, slot0.scale[1], slot0.scale[2], slot0.scale[3])
		transformhelper.setLocalRotation(slot2, slot0.rotation[1], slot0.rotation[2], slot0.rotation[3])
	end

	gohelper.setActive(slot0._go, slot0.isActive)
end

function slot0.release(slot0)
	slot0:_clear()
end

function slot0.dispose(slot0)
	slot0:_clear()
	slot0:__onDispose()
end

function slot0._clear(slot0)
	TaskDispatcher.cancelTask(slot0.release, slot0)
	ResMgr.removeCallBack(slot0._assetId)
	ResMgr.ReleaseObj(slot0._go)

	slot0._go = nil
end

return slot0
