module("modules.logic.battlepass.view.BpTaskItem", package.seeall)

local var_0_0 = class("BpTaskItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtTaskDesc = gohelper.findChildText(arg_1_0.go, "#txt_taskdes")
	arg_1_0._txtTaskTotal = gohelper.findChildText(arg_1_0.go, "#txt_taskdes/#txt_total")
	arg_1_0._goNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_notget/#btn_notfinishbg")
	arg_1_0._goFinishBg = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_notget/#btn_finishbg", AudioEnum.UI.play_ui_permit_receive_button)
	arg_1_0._simageFinish2 = gohelper.findChildSingleImage(arg_1_0.go, "#go_notget/#btn_finishbg/#simage_getmask")
	arg_1_0._goAllFinish = gohelper.findChild(arg_1_0.go, "#go_notget/#go_allfinish")
	arg_1_0._simageFinish = gohelper.findChildSingleImage(arg_1_0.go, "#go_notget/#go_allfinish/#simage_getmask")
	arg_1_0._gobonus = gohelper.findChild(arg_1_0.go, "#go_bonus")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.go, "#simage_bg")
	arg_1_0._goremaintime = gohelper.findChild(arg_1_0.go, "#go_remaintime")
	arg_1_0._txtremaintime = gohelper.findChildTextMesh(arg_1_0.go, "#go_remaintime/bg/icon/#txt_remaintime")
	arg_1_0._goturnback = gohelper.findChild(arg_1_0.go, "#go_turnback")
	arg_1_0._gonewbie = gohelper.findChild(arg_1_0.go, "#go_newbie")

	arg_1_0._simageFinish:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	arg_1_0._simageFinish2:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))

	arg_1_0._animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gobonusItem = gohelper.findChild(arg_1_0._gobonus, "#go_item")
	arg_1_0._gobonusExpup = gohelper.findChild(arg_1_0._gobonus, "#go_expup")
	arg_1_0._gobonusExpupTxt = gohelper.findChildText(arg_1_0._gobonusExpup, "#txt_num")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._goNotFinish:AddClickListener(arg_2_0._goNotFinishOnClick, arg_2_0)
	arg_2_0._goFinishBg:AddClickListener(arg_2_0._goFinishBgOnClick, arg_2_0)
	arg_2_0:addEventCb(arg_2_0._view.viewContainer, BpEvent.OnTaskFinishAnim, arg_2_0.playFinishAnim, arg_2_0)
	arg_2_0:addEventCb(arg_2_0._view.viewContainer, BpEvent.TapViewOpenAnimBegin, arg_2_0.onTabOpen, arg_2_0)
	arg_2_0:addEventCb(arg_2_0._view.viewContainer, BpEvent.TapViewCloseAnimBegin, arg_2_0.onTabClose, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._goNotFinish:RemoveClickListener()
	arg_3_0._goFinishBg:RemoveClickListener()
	arg_3_0:removeEventCb(arg_3_0._view.viewContainer, BpEvent.OnTaskFinishAnim, arg_3_0.playFinishAnim, arg_3_0)
	arg_3_0:removeEventCb(arg_3_0._view.viewContainer, BpEvent.TapViewOpenAnimBegin, arg_3_0.onTabOpen, arg_3_0)
	arg_3_0:removeEventCb(arg_3_0._view.viewContainer, BpEvent.TapViewCloseAnimBegin, arg_3_0.onTabClose, arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0.mo = arg_4_1
	arg_4_0._txtTaskDesc.text = arg_4_0.mo.config.desc
	arg_4_0._txtTaskTotal.text = string.format("%s/%s", arg_4_0.mo.progress, arg_4_0.mo.config.maxProgress)

	local var_4_0 = arg_4_0.mo.progress
	local var_4_1 = arg_4_0.mo.config.maxProgress
	local var_4_2 = arg_4_0.mo.config.loopType <= 2 and BpModel.instance:isWeeklyScoreFull()

	gohelper.setActive(arg_4_0._goNotFinish.gameObject, not var_4_2 and var_4_0 < var_4_1 and arg_4_0.mo.config.jumpId > 0)
	gohelper.setActive(arg_4_0._goFinishBg.gameObject, not var_4_2 and var_4_1 <= var_4_0 and arg_4_0.mo.finishCount == 0)
	gohelper.setActive(arg_4_0._goAllFinish, var_4_2 or arg_4_0.mo.finishCount > 0)
	gohelper.setActive(arg_4_0._goturnback, arg_4_1.config.turnbackTask)
	gohelper.setActive(arg_4_0._gonewbie, arg_4_1.config.newbieTask)

	local var_4_3 = -1

	if not string.nilorempty(arg_4_0.mo.config.startTime) and not string.nilorempty(arg_4_0.mo.config.endTime) and arg_4_0.mo.finishCount <= 0 then
		var_4_3 = TimeUtil.stringToTimestamp(arg_4_0.mo.config.endTime)
		var_4_3 = var_4_3 - ServerTime.now()
	end

	if var_4_3 > 0 then
		gohelper.setActive(arg_4_0._goremaintime, true)

		if var_4_3 > 3600 then
			local var_4_4 = math.floor(var_4_3 / 86400)
			local var_4_5 = math.floor(var_4_3 % 86400 / 3600)

			arg_4_0._txtremaintime.text = formatLuaLang("remain", string.format("%d%s%d%s", var_4_4, luaLang("time_day"), var_4_5, luaLang("time_hour")))
		else
			arg_4_0._txtremaintime.text = luaLang("not_enough_one_hour")
		end
	else
		gohelper.setActive(arg_4_0._goremaintime, false)
	end

	local var_4_6 = GameUtil.calcByDeltaRate1000AsInt(arg_4_0.mo.config.bonusScore, arg_4_0.mo.config.bonusScoreTimes)

	if not arg_4_0.bonusItem then
		local var_4_7 = IconMgr.instance:getCommonPropItemIcon(arg_4_0._gobonusItem)

		gohelper.setAsFirstSibling(var_4_7.go)
		var_4_7:setMOValue(1, BpEnum.ScoreItemId, var_4_6, nil, true)
		var_4_7:setCountFontSize(36)
		var_4_7:setScale(0.54)
		var_4_7:SetCountLocalY(42)
		var_4_7:SetCountBgHeight(22)
		var_4_7:showStackableNum2()
		var_4_7:setHideLvAndBreakFlag(true)
		var_4_7:hideEquipLvAndBreak(true)

		arg_4_0.bonusItem = var_4_7
	else
		arg_4_0.bonusItem:setMOValue(1, BpEnum.ScoreItemId, var_4_6, nil, true)
	end

	arg_4_0:_refreshExpup()
end

function var_0_0.onTabClose(arg_5_0, arg_5_1)
	if arg_5_1 == 2 then
		arg_5_0._animator:Play(UIAnimationName.Close)
	end
end

function var_0_0.onTabOpen(arg_6_0, arg_6_1)
	if arg_6_1 == 2 then
		arg_6_0._animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0._goNotFinishOnClick(arg_7_0)
	local var_7_0 = arg_7_0.mo.config.jumpId

	if var_7_0 ~= 0 then
		GameFacade.jump(var_7_0)
	end
end

function var_0_0._goFinishBgOnClick(arg_8_0)
	UIBlockMgr.instance:startBlock("BpTaskItemFinish")
	TaskDispatcher.runDelay(arg_8_0.finishTask, arg_8_0, BpEnum.TaskMaskTime)
	arg_8_0._view.viewContainer:dispatchEvent(BpEvent.OnTaskFinishAnim, arg_8_0._index)
end

function var_0_0.playFinishAnim(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1 ~= arg_9_0._index then
		return
	end

	if not arg_9_0._goFinishBg.gameObject.activeSelf then
		return
	end

	arg_9_0._animator:Play("get", 0, 0)
end

function var_0_0.finishTask(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.finishTask, arg_10_0)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskRpc.instance:sendFinishTaskRequest(arg_10_0.mo.id)
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.finishTask, arg_11_0)

	if arg_11_0.bonusItem then
		arg_11_0.bonusItem:onDestroy()
	end

	arg_11_0._simageFinish:UnLoadImage()
	arg_11_0._simageFinish2:UnLoadImage()
end

function var_0_0._refreshExpup(arg_12_0)
	local var_12_0 = 1000 + (arg_12_0.mo.config.bonusScoreTimes or 0)
	local var_12_1 = var_12_0 > 1000

	if var_12_1 then
		local var_12_2 = GameUtil.convertToPercentStr(var_12_0)

		arg_12_0._gobonusExpupTxt.text = var_12_2
	end

	gohelper.setActive(arg_12_0._gobonusExpup, var_12_1)
end

return var_0_0
