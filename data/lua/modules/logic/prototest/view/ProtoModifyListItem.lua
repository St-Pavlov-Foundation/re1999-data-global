module("modules.logic.prototest.view.ProtoModifyListItem", package.seeall)

slot0 = class("ProtoModifyListItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._txtKey = gohelper.findChildText(slot1, "txtKey")
	slot0._txtValue = gohelper.findChildText(slot1, "txtValue")
	slot0._btnRemove = gohelper.findChildButtonWithAudio(slot1, "btnRemove")
	slot0._btnAdd = gohelper.findChildButtonWithAudio(slot1, "btnAdd")
	slot0._click = gohelper.getClick(slot1)
end

function slot0.addEventListeners(slot0)
	slot0._btnRemove:AddClickListener(slot0._onClickRemove, slot0)
	slot0._btnAdd:AddClickListener(slot0._onClickAdd, slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnRemove:RemoveClickListener()
	slot0._btnAdd:RemoveClickListener()
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if isTypeOf(slot1, ProtoTestCaseParamMO) then
		slot0._txtKey.text = (slot1.repeated and "[" .. slot1.key .. "]" or slot1.key) .. "  <color=#A42316>" .. ProtoEnum.LabelType[slot1.pLabel] .. " - " .. (slot1.pType == ProtoEnum.ParamType.proto and slot1.struct or ProtoEnum.ParamType[slot1.pType]) .. "</color>"
		slot0._txtValue.text = slot1:getParamDescLine()

		gohelper.setActive(slot0._txtKey.gameObject, true)
		gohelper.setActive(slot0._txtValue.gameObject, true)
		gohelper.setActive(slot0._btnRemove.gameObject, slot1.repeated)
		gohelper.setActive(slot0._btnAdd.gameObject, false)
	else
		gohelper.setActive(slot0._txtKey.gameObject, false)
		gohelper.setActive(slot0._txtValue.gameObject, false)
		gohelper.setActive(slot0._btnRemove.gameObject, false)
		gohelper.setActive(slot0._btnAdd.gameObject, true)
	end
end

function slot0._onClickThis(slot0)
	ProtoTestMgr.instance:dispatchEvent(ProtoEnum.OnClickModifyItem, slot0._mo.id)
end

function slot0._onClickRemove(slot0)
	ProtoModifyModel.instance:removeRepeatedParam(slot0._mo.id)
end

function slot0._onClickAdd(slot0)
	ProtoModifyModel.instance:addRepeatedParam()
	ProtoTestCaseModel.instance:onModelUpdate()
end

return slot0
