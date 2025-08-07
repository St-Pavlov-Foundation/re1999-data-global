module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummonPanel", package.seeall)

local var_0_0 = class("V2a9_VersionSummonPanel", V2a9_VersionSummon_BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "image_TimeBG/#txt_remainTime")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Claim", AudioEnum.UI.Play_UI_Tags)
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Normal")
	arg_1_0._goHasReceived = gohelper.findChild(arg_1_0.viewGO, "#btn_Claim/#go_Received")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._btnMask = gohelper.findChildButton(arg_1_0.viewGO, "Mask")
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
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnMask:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnMask:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnClaimOnClick(arg_5_0)
	arg_5_0.viewContainer:sendGet101BonusRequest()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._txtremainTime.text = ""

	arg_6_0:internal_set_actId(arg_6_0.viewParam.actId)
	arg_6_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	arg_6_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_6_0._refreshTimeTick, arg_6_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.onUpdateParam(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._refreshTimeTick, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0._refreshTimeTick, arg_7_0, TimeUtil.OneMinuteSecond)
	arg_7_0:onRefresh()
end

function var_0_0.onRefresh(arg_8_0)
	arg_8_0:_refreshTimeTick()

	local var_8_0 = arg_8_0.viewContainer:isType101RewardCouldGetAnyOne()

	gohelper.setActive(arg_8_0._goNormal, var_8_0)
	gohelper.setActive(arg_8_0._goHasReceived, not var_8_0)
end

function var_0_0._refreshTimeTick(arg_9_0)
	arg_9_0._txtremainTime.text = arg_9_0.viewContainer:getActRemainTimeStr()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._refreshTimeTick, arg_11_0)
end

function var_0_0.onClickModalMask(arg_12_0)
	arg_12_0:closeThis()
end

return var_0_0
