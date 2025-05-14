module("modules.common.others.LuaListScrollViewWithAnimator", package.seeall)

local var_0_0 = class("LuaListScrollViewWithAnimator", LuaListScrollView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._animationStartTime = nil
	arg_1_0._animationDelayTimes = arg_1_3
	arg_1_0._firstUpdate = true
	arg_1_0.dontPlayCloseAnimation = false
	arg_1_0.indexOffset = 0
end

function var_0_0.ResetFirstUpdate(arg_2_0)
	arg_2_0._firstUpdate = true
end

function var_0_0._getAnimationTime(arg_3_0, arg_3_1)
	if not arg_3_0._animationStartTime then
		return nil
	end

	arg_3_1 = arg_3_1 - arg_3_0.indexOffset

	if arg_3_1 < 1 then
		return nil
	end

	if not arg_3_0._animationDelayTimes or not arg_3_0._animationDelayTimes[arg_3_1] then
		return nil
	end

	return arg_3_0._animationStartTime + arg_3_0._animationDelayTimes[arg_3_1]
end

function var_0_0.playOpenAnimation(arg_4_0)
	arg_4_0._animationStartTime = Time.time

	arg_4_0:onModelUpdate()
end

function var_0_0.changeDelayTime(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_0._animationDelayTimes then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._animationDelayTimes) do
			arg_5_0._animationDelayTimes[iter_5_0] = iter_5_1 + arg_5_1
		end
	end
end

function var_0_0.onOpen(arg_6_0)
	var_0_0.super.onOpen(arg_6_0)

	if arg_6_0.viewContainer.notPlayAnimation then
		return
	end

	arg_6_0:playOpenAnimation()
end

function var_0_0.onClose(arg_7_0)
	var_0_0.super.onClose(arg_7_0)

	if arg_7_0.dontPlayCloseAnimation then
		return
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0._cellCompDict) do
		var_0_0._playCloseAnimation(iter_7_0)
	end
end

