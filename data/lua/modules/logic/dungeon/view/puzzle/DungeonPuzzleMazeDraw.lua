module("modules.logic.dungeon.view.puzzle.DungeonPuzzleMazeDraw", package.seeall)

slot0 = class("DungeonPuzzleMazeDraw", BaseView)

function slot0.onInitView(slot0)
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._goconnect = gohelper.findChild(slot0.viewGO, "#go_connect")
	slot0._imagelinetemplater = gohelper.findChildImage(slot0.viewGO, "#image_line_template_r")
	slot0._imagelinetemplatel = gohelper.findChildImage(slot0.viewGO, "#image_line_template_l")
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
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gomap)

	slot0._drag:AddDragBeginListener(slot0.onDragBeginHandler, slot0)
	slot0._drag:AddDragListener(slot0.onDragCallHandler, slot0)
	slot0._drag:AddDragEndListener(slot0.onDragEndHandler, slot0)

	slot0._drawHandleMap = {
		[DungeonPuzzleEnum.MazeObjType.Start] = slot0.drawNormalObject,
		[DungeonPuzzleEnum.MazeObjType.End] = slot0.drawNormalObject,
		[DungeonPuzzleEnum.MazeObjType.CheckPoint] = slot0.drawCheckPoint,
		[DungeonPuzzleEnum.MazeObjType.CheckPointPassed] = slot0.drawCheckPoint,
		[DungeonPuzzleEnum.MazeObjType.Block] = slot0.drawBlockObject
	}
	slot0._curDragLine = {
		x2 = 0,
		y2 = 0,
		x1 = 0,
		y1 = 0
	}
	slot0._objectMap = {}
	slot0._lineMap = {}
	slot0._alertObjList = {}
	slot0._alertSymbolPool = {}
	slot0._canTouch = true
end

