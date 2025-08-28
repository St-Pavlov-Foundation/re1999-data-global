module("modules.logic.fightuiswitch.view.FightUISwitchEffectComp", package.seeall)

local var_0_0 = class("FightUISwitchEffectComp", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrolleffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_effect")
	arg_1_0._goeffectItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_effect/Viewport/Content/#go_effectItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	gohelper.setActive(arg_2_0._goeffectItem, false)
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.viewGO = arg_3_1
	arg_3_0._showResObjTb = nil
	arg_3_0._sceneParent = nil

	arg_3_0:onInitView()

	arg_3_0._effectItems = arg_3_0:getUserDataTb_()
	arg_3_0._showResObjTb = arg_3_0:getUserDataTb_()

	arg_3_0:addEvent()
end

function var_0_0.addEvent(arg_4_0)
	FightUISwitchController.instance:registerCallback(FightUISwitchEvent.LoadFinish, arg_4_0._loadFinish, arg_4_0)
end

function var_0_0.removeEvent(arg_5_0)
	FightUISwitchController.instance:unregisterCallback(FightUISwitchEvent.LoadFinish, arg_5_0._loadFinish, arg_5_0)
end

function var_0_0._loadFinish(arg_6_0, arg_6_1)
	if arg_6_0._viewName ~= arg_6_1 then
		return
	end

	local var_6_0 = arg_6_0:_getSceneRes()
	local var_6_1 = FightUISwitchController.instance:getRes(var_6_0)

	if var_6_1 and arg_6_0._sceneParent then
		local var_6_2 = arg_6_0._showResObjTb[var_6_0]
		local var_6_3

		if not var_6_2 or not var_6_2.resObj then
			var_6_2 = arg_6_0:getUserDataTb_()
			var_6_2.resObj = gohelper.clone(var_6_1, arg_6_0._sceneParent)

			recthelper.setAnchor(var_6_2.resObj.transform, 0, 0)
			gohelper.setActive(var_6_2.resObj, true)

			arg_6_0._showResObjTb[var_6_0] = var_6_2
		end

		local var_6_4 = var_6_2.resObj

		if var_6_2 and not var_6_2.effectSceneTb then
			var_6_2.effectSceneTb = arg_6_0:getUserDataTb_()

			for iter_6_0, iter_6_1 in ipairs(arg_6_0._effectMoList) do
				if not string.nilorempty(iter_6_1.co.res) then
					local var_6_5 = gohelper.findChild(var_6_4.gameObject, iter_6_1.co.res)

					if not arg_6_0._effectSceneTb then
						arg_6_0._effectSceneTb = arg_6_0:getUserDataTb_()
					end

					local var_6_6 = arg_6_0._effectSceneTb[var_6_0] or arg_6_0:getUserDataTb_()

					if not var_6_6[iter_6_1.co.res] then
						var_6_6[iter_6_1.co.res] = arg_6_0:getUserDataTb_()
						var_6_6[iter_6_1.co.res].root = var_6_5
						var_6_6[iter_6_1.co.res].anim = var_6_5:GetComponent(typeof(UnityEngine.Animator))
						arg_6_0._effectSceneTb[var_6_0] = var_6_6
					end
				end
			end
		end

		for iter_6_2, iter_6_3 in pairs(arg_6_0._showResObjTb) do
			gohelper.setActive(iter_6_3.resObj, iter_6_2 == var_6_0)
		end

		arg_6_0:_runRepeatEffectAnim()
	end
end

function var_0_0.setViewAnim(arg_7_0, arg_7_1)
	arg_7_0._viewAnimator = arg_7_1
end

function var_0_0.refreshEffect(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._sceneParent = arg_8_1
	arg_8_2 = arg_8_2 or FightUISwitchModel.instance:getCurStyleMo()
	arg_8_0._mo = arg_8_2
	arg_8_0._viewName = arg_8_3
	arg_8_0._effectMoList = arg_8_2:getAllEffectMos()

	arg_8_0:clearEffectAnim()
	arg_8_0:_loadScene()

	if arg_8_0._effectMoList then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._effectMoList) do
			local var_8_0 = arg_8_0:_getEffectItem(iter_8_0)

			var_8_0:onUpdateMO(iter_8_1, iter_8_0)
			var_8_0:addBtnListeners(arg_8_0._clickEffectBtn, arg_8_0)
			var_8_0:setTxt(iter_8_1:getName())
		end

		for iter_8_2 = 1, #arg_8_0._effectItems do
			arg_8_0._effectItems[iter_8_2]:setActive(iter_8_2 <= #arg_8_0._effectMoList)
		end
	end

	arg_8_0:_showCurEffect(1)
end

function var_0_0._getEffectItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._effectItems[arg_9_1]

	if not var_9_0 then
		local var_9_1 = gohelper.cloneInPlace(arg_9_0._goeffectItem, "effect_" .. arg_9_1)

		var_9_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, MainSwitchClassifyItem)
		arg_9_0._effectItems[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0._loadScene(arg_10_0)
	if not arg_10_0._sceneParent or not arg_10_0._mo then
		return
	end

	FightUISwitchController.instance:loadRes(arg_10_0._mo.id, arg_10_0._viewName)
end

function var_0_0._getSceneRes(arg_11_0)
	return (FightUISwitchModel.instance:getSceneRes(arg_11_0._mo:getConfig(), arg_11_0._viewName))
end

function var_0_0._refreshEffectSceneRoot(arg_12_0)
	local var_12_0 = arg_12_0._showEffectMo.co.res
	local var_12_1 = arg_12_0:_getSceneRes()

	if arg_12_0._effectSceneTb and arg_12_0._effectSceneTb[var_12_1] then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._effectSceneTb[var_12_1]) do
			if iter_12_1.root then
				gohelper.setActive(iter_12_1.root, iter_12_0 == var_12_0)
			end
		end
	end
end

function var_0_0._runRepeatEffectAnim(arg_13_0)
	arg_13_0._showEffectIndex = 0

	arg_13_0:_playEffectAnim()
end

function var_0_0._playEffectAnim(arg_14_0)
	local var_14_0 = arg_14_0._showEffectIndex + 1

	if var_14_0 > #arg_14_0._effectMoList then
		var_14_0 = 1
	end

	local var_14_1 = var_14_0 or arg_14_0._showEffectIndex

	arg_14_0:_showCurEffect(var_14_1)

	local var_14_2 = arg_14_0:_getEffectDelayTime()

	TaskDispatcher.runDelay(arg_14_0._showNextEffect, arg_14_0, var_14_2)
end

function var_0_0._showNextEffect(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._playEffectAnim, arg_15_0)

	if arg_15_0._viewAnimator then
		arg_15_0._viewAnimator:Play(FightUISwitchEnum.AnimKey.Switch, 0, 0)
		TaskDispatcher.runDelay(arg_15_0._playEffectAnim, arg_15_0, FightUISwitchEnum.SwitchAnimDelayTime)
	else
		arg_15_0:_playEffectAnim()
	end
end

function var_0_0._getCurShowEffectSceneRootTb(arg_16_0)
	local var_16_0 = arg_16_0:_getSceneRes()
	local var_16_1 = arg_16_0._showEffectMo.co.res

	if arg_16_0._effectSceneTb and arg_16_0._effectSceneTb[var_16_0] then
		return arg_16_0._effectSceneTb[var_16_0][var_16_1]
	end
end

function var_0_0._showCurEffect(arg_17_0, arg_17_1)
	local var_17_0 = #arg_17_0._effectMoList

	if not arg_17_0._effectMoList or var_17_0 < arg_17_1 then
		return
	end

	arg_17_0._showEffectIndex = arg_17_1
	arg_17_0._showEffectMo = arg_17_0._effectMoList[arg_17_1]

	if not arg_17_0._showEffectMo then
		return
	end

	if arg_17_0._effectItems then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._effectItems) do
			iter_17_1:onSelectByIndex(arg_17_1)
		end
	end

	arg_17_0:_refreshEffectSceneRoot()

	local var_17_1
	local var_17_2 = arg_17_1 < 3 and 0 or arg_17_1 > var_17_0 - 3 and 1 or math.floor(arg_17_1 / var_17_0)

	arg_17_0._scrolleffect.horizontalNormalizedPosition = var_17_2
