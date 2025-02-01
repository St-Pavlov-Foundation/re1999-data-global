module("modules.logic.social.view.InformPlayerTipView", package.seeall)

slot0 = class("InformPlayerTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_leftbg")
	slot0._txtinfotarget = gohelper.findChildText(slot0.viewGO, "inform/#txt_infotarget")
	slot0._goinformContent = gohelper.findChild(slot0.viewGO, "scroll_inform/Viewport/#go_informContent")
	slot0._goinformItem = gohelper.findChild(slot0.viewGO, "scroll_inform/Viewport/#go_informContent/#go_informItem")
	slot0._inputinformReason = gohelper.findChildTextMeshInputField(slot0.viewGO, "informreason/#input_informReason")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_close")
	slot0._btninform = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_inform")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btninform:AddClickListener(slot0._btninformOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btninform:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btninformOnClick(slot0)
	if slot0.informIng then
		return
	end

	if not ReportTypeListModel.instance:getSelectReportId() then
		GameFacade.showToast(ToastEnum.ClickInformPlayer)

		return
	end

	slot0.informIng = true

	ChatRpc.instance:sendReportRequest(slot0.socialPlayerMO.userId, slot1, slot0._inputinformReason:GetText())
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._inputinformReason:AddOnValueChanged(slot0.onReasonTextValueChanged, slot0)
end

function slot0.onReasonTextValueChanged(slot0, slot1)
	if CommonConfig.instance:getConstNum(ConstEnum.InformPlayerCharLen) < GameUtil.utf8len(slot1) then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)
		slot0._inputinformReason:SetText(GameUtil.utf8sub(slot1, 1, CommonConfig.instance:getConstNum(ConstEnum.InformPlayerCharLen)))
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.socialPlayerMO = slot0.viewParam
	slot0._txtinfotarget.text = slot0.socialPlayerMO.name

	slot0:refreshReportType()
	slot0:addEventCb(SocialController.instance, SocialEvent.InformSuccessReply, slot0.onInformSuccess, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.InformFailReply, slot0.onInformFail, slot0)
end

function slot0.refreshReportType(slot0)
	ReportTypeListModel.instance:refreshData()
end

function slot0.onInformSuccess(slot0)
	GameFacade.showToast(ToastEnum.OnInformSuccess)
	slot0:onInformFail()
end

function slot0.onInformFail(slot0)
	slot0.informIng = false

	slot0:closeThis()
end

function slot0.onClose(slot0)
	ReportTypeListModel.instance:clearSelectReportItem()
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._inputinformReason:RemoveOnValueChanged()
end

return slot0
