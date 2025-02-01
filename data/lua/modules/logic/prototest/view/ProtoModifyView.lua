module("modules.logic.prototest.view.ProtoModifyView", package.seeall)

slot0 = class("ProtoModifyView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnBack1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "paramlistpanel/btnBack")
	slot0._btnBack2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "modifyparampanel/btnBack")
	slot0._btnSave = gohelper.findChildButtonWithAudio(slot0.viewGO, "modifyparampanel/panel/Btn_save")
	slot0._listPanel = gohelper.findChild(slot0.viewGO, "paramlistpanel")
	slot0._modifyPanel = gohelper.findChild(slot0.viewGO, "modifyparampanel")
	slot0._txtTitle1 = gohelper.findChildText(slot0.viewGO, "paramlistpanel/txtTitle")
	slot0._txtTitle2 = gohelper.findChildText(slot0.viewGO, "modifyparampanel/txtTitle")
	slot0._txtParam = gohelper.findChildText(slot0.viewGO, "modifyparampanel/panel/txtParam")
	slot0._inputValue = gohelper.findChildTextMeshInputField(slot0.viewGO, "modifyparampanel/panel/inputValue")
end

function slot0.addEvents(slot0)
	slot0._btnBack1:AddClickListener(slot0._onClickBack, slot0)
	slot0._btnBack2:AddClickListener(slot0._closeModify, slot0)
	slot0._btnSave:AddClickListener(slot0._onClickSave, slot0)
	ProtoTestMgr.instance:registerCallback(ProtoEnum.OnClickModifyItem, slot0._enterModifyItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnBack1:RemoveClickListener()
	slot0._btnBack2:RemoveClickListener()
	slot0._btnSave:RemoveClickListener()
	ProtoTestMgr.instance:unregisterCallback(ProtoEnum.OnClickModifyItem, slot0._enterModifyItem, slot0)
end

function slot0.onOpen(slot0)
	slot2 = slot0.viewParam.paramId

	if slot0.viewParam.protoMO then
		ProtoModifyModel.instance:enterProto(slot1)

		if slot2 then
			slot0:_enterModifyItem(slot2)
		else
			slot0:_updateTitle()
		end
	end
end

function slot0._enterModifyItem(slot0, slot1)
	ProtoModifyModel.instance:enterParam(slot1)

	slot2 = ProtoModifyModel.instance:getLastMO()

	if slot2:isRepeated() or slot2:isProtoType() then
		gohelper.setActive(slot0._listPanel, true)
		gohelper.setActive(slot0._modifyPanel, false)
	else
		if type(slot2.value) == "boolean" or type(slot5) == "number" then
			slot5 = tostring(slot5) or slot5
		end

		slot0._inputValue:SetText(slot5)
		gohelper.setActive(slot0._listPanel, false)
		gohelper.setActive(slot0._modifyPanel, true)
	end

	slot0:_updateTitle()
end

function slot0._updateTitle(slot0)
	slot3 = ProtoModifyModel.instance:getLastMO()
	slot4 = ProtoModifyModel.instance:getProtoMO().struct

	for slot8, slot9 in ipairs(ProtoModifyModel.instance:getDepthParamMOs()) do
		slot4 = slot9.repeated and slot4 .. "[" .. slot9.key .. "]" or slot4 .. "[" .. slot9.key .. "]" .. " - " .. slot9.key
	end

	slot0._txtTitle1.text = slot4
	slot0._txtTitle2.text = slot4

	if isTypeOf(slot3, ProtoTestCaseParamMO) then
		slot0._txtParam.text = ProtoEnum.LabelType[slot3.pLabel] .. " - " .. (slot3.pType == ProtoEnum.ParamType.proto and slot3.struct or ProtoEnum.ParamType[slot3.pType])
	end
end

function slot0._updateList(slot0)
	ProtoModifyModel.instance:onModelUpdate()
	ProtoTestCaseModel.instance:onModelUpdate()
end

function slot0._onClickBack(slot0)
	if ProtoModifyModel.instance:isRoot() then
		slot0:closeThis()
	else
		slot0:_closeModify()
	end
end

function slot0._closeModify(slot0)
	ProtoModifyModel.instance:exitParam()
	gohelper.setActive(slot0._listPanel, true)
	gohelper.setActive(slot0._modifyPanel, false)
	slot0:_updateTitle()
end

function slot0._onClickSave(slot0)
	if ProtoModifyModel.instance:getLastMO().pType ~= ProtoEnum.ParamType.string and string.nilorempty(slot0._inputValue:GetText()) and not slot1:isOptional() then
		GameFacade.showToast(ToastEnum.ProtoModifyNotString)

		return
	end

	if slot1.pType == ProtoEnum.ParamType.int32 or slot1.pType == ProtoEnum.ParamType.uint32 then
		if not tonumber(slot2) then
			GameFacade.showToast(ToastEnum.ProtoModifyNotValue)

			return
		end

		slot1.value = slot3
	elseif slot1.pType == ProtoEnum.ParamType.int64 or slot1.pType == ProtoEnum.ParamType.uint64 then
		if not string.nilorempty(slot2) and not tonumber(slot2) then
			GameFacade.showToast(ToastEnum.ProtoModifyNotValue)

			return
		end

		slot1.value = not string.nilorempty(slot2) and slot2 or nil
	elseif slot1.pType == ProtoEnum.ParamType.bool then
		slot4 = ({
			["0"] = false,
			["false"] = false,
			["1"] = true,
			["true"] = true
		})[string.lower(slot2)]

		if not slot1:isOptional() and slot4 == nil then
			GameFacade.showToast(ToastEnum.ProtoModifyIsNil)

			return
		end

		slot1.value = slot4
	else
		slot1.value = slot2
	end

	slot0:_closeModify()
	slot0:_updateList()
end

function slot0.onClickModalMask(slot0)
	if slot0._modifyPanel.activeInHierarchy then
		slot0:_closeModify()
	else
		slot0:_onClickBack()
	end
end

return slot0
