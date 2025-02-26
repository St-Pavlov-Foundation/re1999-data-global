module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle2", package.seeall)

slot0 = class("FairyLandPuzzle2", FairyLandPuzzleBase)

function slot0.onInitView(slot0)
	slot0._puzzleGO = gohelper.findChild(slot0.viewGO, "main/#go_Root/#go_Puzzle/2")
	slot0._goShape = gohelper.findChild(slot0.viewGO, "main/#go_Shape")
	slot0._shapeGO = gohelper.findChild(slot0.viewGO, "main/#go_Shape/2")
	slot0.tipAnim = SLFramework.AnimatorPlayer.Get(slot0._shapeGO)
	slot0._shapeTrs = slot0._shapeGO.transform
	slot0._goImageShape = gohelper.findChild(slot0._shapeGO, "image_shape")

	slot0:addDrag(slot0._goImageShape)

	slot0.itemList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._puzzleGO, "item" .. tostring(slot4))
		slot5.anim = slot5.go:GetComponent(typeof(UnityEngine.Animator))
		slot5.transform = slot5.go.transform
		slot5.itemGO = gohelper.findChild(slot5.go, "item")
		slot5.itemTransform = slot5.itemGO.transform
		slot0.itemList[slot4] = slot5
	end

	slot0.mainGO = gohelper.findChild(slot0.viewGO, "main")
	slot0.mainTrs = slot0.mainGO.transform
	slot0._dragTrs = slot0._shapeTrs
	slot0.initPos = recthelper.uiPosToScreenPos(slot0._dragTrs)
	slot0.initAngle = slot0:getRotationZ()
end

function slot0.initPuzzleView(slot0)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetSceneUpdatePos, true)
	gohelper.addChildPosStay(slot0.viewGO, slot0._shapeGO)
end

function slot0.resetGOList(slot0)
	transformhelper.setLocalRotation(slot0.mainTrs, 0, 0, slot0.initAngle)
	transformhelper.setLocalRotation(slot0._shapeTrs, 0, 0, slot0.initAngle)
	gohelper.addChildPosStay(slot0._goShape, slot0._shapeGO)
end

function slot0.addDrag(slot0, slot1)
	if slot0._drag then
		return
	end

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot1)

	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0, slot1.transform)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0, slot1.transform)
end

function slot0.onStart(slot0)
	slot1 = FairyLandModel.instance:isPassPuzzle(slot0.config.id)
	slot0._canDrag = not slot1

	gohelper.setActive(slot0._puzzleGO, not slot1)
	gohelper.setActive(slot0._shapeGO, not slot1)

	if slot1 then
		if slot0.gyro then
			slot0.gyro:closeGyro()
		end

		slot0:resetGOList()
	else
		slot0:initPuzzleView()
		slot0:setItemPos(1, 19)
		slot0:setItemPos(2, 20)
		slot0:setItemPos(3, 21)
		slot0:startGyro()
	end

	slot0:startCheckTips()
end

function slot0.startGyro(slot0)
	if slot0.gyro then
		return
	end

	slot0.gyro = FairyLandGyroRotationComp.New()

	slot0.gyro:init({
		callback = slot0.checkFinish,
		callbackObj = slot0,
		goList = {
			slot0._shapeGO,
			slot0.mainGO
		}
	})
end

function slot0.setItemPos(slot0, slot1, slot2)
	if slot0.itemList[slot1] then
		gohelper.setActive(slot3.go, true)
		recthelper.setAnchor(slot3.transform, (slot2 - 1) * 244 - 100, -((slot2 - 1) * 73 + 52))
	end
end

function slot0.checkFinish(slot0)
	if slot0:getRotationZ() > 160 and slot1 < 200 then
		slot0:finished()
	end
end

function slot0.finished(slot0)
	if slot0.inDrag then
		return
	end

	slot0._canDrag = false

	if slot0.gyro then
		slot0.gyro:closeGyro()
	end

	slot0:stopCheckTips()
	slot0:killTweenId()
	slot0:playFinishAnim()
end