end

function var_0_0.clearEffectAnim(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._showNextEffect, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._playEffectAnim, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._repeatShowEffectAnim, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._repeatShowEffectAnimCB, arg_18_0)
end

function var_0_0._clickEffectBtn(arg_19_0, arg_19_1)
	arg_19_0:clearEffectAnim()

	if arg_19_0._showEffectIndex == arg_19_1 then
		return
	end

	arg_19_0._showEffectIndex = arg_19_1
	arg_19_0._repeatEffectTime = arg_19_0:_getEffectDelayTime()

	TaskDispatcher.cancelTask(arg_19_0._repeatShowEffectAnim, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._repeatShowEffectAnimCB, arg_19_0)

	if arg_19_0._viewAnimator then
		arg_19_0._viewAnimator:Play(FightUISwitchEnum.AnimKey.Switch, 0, 0)
		TaskDispatcher.runDelay(arg_19_0._repeatShowEffectAnim, arg_19_0, FightUISwitchEnum.SwitchAnimDelayTime)
	else
		arg_19_0:_repeatShowEffectAnim()
	end
end

function var_0_0._getEffectDelayTime(arg_20_0)
	local var_20_0 = FightUISwitchEnum.SwitchAnimTime
	local var_20_1 = arg_20_0:_getCurShowEffectSceneRootTb()

	if var_20_1 then
		if not var_20_1.delayLength then
			local var_20_2 = var_20_1.anim:GetCurrentAnimatorStateInfo(0).length

			var_20_1.delayLength = math.max(var_20_2, FightUISwitchEnum.SwitchAnimTime)
		end

		var_20_0 = var_20_1.delayLength
	end

	return var_20_0
