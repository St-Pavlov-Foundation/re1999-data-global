module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeSimulatePlaneComp", package.seeall)

local var_0_0 = class("PuzzleMazeSimulatePlaneComp", BaseView)
local var_0_1 = 1
local var_0_2 = {
	[PuzzleEnum.dir.left] = {
		0,
		180,
		0
	},
	[PuzzleEnum.dir.right] = {
		0,
		0,
		0
	},
	[PuzzleEnum.dir.up] = {
		0,
		0,
		0
	},
	[PuzzleEnum.dir.down] = {
		0,
		0,
		0
	}
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._goplane = gohelper.findChild(arg_1_0.viewGO, "#go_map/#go_plane")
	arg_1_0._gobigplane = gohelper.findChild(arg_1_0.viewGO, "image_Dec")
	arg_1_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0._gobigplane)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.InitGameDone, arg_4_0._initGameDone, arg_4_0)
	arg_4_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.SimulatePlane, arg_4_0._onTriggerSwitch, arg_4_0)
	arg_4_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.RecyclePlane, arg_4_0._recyclePlane, arg_4_0)
end

function var_0_0._initGameDone(arg_5_0)
	arg_5_0._animatorPlayer.animator.enabled = true

	arg_5_0._animatorPlayer.animator:Play("in", 0, 0)
end

function var_0_0._onTriggerSwitch(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._objPosX = arg_6_1
	arg_6_0._objPosY = arg_6_2

	arg_6_0._animatorPlayer:Play("out", arg_6_0._simulateFlyPlane, arg_6_0)
end

function var_0_0._simulateFlyPlane(arg_7_0)
	local var_7_0, var_7_1 = PuzzleMazeDrawController.instance:getLastPos()
	local var_7_2, var_7_3 = PuzzleMazeDrawModel.instance:getObjectAnchor(var_7_0, var_7_1)
	local var_7_4, var_7_5 = PuzzleMazeDrawModel.instance:getObjectAnchor(arg_7_0._objPosX, arg_7_0._objPosY)
	local var_7_6, var_7_7, var_7_8 = arg_7_0:_getPlaneTargetRotation(var_7_0, var_7_1, arg_7_0._objPosX, arg_7_0._objPosY)

	transformhelper.setEulerAngles(arg_7_0._goplane.transform, var_7_6, var_7_7, var_7_8)
	recthelper.setAnchor(arg_7_0._goplane.transform, var_7_2, var_7_3)
	gohelper.setAsLastSibling(arg_7_0._goplane)
	gohelper.setActive(arg_7_0._goplane, true)
	arg_7_0:_lockScreen(true)

	arg_7_0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(arg_7_0._goplane.transform, var_7_4, var_7_5, var_0_1, arg_7_0._onSlimulateFlyPlaneDone, arg_7_0)
end

function var_0_0._getPlaneTargetRotation(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = PuzzleEnum.dir.left

	if arg_8_1 ~= arg_8_3 then
		var_8_0 = arg_8_3 < arg_8_1 and PuzzleEnum.dir.left or PuzzleEnum.dir.right
	elseif arg_8_2 ~= arg_8_4 then
		var_8_0 = arg_8_4 < arg_8_2 and PuzzleEnum.dir.down or PuzzleEnum.dir.up
	end

	local var_8_1 = var_0_2 and var_0_2[var_8_0]
	local var_8_2 = var_8_1 and var_8_1[1] or 0
	local var_8_3 = var_8_1 and var_8_1[2] or 0
	local var_8_4 = var_8_1 and var_8_1[3] or 0

	return var_8_2, var_8_3, var_8_4
end

function var_0_0._onSlimulateFlyPlaneDone(arg_9_0)
	arg_9_0:_lockScreen(false)
	arg_9_0:_killSimulatePlaneTween()
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnSimulatePlaneDone)
end

function var_0_0._killSimulatePlaneTween(arg_10_0)
	if arg_10_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_10_0._moveTweenId)

		arg_10_0._moveTweenId = nil
	end
end

function var_0_0._recyclePlane(arg_11_0)
	gohelper.setActive(arg_11_0._goplane, false)

	arg_11_0._animatorPlayer.animator.enabled = true

	arg_11_0._animatorPlayer.animator:Play("in", 0, 0)
end

function var_0_0._lockScreen(arg_12_0, arg_12_1)
	if arg_12_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("PuzzleMazeSimulatePlaneComp SimulatePlane")
	else
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock("PuzzleMazeSimulatePlaneComp SimulatePlane")
	end
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:_lockScreen(false)
	arg_13_0:_killSimulatePlaneTween()
end

return var_0_0
