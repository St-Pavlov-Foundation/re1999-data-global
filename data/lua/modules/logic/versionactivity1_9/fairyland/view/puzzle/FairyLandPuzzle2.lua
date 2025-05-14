module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle2", package.seeall)

local var_0_0 = class("FairyLandPuzzle2", FairyLandPuzzleBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._puzzleGO = gohelper.findChild(arg_1_0.viewGO, "main/#go_Root/#go_Puzzle/2")
	arg_1_0._goShape = gohelper.findChild(arg_1_0.viewGO, "main/#go_Shape")
	arg_1_0._shapeGO = gohelper.findChild(arg_1_0.viewGO, "main/#go_Shape/2")
	arg_1_0.tipAnim = SLFramework.AnimatorPlayer.Get(arg_1_0._shapeGO)
	arg_1_0._shapeTrs = arg_1_0._shapeGO.transform
	arg_1_0._goImageShape = gohelper.findChild(arg_1_0._shapeGO, "image_shape")

	arg_1_0:addDrag(arg_1_0._goImageShape)

	arg_1_0.itemList = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		var_1_0.go = gohelper.findChild(arg_1_0._puzzleGO, "item" .. tostring(iter_1_0))
		var_1_0.anim = var_1_0.go:GetComponent(typeof(UnityEngine.Animator))
		var_1_0.transform = var_1_0.go.transform
		var_1_0.itemGO = gohelper.findChild(var_1_0.go, "item")
		var_1_0.itemTransform = var_1_0.itemGO.transform
		arg_1_0.itemList[iter_1_0] = var_1_0
	end

	arg_1_0.mainGO = gohelper.findChild(arg_1_0.viewGO, "main")
	arg_1_0.mainTrs = arg_1_0.mainGO.transform
	arg_1_0._dragTrs = arg_1_0._shapeTrs
	arg_1_0.initPos = recthelper.uiPosToScreenPos(arg_1_0._dragTrs)
	arg_1_0.initAngle = arg_1_0:getRotationZ()
end

function var_0_0.initPuzzleView(arg_2_0)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetSceneUpdatePos, true)
	gohelper.addChildPosStay(arg_2_0.viewGO, arg_2_0._shapeGO)
end

function var_0_0.resetGOList(arg_3_0)
	transformhelper.setLocalRotation(arg_3_0.mainTrs, 0, 0, arg_3_0.initAngle)
	transformhelper.setLocalRotation(arg_3_0._shapeTrs, 0, 0, arg_3_0.initAngle)
	gohelper.addChildPosStay(arg_3_0._goShape, arg_3_0._shapeGO)
end

function var_0_0.addDrag(arg_4_0, arg_4_1)
	if arg_4_0._drag then
		return
	end

	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_1)

	arg_4_0._drag:AddDragBeginListener(arg_4_0._onBeginDrag, arg_4_0, arg_4_1.transform)
	arg_4_0._drag:AddDragListener(arg_4_0._onDrag, arg_4_0)
	arg_4_0._drag:AddDragEndListener(arg_4_0._onEndDrag, arg_4_0, arg_4_1.transform)
end

function var_0_0.onStart(arg_5_0)
	local var_5_0 = FairyLandModel.instance:isPassPuzzle(arg_5_0.config.id)

	arg_5_0._canDrag = not var_5_0

	gohelper.setActive(arg_5_0._puzzleGO, not var_5_0)
	gohelper.setActive(arg_5_0._shapeGO, not var_5_0)

	if var_5_0 then
		if arg_5_0.gyro then
			arg_5_0.gyro:closeGyro()
		end

		arg_5_0:resetGOList()
	else
		arg_5_0:initPuzzleView()
		arg_5_0:setItemPos(1, 19)
		arg_5_0:setItemPos(2, 20)
		arg_5_0:setItemPos(3, 21)
		arg_5_0:startGyro()
	end

	arg_5_0:startCheckTips()
end

function var_0_0.startGyro(arg_6_0)
	if arg_6_0.gyro then
		return
	end

	arg_6_0.gyro = FairyLandGyroRotationComp.New()

	local var_6_0 = {
		callback = arg_6_0.checkFinish,
		callbackObj = arg_6_0,
		goList = {
			arg_6_0._shapeGO,
			arg_6_0.mainGO
		}
	}

	arg_6_0.gyro:init(var_6_0)
end

