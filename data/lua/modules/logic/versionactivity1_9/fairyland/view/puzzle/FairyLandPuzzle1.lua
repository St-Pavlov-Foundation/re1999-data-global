module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle1", package.seeall)

local var_0_0 = class("FairyLandPuzzle1", FairyLandPuzzleBase)

var_0_0.ZeroVector2 = Vector2(0, 0)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._puzzleGO = gohelper.findChild(arg_1_0.viewGO, "main/#go_Root/#go_Puzzle/1")
	arg_1_0._shapeGO = gohelper.findChild(arg_1_0.viewGO, "main/#go_Shape/1")
	arg_1_0.tipAnim = SLFramework.AnimatorPlayer.Get(arg_1_0._shapeGO)
	arg_1_0._shapeTrs = arg_1_0._shapeGO.transform
	arg_1_0._goImageShape = gohelper.findChild(arg_1_0._shapeGO, "image_shape")
	arg_1_0._dragTrs = arg_1_0._goImageShape.transform

	arg_1_0:addDrag(arg_1_0._goImageShape)

	arg_1_0.itemList = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		var_1_0.go = gohelper.findChild(arg_1_0._puzzleGO, "item" .. tostring(iter_1_0))
		var_1_0.anim = var_1_0.go:GetComponent(typeof(UnityEngine.Animator))
		arg_1_0.itemList[iter_1_0] = var_1_0
	end

	arg_1_0.limitPos = 30
	arg_1_0.shakeLimitPos = 15
	arg_1_0.initPos = arg_1_0._dragTrs.anchoredPosition
	arg_1_0.lastDistance = 0
	arg_1_0.shakeFinishTime = 3
	arg_1_0.shakeTime = 0
end

function var_0_0.addDrag(arg_2_0, arg_2_1)
	if arg_2_0._drag then
		return
	end

	arg_2_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_2_1)

	arg_2_0._drag:AddDragBeginListener(arg_2_0._onBeginDrag, arg_2_0, arg_2_1.transform)
	arg_2_0._drag:AddDragListener(arg_2_0._onDrag, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onEndDrag, arg_2_0, arg_2_1.transform)
end

function var_0_0.onStart(arg_3_0)
	local var_3_0 = FairyLandModel.instance:isPassPuzzle(arg_3_0.config.id)

	arg_3_0._canDrag = not var_3_0

	gohelper.setActive(arg_3_0._puzzleGO, not var_3_0)
	gohelper.setActive(arg_3_0._shapeGO, not var_3_0)

	arg_3_0.finishDict = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.finishDict[iter_3_0] = var_3_0
	end

	arg_3_0:setItemPos(1, 11)
	arg_3_0:setItemPos(2, 12)
	arg_3_0:setItemPos(3, 13)

	if var_3_0 then
		if arg_3_0.gyro then
			arg_3_0.gyro:closeGyro()
		end
	else
		arg_3_0:startGyro()
	end

	arg_3_0:startCheckTips()
end

function var_0_0.startGyro(arg_4_0)
	if arg_4_0.gyro then
		return
	end

	arg_4_0.gyro = FairyLandGyroComp.New()

	local var_4_0 = {
		callback = arg_4_0.frameUpdate,
		callbackObj = arg_4_0,
		go = arg_4_0._goImageShape,
		posLimit = arg_4_0.limitPos
	}

	arg_4_0.gyro:init(var_4_0)
end

function var_0_0.setItemPos(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.itemList[arg_5_1]

	if var_5_0 then
		gohelper.setActive(var_5_0.go, not arg_5_0.finishDict[arg_5_1])

		local var_5_1 = (arg_5_2 - 1) * 244 - 102
		local var_5_2 = -((arg_5_2 - 1) * 73 + 59)

		recthelper.setAnchor(var_5_0.go.transform, var_5_1, var_5_2)
	end
end

function var_0_0.moveItem(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList) do
		if not arg_6_0.finishDict[iter_6_0] then
			iter_6_1.anim:Play("move")

			iter_6_1.anim.speed = 1

			arg_6_0:playShakeAudio()

			break
		end
	end
end

function var_0_0.stopItem(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.itemList) do
		if not arg_7_0.finishDict[iter_7_0] then
			iter_7_1.anim.speed = 0

			arg_7_0:stopShakeAudio()

			break
		end
	end
end

function var_0_0.checkFinish(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.itemList) do
		if not arg_8_0.finishDict[iter_8_0] then
			arg_8_0:setItemFinish(iter_8_0)

			break
		end
	end
end

function var_0_0.setItemFinish(arg_9_0, arg_9_1)
	arg_9_0.finishDict[arg_9_1] = true

	local var_9_0 = arg_9_0.itemList[arg_9_1]

	if var_9_0 then
		var_9_0.anim:Play("close", 0, 0)

		var_9_0.anim.speed = 1

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bean_fall)
	end

	local var_9_1 = true

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemList) do
		if not arg_9_0.finishDict[iter_9_0] then
			var_9_1 = false

			break
		end
	end

	if var_9_1 then
		arg_9_0:stopShakeAudio()

		arg_9_0._canDrag = false

		if arg_9_0.gyro then
			arg_9_0.gyro:closeGyro()

			arg_9_0.gyro = nil
		end

		TaskDispatcher.runDelay(arg_9_0.onItemTweenFinish, arg_9_0, 2)
	end
end

