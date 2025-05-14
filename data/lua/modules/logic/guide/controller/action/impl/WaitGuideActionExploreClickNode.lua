module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreClickNode", package.seeall)

local var_0_0 = class("WaitGuideActionExploreClickNode", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = string.split(arg_1_0.actionParam, "#")
	local var_1_1 = tonumber(var_1_0[1]) or 0
	local var_1_2 = tonumber(var_1_0[2]) or 0
	local var_1_3 = tonumber(var_1_0[3]) or 0
	local var_1_4 = ExploreController.instance:getMap():getNowStatus()
	local var_1_5, var_1_6 = ExploreMapModel.instance:getHeroPos()

	if var_1_5 == var_1_1 and var_1_6 == var_1_2 and var_1_4 == ExploreEnum.MapStatus.Normal then
		arg_1_0:onDone(true)

		return
	end

	local var_1_7 = ExploreMapModel.instance:getNode(ExploreHelper.getKeyXY(var_1_1, var_1_2))
	local var_1_8 = 0

	if var_1_7 then
		var_1_8 = var_1_7.rawHeight
	end

	local var_1_9 = var_1_8 + var_1_3

	arg_1_0._targetPos = Vector3.New(var_1_1 + 0.5, var_1_9, var_1_2 + 0.5)

	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, arg_1_0._setMaskPosAndClickAction, arg_1_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_1_0._setMaskPosAndClickAction, arg_1_0)

	if not ViewMgr.instance:isOpenFinish(ViewName.GuideView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._checkOpenViewFinish, arg_1_0)
	else
		arg_1_0:_setMaskPosAndClickAction()
	end
end

function var_0_0._checkOpenViewFinish(arg_2_0, arg_2_1, arg_2_2)
	if ViewName.GuideView ~= arg_2_1 then
		return
	end

	arg_2_0:_setMaskPosAndClickAction()
end

function var_0_0._setMaskPosAndClickAction(arg_3_0)
	if not ViewMgr.instance:isOpenFinish(ViewName.GuideView) then
		return
	end

	GuideController.instance:dispatchEvent(GuideEvent.SetMaskPosition, arg_3_0._targetPos, true)
	GuideViewMgr.instance:setHoleClickCallback(arg_3_0._onHoldClick, arg_3_0)
end

function var_0_0._getScreenPos(arg_4_0)
	return CameraMgr.instance:getMainCamera():WorldToScreenPoint(arg_4_0._targetPos)
end

function var_0_0._onHoldClick(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:_getScreenPos()

	if arg_5_1 or not arg_5_0._isForceGuide or arg_5_0:isOutScreen(var_5_0) then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnClickMap, var_5_0)
		GuideController.instance:dispatchEvent(GuideEvent.SetMaskPosition, nil)
		GuideViewMgr.instance:close()
		arg_5_0:onDone(true)
	end
end

function var_0_0.isOutScreen(arg_6_0, arg_6_1)
	if arg_6_1.x < 0 or arg_6_1.y < 0 or arg_6_1.x > UnityEngine.Screen.width or arg_6_1.y > UnityEngine.Screen.height then
		return true
	end

	return false
end

function var_0_0.clearWork(arg_7_0)
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, arg_7_0._setMaskPosAndClickAction, arg_7_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_7_0._setMaskPosAndClickAction, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_7_0._checkOpenViewFinish, arg_7_0)
end

return var_0_0
