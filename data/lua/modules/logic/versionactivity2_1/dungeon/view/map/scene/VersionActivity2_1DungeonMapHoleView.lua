module("modules.logic.versionactivity2_1.dungeon.view.map.scene.VersionActivity2_1DungeonMapHoleView", package.seeall)

slot0 = class("VersionActivity2_1DungeonMapHoleView", DungeonMapHoleView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.initCameraParam, slot0)
	slot0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnAddOneElement, slot0.onAddOneElement, slot0)
	slot0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnRecycleAllElement, slot0.onRecycleAllElement, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.initCameraParam, slot0)
	slot0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnAddOneElement, slot0.onAddOneElement, slot0)
	slot0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnRecycleAllElement, slot0.onRecycleAllElement, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.loadSceneFinish(slot0, slot1)
	uv0.super.loadSceneFinish(slot0, {
		slot1.mapConfig,
		slot1.mapSceneGo
	})
end

function slot0.onMapPosChanged(slot0, slot1, slot2)
	uv0.super.onMapPosChanged(slot0, slot1, slot2)
end

function slot0.initCameraParam(slot0)
	uv0.super.initCameraParam(slot0)
end

function slot0.onAddOneElement(slot0, slot1)
	if slot1 then
		slot0:_onAddElement(slot1:getElementId())
	end
end

function slot0.onRemoveElement(slot0, slot1)
	if slot1 and slot1._config.fragment == 0 then
		slot0:_onRemoveElement(slot1:getElementId())
	end
end

function slot0.onRecycleAllElement(slot0)
	slot0.holdCoList = {}

	slot0:refreshHoles()
end

return slot0