function slot0.playFinishAnim(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot6, slot7, slot8 = transformhelper.getPos(slot5.itemTransform)
		slot5.downDir = Vector3.down
		slot5.initPos = {
			slot6,
			slot7,
			slot8
		}

		slot5.anim:Play("open", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_barrier_fall)

	slot0.moveTweenId = ZProj.TweenHelper.DOTweenFloat(0, 10, 0.84, slot0._itemFrameMove, slot0._onFinishAnimEnd, slot0, nil, EaseType.Linear)
end

function slot0._itemFrameMove(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.itemList) do
		slot7 = slot6.downDir * slot1

		transformhelper.setPos(slot6.itemTransform, slot7.x + slot6.initPos[1], slot7.y + slot6.initPos[2], slot7.z + slot6.initPos[3])
	end
end

function slot0._onFinishAnimEnd(slot0)
	slot0:resetGOList()
	gohelper.setActive(slot0._puzzleGO, false)
	gohelper.setActive(slot0._shapeGO, false)
	slot0:playSuccessTalk()
end

function slot0.canDrag(slot0)
	return slot0._canDrag
end

function slot0.getRotationZ(slot0, slot1)
	slot2, slot3, slot4 = transformhelper.getLocalRotation(slot1 or slot0._dragTrs)

	return slot4
end

function slot0.vector2Angle(slot0, slot1)
	return Mathf.Atan2(slot1.y - slot0.initPos.y, slot1.x - slot0.initPos.x) / Mathf.PI * 180
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	slot0:killTweenId()

	slot0.angleRecord = slot0:getRotationZ()
	slot0.clickRecord = slot0:vector2Angle(slot2.position)
	slot0.inDrag = true
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	slot4 = slot0.angleRecord + slot0:vector2Angle(slot2.position) - slot0.clickRecord

	slot0:_tweenToRotation(slot0._dragTrs, slot4)
	slot0:_tween2ToRotation(slot0.mainTrs, slot4)

	slot0.inDrag = true
end

function slot0._onEndDrag(slot0, slot1, slot2)
	slot0:startCheckTips()

	slot0.inDrag = false

	if not slot0:canDrag() then
		return
	end

	slot0:killTweenId()
	slot0:checkFinish()
end

function slot0._onDragTweenEnd(slot0)
end

function slot0._tweenToRotation(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	if math.abs(slot0:getRotationZ(slot1) - slot2) > 1 then
		slot0.tweenId = ZProj.TweenHelper.DOLocalRotate(slot1, 0, 0, slot2, 0.16, slot3, slot4, slot5)
	else
		transformhelper.setLocalRotation(slot1, 0, 0, slot2)

		if slot3 then
			slot3(slot4, slot5)
		end
	end
end

function slot0._tween2ToRotation(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.tweenId2 then
		ZProj.TweenHelper.KillById(slot0.tweenId2)

		slot0.tweenId2 = nil
	end

	if math.abs(slot0:getRotationZ(slot1) - slot2) > 1 then
		slot0.tweenId2 = ZProj.TweenHelper.DOLocalRotate(slot1, 0, 0, slot2, 0.16, slot3, slot4, slot5)
	else
		transformhelper.setLocalRotation(slot1, 0, 0, slot2)

		if slot3 then
			slot3(slot4, slot5)
		end
	end
end

function slot0.killTweenId(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	if slot0.tweenId2 then
		ZProj.TweenHelper.KillById(slot0.tweenId2)

		slot0.tweenId2 = nil
	end

	if slot0.moveTweenId then
		ZProj.TweenHelper.KillById(slot0.moveTweenId)

		slot0.moveTweenId = nil
	end
end

function slot0.playTipsTalk(slot0)
	slot0:playTalk(slot0.config.tipsTalkId, slot0.startCheckTalk, slot0, true, true)
end

function slot0.onDestroyView(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
	end

	if slot0.gyro then
		slot0.gyro:closeGyro()
	end

	slot0:killTweenId()
	gohelper.setActive(slot0._puzzleGO, false)
	gohelper.setActive(slot0._shapeGO, false)
	slot0:resetGOList()
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetSceneUpdatePos, false)
end

return slot0
