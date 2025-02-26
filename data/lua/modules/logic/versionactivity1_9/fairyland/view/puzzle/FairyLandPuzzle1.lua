module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle1", package.seeall)

slot0 = class("FairyLandPuzzle1", FairyLandPuzzleBase)
slot0.ZeroVector2 = Vector2(0, 0)

function slot0.onInitView(slot0)
	slot0._puzzleGO = gohelper.findChild(slot0.viewGO, "main/#go_Root/#go_Puzzle/1")
	slot0._shapeGO = gohelper.findChild(slot0.viewGO, "main/#go_Shape/1")
	slot0.tipAnim = SLFramework.AnimatorPlayer.Get(slot0._shapeGO)
	slot0._shapeTrs = slot0._shapeGO.transform
	slot0._goImageShape = gohelper.findChild(slot0._shapeGO, "image_shape")
	slot0._dragTrs = slot0._goImageShape.transform

	slot0:addDrag(slot0._goImageShape)

	slot0.itemList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._puzzleGO, "item" .. tostring(slot4))
		slot5.anim = slot5.go:GetComponent(typeof(UnityEngine.Animator))
		slot0.itemList[slot4] = slot5
	end

	slot0.limitPos = 30
	slot0.shakeLimitPos = 15
	slot0.initPos = slot0._dragTrs.anchoredPosition
	slot0.lastDistance = 0
	slot0.shakeFinishTime = 3
	slot0.shakeTime = 0
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

	slot0.finishDict = {}

	for slot5 = 1, 3 do
		slot0.finishDict[slot5] = slot1
	end

	slot0:setItemPos(1, 11)
	slot0:setItemPos(2, 12)
	slot0:setItemPos(3, 13)

	if slot1 then
		if slot0.gyro then
			slot0.gyro:closeGyro()
		end
	else
		slot0:startGyro()
	end

	slot0:startCheckTips()
end

function slot0.startGyro(slot0)
	if slot0.gyro then
		return
	end

	slot0.gyro = FairyLandGyroComp.New()

	slot0.gyro:init({
		callback = slot0.frameUpdate,
		callbackObj = slot0,
		go = slot0._goImageShape,
		posLimit = slot0.limitPos
	})
end

function slot0.setItemPos(slot0, slot1, slot2)
	if slot0.itemList[slot1] then
		gohelper.setActive(slot3.go, not slot0.finishDict[slot1])
		recthelper.setAnchor(slot3.go.transform, (slot2 - 1) * 244 - 102, -((slot2 - 1) * 73 + 59))
	end
end