function slot0.onDestroyView(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end
end

function slot0.onOpen(slot0)
	slot0:drawAllObjects()
	slot0:restartGame()
end

function slot0.onClose(slot0)
	if slot0:getOrCreatePawnObj().animEvent then
		slot1.animEvent:RemoveEventListener(DungeonPuzzleEnum.AnimEvent_OnJump)
	end
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

	slot0:removeAllLine()
	slot0:removeAllObjects()
	slot0:restartGame()
	slot0:drawAllObjects()
	gohelper.setAsLastSibling(slot0:getOrCreatePawnObj().go)
end

function slot0.drawAllObjects(slot0)
	for slot5, slot6 in ipairs(DungeonPuzzleMazeDrawModel.instance:getList()) do
		if slot0._drawHandleMap[slot6.objType] then
			if slot6.isPos then
				slot7(slot0, slot6, slot6.x, slot6.y)
			else
				slot7(slot0, slot6, slot6.x1, slot6.y1, slot6.x2, slot6.y2)
			end
		end
	end
end

function slot0.drawNormalObject(slot0, slot1, slot2, slot3)
	slot4 = slot0:getOrCreateObject(true, slot2, slot3)

	gohelper.setActive(slot4.go, true)

	slot5 = DungeonPuzzleEnum.MazeObjResType[slot1.objType]

	UISpriteSetMgr.instance:setPuzzleSprite(slot4.image, slot5[1], true)
	recthelper.setAnchor(slot4.imageTf, slot5[2], slot5[3])

	if slot1.objType == DungeonPuzzleEnum.MazeObjType.Start or slot1.objType == DungeonPuzzleEnum.MazeObjType.End then
		gohelper.setActive(slot4.goChecked, true)
		slot4.anim:Play("highlight_loop", 0, 0)
	end
end

function slot0.drawBlockObject(slot0, slot1, slot2, slot3, slot4, slot5)
	gohelper.setActive(slot0:getOrCreateObject(false, slot2, slot3, slot4, slot5).go, true)

	slot7 = DungeonPuzzleEnum.mazeBlockResMap[slot1.val] or DungeonPuzzleEnum.MazeObjResType[slot1.objType]

	UISpriteSetMgr.instance:setPuzzleSprite(slot6.image, slot7[1], true)
	recthelper.setAnchor(slot6.imageTf, slot7[2], slot7[3])
end

function slot0.drawCheckPoint(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0:getOrCreateObject(true, slot2, slot3).go, true)

	slot5 = slot1.objType
	slot6 = nil

	if DungeonPuzzleMazeDrawController.instance:alreadyCheckPoint(slot1) then
		gohelper.setActive(slot4.goChecked, true)

		slot6 = DungeonPuzzleEnum.mazeCheckPointPassedResMap[slot1.val] or DungeonPuzzleEnum.MazeObjResType[DungeonPuzzleEnum.MazeObjType.CheckPointPassed]
	else
		gohelper.setActive(slot4.goChecked, false)

		slot6 = DungeonPuzzleEnum.mazeCheckPointResMap[slot1.val] or DungeonPuzzleEnum.MazeObjResType[slot5]
	end

	slot7 = slot6[1]

	UISpriteSetMgr.instance:setPuzzleSprite(slot4.image, slot7, true)
	UISpriteSetMgr.instance:setPuzzleSprite(slot4.imageChecked, slot7, true)
	recthelper.setAnchor(slot4.imageTf, slot6[2], slot6[3])
end

function slot0.getOrCreatePawnObj(slot0)
	if not slot0._objPawn then
		slot1 = slot0:getUserDataTb_()
		slot3 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot0._gomap, "pawn")
		slot1.go = slot3
		slot1.image = gohelper.findChildImage(slot3, "#go_ctrl/#image_content")
		slot1.imageTf = slot1.image.transform
		slot1.goCtrl = gohelper.findChild(slot3, "#go_ctrl")
		slot1.tf = slot3.transform
		slot1.dir = DungeonPuzzleEnum.dir.left
		slot1.anim = slot1.image.gameObject:GetComponent(typeof(UnityEngine.Animator))

		slot1.anim:Play("open")

		slot1.animEvent = slot1.image.gameObject:GetComponent(typeof(ZProj.AnimationEventWrap))

		slot1.animEvent:AddEventListener(DungeonPuzzleEnum.AnimEvent_OnJump, slot0.onPawnJump, slot0)
		transformhelper.setLocalScale(slot1.goCtrl.transform, 1.5, 1.5, 1)

		slot4 = DungeonPuzzleEnum.MazePawnPath

		UISpriteSetMgr.instance:setPuzzleSprite(slot1.image, slot4[1], true)
		recthelper.setAnchor(slot1.goCtrl.transform, slot4[2], slot4[3])

		slot0._objPawn = slot1
	end

	return slot1
end

function slot0.onPawnJump(slot0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_move)
end

function slot0.initPawn(slot0)
	slot1, slot2 = DungeonPuzzleMazeDrawModel.instance:getStartPoint()

	if slot1 ~= nil then
		slot3, slot4 = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(slot1, slot2)
		slot5 = slot0:getOrCreatePawnObj()

		recthelper.setAnchor(slot5.tf, slot3, slot4)
		gohelper.setAsLastSibling(slot5.go)
	end
end

function slot0.restartGame(slot0)
	logNormal("restartGame")

	slot0._canTouch = true
	slot0._isClear = false
	slot0._alreadyDrag = false

	DungeonPuzzleMazeDrawController.instance:startGame()
	slot0:initPawn()
end

function slot0.syncPath(slot0)
	slot1, slot2 = DungeonPuzzleMazeDrawController.instance:getPassedPoints()
	slot3, slot4 = nil
	slot5 = {}

	for slot9 = 1, #slot1 do
		slot10 = slot1[slot9]
		slot11 = slot2[slot9]

		if slot3 ~= nil then
			if DungeonPuzzleMazeDrawController.getFromToDir(slot3, slot4, slot10, slot11) then
				slot13, slot14, slot15, slot16 = DungeonPuzzleMazeDrawController.formatPos(slot3, slot4, slot10, slot11)

				slot0:refreshLineDir(slot0:getOrCreateLine(DungeonPuzzleMazeDrawModel.getLineKey(slot13, slot14, slot15, slot16), slot13, slot14, slot15, slot16), slot12)

				if slot0:isReverseDir(slot12) then
					slot0:refreshLineProgress(slot18, slot12, 0)
				else
					slot0:refreshLineProgress(slot18, slot12, 1)
				end

				slot5[slot17] = 1
			else
				logNormal(string.format("error dir in (%s,%s,%s,%s)", slot3, slot4, slot10, slot11))
			end
		end

		slot4 = slot11
		slot3 = slot10
	end

	for slot9, slot10 in pairs(slot0._lineMap) do
		if not slot5[slot9] then
			slot10.image.fillAmount = 0
			slot10.dir = nil
		end
	end

	DungeonPuzzleMazeDrawController.instance:resetLineDirty()
