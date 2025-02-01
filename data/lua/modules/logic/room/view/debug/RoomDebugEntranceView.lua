module("modules.logic.room.view.debug.RoomDebugEntranceView", package.seeall)

slot0 = class("RoomDebugEntranceView", BaseView)

function slot0.onInitView(slot0)
	slot0._btndebug = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_debug")
	slot0._btninit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_init")
	slot0._btnpackage = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_package")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndebug:AddClickListener(slot0._btndebugOnClick, slot0)
	slot0._btninit:AddClickListener(slot0._btninitOnClick, slot0)
	slot0._btnpackage:AddClickListener(slot0._btnpackageOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndebug:RemoveClickListener()
	slot0._btninit:RemoveClickListener()
	slot0._btnpackage:RemoveClickListener()
end

function slot0._btndebugOnClick(slot0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.DebugNormal)
	ViewMgr.instance:closeAllPopupViews()
end

function slot0._btninitOnClick(slot0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.DebugInit)
	ViewMgr.instance:closeAllPopupViews()
end

function slot0._btnpackageOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoomDebugSelectPackageView)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
