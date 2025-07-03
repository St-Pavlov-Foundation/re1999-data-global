module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PanelView", package.seeall)

local var_0_0 = class("V2a7_SelfSelectSix_PanelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goClaim = gohelper.findChild(arg_1_0.viewGO, "root/simage_panelbg/reward/#btn_Claim")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "root/simage_panelbg/reward/#go_hasget")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/simage_panelbg/reward/#btn_Claim")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Close")
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyRight")
	arg_1_0._btnGo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Go")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/simage_panelbg/#txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnemptyTop:AddClickListener(arg_2_0._btnemptyTopOnClick, arg_2_0)
	arg_2_0._btnemptyBottom:AddClickListener(arg_2_0._btnemptyBottomOnClick, arg_2_0)
	arg_2_0._btnemptyLeft:AddClickListener(arg_2_0._btnemptyLeftOnClick, arg_2_0)
	arg_2_0._btnemptyRight:AddClickListener(arg_2_0._btnemptyRightOnClick, arg_2_0)
	arg_2_0._btnGo:AddClickListener(arg_2_0._btnGoOnClick, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnemptyTop:RemoveClickListener()
	arg_3_0._btnemptyBottom:RemoveClickListener()
	arg_3_0._btnemptyLeft:RemoveClickListener()
	arg_3_0._btnemptyRight:RemoveClickListener()
	arg_3_0._btnGo:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._btnClaimOnClick(arg_4_0)
	if not arg_4_0:checkReceied() and arg_4_0:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_4_0._actId, 1)
	end
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnemptyTopOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnemptyBottomOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnemptyLeftOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btnemptyRightOnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._btnGoOnClick(arg_10_0)
	arg_10_0:closeThis()

	local var_10_0 = ActivityModel.instance:getActMO(arg_10_0._actId)

	if var_10_0 and var_10_0.centerId then
		ActivityModel.instance:setTargetActivityCategoryId(arg_10_0._actId)

		if var_10_0.centerId == ActivityEnum.ActivityType.Beginner then
			ActivityController.instance:openActivityBeginnerView()
		else
			ActivityController.instance:openActivityWelfareView()
		end
	end
end

function var_0_0._editableInitView(arg_11_0)
	return
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)

	arg_13_0._actId = arg_13_0.viewParam.actId
	arg_13_0._actCo = ActivityConfig.instance:getActivityCo(arg_13_0._actId)
	arg_13_0._txtdesc.text = arg_13_0._actCo.actDesc
end

function var_0_0.refreshUI(arg_14_0)
	local var_14_0 = arg_14_0:checkReceied()
	local var_14_1 = arg_14_0:checkCanGet()

	gohelper.setActive(arg_14_0._goClaim, not var_14_0 and var_14_1)
	gohelper.setActive(arg_14_0._gohasget, var_14_0)
end

function var_0_0.checkReceied(arg_15_0)
	return (ActivityType101Model.instance:isType101RewardGet(arg_15_0._actId, 1))
end

function var_0_0.checkCanGet(arg_16_0)
	return (ActivityType101Model.instance:isType101RewardCouldGet(arg_16_0._actId, 1))
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
