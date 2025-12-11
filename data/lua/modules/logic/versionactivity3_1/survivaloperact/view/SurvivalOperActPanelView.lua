module("modules.logic.versionactivity3_1.survivaloperact.view.SurvivalOperActPanelView", package.seeall)

local var_0_0 = class("SurvivalOperActPanelView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._simageRightPanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/Right/#simage_RightPanelBG")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#btn_reward")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#btn_Enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#btn_Enter/#go_reddot")
	arg_1_0._simageLeftPanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/Left/#simage_LeftPanelBG")
	arg_1_0._simageRole = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/Left/#simage_Role")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/Left/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/Left/#simage_Title")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "Root/Left/Reward/image_dec")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "Root/Left/Reward/go_canget")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Left/Reward/go_canget/#btn_Claim")
	arg_1_0._goreceive = gohelper.findChild(arg_1_0.viewGO, "Root/Left/Reward/go_receive")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "Root/Left/Reward/go_receive/go_hasget")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "Root/Left/Scroll View/Viewport/Content/#go_Item")
	arg_1_0._txtItem = gohelper.findChildText(arg_1_0.viewGO, "Root/Left/Scroll View/Viewport/Content/#go_Item/#txt_Item")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnrewardOnClick(arg_4_0)
	local var_4_0 = CommonConfig.instance:getConstNum(ConstEnum.SurvivalOperActItem)

	MaterialTipController.instance:showMaterialInfo(1, var_4_0)
end

function var_0_0._btnEnterOnClick(arg_5_0)
	GameFacade.jump(JumpEnum.JumpView.SurvivalHandbook)
end

function var_0_0._btnClaimOnClick(arg_6_0)
	if not ActivityType101Model.instance:isType101RewardCouldGet(arg_6_0._actId, 1) then
		return
	end

	arg_6_0._anim:Play("open", 0, 0)
	TaskDispatcher.runDelay(arg_6_0._startGetReward, arg_6_0, 1)
end

function var_0_0._startGetReward(arg_7_0)
	gohelper.setActive(arg_7_0._gocanget, false)
	gohelper.setActive(arg_7_0._goreceive, true)
	Activity101Rpc.instance:sendGet101BonusRequest(arg_7_0._actId, 1, arg_7_0._refreshUI, arg_7_0)
end

function var_0_0._btnCloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._txtLimitTime.text = ""
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum3_1.SurvivalOperAct.play_ui_diqiu_jinru)

	arg_10_0._actId = VersionActivity3_1Enum.ActivityId.SurvivalOperAct
	arg_10_0._anim = arg_10_0._gohasget:GetComponent(typeof(UnityEngine.Animator))

	arg_10_0:_refreshUI()
	arg_10_0:_clearTimeTick()
	TaskDispatcher.runRepeat(arg_10_0._refreshTimeTick, arg_10_0, 1)
	TaskDispatcher.runRepeat(arg_10_0._playClick, arg_10_0, 1)
end

function var_0_0._playClick(arg_11_0)
	return
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._startGetReward, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._playClick, arg_13_0)
	arg_13_0:_clearTimeTick()
end

function var_0_0._clearTimeTick(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._refreshTimeTick, arg_14_0)
end

function var_0_0._refreshUI(arg_15_0)
	local var_15_0 = ActivityType101Model.instance:isType101RewardCouldGet(arg_15_0._actId, 1)

	gohelper.setActive(arg_15_0._gocanget, var_15_0)
	gohelper.setActive(arg_15_0._goreceive, not var_15_0)
	gohelper.setActive(arg_15_0._goicon, var_15_0)
end

function var_0_0._refreshTimeTick(arg_16_0)
	arg_16_0._txtLimitTime.text = arg_16_0:getRemainTimeStr()
end

return var_0_0