end

function slot0.syncDragLine(slot0)
	slot1 = false
	slot2, slot3, slot4, slot5 = DungeonPuzzleMazeDrawController.instance:getProgressLine()

	if not DungeonPuzzleMazeDrawController.instance:isBackward(slot2, slot3) then
		for slot10, slot11 in pairs(DungeonPuzzleMazeDrawController.instance:getAlertMap()) do
			return false
		end
	end

	slot6 = slot4 or slot5

	if slot2 and slot3 and slot6 then
		slot7, slot8 = DungeonPuzzleMazeDrawController.instance:getLastPos()
		slot9, slot10, slot11, slot12 = DungeonPuzzleMazeDrawController.formatPos(slot7, slot8, slot2, slot3)

		if slot0._curDragLine.x1 ~= slot9 or slot0._curDragLine.y1 ~= slot10 or slot0._curDragLine.x2 ~= slot11 or slot0._curDragLine.y2 ~= slot12 then
			slot0._curDragLine.y2 = slot12
			slot0._curDragLine.x2 = slot11
			slot0._curDragLine.y1 = slot10
			slot0._curDragLine.x1 = slot9
			slot1 = true

			slot0:cleanDragLine()
		end

		slot13 = DungeonPuzzleMazeDrawController.getFromToDir(slot7, slot8, slot2, slot3)

		slot0:refreshPawnDir(slot13)
		slot0:refreshLineProgress(slot0:getOrCreateLine(DungeonPuzzleMazeDrawModel.getLineKey(slot9, slot10, slot11, slot12), slot9, slot10, slot11, slot12), slot13, slot6)

		return slot1
	end

	return false
end

function slot0.refreshPawnDir(slot0, slot1)
	if slot1 ~= DungeonPuzzleEnum.dir.up and slot1 ~= DungeonPuzzleEnum.dir.down then
		transformhelper.setLocalRotation(slot0._objPawn.tf, 0, slot1 == DungeonPuzzleEnum.dir.right and 180 or 0, 0)

		slot0._objPawn.dir = slot1
	end
end

function slot0.syncAlertObjs(slot0)
	slot0:recycleAlertObjs()

	slot2, slot3 = nil

	for slot7, slot8 in pairs(DungeonPuzzleMazeDrawController.instance:getAlertMap()) do
		if type(slot7) == "table" then
			slot10 = slot0:getOrCreateAlertObj()
			slot15, slot16 = DungeonPuzzleMazeDrawModel.instance:getLineAnchor(slot7.x1, slot7.y1, slot7.x2, slot7.y2)

			recthelper.setAnchor(slot10.tf, slot15 + DungeonPuzzleEnum.MazeAlertBlockOffsetX, slot16 + DungeonPuzzleEnum.MazeAlertBlockOffsetY)
			gohelper.setAsLastSibling(slot10.go)
			AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)

			return
		end
	end

	for slot8, slot9 in pairs(slot1) do
		if type(slot8) == "string" then
			slot11 = slot0:getOrCreateAlertObj()
			slot12 = string.splitToNumber(slot8, "_")
			slot13, slot14 = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(slot12[1], slot12[2])

			recthelper.setAnchor(slot11.tf, slot13 + DungeonPuzzleEnum.MazeAlertCrossOffsetX, slot14 + DungeonPuzzleEnum.MazeAlertCrossOffsetY)
			gohelper.setAsLastSibling(slot11.go)

			if not false then
				AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)

				slot4 = true
			end
		end
	end
end

function slot0.syncPawn(slot0)
	slot1, slot2 = DungeonPuzzleMazeDrawController.instance:getLastPos()
	slot3, slot4 = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(slot1, slot2)

	recthelper.setAnchor(slot0:getOrCreatePawnObj().tf, slot3, slot4)
