module("modules.logic.prototest.view.ProtoTestCaseItem", package.seeall)

slot0 = class("ProtoTestCaseItem", MixScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._tr = slot1.transform
	slot0._txtId = gohelper.findChildText(slot1, "Txt_id")
	slot0._txtFields = {
		gohelper.findChildText(slot1, "Txt_field")
	}
	slot0._btnRemove = gohelper.findChildButtonWithAudio(slot1, "Btn_remove")
	slot0._btnCopy = gohelper.findChildButtonWithAudio(slot1, "Btn_copy")
	slot0._btnSend = gohelper.findChildButtonWithAudio(slot1, "Btn_send")
end

function slot0.addEventListeners(slot0)
	slot0._btnRemove:AddClickListener(slot0._onClickRemove, slot0)
	slot0._btnCopy:AddClickListener(slot0._onClickCopy, slot0)
	slot0._btnSend:AddClickListener(slot0._onClickSend, slot0)
	gohelper.getClick(slot0._go):AddClickListener(slot0._onClickItem, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnRemove:RemoveClickListener()
	slot0._btnCopy:RemoveClickListener()
	slot0._btnSend:RemoveClickListener()
	gohelper.getClick(slot0._go):RemoveClickListener()

	for slot4 = 1, #slot0._txtFields do
		gohelper.getClick(slot0._txtFields[slot4].gameObject):RemoveClickListener()
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	recthelper.setHeight(slot0._tr, slot3)

	slot0._mo = slot1
	slot7 = slot0._mo.struct
	slot0._txtId.text = slot0._mo.id .. ". " .. slot7

	for slot7, slot8 in ipairs(slot0._mo.value) do
		slot9 = slot0._txtFields[1].gameObject

		if not slot0._txtFields[slot7] then
			slot10 = gohelper.clone(slot9, slot9.transform.parent.gameObject, slot9.name .. slot7):GetComponent(gohelper.Type_Text) or slot11:GetComponent(gohelper.Type_TextMesh)

			recthelper.setAnchorY(slot10.transform, recthelper.getAnchorY(slot9.transform) - 28 * (slot7 - 1))
			table.insert(slot0._txtFields, slot10)
		end

		slot10.text = slot8:getParamDescLine()

		gohelper.setActive(slot10.gameObject, true)
		gohelper.getClick(slot10.gameObject):AddClickListener(slot0._onClickParam, slot0, slot7)
	end

	for slot7 = #slot0._mo.value + 1, #slot0._txtFields do
		gohelper.setActive(slot0._txtFields[slot7].gameObject, false)
	end
end

function slot0._onClickItem(slot0)
	ViewMgr.instance:openView(ViewName.ProtoModifyView, {
		protoMO = slot0._mo
	})
end

function slot0._onClickParam(slot0, slot1)
	ViewMgr.instance:openView(ViewName.ProtoModifyView, {
		protoMO = slot0._mo,
		paramId = slot1
	})
end

function slot0._onClickRemove(slot0)
	ProtoTestCaseModel.instance:remove(slot0._mo)

	for slot5, slot6 in ipairs(ProtoTestCaseModel.instance:getList()) do
		slot6.id = slot5
	end

	ProtoTestCaseModel.instance:setList(slot1)
end

function slot0._onClickCopy(slot0)
	slot2 = ProtoTestCaseModel.instance:getList()
	slot6 = slot0._mo:clone()

	table.insert(slot2, slot6)

	for slot6, slot7 in ipairs(slot2) do
		slot7.id = slot6
	end

	ProtoTestCaseModel.instance:setList(slot2)
end

function slot0._onClickSend(slot0)
	LuaSocketMgr.instance:sendMsg(slot0._mo:buildProtoMsg())
end

return slot0