function slot0.moveItem(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		if not slot0.finishDict[slot4] then
			slot5.anim:Play("move")

			slot5.anim.speed = 1

			slot0:playShakeAudio()

			break
		end
	end
end

function slot0.stopItem(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		if not slot0.finishDict[slot4] then
			slot5.anim.speed = 0

			slot0:stopShakeAudio()

			break
		end
	end
end

function slot0.checkFinish(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		if not slot0.finishDict[slot4] then
			slot0:setItemFinish(slot4)

			break
		end
	end
end

function slot0.setItemFinish(slot0, slot1)
	slot0.finishDict[slot1] = true

	if slot0.itemList[slot1] then
		slot2.anim:Play("close", 0, 0)

		slot2.anim.speed = 1

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bean_fall)
	end

	slot3 = true

	for slot7, slot8 in ipairs(slot0.itemList) do
		if not slot0.finishDict[slot7] then
			slot3 = false

			break
		end
	end

	if slot3 then
		slot0:stopShakeAudio()

		slot0._canDrag = false

		if slot0.gyro then
			slot0.gyro:closeGyro()

			slot0.gyro = nil
		end

		TaskDispatcher.runDelay(slot0.onItemTweenFinish, slot0, 2)
	end
end

function slot0.onItemTweenFinish(slot0)
	gohelper.setActive(slot0._puzzleGO, false)
	gohelper.setActive(slot0._shapeGO, false)
	slot0:playSuccessTalk()
end

function slot0.canDrag(slot0)
	return slot0._canDrag
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	slot0:killTweenId()

	slot3 = slot0:getDragPos(slot2.position)
	slot0.offsetPos = slot3

	slot0:_tweenToPos(slot0._dragTrs, slot3 - slot0.offsetPos)

	slot0.inDrag = true
	slot0.shakeTime = 0
	slot0.shaking = false
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	slot0:_tweenToPos(slot0._dragTrs, slot0:getDragPos(slot2.position) - slot0.offsetPos)

	slot0.inDrag = true
end

function slot0._onEndDrag(slot0, slot1, slot2)
	slot0.inDrag = false
	slot0.shaking = false
	slot0.shakeTime = 0

	if not slot0:canDrag() then
		return
	end

	slot0:killTweenId()
	slot0:_tweenToPos(slot0._dragTrs, uv0.ZeroVector2, slot0._onDragTweenEnd, slot0)
end

function slot0._onDragTweenEnd(slot0)
end

function slot0.frameUpdate(slot0)
	slot0:checkShake()

	if slot0.shaking then
		slot0:onShake()
	else
		slot0:stopItem()
	end
end

function slot0.checkShake(slot0)
	slot1 = slot0._dragTrs.anchoredPosition

	if not slot0.lastPos then
		slot0.lastPos = slot1
	end

	slot0.shaking = Vector2.Distance(slot0.lastPos, slot1) > 0.1
	slot0.lastPos = slot1
end

function slot0.getDragPos(slot0, slot1)
	return recthelper.screenPosToAnchorPos(slot1, slot0._shapeTrs)
end

function slot0._tweenToPos(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.posTweenId then
		ZProj.TweenHelper.KillById(slot0.posTweenId)

		slot0.posTweenId = nil
	end

	slot7, slot8 = recthelper.getAnchor(slot1)

	if math.abs(slot7 - slot0:clampPos(slot2).x) > 10 or math.abs(slot8 - slot6.y) > 10 then
		slot0.posTweenId = ZProj.TweenHelper.DOAnchorPos(slot1, slot6.x, slot6.y, 0.16, slot3, slot4, slot5)
	else
		recthelper.setAnchor(slot1, slot6.x, slot6.y)

		if slot3 then
			slot3(slot4, slot5)
		end
	end
end

function slot0.clampPos(slot0, slot1)
	if Vector2.Distance(slot0.initPos, slot1) < slot0.limitPos then
		return slot1
	end

	return slot0.initPos + (slot1 - slot0.initPos).normalized * slot0.limitPos
end

function slot0.onShake(slot0)
	slot0.shakeTime = slot0.shakeTime + Time.deltaTime * 0.9

	if slot0.shakeFinishTime <= slot0.shakeTime then
		slot0.shakeTime = 0
		slot0.shaking = false

		slot0:checkFinish()
	else
		slot0:moveItem()
	end
end

function slot0.killTweenId(slot0)
	if slot0.posTweenId then
		ZProj.TweenHelper.KillById(slot0.posTweenId)

		slot0.posTweenId = nil
	end
end

function slot0.playShakeAudio(slot0)
	if slot0.playingId then
		return
	end

	slot0.playingId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bean_shaking)
end

function slot0.stopShakeAudio(slot0)
	if slot0.playingId then
		AudioMgr.instance:stopPlayingID(slot0.playingId)

		slot0.playingId = nil
	end
end

function slot0.onDestroyView(slot0)
	slot0:stopShakeAudio()

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
	end

	if slot0.gyro then
		slot0.gyro:closeGyro()

		slot0.gyro = nil
	end

	slot0:killTweenId()
	gohelper.setActive(slot0._puzzleGO, false)
	gohelper.setActive(slot0._shapeGO, false)
	TaskDispatcher.cancelTask(slot0.onItemTweenFinish, slot0)
end

return slot0
