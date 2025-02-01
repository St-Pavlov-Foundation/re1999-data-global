module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomGetBuilding", package.seeall)

slot0 = class("WaitGuideActionRoomGetBuilding", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._sceneType = SceneType.Room

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._checkOpenView, slot0)
	RoomController.instance:registerCallback(RoomEvent.GetGuideBuilding, slot0._onGetGuideBuilding, slot0)

	slot0._buildingId = tonumber(slot0.actionParam)

	if GameSceneMgr.instance:getCurSceneType() == slot0._sceneType and not GameSceneMgr.instance:isLoading() then
		slot0:_check()
	else
		GameSceneMgr.instance:registerCallback(slot0._sceneType, slot0._onEnterScene, slot0)
	end
end

function slot0._onEnterScene(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0:_check()
	end
end

function slot0._check(slot0)
	if 1 <= ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Building, slot0._buildingId) then
		slot0:onDone(true)
	else
		RoomRpc.instance:sendGainGuideBuildingRequest(slot0.guideId, slot0.stepId)
	end
end

function slot0._checkOpenView(slot0, slot1)
	if ViewName.RoomBlockPackageGetView == slot1 then
		slot0:clearWork()
		slot0:onDone(true)
	end
end

function slot0._onGetGuideBuilding(slot0, slot1)
	slot2 = {}

	table.insert(slot2, {
		roomBuildingLevel = 1,
		itemType = MaterialEnum.MaterialType.Building,
		itemId = slot0._buildingId
	})
	PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
		itemList = slot2
	})
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._checkOpenView, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.GetGuideBuilding, slot0._onGetGuideBuilding, slot0)
	GameSceneMgr.instance:unregisterCallback(slot0._sceneType, slot0._onEnterScene, slot0)
end

return slot0
