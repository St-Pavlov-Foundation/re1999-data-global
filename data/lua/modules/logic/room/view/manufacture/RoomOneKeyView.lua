module("modules.logic.room.view.manufacture.RoomOneKeyView", package.seeall)

slot0 = class("RoomOneKeyView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnfill = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_fill")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfill:AddClickListener(slot0._btnfillOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfill:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()

	if slot0.optionItemDict then
		for slot4, slot5 in pairs(slot0.optionItemDict) do
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0._btnfillOnClick(slot0)
	ManufactureController.instance:oneKeyManufactureItem(slot0.curOneKeyType)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclickOnClick(slot0, slot1)
	if slot0.curOneKeyType and slot0.curOneKeyType == slot1 then
		return
	end

	slot0.curOneKeyType = slot1

	if slot0.optionItemDict then
		for slot5, slot6 in pairs(slot0.optionItemDict) do
			gohelper.setActive(slot6.goselected, slot5 == slot1)
		end
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.optionItemDict = {}

	for slot4, slot5 in pairs(RoomManufactureEnum.OneKeyType) do
		slot0.optionItemDict[slot5] = slot0:getOptionItem(gohelper.findChild(slot0.viewGO, "root/#scroll_option/Viewport/Content/#go_type" .. slot5), slot5)
	end

	slot0:_btnclickOnClick(ManufactureModel.instance:getRecordOneKeyType())
end

function slot0.getOptionItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.oneKeyType = slot2
	slot3.goselected = gohelper.findChild(slot1, "selectdBg/#go_selected")
	slot3.btnclick = gohelper.findChildClickWithAudio(slot1, "#btn_click")

	slot3.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot2)

	return slot3
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
