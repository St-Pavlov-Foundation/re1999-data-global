module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentReceiveView", package.seeall)

local var_0_0 = class("GoldenMilletPresentReceiveView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	gohelper.setActive(arg_1_0.viewGO, true)

	arg_1_0._txtReceiveRemainTime = gohelper.findChildText(arg_1_0.viewGO, "image_TimeBG/#txt_remainTime")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Claim")
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Normal")
	arg_1_0._goHasReceived = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Received")
	arg_1_0._btnCloseReceive = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
	arg_2_0._btnCloseReceive:AddClickListener(arg_2_0._btnCloseReceiveOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnCloseReceive:RemoveClickListener()
end

function var_0_0._btnClaimOnClick(arg_4_0)
	GoldenMilletPresentController.instance:receiveGoldenMilletPresent(arg_4_0.refreshReceiveStatus, arg_4_0)
end

function var_0_0._btnCloseReceiveOnClick(arg_5_0)
	arg_5_0.viewContainer:openGoldMilletPresentDisplayView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshRemainTime()
	TaskDispatcher.cancelTask(arg_6_0.refreshRemainTime, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0.refreshRemainTime, arg_6_0, TimeUtil.OneMinuteSecond)
	arg_6_0:refreshReceiveStatus()
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletReceiveViewOpen)
end

function var_0_0.refreshReceiveStatus(arg_7_0)
	local var_7_0 = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(arg_7_0._goNormal, not var_7_0)
	gohelper.setActive(arg_7_0._goHasReceived, var_7_0)
end

function var_0_0.refreshRemainTime(arg_8_0)
	local var_8_0 = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
	local var_8_1 = ActivityModel.instance:getActMO(var_8_0)
	local var_8_2 = TimeUtil.SecondToActivityTimeFormat(var_8_1:getRealEndTimeStamp() - ServerTime.now())

	arg_8_0._txtReceiveRemainTime.text = string.format(luaLang("remain"), var_8_2)
end

function var_0_0.onClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.refreshRemainTime, arg_9_0)
end

return var_0_0
