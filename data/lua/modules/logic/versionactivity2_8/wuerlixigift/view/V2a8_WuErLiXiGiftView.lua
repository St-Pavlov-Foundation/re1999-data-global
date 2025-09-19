module("modules.logic.versionactivity2_8.wuerlixigift.view.V2a8_WuErLiXiGiftView", package.seeall)

local var_0_0 = class("V2a8_WuErLiXiGiftView", DecalogPresentView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_TimeBG/#txt_remainTime")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Claim")
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "Root/#btn_Claim/#go_Normal")
	arg_1_0._goHasReceived = gohelper.findChild(arg_1_0.viewGO, "Root/#btn_Claim/#go_Received")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._btnClaimOnClick(arg_2_0)
	V2a8_WuErLiXiGiftController.instance:receiveV2a8_WuErLiXiGift()
end

function var_0_0.refreshReceiveStatus(arg_3_0)
	local var_3_0 = V2a8_WuErLiXiGiftModel.instance:getV2a8_WuErLiXiGiftActId()
	local var_3_1 = V2a8_WuErLiXiGiftModel.REWARD_INDEX
	local var_3_2 = ActivityType101Model.instance:isType101RewardCouldGet(var_3_0, var_3_1)

	gohelper.setActive(arg_3_0._goNormal, var_3_2)
	gohelper.setActive(arg_3_0._goHasReceived, not var_3_2)
end

function var_0_0.refreshRemainTime(arg_4_0)
	local var_4_0 = V2a8_WuErLiXiGiftModel.instance:getV2a8_WuErLiXiGiftActId()
	local var_4_1 = ActivityModel.instance:getActMO(var_4_0):getRemainTimeStr3(false, true)

	arg_4_0._txtremainTime.text = string.format(luaLang("remain"), var_4_1)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshReceiveStatus()
	arg_5_0:refreshRemainTime()
	TaskDispatcher.cancelTask(arg_5_0.refreshRemainTime, arg_5_0)
	TaskDispatcher.runRepeat(arg_5_0.refreshRemainTime, arg_5_0, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_button_display)
end

return var_0_0
