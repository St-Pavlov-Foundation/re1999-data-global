module("modules.logic.dungeon.view.puzzle.DungeonPuzzlePipes", package.seeall)

slot0 = class("DungeonPuzzlePipes", BaseView)

function slot0.onInitView(slot0)
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._goconnect = gohelper.findChild(slot0.viewGO, "#go_connect")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0:initConst()

	slot0._touch = TouchEventMgrHepler.getTouchEventMgr(slot0._gomap)

	slot0._touch:SetOnlyTouch(true)
	slot0._touch:SetIgnoreUI(true)
	slot0._touch:SetOnClickCb(slot0._onClickContainer, slot0)

	slot0._canTouch = true
end

function slot0.initConst(slot0)
	slot0._itemSizeX = 132
	slot0._itemSizeY = 130
	slot0._gameWidth, slot0._gameHeight = DungeonPuzzlePipeModel.instance:getGameSize()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._gridObjs = {}
	slot0._connectObjs = {}

	for slot4 = 1, slot0._gameWidth do
		for slot8 = 1, slot0._gameHeight do
			slot0._gridObjs[slot4] = slot0._gridObjs[slot4] or {}
			slot0._connectObjs[slot4] = slot0._connectObjs[slot4] or {}

			slot0:addNewItem(slot4, slot8)
		end
	end

	slot0:_refreshEntryItem()
	slot0:addEventCb(DungeonPuzzlePipeController.instance, DungeonPuzzleEvent.GuideClickGrid, slot0._onGuideClickGrid, slot0)
end

function slot0._onGuideClickGrid(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "_")

	slot0:_onClickGridItem(slot2[1], slot2[2])
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_resetGame()
	end)
end

function slot0._resetGame(slot0)
	if not slot0._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	DungeonPuzzlePipeController.instance:resetGame()

	for slot4 = 1, slot0._gameWidth do
		for slot8 = 1, slot0._gameHeight do
			slot0:initItem(slot4, slot8)
			slot0:_refreshConnectItem(slot4, slot8)
		end
	end

	slot0:_refreshEntryItem()
end

function slot0.addNewItem(slot0, slot1, slot2)
	slot0:_newPipeItem(slot1, slot2)
	slot0:initItem(slot1, slot2)
	slot0:_refreshConnectItem(slot1, slot2)
end

function slot0._newPipeItem(slot0, slot1, slot2)
	slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gomap, slot1 .. "_" .. slot2)
	slot5 = slot4.transform
	slot6, slot7 = DungeonPuzzlePipeModel.instance:getRelativePosition(slot1, slot2, slot0._itemSizeX, slot0._itemSizeY)

	recthelper.setAnchor(slot5, slot6, slot7)

	slot8 = slot0:getUserDataTb_()
	slot8.go = slot4
	slot8.image = gohelper.findChildImage(slot4, "#image_content")
	slot8.imageTf = slot8.image.transform
	slot8.tf = slot5
	slot0._gridObjs[slot1][slot2] = slot8
end

function slot0.initItem(slot0, slot1, slot2)
	slot4 = DungeonPuzzleEnum.backgroundRes[DungeonPuzzlePipeModel.instance:getData(slot1, slot2).value]
	slot7 = slot0._gridObjs[slot1][slot2]

	UISpriteSetMgr.instance:setPuzzleSprite(slot7.image, slot4[1], true)
	transformhelper.setLocalRotation(slot7.tf, 0, 0, slot4[2])
	recthelper.setAnchor(slot7.imageTf, slot4[3], slot4[4])
end

function slot0._refreshConnectItem(slot0, slot1, slot2)
	if slot1 > 0 and slot1 <= slot0._gameWidth and slot2 > 0 and slot2 <= slot0._gameHeight then
		if DungeonPuzzlePipeModel.instance:getData(slot1, slot2):getConnectValue() ~= 0 then
			slot0:_initConnectObj(slot0._connectObjs[slot1][slot2] or slot0:_newConnectObj(slot1, slot2), slot3, slot4)
		else
			slot0:hideConnectItem(slot5)
		end
	end
end

