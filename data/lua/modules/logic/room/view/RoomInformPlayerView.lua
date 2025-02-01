module("modules.logic.room.view.RoomInformPlayerView", package.seeall)

slot0 = class("RoomInformPlayerView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtinfotarget = gohelper.findChildText(slot0.viewGO, "object/inform/#txt_infotarget")
	slot0._goinformContent = gohelper.findChild(slot0.viewGO, "object/scroll_inform/Viewport/#go_informContent")
	slot0._goinformItem = gohelper.findChild(slot0.viewGO, "object/scroll_inform/Viewport/#go_informContent/#go_informItem")
	slot0._inputinformReason = gohelper.findChildTextMeshInputField(slot0.viewGO, "object/informreason/#input_informReason")
	slot0._gominimap = gohelper.findChild(slot0.viewGO, "object/informreason/#go_minimap")
	slot0._btninform = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_inform")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btninform:AddClickListener(slot0._btninformOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btninform:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btninformOnClick(slot0)
	slot1 = RoomReportTypeListModel.instance:getSelectId()
	slot2 = RoomReportTypeListModel.instance:getById(slot1)

	if not slot1 or not slot2 then
		GameFacade.showToast(ToastEnum.ClickInformPlayer)

		return
	end

	RoomInformController.instance:sendReportRoom(slot0.socialPlayerMO.userId, slot2.desc, slot0._inputinformReason:GetText(), slot0._shareCode)
end

function slot0._editableInitView(slot0)
	slot0._rawImageMap = gohelper.onceAddComponent(slot0._gominimap, gohelper.Type_RawImage)

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
	slot0.socialPlayerMO = slot0.viewParam.playerMO
	slot0._shareCode = slot0.viewParam.shareCode
	slot0._txtinfotarget.text = slot0.socialPlayerMO.name
	slot0._texture = slot0.viewParam.texture2d
	slot0.viewParam.texture2d = nil
	slot0._rawImageMap.texture = slot0._texture

	if slot0._texture and slot0._texture.width ~= 0 then
		slot3 = slot0._rawImageMap.transform

		recthelper.setHeight(slot3, recthelper.getWidth(slot3) * slot0._texture.height / slot1)
	end

	slot0:refreshReportType()
	slot0:addEventCb(RoomController.instance, RoomEvent.InformSuccessReply, slot0._onInformSuccess, slot0)
end

function slot0.refreshReportType(slot0)
end

function slot0._onInformSuccess(slot0, slot1)
	GameFacade.showToast(ToastEnum.OnInformSuccess)

	if not string.nilorempty(slot1) and slot0._texture then
		RoomInformController.instance:uploadImage(slot0._texture, slot1)
	end

	slot0:closeThis()
end

function slot0.onClose(slot0)
	RoomReportTypeListModel.instance:clearSelect()
end

function slot0.onDestroyView(slot0)
	slot0._inputinformReason:RemoveOnValueChanged()

	slot0._texture = nil
end

return slot0
