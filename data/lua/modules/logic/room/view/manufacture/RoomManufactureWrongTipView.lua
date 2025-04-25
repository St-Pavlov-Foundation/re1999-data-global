module("modules.logic.room.view.manufacture.RoomManufactureWrongTipView", package.seeall)

slot0 = class("RoomManufactureWrongTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "root")
	slot0._gorightroot = gohelper.findChild(slot0.viewGO, "rightRoot")
	slot0._goworngPop = gohelper.findChild(slot0.viewGO, "root/#go_wrongPop")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_wrongPop/#simage_bg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "root/#go_wrongPop/#txt_title")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_wrongPop/#btn_close")
	slot0._scrolllist = gohelper.findChildScrollRect(slot0.viewGO, "root/#go_wrongPop/#scroll_list")
	slot0._gotipcontent = gohelper.findChild(slot0.viewGO, "root/#go_wrongPop/#scroll_list/viewport/content")
	slot0._gotipItem = gohelper.findChild(slot0.viewGO, "root/#go_wrongPop/#scroll_list/viewport/content/#go_tipItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	if not slot0.viewParam then
		return
	end

	slot0.isRight = slot0.viewParam.isRight
	slot0.buildingUid = slot0.viewParam.buildingUid

	slot0:setTipItems()
	ManufactureController.instance:dispatchEvent(ManufactureEvent.OnWrongTipViewChange, slot0.buildingUid)
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()

	if slot0.isRight then
		gohelper.addChild(slot0._gorightroot, slot0._goworngPop)
	end
end

function slot0.setTipItems(slot0)
	slot0.tipItemList = {}

	gohelper.CreateObjList(slot0, slot0._onSetTipItem, ManufactureModel.instance:getManufactureWrongTipItemList(slot0.buildingUid), slot0._gotipcontent, slot0._gotipItem, RoomManufactureWrongTipItem)
end

function slot0._onSetTipItem(slot0, slot1, slot2, slot3)
	slot0.tipItemList[slot3] = slot1

	slot1:setData(slot0.buildingUid, slot2.manufactureItemId, slot2.wrongSlotIdList, slot0.isRight)
end

function slot0.onClose(slot0)
	ManufactureController.instance:dispatchEvent(ManufactureEvent.OnWrongTipViewChange)
end

function slot0.onDestroyView(slot0)
end

return slot0
