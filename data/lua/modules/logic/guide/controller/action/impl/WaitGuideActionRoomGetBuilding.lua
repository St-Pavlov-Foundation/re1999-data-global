module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomGetBuilding", package.seeall)

local var_0_0 = class("WaitGuideActionRoomGetBuilding", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._sceneType = SceneType.Room

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._checkOpenView, arg_1_0)
	RoomController.instance:registerCallback(RoomEvent.GetGuideBuilding, arg_1_0._onGetGuideBuilding, arg_1_0)

	arg_1_0._buildingId = tonumber(arg_1_0.actionParam)

	if GameSceneMgr.instance:getCurSceneType() == arg_1_0._sceneType and not GameSceneMgr.instance:isLoading() then
		arg_1_0:_check()
	else
		GameSceneMgr.instance:registerCallback(arg_1_0._sceneType, arg_1_0._onEnterScene, arg_1_0)
	end
end

function var_0_0._onEnterScene(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == 1 then
		arg_2_0:_check()
	end
end

function var_0_0._check(arg_3_0)
	if 1 <= ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Building, arg_3_0._buildingId) then
		arg_3_0:onDone(true)
	else
		RoomRpc.instance:sendGainGuideBuildingRequest(arg_3_0.guideId, arg_3_0.stepId)
	end
end

function var_0_0._checkOpenView(arg_4_0, arg_4_1)
	if ViewName.RoomBlockPackageGetView == arg_4_1 then
		arg_4_0:clearWork()
		arg_4_0:onDone(true)
	end
end

function var_0_0._onGetGuideBuilding(arg_5_0, arg_5_1)
	local var_5_0 = {}

	table.insert(var_5_0, {
		roomBuildingLevel = 1,
		itemType = MaterialEnum.MaterialType.Building,
		itemId = arg_5_0._buildingId
	})
	PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
		itemList = var_5_0
	})
end

function var_0_0.clearWork(arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_6_0._checkOpenView, arg_6_0)
	RoomController.instance:unregisterCallback(RoomEvent.GetGuideBuilding, arg_6_0._onGetGuideBuilding, arg_6_0)
	GameSceneMgr.instance:unregisterCallback(arg_6_0._sceneType, arg_6_0._onEnterScene, arg_6_0)
end

return var_0_0