function var_0_0.onItemTweenFinish(arg_10_0)
	gohelper.setActive(arg_10_0._puzzleGO, false)
	gohelper.setActive(arg_10_0._shapeGO, false)
	arg_10_0:playSuccessTalk()
end

function var_0_0.canDrag(arg_11_0)
	return arg_11_0._canDrag
end

function var_0_0._onBeginDrag(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0:canDrag() then
		arg_12_0.inDrag = false

		return
	end

	arg_12_0:killTweenId()

	local var_12_0 = arg_12_0:getDragPos(arg_12_2.position)

	arg_12_0.offsetPos = var_12_0

	arg_12_0:_tweenToPos(arg_12_0._dragTrs, var_12_0 - arg_12_0.offsetPos)

	arg_12_0.inDrag = true
	arg_12_0.shakeTime = 0
	arg_12_0.shaking = false
end

function var_0_0._onDrag(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0:canDrag() then
		arg_13_0.inDrag = false

		return
	end

	local var_13_0 = arg_13_0:getDragPos(arg_13_2.position)

	arg_13_0:_tweenToPos(arg_13_0._dragTrs, var_13_0 - arg_13_0.offsetPos)

	arg_13_0.inDrag = true
end

function var_0_0._onEndDrag(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.inDrag = false
	arg_14_0.shaking = false
	arg_14_0.shakeTime = 0

	if not arg_14_0:canDrag() then
		return
	end

	arg_14_0:killTweenId()

	local var_14_0 = var_0_0.ZeroVector2

	arg_14_0:_tweenToPos(arg_14_0._dragTrs, var_14_0, arg_14_0._onDragTweenEnd, arg_14_0)
end

function var_0_0._onDragTweenEnd(arg_15_0)
	return
end

function var_0_0.frameUpdate(arg_16_0)
	arg_16_0:checkShake()

	if arg_16_0.shaking then
		arg_16_0:onShake()
	else
		arg_16_0:stopItem()
	end
end

function var_0_0.checkShake(arg_17_0)
	local var_17_0 = arg_17_0._dragTrs.anchoredPosition

	if not arg_17_0.lastPos then
		arg_17_0.lastPos = var_17_0
	end

	arg_17_0.shaking = Vector2.Distance(arg_17_0.lastPos, var_17_0) > 0.1
	arg_17_0.lastPos = var_17_0
end

function var_0_0.getDragPos(arg_18_0, arg_18_1)
	return (recthelper.screenPosToAnchorPos(arg_18_1, arg_18_0._shapeTrs))
end

function var_0_0._tweenToPos(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	if arg_19_0.posTweenId then
		ZProj.TweenHelper.KillById(arg_19_0.posTweenId)

		arg_19_0.posTweenId = nil
	end

	local var_19_0 = arg_19_0:clampPos(arg_19_2)
	local var_19_1, var_19_2 = recthelper.getAnchor(arg_19_1)

	if math.abs(var_19_1 - var_19_0.x) > 10 or math.abs(var_19_2 - var_19_0.y) > 10 then
		arg_19_0.posTweenId = ZProj.TweenHelper.DOAnchorPos(arg_19_1, var_19_0.x, var_19_0.y, 0.16, arg_19_3, arg_19_4, arg_19_5)
	else
		recthelper.setAnchor(arg_19_1, var_19_0.x, var_19_0.y)

		if arg_19_3 then
			arg_19_3(arg_19_4, arg_19_5)
		end
	end
end

function var_0_0.clampPos(arg_20_0, arg_20_1)
	if Vector2.Distance(arg_20_0.initPos, arg_20_1) < arg_20_0.limitPos then
		return arg_20_1
	end

	local var_20_0 = arg_20_1 - arg_20_0.initPos

	return arg_20_0.initPos + var_20_0.normalized * arg_20_0.limitPos
end

function var_0_0.onShake(arg_21_0)
	arg_21_0.shakeTime = arg_21_0.shakeTime + Time.deltaTime * 0.9

	if arg_21_0.shakeTime >= arg_21_0.shakeFinishTime then
		arg_21_0.shakeTime = 0
		arg_21_0.shaking = false

		arg_21_0:checkFinish()
	else
		arg_21_0:moveItem()
	end
end

function var_0_0.killTweenId(arg_22_0)
	if arg_22_0.posTweenId then
		ZProj.TweenHelper.KillById(arg_22_0.posTweenId)

		arg_22_0.posTweenId = nil
	end
end

function var_0_0.playShakeAudio(arg_23_0)
	if arg_23_0.playingId then
		return
	end

	arg_23_0.playingId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bean_shaking)
end

function var_0_0.stopShakeAudio(arg_24_0)
	if arg_24_0.playingId then
		AudioMgr.instance:stopPlayingID(arg_24_0.playingId)

		arg_24_0.playingId = nil
	end
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0:stopShakeAudio()

	if arg_25_0._drag then
		arg_25_0._drag:RemoveDragBeginListener()
		arg_25_0._drag:RemoveDragListener()
		arg_25_0._drag:RemoveDragEndListener()
	end

	if arg_25_0.gyro then
		arg_25_0.gyro:closeGyro()

		arg_25_0.gyro = nil
	end

	arg_25_0:killTweenId()
	gohelper.setActive(arg_25_0._puzzleGO, false)
	gohelper.setActive(arg_25_0._shapeGO, false)
	TaskDispatcher.cancelTask(arg_25_0.onItemTweenFinish, arg_25_0)
end

return var_0_0
