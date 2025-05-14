module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentReceiveView", package.seeall)

local var_0_0 = class("V2a5_GoldenMilletPresentReceiveView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	gohelper.setActive(arg_1_0.viewGO, true)

	arg_1_0._txtReceiveRemainTime = gohelper.findChildText(arg_1_0.viewGO, "image_TimeBG/#txt_remainTime")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Claim")
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Normal")
	arg_1_0._goHasReceived = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Received")
	arg_1_0._btnCloseReceive = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._btnBgClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "close")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)

	if arg_2_0._btnCloseReceive then
		arg_2_0._btnCloseReceive:AddClickListener(arg_2_0._btnCloseReceiveOnClick, arg_2_0)
	end

	if arg_2_0._btnBgClose then
		arg_2_0._btnBgClose:AddClickListener(arg_2_0._btnCloseReceiveOnClick, arg_2_0)
	end

	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.afterReceive, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()

	if arg_3_0._btnCloseReceive then
		arg_3_0._btnCloseReceive:RemoveClickListener()
	end

	if arg_3_0._btnBgClose then
		arg_3_0._btnBgClose:RemoveClickListener()
	end

	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.afterReceive, arg_3_0)
end

function var_0_0._btnClaimOnClick(arg_4_0)
	GoldenMilletPresentController.instance:receiveGoldenMilletPresent(arg_4_0.afterReceive, arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

function var_0_0._btnCloseReceiveOnClick(arg_5_0)
	arg_5_0.viewContainer:openGoldMilletPresentDisplayView()
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshRemainTime()
	TaskDispatcher.cancelTask(arg_6_0.refreshRemainTime, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0.refreshRemainTime, arg_6_0, TimeUtil.OneMinuteSecond)
	arg_6_0:refreshReceiveStatus()
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletReceiveViewOpen)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.play_ui_tangren_songpifu_loop)
end

function var_0_0.refreshReceiveStatus(arg_7_0)
	local var_7_0 = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(arg_7_0._goNormal, not var_7_0)
	gohelper.setActive(arg_7_0._goHasReceived, var_7_0)
end

function var_0_0.afterReceive(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.CharacterSkinGainView then
		arg_8_0.viewContainer:openGoldMilletPresentDisplayView()
	end
end

function var_0_0.refreshRemainTime(arg_9_0)
	local var_9_0 = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
	local var_9_1 = ActivityModel.instance:getActMO(var_9_0):getRemainTimeStr3(false, true)

	arg_9_0._txtReceiveRemainTime.text = string.format(luaLang("remain"), var_9_1)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.refreshRemainTime, arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

return var_0_0
