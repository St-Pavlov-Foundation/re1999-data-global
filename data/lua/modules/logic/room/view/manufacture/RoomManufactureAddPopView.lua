module("modules.logic.room.view.manufacture.RoomManufactureAddPopView", package.seeall)

slot0 = class("RoomManufactureAddPopView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "root")
	slot0._gorightroot = gohelper.findChild(slot0.viewGO, "rightRoot")
	slot0._goaddPop = gohelper.findChild(slot0.viewGO, "root/#go_addPop")
	slot0._btncloseAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_addPop/#btn_closeAdd")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseAdd:AddClickListener(slot0._btncloseAddOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseAdd:RemoveClickListener()
end

function slot0._btncloseAddOnClick(slot0)
	ManufactureController.instance:clearSelectedSlotItem()
end

function slot0._editableInitView(slot0)
	slot0._transroot = slot0._goroot.transform
	slot0.animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0._goaddPop)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewParam and slot0.viewParam.inRight then
		gohelper.addChild(slot0._gorightroot, slot0._goaddPop)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
