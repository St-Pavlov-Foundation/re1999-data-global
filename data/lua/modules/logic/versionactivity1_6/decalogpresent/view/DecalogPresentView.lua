module("modules.logic.versionactivity1_6.decalogpresent.view.DecalogPresentView", package.seeall)

local var_0_0 = class("DecalogPresentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "image_TimeBG/#txt_remainTime")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Claim", AudioEnum.UI.Play_UI_Tags)
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Normal")
	arg_1_0._goHasReceived = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Received")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshReceiveStatus, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.refreshReceiveStatus, arg_3_0)
end

function var_0_0._btnClaimOnClick(arg_4_0)
	DecalogPresentController.instance:receiveDecalogPresent()
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshReceiveStatus()
	arg_8_0:refreshRemainTime()
	TaskDispatcher.cancelTask(arg_8_0.refreshRemainTime, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0.refreshRemainTime, arg_8_0, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)
end

function var_0_0.refreshRemainTime(arg_9_0)
	local var_9_0 = DecalogPresentModel.instance:getDecalogPresentActId()
	local var_9_1 = ActivityModel.instance:getActMO(var_9_0):getRemainTimeStr3(false, true)

	arg_9_0._txtremainTime.text = string.format(luaLang("remain"), var_9_1)
end

function var_0_0.refreshReceiveStatus(arg_10_0)
	local var_10_0 = DecalogPresentModel.instance:getDecalogPresentActId()
	local var_10_1 = DecalogPresentModel.REWARD_INDEX
	local var_10_2 = ActivityType101Model.instance:isType101RewardCouldGet(var_10_0, var_10_1)

	gohelper.setActive(arg_10_0._goNormal, var_10_2)
	gohelper.setActive(arg_10_0._goHasReceived, not var_10_2)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.refreshRemainTime, arg_12_0)
end

return var_0_0