end

function slot0.refreshLineDir(slot0, slot1, slot2)
	slot3 = 0
	slot4 = 0
	slot5 = 0
	slot6 = DungeonPuzzleEnum.mazeUILineHorizonUIWidth

	if slot2 == DungeonPuzzleEnum.dir.left then
		slot4 = slot1.resCfg[5] == true and 180 or 0
		slot1.image.fillOrigin = slot1.resCfg[5] == true and slot0._imagelinetemplatel.fillOrigin or slot0._imagelinetemplater.fillOrigin
	elseif slot2 == DungeonPuzzleEnum.dir.right then
		slot4 = slot1.resCfg[5] == true and 180 or 0
		slot1.image.fillOrigin = slot1.resCfg[5] == true and slot0._imagelinetemplater.fillOrigin or slot0._imagelinetemplatel.fillOrigin
	elseif slot2 == DungeonPuzzleEnum.dir.up then
		slot3 = slot1.resCfg[5] == true and 180 or 0
		slot6 = DungeonPuzzleEnum.mazeUILineVerticalUIWidth
		slot5 = 90
		slot4 = 0
		slot1.image.fillOrigin = slot1.resCfg[5] == true and slot0._imagelinetemplater.fillOrigin or slot0._imagelinetemplatel.fillOrigin
	elseif slot2 == DungeonPuzzleEnum.dir.down then
		slot3 = slot1.resCfg[5] == true and 180 or 0
		slot6 = DungeonPuzzleEnum.mazeUILineVerticalUIWidth
		slot5 = 90
		slot4 = 0
		slot1.image.fillOrigin = slot1.resCfg[5] == true and slot0._imagelinetemplatel.fillOrigin or slot0._imagelinetemplater.fillOrigin
	end

	transformhelper.setLocalRotation(slot1.imageTf, slot3, slot4, slot5)
	recthelper.setWidth(slot1.imageTf, slot6)

	slot1.dir = slot2
end

function slot0.refreshLineProgress(slot0, slot1, slot2, slot3)
	if slot1.dir == nil and slot2 ~= nil then
		slot0:refreshLineDir(slot1, slot2)
	end

	if slot1.dir ~= nil then
		if slot0:isReverseDir(slot1.dir) then
			slot3 = 1 - slot3
		end

		slot1.image.fillAmount = slot3
	end
end

function slot0.isReverseDir(slot0, slot1)
	return slot1 == DungeonPuzzleEnum.dir.left or slot1 == DungeonPuzzleEnum.dir.down
end

function slot0.cleanDragLine(slot0)
	for slot4, slot5 in pairs(slot0._lineMap) do
		if slot5.image.fillAmount <= 0.999 and slot6 >= 0.01 then
			slot5.image.fillAmount = 0
		end
	end
end

function slot0.refreshAlertColor(slot0)
	slot2 = DungeonPuzzleMazeDrawController.instance:getAlertMap()

	for slot6, slot7 in pairs(slot0._lineMap) do
		UISpriteSetMgr.instance:setPuzzleSprite(slot7.image, DungeonPuzzleMazeDrawController.instance:hasAlertObj() and slot7.resCfg[4] or slot7.resCfg[1], false)
	end

	for slot6, slot7 in pairs(slot0._objectMap) do
		if DungeonPuzzleMazeDrawModel.instance:getObjByLineKey(slot6) and slot8.objType == DungeonPuzzleEnum.MazeObjType.Block then
			slot10 = DungeonPuzzleEnum.mazeBlockResMap[slot8.val]

			UISpriteSetMgr.instance:setPuzzleSprite(slot7.image, slot2[slot8] and slot10[4] or slot10[1], true)
		end
	end
end

function slot0.refreshCheckPoints(slot0)
	for slot7, slot8 in ipairs(DungeonPuzzleMazeDrawModel.instance:getList()) do
		if slot8.objType == DungeonPuzzleEnum.MazeObjType.CheckPoint then
			slot0:drawCheckPoint(slot8, slot8.x, slot8.y)

			if DungeonPuzzleMazeDrawController.instance:alreadyCheckPoint(slot8) then
				slot2 = "" .. tostring(slot8)
				slot3 = 0 + 1
			end
		end
	end

	if slot0._lastCheckSum ~= nil and slot0._lastCheckSum ~= slot2 and slot0._lastCheckCount <= slot3 then
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_unlock)
	end

	slot0._lastCheckSum = slot2
	slot0._lastCheckCount = slot3
