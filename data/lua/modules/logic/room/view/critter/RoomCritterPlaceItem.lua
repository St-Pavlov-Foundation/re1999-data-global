module("modules.logic.room.view.critter.RoomCritterPlaceItem", package.seeall)

slot0 = class("RoomCritterPlaceItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_icon")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#go_click")
	slot0._uiclick = gohelper.getClickWithDefaultAudio(slot0._goclick)
	slot0._uidrag = SLFramework.UGUI.UIDragListener.Get(slot0._goclick)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._uiclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._uiclick:AddClickDownListener(slot0._btnclickOnClickDown, slot0)
	slot0._uidrag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._uidrag:AddDragListener(slot0._onDrag, slot0)
	slot0._uidrag:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0._uiclick:RemoveClickListener()
	slot0._uiclick:RemoveClickDownListener()
	slot0._uidrag:RemoveDragBeginListener()
	slot0._uidrag:RemoveDragListener()
	slot0._uidrag:RemoveDragEndListener()
end

function slot0._btnclickOnClickDown(slot0)
	slot0._isDragUI = false
end

function slot0._btnclickOnClick(slot0)
	if slot0._isDragUI then
		return
	end

	CritterController.instance:clickCritterPlaceItem(slot0:getViewBuilding(), slot0:getCritterId())
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._isDragUI = true
	slot0._isDragFirstBegin = true

	CritterController.instance:dispatchEvent(CritterEvent.CritterListOnDragBeginListener, slot2)
end

function slot0._onDrag(slot0, slot1, slot2)
	slot0._isDragUI = true

	if not slot0._isStartDrag and slot0._dragStartY < slot2.position.y and slot0._isDragFirstBegin then
		if nil then
			slot0._isStartDrag = true
		else
			slot0._isDragFirstBegin = false
		end
	end

	if not slot0._isStartDrag then
		CritterController.instance:dispatchEvent(CritterEvent.CritterListOnDragListener, slot2)
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._isDragUI = false

	if slot0._isStartDrag then
		slot0._isStartDrag = false
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterListOnDragEndListener, slot2)
end

function slot0._editableInitView(slot0)
	slot0._isStartDrag = false
	slot0._isDragFirstBegin = false
	slot0._isDragUI = false
	slot0._dragStartY = 250 * UnityEngine.Screen.height / 1080
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:setCritter()
	slot0:refresh()
end

function slot0.setCritter(slot0)
	slot1, slot2 = slot0:getCritterId()

	if not slot0.critterIcon then
		slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._goicon)

		slot0.critterIcon:setSelectUIVisible(true)
	end

	slot0.critterIcon:setMOValue(slot1, slot2)
	slot0.critterIcon:showMood()
	slot0.critterIcon:setIsShowBuildingIcon(ManufactureModel.instance:getCritterRestingBuilding(slot1) ~= slot0:getViewBuilding())
end

function slot0.refresh(slot0)
end

function slot0.onSelect(slot0, slot1)
	if slot0.critterIcon then
		slot0.critterIcon:onSelect(slot1)
	end

	slot0._isSelect = slot1
end

function slot0.getCritterId(slot0)
	slot1, slot2 = nil

	if slot0._mo then
		slot1 = slot0._mo:getId()
		slot2 = slot0._mo:getDefineId()
	end

	return slot1, slot2
end

function slot0.getViewBuilding(slot0)
	slot1, slot2 = slot0._view.viewContainer:getContainerViewBuilding(true)

	return slot1, slot2
end

function slot0.onDestroy(slot0)
end

return slot0