function var_0_0._onUpdateCell(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._firstUpdate then
		arg_8_0._firstUpdate = false
		arg_8_0._animationStartTime = Time.time
	end

	var_0_0.super._onUpdateCell(arg_8_0, arg_8_1, arg_8_2)

	local var_8_0 = gohelper.findChild(arg_8_1, LuaListScrollView.PrefabInstName)

	if not var_8_0 then
		return
	end

	local var_8_1 = MonoHelper.getLuaComFromGo(var_8_0, arg_8_0._param.cellClass)

	var_0_0._refreshOpenAnimation(var_8_1)
end

local var_0_1 = UnityEngine.Animator.StringToHash(UIAnimationName.Idle)

function var_0_0._refreshOpenAnimation(arg_9_0)
	if not arg_9_0 then
		return
	end

	if not arg_9_0.getAnimator then
		return
	end

	local var_9_0 = arg_9_0:getAnimator()

	if not var_9_0 or not var_9_0.gameObject.activeInHierarchy then
		return
	end

	local var_9_1 = arg_9_0._view:_getAnimationTime(arg_9_0._index)

	if not var_9_1 then
		var_9_0.speed = 0

		var_9_0:Play(UIAnimationName.Open, 0, 1)
		var_9_0:Update(0)
	else
		local var_9_2 = var_0_0._getOpenAnimLen(arg_9_0)

		if not var_9_2 or var_9_2 >= Time.time - var_9_1 or not var_0_0._haveIdleAnim(arg_9_0) then
			var_9_0.speed = 0

			var_9_0:Play(UIAnimationName.Open, 0, 0)
			var_9_0:Update(0)
		else
			var_9_0:Play(var_0_1, 0, 0)
		end

		var_0_0._delayPlayOpenAnimation(arg_9_0)
	end
end

function var_0_0._getOpenAnimLen(arg_10_0)
	if not arg_10_0 then
		return false
	end

	if arg_10_0.__openAnimLen ~= nil then
		return arg_10_0.__openAnimLen
	end

	if not arg_10_0.getAnimator then
		return false
	end

	local var_10_0 = arg_10_0:getAnimator().runtimeAnimatorController.animationClips

	for iter_10_0 = 0, var_10_0.Length - 1 do
		local var_10_1 = var_10_0[iter_10_0]

		if var_10_1.name:find(UIAnimationName.Open) then
			arg_10_0.__openAnimLen = math.abs(var_10_1.length)

			break
		end
	end

	arg_10_0.__openAnimLen = arg_10_0.__openAnimLen or false

	return arg_10_0.__openAnimLen
end

function var_0_0._haveIdleAnim(arg_11_0)
	if not arg_11_0 then
		return false
	end

	if not arg_11_0.getAnimator then
		return false
	end

	return arg_11_0:getAnimator():HasState(0, var_0_1)
end

function var_0_0._delayPlayOpenAnimation(arg_12_0)
	if not arg_12_0 then
		return
	end

	if not arg_12_0.getAnimator then
		return
	end

	local var_12_0 = arg_12_0:getAnimator()

	if not var_12_0 or not var_12_0.gameObject.activeInHierarchy then
		return
	end

	if not arg_12_0._view:_getAnimationTime(arg_12_0._index) then
		return
	end

	var_12_0.speed = 1

	local var_12_1 = arg_12_0._view:_getAnimationTime(arg_12_0._index)
	local var_12_2 = var_0_0._getOpenAnimLen(arg_12_0)

	if var_12_2 and var_12_2 < Time.time - var_12_1 and var_0_0._haveIdleAnim(arg_12_0) then
		var_12_0:Play(UIAnimationName.Idle, 0, 0)

		return
	end

	var_12_0:Play(UIAnimationName.Open, 0, 0)
	var_12_0:Update(0)

	local var_12_3 = var_12_0:GetCurrentAnimatorStateInfo(0).length

	if var_12_3 <= 0 then
		var_12_3 = 1
	end

	var_12_0:Play(UIAnimationName.Open, 0, (Time.time - var_12_1) / var_12_3)
	var_12_0:Update(0)
end

function var_0_0._playCloseAnimation(arg_13_0)
	if not arg_13_0 then
		return
	end

	if not arg_13_0.getAnimator then
		return
	end

	local var_13_0 = arg_13_0:getAnimator()

	if var_13_0 and var_13_0.gameObject.activeInHierarchy then
		var_13_0.speed = 1

		var_13_0:Play(UIAnimationName.Close, 0, 0)
	end
end

function var_0_0.moveToByCheckFunc(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if not arg_14_1 then
		return
	end

	local var_14_0 = arg_14_0._model:getList()

	if not var_14_0 then
		return
	end

	local var_14_1

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if arg_14_1(iter_14_1) then
			var_14_1 = iter_14_0

			break
		end
	end

	if not var_14_1 then
		return
	end

	arg_14_0:moveToByIndex(var_14_1, arg_14_2, arg_14_3, arg_14_4)
end

function var_0_0.moveToByIndex(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_0._csListScroll.gameObject:GetComponent(gohelper.Type_ScrollRect)
	local var_15_1 = var_15_0.content
	local var_15_2 = math.ceil(arg_15_1 / arg_15_0._param.lineCount)
	local var_15_3 = arg_15_0._param.scrollDir == ScrollEnum.ScrollDirV
	local var_15_4 = arg_15_0._param.startSpace
	local var_15_5 = var_15_3 and arg_15_0._param.cellSpaceV or arg_15_0._param.cellSpaceH
	local var_15_6 = var_15_3 and arg_15_0._param.cellHeight or arg_15_0._param.cellWidth
	local var_15_7 = var_15_4 + (var_15_2 - 1) * (var_15_5 + var_15_6)
	local var_15_8 = 0

	if var_15_3 then
		local var_15_9 = recthelper.getHeight(var_15_1) - recthelper.getHeight(var_15_0.transform)
		local var_15_10 = math.max(0, var_15_9)

		var_15_7 = math.min(var_15_10, var_15_7)
	else
		local var_15_11 = recthelper.getWidth(var_15_1) - recthelper.getWidth(var_15_0.transform)
		local var_15_12 = math.max(0, var_15_11)

		var_15_7 = math.min(var_15_12, var_15_7)
		var_15_7 = -var_15_7
	end

	if arg_15_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_15_0._moveTweenId)

		arg_15_0._moveTweenId = nil
	end

	if arg_15_2 and arg_15_2 > 0 then
		if var_15_3 then
			arg_15_0._moveTweenId = ZProj.TweenHelper.DOAnchorPosY(var_15_1, var_15_7, arg_15_2, arg_15_3, arg_15_4)
		else
			arg_15_0._moveTweenId = ZProj.TweenHelper.DOAnchorPosX(var_15_1, var_15_7, arg_15_2, arg_15_3, arg_15_4)
		end
	else
		if var_15_3 then
			recthelper.setAnchorY(var_15_1, var_15_7)
		else
			recthelper.setAnchorX(var_15_1, var_15_7)
		end

		if arg_15_3 then
			arg_15_3(arg_15_4)
		end
	end
end

return var_0_0