function slot0._newConnectObj(slot0, slot1, slot2)
	slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._goconnect, slot1 .. "_" .. slot2)
	slot5 = slot4.transform
	slot6, slot7 = DungeonPuzzlePipeModel.instance:getRelativePosition(slot1, slot2, slot0._itemSizeX, slot0._itemSizeY)

	recthelper.setAnchor(slot5, slot6, slot7)

	slot8 = slot0:getUserDataTb_()
	slot8.go = slot4
	slot8.image = gohelper.findChildImage(slot4, "#image_content")
	slot8.imageTf = slot8.image.transform
	slot8.tf = slot5
	slot0._connectObjs[slot1][slot2] = slot8

	return slot8
end

function slot0._initConnectObj(slot0, slot1, slot2, slot3)
	slot4 = nil

	if (not slot2:isEntry() or DungeonPuzzleEnum.connectRes[0]) and DungeonPuzzleEnum.connectRes[slot3] then
		slot1.go:SetActive(true)
		UISpriteSetMgr.instance:setPuzzleSprite(slot1.image, slot4[1], true)
		transformhelper.setLocalRotation(slot1.tf, 0, 0, slot4[2])
		recthelper.setAnchor(slot1.imageTf, slot4[3], slot4[4])
	else
		slot0:hideConnectItem(slot1)
	end
end

function slot0.hideConnectItem(slot0, slot1)
	if slot1 and slot1.go ~= nil then
		slot1.go:SetActive(false)
	end
end

function slot0._syncRotation(slot0, slot1, slot2, slot3)
	if slot3:isEntry() then
		return
	end

	transformhelper.setLocalRotation(slot0._gridObjs[slot1][slot2].tf, 0, 0, DungeonPuzzleEnum.backgroundRes[slot3.value][2])
end

function slot0._onClickContainer(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	slot2 = recthelper.screenPosToAnchorPos(slot1, slot0._gomap.transform)
	slot3, slot4 = DungeonPuzzlePipeModel.instance:getIndexByTouchPos(slot2.x, slot2.y, slot0._itemSizeX, slot0._itemSizeY)

	if slot3 ~= -1 then
		slot0:_onClickGridItem(slot3, slot4)
	end
end

function slot0._refreshConnection(slot0)
	for slot4 = 1, slot0._gameWidth do
		for slot8 = 1, slot0._gameHeight do
			slot0:_refreshConnectItem(slot4, slot8)
		end
	end
end

function slot0._refreshEntryItem(slot0)
	for slot5, slot6 in pairs(DungeonPuzzlePipeModel.instance:getEntryList()) do
		slot7 = slot6.x
		slot8 = slot6.y

		slot0._gridObjs[slot7][slot8].go:SetActive(not DungeonPuzzlePipeController.instance:getIsEntryClear(slot6))

		if slot0._connectObjs[slot7][slot8] then
			slot10.go:SetActive(slot11)

			if slot11 then
				DungeonPuzzlePipeModel.instance._connectEntryX = slot7
				DungeonPuzzlePipeModel.instance._connectEntryY = slot8

				DungeonPuzzlePipeController.instance:dispatchEvent(DungeonPuzzleEvent.GuideEntryConnectClear)
			end
		end

		if not gohelper.isNil(slot0:getOrderGO(slot7, slot8)) then
			gohelper.setActive(slot12, not slot11)
		end
	end
end

function slot0.getOrderGO(slot0, slot1, slot2)
	return gohelper.findChild(slot0.viewGO, string.format("indexs/#go_index_%s_%s", slot1, slot2))
end

function slot0._onClickGridItem(slot0, slot1, slot2)
	if not slot0._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	if DungeonPuzzlePipeModel.instance:getData(slot1, slot2):isEntry() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	DungeonPuzzlePipeController.instance:changeDirection(slot1, slot2, true)
	DungeonPuzzlePipeController.instance:updateConnection()
	slot0:_syncRotation(slot1, slot2, slot3)
	slot0:_refreshConnection()
	slot0:_refreshEntryItem()

	slot0._canTouch = not DungeonPuzzlePipeModel.instance:getGameClear()

	DungeonPuzzlePipeController.instance:checkDispatchClear()
end

function slot0.onClose(slot0)
	if slot0._touch then
		TouchEventMgrHepler.remove(slot0._touch)

		slot0._touch = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
