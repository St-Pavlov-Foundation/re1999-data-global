module("modules.logic.guide.controller.action.impl.GuideActionRoomFocusBlockBuildingPut", package.seeall)

local var_0_0 = class("GuideActionRoomFocusBlockBuildingPut", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.actionParam and string.splitToNumber(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = var_1_0[2] or 0
	local var_1_3 = var_1_0[3] or 0

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		if var_1_1 < 100 then
			arg_1_0:focusByBuildingType(var_1_1, var_1_2, var_1_3)
		else
			arg_1_0:focusByBuildingId(var_1_1, var_1_2, var_1_3)
		end
	else
		logError("不在小屋场景，指引失败 " .. arg_1_0.guideId .. "_" .. arg_1_0.stepId)
		arg_1_0:onDone(true)
	end
end

function var_0_0.focusByBuildingType(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = RoomMapBuildingModel.instance:getBuildingListByType(arg_2_1)
	local var_2_1

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if iter_2_1:isInMap() then
				var_2_1 = iter_2_1.hexPoint

				local var_2_2 = GameSceneMgr.instance:getCurScene()
				local var_2_3 = var_2_2.buildingmgr and var_2_2.buildingmgr:getBuildingEntity(iter_2_1.id, SceneTag.RoomBuilding)
				local var_2_4 = var_2_3 and SLFramework.GameObjectHelper.GetPath(var_2_3.go)

				GuideModel.instance:setNextStepGOPath(arg_2_0.guideId, arg_2_0.stepId, var_2_4)

				break
			end
		end
	end

	arg_2_0:_focusByPoint(var_2_1, arg_2_2, arg_2_3)
end

function var_0_0.focusByBuildingId(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(arg_3_1)
	local var_3_1

	if var_3_0 and var_3_0:isInMap() then
		var_3_1 = var_3_0.hexPoint
	else
		local var_3_2 = arg_3_0:getNearRotate(arg_3_1)
		local var_3_3 = RoomBuildingHelper.getRecommendHexPoint(arg_3_1, nil, nil, nil, var_3_2)

		var_3_1 = var_3_3 and var_3_3.hexPoint
	end

	arg_3_0:_focusByPoint(var_3_1, arg_3_2, arg_3_3)
end

function var_0_0._focusByPoint(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 then
		local var_4_0 = HexMath.hexToPosition(arg_4_1, RoomBlockEnum.BlockSize)
		local var_4_1 = {
			focusX = var_4_0.x + arg_4_2,
			focusY = var_4_0.y + arg_4_3
		}

		GameSceneMgr.instance:getCurScene().camera:tweenCamera(var_4_1)
		TaskDispatcher.runDelay(arg_4_0._onDone, arg_4_0, 0.7)
	else
		arg_4_0:onDone(true)
	end
end

function var_0_0._onDone(arg_5_0, arg_5_1)
	arg_5_0:onDone(true)
end

function var_0_0.getNearRotate(arg_6_0, arg_6_1)
	local var_6_0 = RoomCameraController.instance:getRoomScene().camera:getCameraRotate() * Mathf.Rad2Deg

	return RoomRotateHelper.getCameraNearRotate(var_6_0) + RoomConfig.instance:getBuildingConfig(arg_6_1).rotate
end

function var_0_0.clearWork(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._onDone, arg_7_0)
end

return var_0_0
