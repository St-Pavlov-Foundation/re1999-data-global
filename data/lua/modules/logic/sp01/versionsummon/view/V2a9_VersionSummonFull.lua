module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummonFull", package.seeall)

local var_0_0 = class("V2a9_VersionSummonFull", V2a9_VersionSummon_BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "image_TimeBG/#txt_remainTime")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Claim")
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Normal")
	arg_1_0._goReceived = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Received")
	arg_1_0._simageRole = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Role")
	arg_1_0._simageLogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Logo")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Title")
	arg_1_0._simageProp = gohelper.findChildSingleImage(arg_1_0.viewGO, "prop/image_Prop")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "txt_Tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()
end

function var_0_0._btnClaimOnClick(arg_4_0)
	arg_4_0.viewContainer:sendGet101BonusRequest()
end

function var_0_0.onUpdateParam(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._refreshTimeTick, arg_5_0)
	TaskDispatcher.runRepeat(arg_5_0._refreshTimeTick, arg_5_0, TimeUtil.OneMinuteSecond)
	arg_5_0:onRefresh()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._txtremainTime.text = ""

	arg_6_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	arg_6_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_6_0._refreshTimeTick, arg_6_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.onRefresh(arg_7_0)
	arg_7_0:_refreshTimeTick()

	local var_7_0 = arg_7_0.viewContainer:isType101RewardCouldGetAnyOne()

	gohelper.setActive(arg_7_0._goNormal, var_7_0)
	gohelper.setActive(arg_7_0._goReceived, not var_7_0)
end

function var_0_0._refreshTimeTick(arg_8_0)
	arg_8_0._txtremainTime.text = arg_8_0.viewContainer:getActRemainTimeStr()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._refreshTimeTick, arg_10_0)
end

return var_0_0
