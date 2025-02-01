module("modules.logic.room.view.backpack.RoomCritterDecomposeItem", package.seeall)

slot0 = class("RoomCritterDecomposeItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocritterIcon = gohelper.findChild(slot0.viewGO, "#go_critterIcon")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._goAni = gohelper.findChild(slot0.viewGO, "vx_compose")
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.viewGO)
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.click:AddClickListener(slot0.onClick, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, slot0.refreshSelected, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.BeforeDecomposeCritter, slot0.beforeDecompose, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, slot0._onCritterLockStatusChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0.click:RemoveClickListener()
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, slot0.refreshSelected, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.BeforeDecomposeCritter, slot0.beforeDecompose, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, slot0._onCritterLockStatusChange, slot0)
end

function slot0.onClick(slot0)
	if slot0._mo:isLock() then
		GameFacade.showToast(ToastEnum.RoomCritterIsLock)

		return
	end

	if RoomCritterDecomposeListModel.instance:isSelect(slot0._mo:getId()) then
		RoomCritterDecomposeListModel.instance:unselectDecomposeCritter(slot0._mo)
	else
		RoomCritterDecomposeListModel.instance:selectDecomposeCritter(slot0._mo)
	end
end

function slot0.beforeDecompose(slot0)
	if RoomCritterDecomposeListModel.instance:isSelect(slot0._mo:getId()) then
		gohelper.setActive(slot0._goAni, true)
	end
end

function slot0._onCritterLockStatusChange(slot0, slot1)
	slot2 = slot0._mo and slot0._mo:getId()

	if not slot0._critterIcon or not slot2 or slot2 ~= slot1 then
		return
	end

	slot0._critterIcon:refreshLockIcon()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if not slot0._critterIcon then
		slot0._critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocritterIcon)

		slot0._critterIcon:setCanClick(false)
		slot0._critterIcon:setLockIconShow(true)
		slot0._critterIcon:setMaturityIconShow(true)
	end

	slot0._critterIcon:onUpdateMO(slot0._mo)
	slot0:refreshSelected()
	gohelper.setActive(slot0._goAni, false)
end

function slot0.refreshSelected(slot0)
	gohelper.setActive(slot0._goselect, RoomCritterDecomposeListModel.instance:isSelect(slot0._mo:getId()))
end

function slot0.getAnimator(slot0)
	return slot0.animator
end

function slot0.onDestroyView(slot0)
end

return slot0
