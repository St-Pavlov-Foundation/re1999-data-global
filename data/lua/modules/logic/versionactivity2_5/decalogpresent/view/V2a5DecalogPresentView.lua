module("modules.logic.versionactivity2_5.decalogpresent.view.V2a5DecalogPresentView", package.seeall)

local var_0_0 = class("V2a5DecalogPresentView", V1a9DecalogPresentView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0.btnMask = gohelper.findChildButton(arg_1_0.viewGO, "Mask")
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0.btnMask:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0.btnMask:RemoveClickListener()
end

function var_0_0.refreshRemainTime(arg_4_0)
	local var_4_0 = DecalogPresentModel.instance:getDecalogPresentActId()
	local var_4_1 = ActivityModel.instance:getActMO(var_4_0):getRemainTimeStr3(false, true)

	arg_4_0._txtremainTime.text = var_4_1
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshReceiveStatus()
	arg_5_0:refreshRemainTime()
	TaskDispatcher.cancelTask(arg_5_0.refreshRemainTime, arg_5_0)
	TaskDispatcher.runRepeat(arg_5_0.refreshRemainTime, arg_5_0, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_qiyuan_unlock_1)
end

return var_0_0
