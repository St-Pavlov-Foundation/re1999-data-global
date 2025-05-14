module("modules.logic.social.view.InformPlayerTipView", package.seeall)

local var_0_0 = class("InformPlayerTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_leftbg")
	arg_1_0._txtinfotarget = gohelper.findChildText(arg_1_0.viewGO, "inform/#txt_infotarget")
	arg_1_0._goinformContent = gohelper.findChild(arg_1_0.viewGO, "scroll_inform/Viewport/#go_informContent")
	arg_1_0._goinformItem = gohelper.findChild(arg_1_0.viewGO, "scroll_inform/Viewport/#go_informContent/#go_informItem")
	arg_1_0._inputinformReason = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "informreason/#input_informReason")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_close")
	arg_1_0._btninform = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_inform")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btninform:AddClickListener(arg_2_0._btninformOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btninform:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btninformOnClick(arg_5_0)
	if arg_5_0.informIng then
		return
	end

	local var_5_0 = ReportTypeListModel.instance:getSelectReportId()

	if not var_5_0 then
		GameFacade.showToast(ToastEnum.ClickInformPlayer)

		return
	end

	arg_5_0.informIng = true

	ChatRpc.instance:sendReportRequest(arg_5_0.socialPlayerMO.userId, var_5_0, arg_5_0._inputinformReason:GetText())
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_6_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_6_0._inputinformReason:AddOnValueChanged(arg_6_0.onReasonTextValueChanged, arg_6_0)
end

function var_0_0.onReasonTextValueChanged(arg_7_0, arg_7_1)
	if GameUtil.utf8len(arg_7_1) > CommonConfig.instance:getConstNum(ConstEnum.InformPlayerCharLen) then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)
		arg_7_0._inputinformReason:SetText(GameUtil.utf8sub(arg_7_1, 1, CommonConfig.instance:getConstNum(ConstEnum.InformPlayerCharLen)))
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.socialPlayerMO = arg_9_0.viewParam
	arg_9_0._txtinfotarget.text = arg_9_0.socialPlayerMO.name

	arg_9_0:refreshReportType()
	arg_9_0:addEventCb(SocialController.instance, SocialEvent.InformSuccessReply, arg_9_0.onInformSuccess, arg_9_0)
	arg_9_0:addEventCb(SocialController.instance, SocialEvent.InformFailReply, arg_9_0.onInformFail, arg_9_0)
end

function var_0_0.refreshReportType(arg_10_0)
	ReportTypeListModel.instance:refreshData()
end

function var_0_0.onInformSuccess(arg_11_0)
	GameFacade.showToast(ToastEnum.OnInformSuccess)
	arg_11_0:onInformFail()
end

function var_0_0.onInformFail(arg_12_0)
	arg_12_0.informIng = false

	arg_12_0:closeThis()
end

function var_0_0.onClose(arg_13_0)
	ReportTypeListModel.instance:clearSelectReportItem()
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simageleftbg:UnLoadImage()
	arg_14_0._simagerightbg:UnLoadImage()
	arg_14_0._inputinformReason:RemoveOnValueChanged()
end

return var_0_0
