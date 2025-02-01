module("modules.logic.explore.map.scene.ExploreMapSceneObj", package.seeall)

slot0 = class("ExploreMapSceneObj", UserDataDispose)
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
	slot0.pos = slot1.pos
	slot0.scale = slot1.scale
	slot0.rotation = slot1.rotation
	slot0.rendererInfos = slot1.rendererInfos
	slot0.useLightMapIndexList = {}
	slot0.effectType = slot1.effectType
	slot0.areaId = slot1.areaId
	slot0.overridderLayer = slot1.overridderLayer or -1
	slot0._destoryInterval = ExploreConstValue.MapSceneObjDestoryInterval[slot1.effectType] or ExploreConstValue.CHECK_INTERVAL.MapSceneObjDestory

	for slot5, slot6 in ipairs(slot0.rendererInfos) do
		if tabletool.indexOf(slot0.useLightMapIndexList, slot6.lightmapIndex) == nil then
			table.insert(slot0.useLightMapIndexList, slot6.lightmapIndex)
		end
	end
end

function slot0.show(slot0)
	slot0.isActive = true

	if not slot0._go then
		slot0._assetId = ResMgr.getAbAsset(slot0.path, slot0._loadedCb, slot0, slot0._assetId)
	end

	return slot0._go == nil
end

function slot0.markShow(slot0)
	slot0.ishide = false

	TaskDispatcher.cancelTask(slot0.release, slot0)
end

function slot0.hide(slot0)
	if slot0._go and slot0.isActive == true then
		TaskDispatcher.runDelay(slot0.release, slot0, slot0._destoryInterval)
	end

	ResMgr.removeCallBack(slot0._assetId)

	slot0.isActive = false
	slot0.ishide = true

	return slot0.ishide ~= true
end

function slot0.unloadnow(slot0)
	if slot0._go and slot0.ishide == true then
		slot0:release()
	end
end

slot2 = UnityLayer.SceneOpaqueOcclusionClip

function slot0._loadedCb(slot0, slot1)
	if slot0._go == nil and slot0.isActive and slot1.IsLoadSuccess then
		slot0._go = slot1:getInstance(nil, , slot0._container)
		slot2 = slot0._go.transform

		transformhelper.setPos(slot2, slot0.pos[1], slot0.pos[2], slot0.pos[3])
		transformhelper.setLocalScale(slot2, slot0.scale[1], slot0.scale[2], slot0.scale[3])
		transformhelper.setLocalRotation(slot2, slot0.rotation[1], slot0.rotation[2], slot0.rotation[3])

		if slot0.overridderLayer ~= -1 then
			gohelper.setLayer(slot0._go, slot0.overridderLayer, false)

			for slot8 = 0, slot0._go:GetComponentsInChildren(typeof(UnityEngine.Collider)).Length - 1 do
				slot4[slot8].enabled = slot0.overridderLayer == uv0
			end
		end

		for slot7 = 0, slot0._go:GetComponentsInChildren(uv1, true).Length - 1 do
			slot8 = slot3[slot7]

			if slot0.rendererInfos[slot7 + 1] then
				slot8.lightmapIndex = slot9.lightmapIndex
				slot8.lightmapScaleOffset = Vector4.New(slot9.lightmapOffsetScale[1], slot9.lightmapOffsetScale[2], slot9.lightmapOffsetScale[3], slot9.lightmapOffsetScale[4])
			end
		end
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjLoadedCb)
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
