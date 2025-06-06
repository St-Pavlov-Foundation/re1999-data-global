﻿module("modules.logic.versionactivity1_9.decalogpresent.view.V1a9DecalogPresentFullView", package.seeall)

local var_0_0 = class("V1a9DecalogPresentFullView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "image_TimeBG/#txt_remainTime")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Claim")
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Normal")
	arg_1_0._goReceived = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Received")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()
end

function var_0_0._btnClaimOnClick(arg_4_0)
	DecalogPresentController.instance:receiveDecalogPresent(arg_4_0.refreshCanGet, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.parent

	gohelper.addChild(var_7_0, arg_7_0.viewGO)
	arg_7_0:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.decalog_present_full_view)
end

function var_0_0.refresh(arg_8_0)
	arg_8_0:refreshCanGet()
	arg_8_0:refreshRemainTime()
	TaskDispatcher.cancelTask(arg_8_0.refreshRemainTime, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0.refreshRemainTime, arg_8_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.refreshCanGet(arg_9_0)
	local var_9_0 = DecalogPresentModel.instance:isShowRedDot()

	gohelper.setActive(arg_9_0._goNormal, var_9_0)
	gohelper.setActive(arg_9_0._goReceived, not var_9_0)
end

function var_0_0.refreshRemainTime(arg_10_0)
	local var_10_0 = DecalogPresentModel.instance:getDecalogPresentActId()
	local var_10_1 = ActivityModel.instance:getActMO(var_10_0):getRemainTimeStr3(false, true)

	arg_10_0._txtremainTime.text = string.format(luaLang("remain"), var_10_1)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.refreshRemainTime, arg_12_0)
end

return var_0_0
