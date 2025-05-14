module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationView", package.seeall)

local var_0_0 = class("HeroInvitationView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0.btnMask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mask")
	arg_1_0.txtTotal = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_Total")
	arg_1_0.txtNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_Total/#txt_Num")
	arg_1_0.btnPreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/skinname/txt_Dec2/#btn_preview")
	arg_1_0.btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_claim")
	arg_1_0.goEffect = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_claim/bg_effect1")
	arg_1_0.btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_finish")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnMask, arg_2_0.onClickBtnClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickBtnClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnPreview, arg_2_0.onClickBtnPreview, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClaim, arg_2_0.onClickBtnClaim, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnFinish, arg_2_0.onClickBtnFinish, arg_2_0)
	arg_2_0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.StateChange, arg_2_0.refreshView, arg_2_0)
	arg_2_0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.UpdateInfo, arg_2_0.refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnPreview(arg_5_0)
	local var_5_0 = CommonConfig.instance:getConstStr(ConstEnum.HeroInvitationReward)
	local var_5_1 = GameUtil.splitString2(var_5_0, true)[1]

	MaterialTipController.instance:showMaterialInfo(var_5_1[1], var_5_1[2], false, nil, false)
end

function var_0_0.onClickBtnClaim(arg_6_0)
	if HeroInvitationModel.instance.finalReward then
		return
	end

	if HeroInvitationListModel.instance.count > HeroInvitationListModel.instance.finishCount then
		return
	end

	HeroInvitationRpc.instance:sendGainFinalInviteRewardRequest()
end

function var_0_0.onClickBtnFinish(arg_7_0)
	return
end

function var_0_0.onClickBtnClose(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshView()
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	arg_10_0:refreshView()

	local var_10_0 = arg_10_0.viewContainer:getScrollView()

	var_10_0:moveToByCheckFunc(function(arg_11_0)
		return HeroInvitationModel.instance:getInvitationState(arg_11_0.id) ~= HeroInvitationEnum.InvitationState.Finish
	end)
	var_10_0:refreshScroll()
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.refreshView(arg_13_0)
	HeroInvitationListModel.instance:refreshList()

	local var_13_0, var_13_1 = HeroInvitationModel.instance:getInvitationHasRewardCount()

	arg_13_0.txtNum.text = var_13_1
	arg_13_0.txtTotal.text = var_13_0

	local var_13_2 = HeroInvitationModel.instance.finalReward

	gohelper.setActive(arg_13_0.btnClaim, not var_13_2)
	gohelper.setActive(arg_13_0.btnFinish, var_13_2)

	if not var_13_2 then
		local var_13_3 = var_13_1 < var_13_0

		ZProj.UGUIHelper.SetGrayscale(arg_13_0.btnClaim.gameObject, var_13_3)
		gohelper.setActive(arg_13_0.goEffect, not var_13_3)
	end
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