end

function var_0_0._repeatShowEffectAnim(arg_21_0)
	arg_21_0:_showCurEffect(arg_21_0._showEffectIndex)
	TaskDispatcher.runRepeat(arg_21_0._repeatShowEffectAnimCB, arg_21_0, arg_21_0._repeatEffectTime)
end

function var_0_0._repeatShowEffectAnimCB(arg_22_0)
	local var_22_0 = arg_22_0:_getCurShowEffectSceneRootTb()

	if var_22_0 and var_22_0.anim then
		local var_22_1 = arg_22_0:_getAnimStateName(var_22_0)

		if not string.nilorempty(var_22_1) then
			var_22_0.anim:Play(var_22_1, 0, 0)
		else
			gohelper.setActive(var_22_0.anim.gameObject, false)
			gohelper.setActive(var_22_0.anim.gameObject, true)
		end
	end
end

function var_0_0._getAnimStateName(arg_23_0, arg_23_1)
	if not arg_23_1 or not arg_23_1.anim then
		return
	end

	if arg_23_1.stateName then
		return arg_23_1.stateName
	end

	local var_23_0 = arg_23_1.anim.runtimeAnimatorController.animationClips[0].name

	if arg_23_1.anim:GetCurrentAnimatorStateInfo(0).shortNameHash == UnityEngine.Animator.StringToHash(var_23_0) then
		arg_23_1.stateName = var_23_0

		return var_23_0
	end
end

function var_0_0.onClose(arg_24_0)
	arg_24_0:clearEffectAnim()

	arg_24_0._effectSceneRoot = nil

	arg_24_0:removeEvent()
end

function var_0_0.onDestroy(arg_25_0)
	arg_25_0:clearEffectAnim()

	arg_25_0._effectSceneRoot = nil
end

return var_0_0