function var_0_0.setItemPos(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.itemList[arg_7_1]

	if var_7_0 then
		gohelper.setActive(var_7_0.go, true)

		local var_7_1 = (arg_7_2 - 1) * 244 - 100
		local var_7_2 = -((arg_7_2 - 1) * 73 + 52)

		recthelper.setAnchor(var_7_0.transform, var_7_1, var_7_2)
	end
end

function var_0_0.checkFinish(arg_8_0)
	local var_8_0 = arg_8_0:getRotationZ()

	if var_8_0 > 160 and var_8_0 < 200 then
		arg_8_0:finished()
	end
end

function var_0_0.finished(arg_9_0)
	if arg_9_0.inDrag then
		return
	end

	arg_9_0._canDrag = false

	if arg_9_0.gyro then
		arg_9_0.gyro:closeGyro()
	end

	arg_9_0:stopCheckTips()
	arg_9_0:killTweenId()
	arg_9_0:playFinishAnim()
end

function var_0_0.playFinishAnim(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemList) do
		local var_10_0, var_10_1, var_10_2 = transformhelper.getPos(iter_10_1.itemTransform)

		iter_10_1.downDir = Vector3.down
		iter_10_1.initPos = {
			var_10_0,
			var_10_1,
			var_10_2
		}

		iter_10_1.anim:Play("open", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_barrier_fall)

	arg_10_0.moveTweenId = ZProj.TweenHelper.DOTweenFloat(0, 10, 0.84, arg_10_0._itemFrameMove, arg_10_0._onFinishAnimEnd, arg_10_0, nil, EaseType.Linear)
end

function var_0_0._itemFrameMove(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.itemList) do
		local var_11_0 = iter_11_1.downDir * arg_11_1
		local var_11_1 = var_11_0.x + iter_11_1.initPos[1]
		local var_11_2 = var_11_0.y + iter_11_1.initPos[2]
		local var_11_3 = var_11_0.z + iter_11_1.initPos[3]

		transformhelper.setPos(iter_11_1.itemTransform, var_11_1, var_11_2, var_11_3)
	end
end

function var_0_0._onFinishAnimEnd(arg_12_0)
	arg_12_0:resetGOList()
	gohelper.setActive(arg_12_0._puzzleGO, false)
	gohelper.setActive(arg_12_0._shapeGO, false)
	arg_12_0:playSuccessTalk()
end

function var_0_0.canDrag(arg_13_0)
	return arg_13_0._canDrag
end

function var_0_0.getRotationZ(arg_14_0, arg_14_1)
	local var_14_0, var_14_1, var_14_2 = transformhelper.getLocalRotation(arg_14_1 or arg_14_0._dragTrs)

	return var_14_2
end

function var_0_0.vector2Angle(arg_15_0, arg_15_1)
	return Mathf.Atan2(arg_15_1.y - arg_15_0.initPos.y, arg_15_1.x - arg_15_0.initPos.x) / Mathf.PI * 180
end

function var_0_0._onBeginDrag(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0:canDrag() then
		arg_16_0.inDrag = false

		return
	end

	arg_16_0:killTweenId()

	arg_16_0.angleRecord = arg_16_0:getRotationZ()
	arg_16_0.clickRecord = arg_16_0:vector2Angle(arg_16_2.position)
	arg_16_0.inDrag = true
end

function var_0_0._onDrag(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0:canDrag() then
		arg_17_0.inDrag = false

		return
	end

	local var_17_0 = arg_17_0:vector2Angle(arg_17_2.position)
	local var_17_1 = arg_17_0.angleRecord + var_17_0 - arg_17_0.clickRecord

	arg_17_0:_tweenToRotation(arg_17_0._dragTrs, var_17_1)
	arg_17_0:_tween2ToRotation(arg_17_0.mainTrs, var_17_1)

	arg_17_0.inDrag = true
end

function var_0_0._onEndDrag(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:startCheckTips()

	arg_18_0.inDrag = false

	if not arg_18_0:canDrag() then
		return
	end

	arg_18_0:killTweenId()
	arg_18_0:checkFinish()
end

function var_0_0._onDragTweenEnd(arg_19_0)
	return
end

function var_0_0._tweenToRotation(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	if arg_20_0.tweenId then
		ZProj.TweenHelper.KillById(arg_20_0.tweenId)

		arg_20_0.tweenId = nil
	end

	local var_20_0 = arg_20_0:getRotationZ(arg_20_1)

	if math.abs(var_20_0 - arg_20_2) > 1 then
		arg_20_0.tweenId = ZProj.TweenHelper.DOLocalRotate(arg_20_1, 0, 0, arg_20_2, 0.16, arg_20_3, arg_20_4, arg_20_5)
	else
		transformhelper.setLocalRotation(arg_20_1, 0, 0, arg_20_2)

		if arg_20_3 then
			arg_20_3(arg_20_4, arg_20_5)
		end
	end
end

function var_0_0._tween2ToRotation(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	if arg_21_0.tweenId2 then
		ZProj.TweenHelper.KillById(arg_21_0.tweenId2)

		arg_21_0.tweenId2 = nil
	end

	local var_21_0 = arg_21_0:getRotationZ(arg_21_1)

	if math.abs(var_21_0 - arg_21_2) > 1 then
		arg_21_0.tweenId2 = ZProj.TweenHelper.DOLocalRotate(arg_21_1, 0, 0, arg_21_2, 0.16, arg_21_3, arg_21_4, arg_21_5)
	else
		transformhelper.setLocalRotation(arg_21_1, 0, 0, arg_21_2)

		if arg_21_3 then
			arg_21_3(arg_21_4, arg_21_5)
		end
	end
end

function var_0_0.killTweenId(arg_22_0)
	if arg_22_0.tweenId then
		ZProj.TweenHelper.KillById(arg_22_0.tweenId)

		arg_22_0.tweenId = nil
	end

	if arg_22_0.tweenId2 then
		ZProj.TweenHelper.KillById(arg_22_0.tweenId2)

		arg_22_0.tweenId2 = nil
	end

	if arg_22_0.moveTweenId then
		ZProj.TweenHelper.KillById(arg_22_0.moveTweenId)

		arg_22_0.moveTweenId = nil
	end
end

function var_0_0.playTipsTalk(arg_23_0)
	arg_23_0:playTalk(arg_23_0.config.tipsTalkId, arg_23_0.startCheckTalk, arg_23_0, true, true)
end

function var_0_0.onDestroyView(arg_24_0)
	if arg_24_0._drag then
		arg_24_0._drag:RemoveDragBeginListener()
		arg_24_0._drag:RemoveDragListener()
		arg_24_0._drag:RemoveDragEndListener()
	end

	if arg_24_0.gyro then
		arg_24_0.gyro:closeGyro()
	end

	arg_24_0:killTweenId()
	gohelper.setActive(arg_24_0._puzzleGO, false)
	gohelper.setActive(arg_24_0._shapeGO, false)
	arg_24_0:resetGOList()
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetSceneUpdatePos, false)
end

return var_0_0
