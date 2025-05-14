module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBuildingPlaceBlock", package.seeall)

local var_0_0 = class("WaitGuideActionRoomBuildingPlaceBlock", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._sceneType = SceneType.Room

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")

	arg_1_0._buildingId = var_1_0[1]
	arg_1_0._toastId = var_1_0[2]

	if GameSceneMgr.instance:getCurSceneType() == arg_1_0._sceneType and not GameSceneMgr.instance:isLoading() then
		arg_1_0:_check()
	else
		arg_1_0:addEvents()
	end
end

function var_0_0._onEnterScene(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == 1 then
		arg_2_0:_check()
	end
end

function var_0_0._check(arg_3_0)
	if not GuideExceptionChecker.checkBuildingPut(nil, nil, arg_3_0._buildingId) then
		arg_3_0:onDone(true)
	else
		if arg_3_0._toastId then
			GameFacade.showToast(arg_3_0._toastId)
		end

		arg_3_0:addEvents()
	end
end

function var_0_0.addEvents(arg_4_0)
	if arg_4_0.hasAddEvents then
		return
	end

	arg_4_0.hasAddEvents = true

	GameSceneMgr.instance:registerCallback(arg_4_0._sceneType, arg_4_0._onEnterScene, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	if not arg_5_0.hasAddEvents then
		return
	end

	arg_5_0.hasAddEvents = false

	GameSceneMgr.instance:unregisterCallback(arg_5_0._sceneType, arg_5_0._onEnterScene, arg_5_0)
end

function var_0_0.clearWork(arg_6_0)
	arg_6_0:removeEvents()
end

return var_0_0