end

function slot0.getOrCreateLine(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0._lineMap[slot1] then
		slot6 = slot0:getUserDataTb_()
		slot8 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._goconnect, slot1)
		slot6.go = slot8
		slot6.image = gohelper.findChildImage(slot8, "image_horizon")
		slot6.imageTf = slot6.image.transform
		slot6.y2 = slot5
		slot6.x2 = slot4
		slot6.y1 = slot3
		slot6.x1 = slot2
		slot9 = DungeonPuzzleEnum.SpecLineResMap[slot1] or DungeonPuzzleEnum.NormalLineResPath
		slot6.resCfg = slot9

		UISpriteSetMgr.instance:setPuzzleSprite(slot6.image, slot9[1], false)

		slot11, slot12 = DungeonPuzzleMazeDrawModel.instance:getLineAnchor(slot2, slot3, slot4, slot5)

		recthelper.setAnchor(slot8.transform, slot11 - 0.5, slot12 - 1.3)

		slot0._lineMap[slot1] = slot6
	end

	return slot6
end

function slot0.getOrCreateObject(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = nil

	if not slot0._objectMap[(not slot1 or DungeonPuzzleMazeDrawModel.getPosKey(slot2, slot3)) and DungeonPuzzleMazeDrawModel.getLineKey(slot2, slot3, slot4, slot5)] then
		slot7 = slot0:getUserDataTb_()
		slot9 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gomap, slot6)
		slot7.go = slot9
		slot7.image = gohelper.findChildImage(slot9, "#image_content")
		slot7.imageChecked = gohelper.findChildImage(slot9, "highlight/#image_content (1)")
		slot7.goChecked = gohelper.findChild(slot9, "highlight")
		slot7.imageTf = slot7.image.transform
		slot7.anim = slot7.goChecked:GetComponent(typeof(UnityEngine.Animator))
		slot10, slot11 = nil

		if slot1 then
			slot10, slot11 = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(slot2, slot3)
		else
			slot10, slot11 = DungeonPuzzleMazeDrawModel.instance:getLineObjectAnchor(slot2, slot3, slot4, slot5)
		end

		recthelper.setAnchor(slot9.transform, slot10, slot11)

		slot0._objectMap[slot6] = slot7
	end

	return slot7
end

function slot0.getOrCreateAlertObj(slot0)
	slot1 = nil

	if #slot0._alertSymbolPool <= 0 then
		slot1 = slot0:getUserDataTb_()
		slot3 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gomap, "alertObj")
		slot1.go = slot3
		slot1.image = gohelper.findChildImage(slot3, "#image_content")
		slot1.imageTf = slot1.image.transform
		slot1.tf = slot3.transform

		UISpriteSetMgr.instance:setPuzzleSprite(slot1.image, DungeonPuzzleEnum.MazeAlertResPath, true)
	else
		gohelper.setActive(table.remove(slot0._alertSymbolPool).go, true)
	end

	table.insert(slot0._alertObjList, slot1)

	return slot1
end

function slot0.recycleAlertObjs(slot0)
	for slot4 = #slot0._alertObjList, 1, -1 do
		slot5 = slot0._alertObjList[slot4]

		gohelper.setActive(slot5.go, false)
		table.insert(slot0._alertSymbolPool, slot5)

		slot0._alertObjList[slot4] = nil
	end
end

function slot0.removeAllLine(slot0)
	for slot4, slot5 in pairs(slot0._lineMap) do
		gohelper.destroy(slot5.go)

		slot5.go = nil
		slot5.image = nil
		slot5.imageTf = nil
		slot0._lineMap[slot4] = nil
	end
end

function slot0.removeAllObjects(slot0)
	for slot4, slot5 in pairs(slot0._objectMap) do
		gohelper.destroy(slot5.go)

		slot5.go = nil
		slot5.image = nil
		slot5.imageTf = nil
		slot0._objectMap[slot4] = nil
	end
