module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationView", package.seeall)

slot0 = class("HeroInvitationView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0.btnMask = gohelper.findChildButtonWithAudio(slot0.viewGO, "mask")
	slot0.txtTotal = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_Total")
	slot0.txtNum = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_Total/#txt_Num")
	slot0.btnPreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/skinname/txt_Dec2/#btn_preview")
	slot0.btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_claim")
	slot0.goEffect = gohelper.findChild(slot0.viewGO, "Left/#btn_claim/bg_effect1")
	slot0.btnFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_finish")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnMask, slot0.onClickBtnClose, slot0)
	slot0:addClickCb(slot0.btnClose, slot0.onClickBtnClose, slot0)
	slot0:addClickCb(slot0.btnPreview, slot0.onClickBtnPreview, slot0)
	slot0:addClickCb(slot0.btnClaim, slot0.onClickBtnClaim, slot0)
	slot0:addClickCb(slot0.btnFinish, slot0.onClickBtnFinish, slot0)
	slot0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.StateChange, slot0.refreshView, slot0)
	slot0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.UpdateInfo, slot0.refreshView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnPreview(slot0)
	slot3 = GameUtil.splitString2(CommonConfig.instance:getConstStr(ConstEnum.HeroInvitationReward), true)[1]

	MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2], false, nil, false)
end

function slot0.onClickBtnClaim(slot0)
	if HeroInvitationModel.instance.finalReward then
		return
	end

	if HeroInvitationListModel.instance.finishCount < HeroInvitationListModel.instance.count then
		return
	end

	HeroInvitationRpc.instance:sendGainFinalInviteRewardRequest()
end

function slot0.onClickBtnFinish(slot0)
end

function slot0.onClickBtnClose(slot0)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	slot0:refreshView()

	slot1 = slot0.viewContainer:getScrollView()

	slot1:moveToByCheckFunc(function (slot0)
		return HeroInvitationModel.instance:getInvitationState(slot0.id) ~= HeroInvitationEnum.InvitationState.Finish
	end)
	slot1:refreshScroll()
end

function slot0.onClose(slot0)
end

function slot0.refreshView(slot0)
	HeroInvitationListModel.instance:refreshList()

	slot0.txtTotal.text, slot0.txtNum.text = HeroInvitationModel.instance:getInvitationHasRewardCount()
	slot3 = HeroInvitationModel.instance.finalReward

	gohelper.setActive(slot0.btnClaim, not slot3)
	gohelper.setActive(slot0.btnFinish, slot3)

	if not slot3 then
		slot4 = slot2 < slot1

		ZProj.UGUIHelper.SetGrayscale(slot0.btnClaim.gameObject, slot4)
		gohelper.setActive(slot0.goEffect, not slot4)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
