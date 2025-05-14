module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomLineLvUpSatisfy", package.seeall)

local var_0_0 = class("WaitGuideActionRoomLineLvUpSatisfy", BaseGuideAction)
local var_0_1 = "1#190007#8"

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_1_0._check, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._check, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._check, arg_1_0)
	RoomController.instance:registerCallback(RoomEvent.GuideOpenInitBuilding1, arg_1_0._delayCheck, arg_1_0)
	RoomController.instance:registerCallback(RoomEvent.GuideOpenInitBuilding2, arg_1_0._delayCheck, arg_1_0)

	local var_1_0 = GuideConfig.instance:getNextStepId(arg_1_0.guideId, arg_1_0.stepId)
	local var_1_1 = GuideConfig.instance:getStepCO(arg_1_0.guideId, var_1_0)

	arg_1_0._nextStepBtn = var_1_1 and var_1_1.goPath
	arg_1_0._material = GameUtil.splitString2(var_0_1, true)
	arg_1_0._openView = ViewName.RoomInitBuildingView
	arg_1_0._blockViews = {
		[ViewName.CommonPropView] = true,
		[ViewName.GuideView] = true
	}
end

function var_0_0._delayCheck(arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0._check, arg_2_0, 0.0333, 30)
end

function var_0_0._check(arg_3_0)
	if arg_3_0:_checkOpenView() and arg_3_0:_checkMaterials() and arg_3_0:_checkBtnExist() then
		arg_3_0:onDone(true)
	end
end

function var_0_0._checkBtnExist(arg_4_0)
	local var_4_0 = gohelper.find(arg_4_0._nextStepBtn)

	return GuideUtil.isGOShowInScreen(var_4_0)
end

function var_0_0._checkOpenView(arg_5_0)
	if ViewMgr.instance:isOpenFinish(arg_5_0._openView) then
		local var_5_0 = ViewMgr.instance:getOpenViewNameList()

		for iter_5_0 = #var_5_0, 1, -1 do
			local var_5_1 = var_5_0[iter_5_0]

			if var_5_1 == arg_5_0._openView then
				return true
			end

			if ViewMgr.instance:isFull(var_5_1) or ViewMgr.instance:isModal(var_5_1) or arg_5_0._blockViews[var_5_1] then
				return false
			end
		end
	end
end

function var_0_0._checkMaterials(arg_6_0)
	local var_6_0 = true

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._material) do
		local var_6_1 = iter_6_1[1]
		local var_6_2 = iter_6_1[2]

		if iter_6_1[3] > ItemModel.instance:getItemQuantity(var_6_1, var_6_2) then
			var_6_0 = false

			break
		end
	end

	if var_6_0 then
		return true
	end
end

function var_0_0.clearWork(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._check, arg_7_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_7_0._checkMaterials, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_7_0._check, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_7_0._check, arg_7_0)
	RoomController.instance:unregisterCallback(RoomEvent.GuideOpenInitBuilding1, arg_7_0._delayCheck, arg_7_0)
	RoomController.instance:unregisterCallback(RoomEvent.GuideOpenInitBuilding2, arg_7_0._delayCheck, arg_7_0)
end

return var_0_0