end

function slot0.onDragBeginHandler(slot0, slot1, slot2)
	if not slot0._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0._gomap.transform)
	slot4, slot5 = DungeonPuzzleMazeDrawController.instance:getLastPos()
	slot6, slot7 = DungeonPuzzleMazeDrawModel.instance:getClosePosByTouchPos(slot3.x - DungeonPuzzleEnum.mazeMonsterTouchOffsetX, slot3.y - DungeonPuzzleEnum.mazeMonsterHeight)

	if slot6 ~= -1 and slot4 == slot6 and slot5 == slot7 then
		slot0:startDrag()
	end
end

function slot0.onDragCallHandler(slot0, slot1, slot2)
	if slot0._isPawnMoving then
		slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0._gomap.transform)
		slot4, slot5 = DungeonPuzzleMazeDrawModel.instance:getUIGridSize()
		slot6, slot7 = DungeonPuzzleMazeDrawModel.instance:getClosePosByTouchPos(slot3.x, slot3.y)

		if slot6 ~= -1 then
			DungeonPuzzleMazeDrawController.instance:goPassPos(slot6, slot7)
		else
			slot8, slot9, slot10, slot11, slot12, slot13, slot14 = DungeonPuzzleMazeDrawModel.instance:getLineFieldByTouchPos(slot3.x, slot3.y)

			if slot8 then
				DungeonPuzzleMazeDrawController.instance:goPassLine(slot9, slot10, slot11, slot12, slot13, slot14)
			end
		end

		if DungeonPuzzleMazeDrawController.instance:isLineDirty() then
			slot0:syncPath()
			slot0:refreshAlertColor()
			slot0:syncAlertObjs()
			slot0:refreshCheckPoints()
		end

		if not slot8 and slot0:syncDragLine() then
			slot0:syncPath()
		end

		recthelper.setAnchor(slot0:getOrCreatePawnObj().tf, slot3.x, slot3.y)

		if slot8 then
			slot0:checkGameClear()
		end
	end
end

function slot0.onDragEndHandler(slot0, slot1, slot2)
	slot0:endDrag()
end

function slot0.startDrag(slot0)
	slot0._isPawnMoving = true

	slot0:getOrCreatePawnObj().anim:Play("image_content_drag")

	if not slot0._alreadyDrag then
		slot2, slot3 = DungeonPuzzleMazeDrawModel.instance:getStartPoint()

		slot0:closeCheckObject(slot2, slot3)

		slot0._alreadyDrag = true
	end
end

function slot0.endDrag(slot0)
	if slot0._isPawnMoving then
		slot0._isPawnMoving = false

		slot0:getOrCreatePawnObj().anim:Play("open")

		if DungeonPuzzleMazeDrawController.instance:hasAlertObj() then
			DungeonPuzzleMazeDrawController.instance:goBackPos()
			slot0:syncPawn()
			slot0:syncPath()
			slot0:cleanDragLine()
			slot0:refreshAlertColor()
			slot0:syncAlertObjs()
			slot0:refreshCheckPoints()
		else
			slot0:syncPawn()
			slot0:syncPath()
			slot0:cleanDragLine()
			slot0:checkGameClear()
		end
	end
end

function slot0.closeCheckObject(slot0, slot1, slot2)
	if slot0._objectMap[DungeonPuzzleMazeDrawModel.getPosKey(slot1, slot2)] then
		gohelper.setActive(slot4.goChecked, false)
	end
end

function slot0.checkGameClear(slot0)
	if slot0._isClear then
		return
	end

	if DungeonPuzzleMazeDrawController.instance:isGameClear() then
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)

		slot2, slot3 = DungeonPuzzleMazeDrawModel.instance:getEndPoint()

		slot0:closeCheckObject(slot2, slot3)
		DungeonPuzzleMazeDrawModel.instance:setClearStatus(slot1)

		slot0._canTouch = false
		slot0._isClear = true

		DungeonPuzzleMazeDrawController.instance:dispatchEvent(DungeonPuzzleEvent.MazeDrawGameClear)
		logNormal("MazeDraw Game Clear!!!")

		if slot0._isPawnMoving then
			slot0:endDrag()
		end
	end
end

return slot0
