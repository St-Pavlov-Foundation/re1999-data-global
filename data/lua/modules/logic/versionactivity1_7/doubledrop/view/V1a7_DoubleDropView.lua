module("modules.logic.versionactivity1_7.doubledrop.view.V1a7_DoubleDropView", package.seeall)

local var_0_0 = class("V1a7_DoubleDropView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_time/#go_deadline2/#txt_deadline2")
	arg_1_0._txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_desc/#scroll_desc/Viewport/#txt_desc")
	arg_1_0._txtTotalTimes = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_times/go_total/#txt_totaltimes")
	arg_1_0._goToday = gohelper.findChild(arg_1_0.viewGO, "go_times/go_today")
	arg_1_0._txtTotalDayTimes = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_times/go_today/#txt_totalday")
	arg_1_0._btnJump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnJump, arg_2_0._onClickJump, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnJump)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0.actId = arg_5_0.viewParam.actId

	arg_5_0:refresh()
end

function var_0_0.onOpen(arg_6_0)
	StatController.instance:track(StatEnum.EventName.EnterDoubleEquip)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_page_turn)

	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)

	arg_6_0.actId = arg_6_0.viewParam.actId

	arg_6_0:refresh()
end

function var_0_0.refresh(arg_7_0)
	local var_7_0 = arg_7_0.actId
	local var_7_1 = DoubleDropModel.instance:getById(var_7_0)
	local var_7_2 = var_7_1 and var_7_1.totalCount or 0
	local var_7_3 = var_7_1 and var_7_1.config and var_7_1.config.totalLimit or 0
	local var_7_4 = var_7_3 - var_7_2

	if var_7_4 > 0 then
		arg_7_0._txtTotalTimes.text = string.format("<color=#DE9854>%s</color>/%s", var_7_4, var_7_3)
	else
		arg_7_0._txtTotalTimes.text = string.format("<color=#BF2E11>%s</color>/%s", var_7_4, var_7_3)
	end

	local var_7_5, var_7_6 = DoubleDropModel.instance:getDailyRemainTimes(var_7_0)

	if var_7_5 > 0 then
		arg_7_0._txtTotalDayTimes.text = string.format("<color=#DE9854>%s</color>/%s", var_7_5, var_7_6)
	else
		arg_7_0._txtTotalDayTimes.text = string.format("<color=#BF2E11>%s</color>/%s", var_7_5, var_7_6)
	end

	gohelper.setActive(arg_7_0._goToday, var_7_4 > 0)

	local var_7_7 = ActivityConfig.instance:getActivityCo(var_7_0)

	arg_7_0._txtDesc.text = var_7_7 and var_7_7.actDesc or ""

	arg_7_0:refreshRemainTime()
	TaskDispatcher.cancelTask(arg_7_0.refreshRemainTime, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0.refreshRemainTime, arg_7_0, 1)
end

function var_0_0.refreshRemainTime(arg_8_0)
	local var_8_0 = ActivityModel.instance:getActMO(arg_8_0.actId)

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0:getRealEndTimeStamp() - ServerTime.now()

	if var_8_1 > 0 then
		local var_8_2 = TimeUtil.SecondToActivityTimeFormat(var_8_1)

		arg_8_0._txtTime.text = var_8_2
	else
		arg_8_0._txtTime.text = luaLang("ended")
	end
end

function var_0_0._onClickJump(arg_9_0)
	GameFacade.jump(3601)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.refreshRemainTime, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
