module("modules.logic.room.view.layout.RoomLayoutInputBaseView", package.seeall)

slot0 = class("RoomLayoutInputBaseView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_leftbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_close")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_sure")
	slot0._txtdes = gohelper.findChildText(slot0.viewGO, "message/#txt_des")
	slot0._inputsignature = gohelper.findChildTextMeshInputField(slot0.viewGO, "message/#input_signature")
	slot0._txttext = gohelper.findChildText(slot0.viewGO, "message/#input_signature/textarea/#txt_text")
	slot0._btncleanname = gohelper.findChildButtonWithAudio(slot0.viewGO, "message/#input_signature/#btn_cleanname")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
	slot0._btncleanname:AddClickListener(slot0._btncleannameOnClick, slot0)
	slot0._inputsignature:AddOnEndEdit(slot0._onInputNameEndEdit, slot0)
	slot0._inputsignature:AddOnValueChanged(slot0._onInputNameValueChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnsure:RemoveClickListener()
	slot0._btncleanname:RemoveClickListener()
	slot0._inputsignature:RemoveOnEndEdit()
	slot0._inputsignature:RemoveOnValueChanged()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
	slot0:_closeInvokeCallback(false)
end

function slot0._btnsureOnClick(slot0)
	if not string.nilorempty(slot0._inputsignature:GetText()) then
		slot0:closeThis()
		slot0:_closeInvokeCallback(true, slot1)
	end
end

function slot0._btncleannameOnClick(slot0)
	slot0._inputsignature:SetText("")
end

function slot0._onInputNameEndEdit(slot0)
	slot0:_checkLimit()
end

function slot0._onInputNameValueChange(slot0)
	slot0:_checkLimit()
end

function slot0._checkLimit(slot0)
	slot1 = slot0._inputsignature:GetText()

	if GameUtil.utf8sub(slot1, 1, math.min(GameUtil.utf8len(slot1), slot0:_getInputLimit())) ~= slot1 then
		slot0._inputsignature:SetText(slot3)
	end
end

function slot0._getInputLimit(slot0)
	return CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutNameLimit)
end

function slot0._editableInitView(slot0)
	slot0._txttitlecn = gohelper.findChildText(slot0.viewGO, "titlecn")
	slot0._txttitleen = gohelper.findChildText(slot0.viewGO, "titlecn/titleen")
	slot0._txtbtnsurecn = gohelper.findChildText(slot0.viewGO, "bottom/#btn_sure/text")
	slot0._txtbtnsureed = gohelper.findChildText(slot0.viewGO, "bottom/#btn_sure/texten")
	slot0._txtinputlang = gohelper.findChildText(slot0.viewGO, "message/#input_signature/textarea/lang_txt")

	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshInitUI()
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._onEscape, slot0)
	end

	slot0:_refreshInitUI()
end

function slot0._onEscape(slot0)
	slot0:_btncloseOnClick()
end

function slot0._refreshInitUI(slot0)
	if slot0.viewParam then
		if string.nilorempty(slot0.viewParam.defaultName) then
			slot0._inputsignature:SetText("")
		else
			slot0._inputsignature:SetText(slot1)
		end
	end
end

function slot0._closeInvokeCallback(slot0, slot1, slot2)
	if not slot0.viewParam then
		return
	end

	if slot1 then
		if slot0.viewParam.yesCallback then
			if slot0.viewParam.callbockObj then
				slot0.viewParam.yesCallback(slot0.viewParam.callbockObj, slot2)
			else
				slot0.viewParam.yesCallback(slot2)
			end
		end
	elseif slot0.viewParam.noCallback then
		slot0.viewParam.noCallback(slot0.viewParam.noCallbackObj)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagerightbg:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
end

return slot0
