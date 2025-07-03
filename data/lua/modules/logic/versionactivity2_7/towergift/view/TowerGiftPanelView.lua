module("modules.logic.versionactivity2_7.towergift.view.TowerGiftPanelView", package.seeall)

local var_0_0 = class("TowerGiftPanelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_check")
	arg_1_0._goClaim = gohelper.findChild(arg_1_0.viewGO, "root/reward1/go_canget/#btn_Claim")
	arg_1_0._goreceive = gohelper.findChild(arg_1_0.viewGO, "root/reward1/go_receive")
	arg_1_0._btn1Claim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward1/go_canget/#btn_Claim")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward2/go_goto/#btn_goto")
	arg_1_0._btnicon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward2/icon/click")
	arg_1_0._goreceive2 = gohelper.findChild(arg_1_0.viewGO, "root/reward2/go_receive")
	arg_1_0._gogoto = gohelper.findChild(arg_1_0.viewGO, "root/reward2/go_goto")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "root/reward2/go_lock")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/simage_fullbg/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
	arg_2_0._btn1Claim:AddClickListener(arg_2_0._btn1ClaimOnClick, arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0._btnicon:AddClickListener(arg_2_0._btniconOnClick, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncheck:RemoveClickListener()
	arg_3_0._btn1Claim:RemoveClickListener()
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0._btnicon:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncheckOnClick(arg_5_0)
	local var_5_0 = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = TowerGiftEnum.ShowHeroList
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_5_0)
end

function var_0_0._btn1ClaimOnClick(arg_6_0)
	if not arg_6_0:checkReceied() and arg_6_0:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_6_0._actId, 1)
	end
end

function var_0_0._btngotoOnClick(arg_7_0)
	arg_7_0:closeThis()
	ActivityModel.instance:setTargetActivityCategoryId(ActivityEnum.Activity.V2a7_TowerGift)
	ActivityController.instance:openActivityBeginnerView()
end

function var_0_0._btniconOnClick(arg_8_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, TowerGiftEnum.StoneUpTicketId)
end

function var_0_0.checkReceied(arg_9_0)
	return (ActivityType101Model.instance:isType101RewardGet(arg_9_0._actId, 1))
end

function var_0_0.checkCanGet(arg_10_0)
	return (ActivityType101Model.instance:isType101RewardCouldGet(arg_10_0._actId, 1))
end

function var_0_0._editableInitView(arg_11_0)
	return
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

	arg_13_0._actId = arg_13_0.viewParam.actId

	arg_13_0:refreshUI()
end

function var_0_0.refreshUI(arg_14_0)
	local var_14_0 = arg_14_0:checkReceied()
	local var_14_1 = arg_14_0:checkCanGet()

	gohelper.setActive(arg_14_0._goClaim, var_14_1)
	gohelper.setActive(arg_14_0._goreceive, var_14_0)

	arg_14_0._txttime.text = ActivityHelper.getActivityRemainTimeStr(arg_14_0._actId)

	local var_14_2 = TowerTaskModel.instance:getActRewardTask()
	local var_14_3 = var_14_2 and var_14_2:isClaimed() or false

	gohelper.setActive(arg_14_0._goreceive2, var_14_3)
	gohelper.setActive(arg_14_0._gogoto, true)
	gohelper.setActive(arg_14_0._golock, false)
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
