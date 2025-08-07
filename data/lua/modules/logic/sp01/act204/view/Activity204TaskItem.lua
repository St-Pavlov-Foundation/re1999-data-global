module("modules.logic.sp01.act204.view.Activity204TaskItem", package.seeall)

local var_0_0 = class("Activity204TaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "txtIndex")
	arg_1_0.scrollDesc = gohelper.findChild(arg_1_0.viewGO, "#scroll_Desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#scroll_Desc/Viewport/Content/txt_Desc")
	arg_1_0.goReward = gohelper.findChild(arg_1_0.viewGO, "#go_reward")
	arg_1_0.txtNum = gohelper.findChildTextMesh(arg_1_0.goReward, "#txt_num")
	arg_1_0.btnCanget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_canget")
	arg_1_0.goReceive = gohelper.findChild(arg_1_0.viewGO, "btn/#go_finished")
	arg_1_0.btnJump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_jump")
	arg_1_0.goDoing = gohelper.findChild(arg_1_0.viewGO, "btn/#go_doing")
	arg_1_0.goLightBg = gohelper.findChild(arg_1_0.goReward, "go_lightbg")
	arg_1_0.gotime = gohelper.findChild(arg_1_0.viewGO, "time")
	arg_1_0.txttime = gohelper.findChildText(arg_1_0.viewGO, "time/#txt_time")
	arg_1_0.gosecretbg = gohelper.findChild(arg_1_0.viewGO, "#go_SecretBG")
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.isOpen = true

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnCanget:AddClickListener(arg_2_0.onClickBtnCanget, arg_2_0)
	arg_2_0.btnJump:AddClickListener(arg_2_0.onClickBtnJump, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnCanget:RemoveClickListener()
	arg_3_0.btnJump:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnCanget(arg_5_0)
	if not arg_5_0._mo or not arg_5_0._mo.canGetReward then
		return
	end

	arg_5_0.anim:Play("close", 0, 0)

	if arg_5_0._mo.isGlobalTask then
		TaskRpc.instance:sendFinishTaskRequest(arg_5_0.config.id)
	else
		Activity204Rpc.instance:sendFinishAct204TaskRequest(arg_5_0.config.activityId, arg_5_0.config.id)
	end
end

function var_0_0.onClickBtnJump(arg_6_0)
	if not arg_6_0._mo then
		return
	end

	local var_6_0 = arg_6_0._mo.config.jumpId

	if var_6_0 and var_6_0 ~= 0 then
		GameFacade.jump(var_6_0)
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0.scrollDesc.parentGameObject = arg_7_0._view._csListScroll.gameObject

	if arg_7_0.isOpen then
		arg_7_0.anim:Play("open", 0, 0)
	else
		arg_7_0.anim:Play("open", 0, 1)
	end

	arg_7_0.isOpen = false
	arg_7_0._mo = arg_7_1
	arg_7_0.config = arg_7_0._mo.config

	arg_7_0:refreshDesc()
	arg_7_0:refreshJump()
	arg_7_0:refreshReward()
	arg_7_0:refreshSecretTask()
	arg_7_0:refreshRemainTime()
end

function var_0_0.refreshDesc(arg_8_0)
	arg_8_0.txtIndex.text = string.format("%02d", arg_8_0._mo.index)

	local var_8_0 = Activity173Controller.numberDisplay(arg_8_0._mo.progress)
	local var_8_1 = Activity173Controller.numberDisplay(arg_8_0.config and arg_8_0.config.maxProgress or 0)

	arg_8_0.txtDesc.text = string.format("%s\n(%s/%s)", arg_8_0.config and arg_8_0.config.desc or "", var_8_0, var_8_1)
end

function var_0_0.refreshSecretTask(arg_9_0)
	arg_9_0._isSecretTask = not arg_9_0._mo.isGlobalTask and arg_9_0.config.secretornot ~= 0
	arg_9_0._isNewSecretTask = arg_9_0._isSecretTask and Activity204Controller.instance:getPlayerPrefs(arg_9_0:_getSecretTaskEffectKey(), 0) == 0

	gohelper.setActive(arg_9_0.gosecretbg, arg_9_0._isSecretTask)
	gohelper.setActive(arg_9_0.txtIndex.gameObject, not arg_9_0._isSecretTask)
	arg_9_0:tryPlaySecretEffect()
end

function var_0_0._getSecretTaskEffectKey(arg_10_0)
	return string.format("%s#%s", PlayerPrefsKey.Activity204SecretTaskEffect, arg_10_0.config.id)
end

function var_0_0.tryPlaySecretEffect(arg_11_0)
	if not arg_11_0._isNewSecretTask then
		return
	end

	arg_11_0.anim:Play("close", 0, 1)

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.Activity204TaskView) then
		return
	end

	arg_11_0.anim:Play("open_secret", 0, 0)

	arg_11_0._isNewSecretTask = false

	Activity204Controller.instance:setPlayerPrefs(arg_11_0:_getSecretTaskEffectKey(), 1)
end

function var_0_0.refreshJump(arg_12_0)
	local var_12_0 = arg_12_0._mo.canGetReward
	local var_12_1 = arg_12_0._mo.hasGetBonus

	gohelper.setActive(arg_12_0.btnCanget, var_12_0)
	gohelper.setActive(arg_12_0.goLightBg, var_12_0)
	gohelper.setActive(arg_12_0.goReceive, var_12_1)

	local var_12_2 = arg_12_0._mo.config.jumpId
	local var_12_3 = var_12_2 and var_12_2 ~= 0 and not var_12_0 and not var_12_1

	gohelper.setActive(arg_12_0.btnJump, var_12_3)

	local var_12_4 = not var_12_0 and not var_12_1 and not var_12_3

	gohelper.setActive(arg_12_0.goDoing, var_12_4)
end

function var_0_0.refreshReward(arg_13_0)
	local var_13_0 = (GameUtil.splitString2(arg_13_0.config and arg_13_0.config.bonus, true) or {})[1]

	arg_13_0.txtNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), var_13_0 and var_13_0[3] or 0)
end

function var_0_0.refreshRemainTime(arg_14_0)
	TaskDispatcher.runRepeat(arg_14_0.tickUpdateTaskRemainTime, arg_14_0, 1)
	arg_14_0:tickUpdateTaskRemainTime()
end

function var_0_0.tickUpdateTaskRemainTime(arg_15_0)
	local var_15_0 = (arg_15_0._mo.expireTime or 0) / 1000 - ServerTime.now()
	local var_15_1 = var_15_0 <= 0
	local var_15_2 = arg_15_0._mo.config.durationHour and arg_15_0._mo.config.durationHour ~= 0
	local var_15_3 = not var_15_1 and not arg_15_0._mo.hasGetBonus and var_15_2

	gohelper.setActive(arg_15_0.gotime, var_15_3)

	if not var_15_3 then
		TaskDispatcher.cancelTask(arg_15_0.tickUpdateTaskRemainTime, arg_15_0)

		return
	end

	arg_15_0.txttime.text = TimeUtil.secondToRoughTime3(var_15_0)
end

function var_0_0._onOpenViewFinish(arg_16_0)
	arg_16_0:tryPlaySecretEffect()
end

function var_0_0._onCloseViewFinish(arg_17_0)
	arg_17_0:tryPlaySecretEffect()
end

function var_0_0.onDestroyView(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.tickUpdateTaskRemainTime, arg_18_0)
end

return var_0_0
