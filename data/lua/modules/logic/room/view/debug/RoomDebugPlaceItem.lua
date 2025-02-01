module("modules.logic.room.view.debug.RoomDebugPlaceItem", package.seeall)

slot0 = class("RoomDebugPlaceItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._icon = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "icon"), gohelper.Type_RawImage)
	slot0._txtdefineid = gohelper.findChildText(slot0.viewGO, "#txt_defineid")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._txtuseCount = gohelper.findChildText(slot0.viewGO, "#txt_useCount")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugReplaceBlock, slot0._delayUpdateTask, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugRootOutBlock, slot0._delayUpdateTask, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugReplaceBlock, slot0._delayUpdateTask, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRootOutBlock, slot0._delayUpdateTask, slot0)
end

function slot0._btnclickOnClick(slot0)
	RoomDebugPlaceListModel.instance:setSelect(slot0._mo.id)
end

function slot0._editableInitView(slot0)
	slot0._isSelect = false

	gohelper.addUIClickAudio(slot0._btnclick.gameObject, AudioEnum.UI.UI_Common_Click)
end

function slot0._refreshUI(slot0)
	slot0._txtdefineid.text = "资源id：" .. slot0._mo.id
	slot0._txtname.text = RoomHelper.getBlockPrefabName(slot0._mo.config.prefabPath)
	slot0._txtuseCount.text = string.format("使用总次数：%s\n本地图次数：%s", RoomDebugController.instance:getUseCountByDefineId(slot0._mo.id), slot0:_getMapUseCountByDefineId(slot0._mo.id))
end

function slot0._getMapUseCountByDefineId(slot0, slot1)
	for slot7, slot8 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
		if slot8.blockState == RoomBlockEnum.BlockState.Map and slot8.blockId > 0 and slot8.defineId == slot1 then
			slot3 = 0 + 1
		end
	end

	return slot3
end

function slot0._delayUpdateTask(slot0)
	if not slot0._hasDelayUpdateTask then
		slot0._hasDelayUpdateTask = true

		TaskDispatcher.runDelay(slot0._onRunDelayUpdateTask, slot0, 0.1)
	end
end

function slot0._onRunDelayUpdateTask(slot0)
	if slot0._hasDelayUpdateTask then
		slot0._hasDelayUpdateTask = false

		slot0:_refreshUI()
	end
end

function slot0.onUpdateMO(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot0._isSelect)

	slot2 = slot0._mo and slot0._mo.blockId
	slot0._mo = slot1

	slot0:_refreshBlock(slot1 and slot1.blockId)
	slot0:_refreshUI()
end

function slot0._refreshBlock(slot0, slot1)
	slot0._lastOldBlockId = slot1

	if slot0._lastOldBlockId then
		GameSceneMgr.instance:getCurScene().inventorymgr:removeBlockEntity(slot3)
	end

	gohelper.setActive(slot0._icon, slot1 and true or false)

	if slot1 then
		slot2.inventorymgr:addBlockEntity(slot1)
		OrthCameraRTMgr.instance:setRawImageUvRect(slot0._icon, slot2.inventorymgr:getIndexById(slot1))
	end
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)

	slot0._isSelect = slot1
end

function slot0.onDestroyView(slot0)
	slot0:_refreshBlock(nil)
	TaskDispatcher.cancelTask(slot0._onRunDelayUpdateTask, slot0)
end

return slot0
