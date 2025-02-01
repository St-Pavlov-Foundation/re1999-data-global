module("modules.logic.herogroup.view.HeroGroupModifyNameView", package.seeall)

slot0 = class("HeroGroupModifyNameView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_close")
	slot0._btnSure = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_sure")
	slot0._input = gohelper.findChildTextMeshInputField(slot0.viewGO, "message/#input_signature")
	slot0._btncleanname = gohelper.findChildButtonWithAudio(slot0.viewGO, "message/#btn_cleanname")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_leftbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._onBtnClose, slot0)
	slot0._btnSure:AddClickListener(slot0._onBtnSure, slot0)
	slot0._btncleanname:AddClickListener(slot0._onBtnClean, slot0)
	slot0._input:AddOnValueChanged(slot0._onValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnSure:RemoveClickListener()
	slot0._btncleanname:RemoveClickListener()
	slot0._input:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function slot0.onRefreshViewParam(slot0)
end

function slot0._onBtnClose(slot0)
	slot0:closeThis()
end

function slot0._onBtnClean(slot0)
	slot0._input:SetText("")
end

function slot0._onBtnSure(slot0)
	if string.nilorempty(slot0._input:GetText()) then
		return
	end

	if CommonConfig.instance:getConstNum(141) < GameUtil.utf8len(slot1) then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)

		return
	end

	HeroGroupRpc.instance:sendUpdateHeroGroupNameRequest(HeroGroupModel.instance.curGroupSelectIndex, slot1, slot0.onReq, slot0)
end

function slot0.onReq(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	HeroGroupModel.instance:setCommonGroupName(slot3.currentSelect, slot3.name)
	slot0:closeThis()
end

function slot0._onValueChanged(slot0)
	gohelper.setActive(slot0._btncleanname, not string.nilorempty(slot0._input:GetText()))
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_petrus_exchange_element_get)

	slot1 = HeroGroupModel.instance:getCommonGroupName()

	slot0._input:SetText(slot1)

	slot0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.35, slot0._onFrame, slot0._onFinish, slot0, nil, EaseType.Linear)

	gohelper.setActive(slot0._btncleanname, not string.nilorempty(slot1))
end

function slot0._onFrame(slot0, slot1)
	PostProcessingMgr.instance:setBlurWeight(slot1)
end

function slot0._onFinish(slot0)
	PostProcessingMgr.instance:setBlurWeight(1)
end

function slot0.onClose(slot0)
	if slot0._blurTweenId then
		PostProcessingMgr.instance:setBlurWeight(1)
		ZProj.TweenHelper.KillById(slot0._blurTweenId)

		slot0._blurTweenId = nil
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagerightbg:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
end

return slot0
