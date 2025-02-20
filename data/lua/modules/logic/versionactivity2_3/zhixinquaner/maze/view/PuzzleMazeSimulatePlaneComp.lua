module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeSimulatePlaneComp", package.seeall)

slot0 = class("PuzzleMazeSimulatePlaneComp", BaseView)
slot1 = 1
slot2 = {
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

function slot0.onInitView(slot0)
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._goplane = gohelper.findChild(slot0.viewGO, "#go_map/#go_plane")
	slot0._gobigplane = gohelper.findChild(slot0.viewGO, "image_Dec")
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0._gobigplane)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.InitGameDone, slot0._initGameDone, slot0)
	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.SimulatePlane, slot0._onTriggerSwitch, slot0)
	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.RecyclePlane, slot0._recyclePlane, slot0)
end

function slot0._initGameDone(slot0)
	slot0._animatorPlayer.animator.enabled = true

	slot0._animatorPlayer.animator:Play("in", 0, 0)
end

function slot0._onTriggerSwitch(slot0, slot1, slot2)
	slot0._objPosX = slot1
	slot0._objPosY = slot2

	slot0._animatorPlayer:Play("out", slot0._simulateFlyPlane, slot0)
end

function slot0._simulateFlyPlane(slot0)
	slot1, slot2 = PuzzleMazeDrawController.instance:getLastPos()
	slot3, slot4 = PuzzleMazeDrawModel.instance:getObjectAnchor(slot1, slot2)
	slot5, slot6 = PuzzleMazeDrawModel.instance:getObjectAnchor(slot0._objPosX, slot0._objPosY)
	slot7, slot8, slot9 = slot0:_getPlaneTargetRotation(slot1, slot2, slot0._objPosX, slot0._objPosY)

	transformhelper.setEulerAngles(slot0._goplane.transform, slot7, slot8, slot9)
	recthelper.setAnchor(slot0._goplane.transform, slot3, slot4)
	gohelper.setAsLastSibling(slot0._goplane)
	gohelper.setActive(slot0._goplane, true)
	slot0:_lockScreen(true)

	slot0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(slot0._goplane.transform, slot5, slot6, uv0, slot0._onSlimulateFlyPlaneDone, slot0)
end

function slot0._getPlaneTargetRotation(slot0, slot1, slot2, slot3, slot4)
	slot5 = PuzzleEnum.dir.left

	if slot1 ~= slot3 then
		slot5 = slot3 < slot1 and PuzzleEnum.dir.left or PuzzleEnum.dir.right
	elseif slot2 ~= slot4 then
		slot5 = slot4 < slot2 and PuzzleEnum.dir.down or PuzzleEnum.dir.up
	end

	slot6 = uv0 and uv0[slot5]

	return slot6 and slot6[1] or 0, slot6 and slot6[2] or 0, slot6 and slot6[3] or 0
end

function slot0._onSlimulateFlyPlaneDone(slot0)
	slot0:_lockScreen(false)
	slot0:_killSimulatePlaneTween()
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnSimulatePlaneDone)
end

function slot0._killSimulatePlaneTween(slot0)
	if slot0._moveTweenId then
		ZProj.TweenHelper.KillById(slot0._moveTweenId)

		slot0._moveTweenId = nil
	end
end

function slot0._recyclePlane(slot0)
	gohelper.setActive(slot0._goplane, false)

	slot0._animatorPlayer.animator.enabled = true

	slot0._animatorPlayer.animator:Play("in", 0, 0)
end

function slot0._lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("PuzzleMazeSimulatePlaneComp SimulatePlane")
	else
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock("PuzzleMazeSimulatePlaneComp SimulatePlane")
	end
end

function slot0.onClose(slot0)
	slot0:_lockScreen(false)
	slot0:_killSimulatePlaneTween()
end

return slot0
