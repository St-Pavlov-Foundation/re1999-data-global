module("modules.logic.room.view.RoomInformPlayerView", package.seeall)

local var_0_0 = class("RoomInformPlayerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtinfotarget = gohelper.findChildText(arg_1_0.viewGO, "object/inform/#txt_infotarget")
	arg_1_0._goinformContent = gohelper.findChild(arg_1_0.viewGO, "object/scroll_inform/Viewport/#go_informContent")
	arg_1_0._goinformItem = gohelper.findChild(arg_1_0.viewGO, "object/scroll_inform/Viewport/#go_informContent/#go_informItem")
	arg_1_0._inputinformReason = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "object/informreason/#input_informReason")
	arg_1_0._gominimap = gohelper.findChild(arg_1_0.viewGO, "object/informreason/#go_minimap")
	arg_1_0._btninform = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_inform")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninform:AddClickListener(arg_2_0._btninformOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninform:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btninformOnClick(arg_5_0)
	local var_5_0 = RoomReportTypeListModel.instance:getSelectId()
	local var_5_1 = RoomReportTypeListModel.instance:getById(var_5_0)

	if not var_5_0 or not var_5_1 then
		GameFacade.showToast(ToastEnum.ClickInformPlayer)

		return
	end

	local var_5_2 = arg_5_0._inputinformReason:GetText()

	RoomInformController.instance:sendReportRoom(arg_5_0.socialPlayerMO.userId, var_5_1.desc, var_5_2, arg_5_0._shareCode)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._rawImageMap = gohelper.onceAddComponent(arg_6_0._gominimap, gohelper.Type_RawImage)

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
	arg_9_0.socialPlayerMO = arg_9_0.viewParam.playerMO
	arg_9_0._shareCode = arg_9_0.viewParam.shareCode
	arg_9_0._txtinfotarget.text = arg_9_0.socialPlayerMO.name
	arg_9_0._texture = arg_9_0.viewParam.texture2d
	arg_9_0.viewParam.texture2d = nil
	arg_9_0._rawImageMap.texture = arg_9_0._texture

	if arg_9_0._texture then
		local var_9_0 = arg_9_0._texture.width

		if var_9_0 ~= 0 then
			local var_9_1 = arg_9_0._texture.height
			local var_9_2 = arg_9_0._rawImageMap.transform
			local var_9_3 = recthelper.getWidth(var_9_2) * var_9_1 / var_9_0

			recthelper.setHeight(var_9_2, var_9_3)
		end
	end

	arg_9_0:refreshReportType()
	arg_9_0:addEventCb(RoomController.instance, RoomEvent.InformSuccessReply, arg_9_0._onInformSuccess, arg_9_0)
end

function var_0_0.refreshReportType(arg_10_0)
	return
end

function var_0_0._onInformSuccess(arg_11_0, arg_11_1)
	GameFacade.showToast(ToastEnum.OnInformSuccess)

	if not string.nilorempty(arg_11_1) and arg_11_0._texture then
		RoomInformController.instance:uploadImage(arg_11_0._texture, arg_11_1)
	end

	arg_11_0:closeThis()
end

function var_0_0.onClose(arg_12_0)
	RoomReportTypeListModel.instance:clearSelect()
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._inputinformReason:RemoveOnValueChanged()

	arg_13_0._texture = nil
end

return var_0_0
