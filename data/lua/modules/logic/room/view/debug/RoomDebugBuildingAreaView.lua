module("modules.logic.room.view.debug.RoomDebugBuildingAreaView", package.seeall)

slot0 = class("RoomDebugBuildingAreaView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_close")
	slot0._goarearoot = gohelper.findChild(slot0.viewGO, "#go_content/#go_arearoot")
	slot0._goareaitem = gohelper.findChild(slot0.viewGO, "#go_content/#go_arearoot/#go_areaitem")

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
	slot0._goarearootTrs = slot0._goarearoot.transform
	slot0._itemTbList = {}
	slot0._lastIndex = 1

	table.insert(slot0._itemTbList, slot0:_createTbByGO(slot0._goareaitem))
end

function slot0._createTbByGO(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.goTrs = slot1.transform
	slot2.txtname = gohelper.findChildText(slot1, "txt_name")
	slot2._canvasGroup = slot1:GetComponent(typeof(UnityEngine.CanvasGroup))

	return slot2
end

function slot0.onOpen(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		slot0:closeThis()

		return
	end

	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._refreshUI, slot0)

	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._refreshUI, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshUI(slot0)
	slot0._focusPos = slot0._scene.camera:getCameraFocus()
	slot2 = 1

	for slot6, slot7 in pairs(RoomMapBuildingModel.instance:getAllOccupyDict()) do
		for slot11, slot12 in pairs(slot7) do
			if slot2 > #slot0._itemTbList then
				table.insert(slot0._itemTbList, slot0:_createTbByGO(gohelper.cloneInPlace(slot0._goareaitem)))
			end

			slot13 = slot0._itemTbList[slot2]
			slot2 = slot2 + 1

			slot0:_setTbItemAvtive(slot13, true)
			slot0:_refreshByParam(slot13, slot12)
		end
	end

	for slot6 = slot2, #slot0._itemTbList do
		slot0:_setTbItemAvtive(slot0._itemTbList[slot6], false)
	end
end

function slot0._setTbItemAvtive(slot0, slot1, slot2)
	if slot1.isActive ~= slot2 then
		slot1.isActive = slot2

		gohelper.setActive(slot1.go, slot2)
	end
end

function slot0._refreshByParam(slot0, slot1, slot2)
	if slot1.buildingId ~= slot2.buildingId or slot1.posindex ~= slot2.index then
		slot1.buildingId = slot2.buildingId
		slot1.posindex = slot2.index
		slot5 = RoomMapModel.instance:getBuildingConfigParam(slot2.buildingId).pointList[slot2.index]
		slot1.txtname.text = slot5.x .. "#" .. slot5.y
	end

	slot0:_setTbItemPos(HexMath.hexToPosition(slot2.hexPoint, RoomBlockEnum.BlockSize), slot1, slot0._goarearootTrs)
end

function slot0._setTbItemPos(slot0, slot1, slot2, slot3)
	slot5 = recthelper.worldPosToAnchorPos(Vector3(slot1.x, 0.12, slot1.y), slot3)
	slot7 = 1
	slot2._canvasGroup.alpha = Vector2.Distance(slot0._focusPos, slot1) <= 2.5 and 1 or slot6 >= 3.5 and 0 or 3.5 - slot6

	recthelper.setAnchor(slot2.goTrs, slot5.x, slot5.y)
end

return slot0
