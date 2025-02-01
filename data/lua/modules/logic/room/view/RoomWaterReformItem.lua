module("modules.logic.room.view.RoomWaterReformItem", package.seeall)

slot0 = class("RoomWaterReformItem", ListScrollCellExtend)
slot1 = "#BFB5A3"

function slot0.onInitView(slot0)
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "go_empty")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "go_icon")
	slot0._btnItem = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_icon")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "go_locked")
	slot0._rawImageIcon = gohelper.onceAddComponent(slot0._goicon, gohelper.Type_RawImage)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnItem:AddClickListener(slot0._onBtnItemClick, slot0)
	slot0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, slot0._waterReformShowChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnItem:RemoveClickListener()
	slot0:removeEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, slot0._waterReformShowChanged, slot0)
end

function slot0._onBtnItemClick(slot0)
	if not slot0._mo then
		return
	end

	RoomWaterReformController.instance:selectWaterType(slot0._mo.waterType)
end

function slot0._waterReformShowChanged(slot0)
	if RoomWaterReformModel.instance:isWaterReform() then
		return
	end

	if slot0._rawImageIcon then
		slot0._rawImageIcon.texture = nil
	end

	slot0:clearItem()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goempty, false)

	slot0._rtIndex = OrthCameraRTMgr.instance:getNewIndex()

	OrthCameraRTMgr.instance:setRawImageUvRect(slot0._rawImageIcon, slot0._rtIndex)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._rawImageIcon, uv0)

	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._backBlockIds = {}
end

function slot0.onUpdateMO(slot0, slot1)
	if slot1 and slot1.blockId and slot2 ~= (slot0._mo and slot0._mo.blockId) then
		slot0:clearItem()

		slot0._mo = slot1

		slot0:_refreshBlock()
	end

	slot0:_refreshLocked()
end

function slot0._refreshBlock(slot0)
	if not (slot0._mo and slot0._mo.blockId) then
		return
	end

	slot0._scene.inventorymgr:addBlockEntity(slot1, true)
	OrthCameraRTMgr.instance:setRawImageUvRect(slot0._rawImageIcon, slot0._scene.inventorymgr:getIndexById(slot1))
end

function slot0._refreshLocked(slot0)
	gohelper.setActive(slot0._golocked, not RoomWaterReformModel.instance:isUnlockWaterReform(slot0._mo.waterType))
end

function slot0.clearItem(slot0)
	if not (slot0._mo and slot0._mo.blockId) then
		return
	end

	slot0._scene.inventorymgr:removeBlockEntity(slot1)

	slot0._mo = nil
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._rawImageIcon then
		slot0._rawImageIcon.texture = nil
	end

	slot0:clearItem()
end

return slot0
