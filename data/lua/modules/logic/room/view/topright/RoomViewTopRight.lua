module("modules.logic.room.view.topright.RoomViewTopRight", package.seeall)

slot0 = class("RoomViewTopRight", BaseView)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0)

	slot0._path = slot1
	slot0._resPath = slot2
	slot0._param = slot3
end

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, slot0._refreshShow, slot0)
	slot0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, slot0._refreshShow, slot0)
	slot0:addEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, slot0._refreshShow, slot0)

	slot0._resourceItemList = {}

	if string.nilorempty(slot0._path) or string.nilorempty(slot0._resPath) or not LuaUtil.tableNotEmpty(slot0._param) then
		return
	end

	slot0._topRight = slot0.viewContainer:getResInst(slot0._resPath, gohelper.findChild(slot0.viewGO, slot0._path), "topright")
	slot0._goflyitem = gohelper.findChild(slot0._topRight, "go_flyitem")
	slot0._goresource = gohelper.findChild(slot0._topRight, "container/resource")
	slot5 = false

	gohelper.setActive(slot0._goflyitem, slot5)

	for slot5 = 1, 6 do
		gohelper.setActive(gohelper.cloneInPlace(slot0._goresource, "resource" .. slot5), false)

		if slot0._param[slot5] then
			slot7.parent = slot0
			slot7.index = slot5
			slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0._topRight, "container/resource" .. slot5), slot7.classDefine, slot7)
		end
	end

	gohelper.setActive(slot0._goresource, false)

	slot0._flyItemPoolList = slot0:getUserDataTb_()
end

function slot0.onDestroyView(slot0)
end

function slot0._onOpenView(slot0, slot1)
	slot0:_refreshShow()
end

function slot0._onCloseView(slot0, slot1)
	slot0:_refreshShow()
end

function slot0._refreshShow(slot0)
	gohelper.setActive(slot0._topRight, slot0:_getTopView() == slot0.viewName and not RoomCharacterHelper.isInDialogInteraction() and not RoomWaterReformModel.instance:isWaterReform() and not RoomSkinModel.instance:getIsShowRoomSkinList() and not RoomTransportController.instance:isTransportPathShow())
end

function slot0._getTopView(slot0)
	for slot5 = #NavigateMgr.sortOpenViewNameList(ViewMgr.instance:getOpenViewNameList()), 1, -1 do
		if ViewMgr.instance:getContainer(slot1[slot5]) and slot7._views then
			for slot11 = #slot7._views, 1, -1 do
				if slot7._views[slot11].__cname == slot0.__cname then
					return slot6
				end
			end
		end
	end
end

function slot0.getFlyGO(slot0)
	if slot0._flyItemPoolList[#slot0._flyItemPoolList] then
		table.remove(slot0._flyItemPoolList, #slot0._flyItemPoolList)
	else
		slot1 = gohelper.cloneInPlace(slot0._goflyitem, "flyEffect")
	end

	gohelper.setActive(slot1, false)
	gohelper.setActive(slot1, true)

	return slot1
end

function slot0.returnFlyGO(slot0, slot1)
	gohelper.setActive(slot1, false)
	table.insert(slot0._flyItemPoolList, slot1)
end

return slot0
