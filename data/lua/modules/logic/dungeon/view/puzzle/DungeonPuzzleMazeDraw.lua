module("modules.logic.dungeon.view.puzzle.DungeonPuzzleMazeDraw", package.seeall)

local var_0_0 = class("DungeonPuzzleMazeDraw", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._goconnect = gohelper.findChild(arg_1_0.viewGO, "#go_connect")
	arg_1_0._imagelinetemplater = gohelper.findChildImage(arg_1_0.viewGO, "#image_line_template_r")
	arg_1_0._imagelinetemplatel = gohelper.findChildImage(arg_1_0.viewGO, "#image_line_template_l")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._gomap)

	arg_4_0._drag:AddDragBeginListener(arg_4_0.onDragBeginHandler, arg_4_0)
	arg_4_0._drag:AddDragListener(arg_4_0.onDragCallHandler, arg_4_0)
	arg_4_0._drag:AddDragEndListener(arg_4_0.onDragEndHandler, arg_4_0)

	arg_4_0._drawHandleMap = {
		[DungeonPuzzleEnum.MazeObjType.Start] = arg_4_0.drawNormalObject,
		[DungeonPuzzleEnum.MazeObjType.End] = arg_4_0.drawNormalObject,
		[DungeonPuzzleEnum.MazeObjType.CheckPoint] = arg_4_0.drawCheckPoint,
		[DungeonPuzzleEnum.MazeObjType.CheckPointPassed] = arg_4_0.drawCheckPoint,
		[DungeonPuzzleEnum.MazeObjType.Block] = arg_4_0.drawBlockObject
	}
	arg_4_0._curDragLine = {
		x2 = 0,
		y2 = 0,
		x1 = 0,
		y1 = 0
	}
	arg_4_0._objectMap = {}
	arg_4_0._lineMap = {}
	arg_4_0._alertObjList = {}
	arg_4_0._alertSymbolPool = {}
	arg_4_0._canTouch = true
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._drag then
		arg_5_0._drag:RemoveDragBeginListener()
		arg_5_0._drag:RemoveDragListener()
		arg_5_0._drag:RemoveDragEndListener()

		arg_5_0._drag = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:drawAllObjects()
	arg_6_0:restartGame()
end

function var_0_0.onClose(arg_7_0)
	local var_7_0 = arg_7_0:getOrCreatePawnObj()

	if var_7_0.animEvent then
		var_7_0.animEvent:RemoveEventListener(DungeonPuzzleEnum.AnimEvent_OnJump)
	end
end

function var_0_0._btnresetOnClick(arg_8_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		arg_8_0:_resetGame()
	end)
end

function var_0_0._resetGame(arg_10_0)
	if not arg_10_0._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	arg_10_0:removeAllLine()
	arg_10_0:removeAllObjects()
	arg_10_0:restartGame()
	arg_10_0:drawAllObjects()

	local var_10_0 = arg_10_0:getOrCreatePawnObj()

	gohelper.setAsLastSibling(var_10_0.go)
end

function var_0_0.drawAllObjects(arg_11_0)
	local var_11_0 = DungeonPuzzleMazeDrawModel.instance:getList()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = arg_11_0._drawHandleMap[iter_11_1.objType]

		if var_11_1 then
			if iter_11_1.isPos then
				var_11_1(arg_11_0, iter_11_1, iter_11_1.x, iter_11_1.y)
			else
				var_11_1(arg_11_0, iter_11_1, iter_11_1.x1, iter_11_1.y1, iter_11_1.x2, iter_11_1.y2)
			end
		end
	end
end

function var_0_0.drawNormalObject(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:getOrCreateObject(true, arg_12_2, arg_12_3)

	gohelper.setActive(var_12_0.go, true)

	local var_12_1 = DungeonPuzzleEnum.MazeObjResType[arg_12_1.objType]
	local var_12_2 = var_12_1[1]

	UISpriteSetMgr.instance:setPuzzleSprite(var_12_0.image, var_12_2, true)
	recthelper.setAnchor(var_12_0.imageTf, var_12_1[2], var_12_1[3])

	if arg_12_1.objType == DungeonPuzzleEnum.MazeObjType.Start or arg_12_1.objType == DungeonPuzzleEnum.MazeObjType.End then
		gohelper.setActive(var_12_0.goChecked, true)
		var_12_0.anim:Play("highlight_loop", 0, 0)
	end
end

function var_0_0.drawBlockObject(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_0 = arg_13_0:getOrCreateObject(false, arg_13_2, arg_13_3, arg_13_4, arg_13_5)

	gohelper.setActive(var_13_0.go, true)

	local var_13_1 = DungeonPuzzleEnum.mazeBlockResMap[arg_13_1.val] or DungeonPuzzleEnum.MazeObjResType[arg_13_1.objType]
	local var_13_2 = var_13_1[1]

	UISpriteSetMgr.instance:setPuzzleSprite(var_13_0.image, var_13_2, true)
	recthelper.setAnchor(var_13_0.imageTf, var_13_1[2], var_13_1[3])
end

function var_0_0.drawCheckPoint(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:getOrCreateObject(true, arg_14_2, arg_14_3)

	gohelper.setActive(var_14_0.go, true)

	local var_14_1 = arg_14_1.objType
	local var_14_2

	if DungeonPuzzleMazeDrawController.instance:alreadyCheckPoint(arg_14_1) then
		gohelper.setActive(var_14_0.goChecked, true)

		var_14_1 = DungeonPuzzleEnum.MazeObjType.CheckPointPassed
		var_14_2 = DungeonPuzzleEnum.mazeCheckPointPassedResMap[arg_14_1.val] or DungeonPuzzleEnum.MazeObjResType[var_14_1]
	else
		gohelper.setActive(var_14_0.goChecked, false)

		var_14_2 = DungeonPuzzleEnum.mazeCheckPointResMap[arg_14_1.val] or DungeonPuzzleEnum.MazeObjResType[var_14_1]
	end

	local var_14_3 = var_14_2[1]

	UISpriteSetMgr.instance:setPuzzleSprite(var_14_0.image, var_14_3, true)
	UISpriteSetMgr.instance:setPuzzleSprite(var_14_0.imageChecked, var_14_3, true)
	recthelper.setAnchor(var_14_0.imageTf, var_14_2[2], var_14_2[3])
end

function var_0_0.getOrCreatePawnObj(arg_15_0)
	local var_15_0 = arg_15_0._objPawn

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()

		local var_15_1 = arg_15_0.viewContainer:getSetting().otherRes[3]
		local var_15_2 = arg_15_0:getResInst(var_15_1, arg_15_0._gomap, "pawn")

		var_15_0.go = var_15_2
		var_15_0.image = gohelper.findChildImage(var_15_2, "#go_ctrl/#image_content")
		var_15_0.imageTf = var_15_0.image.transform
		var_15_0.goCtrl = gohelper.findChild(var_15_2, "#go_ctrl")
		var_15_0.tf = var_15_2.transform
		var_15_0.dir = DungeonPuzzleEnum.dir.left
		var_15_0.anim = var_15_0.image.gameObject:GetComponent(typeof(UnityEngine.Animator))

		var_15_0.anim:Play("open")

		var_15_0.animEvent = var_15_0.image.gameObject:GetComponent(typeof(ZProj.AnimationEventWrap))

		var_15_0.animEvent:AddEventListener(DungeonPuzzleEnum.AnimEvent_OnJump, arg_15_0.onPawnJump, arg_15_0)
		transformhelper.setLocalScale(var_15_0.goCtrl.transform, 1.5, 1.5, 1)

		local var_15_3 = DungeonPuzzleEnum.MazePawnPath
		local var_15_4 = var_15_3[1]

		UISpriteSetMgr.instance:setPuzzleSprite(var_15_0.image, var_15_4, true)
		recthelper.setAnchor(var_15_0.goCtrl.transform, var_15_3[2], var_15_3[3])

		arg_15_0._objPawn = var_15_0
	end

	return var_15_0
end

function var_0_0.onPawnJump(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_move)
end

function var_0_0.initPawn(arg_17_0)
	local var_17_0, var_17_1 = DungeonPuzzleMazeDrawModel.instance:getStartPoint()

	if var_17_0 ~= nil then
		local var_17_2, var_17_3 = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(var_17_0, var_17_1)
		local var_17_4 = arg_17_0:getOrCreatePawnObj()

		recthelper.setAnchor(var_17_4.tf, var_17_2, var_17_3)
		gohelper.setAsLastSibling(var_17_4.go)
	end
end

function var_0_0.restartGame(arg_18_0)
	logNormal("restartGame")

	arg_18_0._canTouch = true
	arg_18_0._isClear = false
	arg_18_0._alreadyDrag = false

	DungeonPuzzleMazeDrawController.instance:startGame()
	arg_18_0:initPawn()
end

function var_0_0.syncPath(arg_19_0)
	local var_19_0, var_19_1 = DungeonPuzzleMazeDrawController.instance:getPassedPoints()
	local var_19_2
	local var_19_3
	local var_19_4 = {}

	for iter_19_0 = 1, #var_19_0 do
		local var_19_5 = var_19_0[iter_19_0]
		local var_19_6 = var_19_1[iter_19_0]

		if var_19_2 ~= nil then
			local var_19_7 = DungeonPuzzleMazeDrawController.getFromToDir(var_19_2, var_19_3, var_19_5, var_19_6)

			if var_19_7 then
				local var_19_8, var_19_9, var_19_10, var_19_11 = DungeonPuzzleMazeDrawController.formatPos(var_19_2, var_19_3, var_19_5, var_19_6)
				local var_19_12 = DungeonPuzzleMazeDrawModel.getLineKey(var_19_8, var_19_9, var_19_10, var_19_11)
				local var_19_13 = arg_19_0:getOrCreateLine(var_19_12, var_19_8, var_19_9, var_19_10, var_19_11)

				arg_19_0:refreshLineDir(var_19_13, var_19_7)

				if arg_19_0:isReverseDir(var_19_7) then
					arg_19_0:refreshLineProgress(var_19_13, var_19_7, 0)
				else
					arg_19_0:refreshLineProgress(var_19_13, var_19_7, 1)
				end

				var_19_4[var_19_12] = 1
			else
				logNormal(string.format("error dir in (%s,%s,%s,%s)", var_19_2, var_19_3, var_19_5, var_19_6))
			end
		end

		var_19_2, var_19_3 = var_19_5, var_19_6
	end

	for iter_19_1, iter_19_2 in pairs(arg_19_0._lineMap) do
		if not var_19_4[iter_19_1] then
			iter_19_2.image.fillAmount = 0
			iter_19_2.dir = nil
		end
	end

	DungeonPuzzleMazeDrawController.instance:resetLineDirty()
end

function var_0_0.syncDragLine(arg_20_0)
	local var_20_0 = false
	local var_20_1, var_20_2, var_20_3, var_20_4 = DungeonPuzzleMazeDrawController.instance:getProgressLine()

	if not DungeonPuzzleMazeDrawController.instance:isBackward(var_20_1, var_20_2) then
		local var_20_5 = DungeonPuzzleMazeDrawController.instance:getAlertMap()

		for iter_20_0, iter_20_1 in pairs(var_20_5) do
			return false
		end
	end

	local var_20_6 = var_20_3 or var_20_4

	if var_20_1 and var_20_2 and var_20_6 then
		local var_20_7, var_20_8 = DungeonPuzzleMazeDrawController.instance:getLastPos()
		local var_20_9, var_20_10, var_20_11, var_20_12 = DungeonPuzzleMazeDrawController.formatPos(var_20_7, var_20_8, var_20_1, var_20_2)

		if arg_20_0._curDragLine.x1 ~= var_20_9 or arg_20_0._curDragLine.y1 ~= var_20_10 or arg_20_0._curDragLine.x2 ~= var_20_11 or arg_20_0._curDragLine.y2 ~= var_20_12 then
			arg_20_0._curDragLine.x1, arg_20_0._curDragLine.y1, arg_20_0._curDragLine.x2, arg_20_0._curDragLine.y2 = var_20_9, var_20_10, var_20_11, var_20_12
			var_20_0 = true

			arg_20_0:cleanDragLine()
		end

		local var_20_13 = DungeonPuzzleMazeDrawController.getFromToDir(var_20_7, var_20_8, var_20_1, var_20_2)

		arg_20_0:refreshPawnDir(var_20_13)

		local var_20_14 = DungeonPuzzleMazeDrawModel.getLineKey(var_20_9, var_20_10, var_20_11, var_20_12)
		local var_20_15 = arg_20_0:getOrCreateLine(var_20_14, var_20_9, var_20_10, var_20_11, var_20_12)

		arg_20_0:refreshLineProgress(var_20_15, var_20_13, var_20_6)

		return var_20_0
	end

	return false
end

function var_0_0.refreshPawnDir(arg_21_0, arg_21_1)
	if arg_21_1 ~= DungeonPuzzleEnum.dir.up and arg_21_1 ~= DungeonPuzzleEnum.dir.down then
		transformhelper.setLocalRotation(arg_21_0._objPawn.tf, 0, arg_21_1 == DungeonPuzzleEnum.dir.right and 180 or 0, 0)

		arg_21_0._objPawn.dir = arg_21_1
	end
end

function var_0_0.syncAlertObjs(arg_22_0)
	arg_22_0:recycleAlertObjs()

	local var_22_0 = DungeonPuzzleMazeDrawController.instance:getAlertMap()
	local var_22_1
	local var_22_2

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		if type(iter_22_0) == "table" then
			local var_22_3 = arg_22_0:getOrCreateAlertObj()
			local var_22_4 = iter_22_0.x1
			local var_22_5 = iter_22_0.y1
			local var_22_6 = iter_22_0.x2
			local var_22_7 = iter_22_0.y2
			local var_22_8, var_22_9 = DungeonPuzzleMazeDrawModel.instance:getLineAnchor(var_22_4, var_22_5, var_22_6, var_22_7)

			recthelper.setAnchor(var_22_3.tf, var_22_8 + DungeonPuzzleEnum.MazeAlertBlockOffsetX, var_22_9 + DungeonPuzzleEnum.MazeAlertBlockOffsetY)
			gohelper.setAsLastSibling(var_22_3.go)
			AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)

			return
		end
	end

	local var_22_10 = false

	for iter_22_2, iter_22_3 in pairs(var_22_0) do
		if type(iter_22_2) == "string" then
			local var_22_11 = arg_22_0:getOrCreateAlertObj()
			local var_22_12 = string.splitToNumber(iter_22_2, "_")
			local var_22_13, var_22_14 = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(var_22_12[1], var_22_12[2])

			recthelper.setAnchor(var_22_11.tf, var_22_13 + DungeonPuzzleEnum.MazeAlertCrossOffsetX, var_22_14 + DungeonPuzzleEnum.MazeAlertCrossOffsetY)
			gohelper.setAsLastSibling(var_22_11.go)

			if not var_22_10 then
				AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)

				var_22_10 = true
			end
		end
	end
end

function var_0_0.syncPawn(arg_23_0)
	local var_23_0, var_23_1 = DungeonPuzzleMazeDrawController.instance:getLastPos()
	local var_23_2, var_23_3 = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(var_23_0, var_23_1)
	local var_23_4 = arg_23_0:getOrCreatePawnObj()

	recthelper.setAnchor(var_23_4.tf, var_23_2, var_23_3)
end

function var_0_0.refreshLineDir(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = 0
	local var_24_1 = 0
	local var_24_2 = 0
	local var_24_3 = DungeonPuzzleEnum.mazeUILineHorizonUIWidth

	if arg_24_2 == DungeonPuzzleEnum.dir.left then
		var_24_1 = arg_24_1.resCfg[5] == true and 180 or 0
		arg_24_1.image.fillOrigin = arg_24_1.resCfg[5] == true and arg_24_0._imagelinetemplatel.fillOrigin or arg_24_0._imagelinetemplater.fillOrigin
	elseif arg_24_2 == DungeonPuzzleEnum.dir.right then
		var_24_1 = arg_24_1.resCfg[5] == true and 180 or 0
		arg_24_1.image.fillOrigin = arg_24_1.resCfg[5] == true and arg_24_0._imagelinetemplater.fillOrigin or arg_24_0._imagelinetemplatel.fillOrigin
	elseif arg_24_2 == DungeonPuzzleEnum.dir.up then
		var_24_0 = arg_24_1.resCfg[5] == true and 180 or 0
		var_24_1, var_24_2, var_24_3 = 0, 90, DungeonPuzzleEnum.mazeUILineVerticalUIWidth
		arg_24_1.image.fillOrigin = arg_24_1.resCfg[5] == true and arg_24_0._imagelinetemplater.fillOrigin or arg_24_0._imagelinetemplatel.fillOrigin
	elseif arg_24_2 == DungeonPuzzleEnum.dir.down then
		var_24_0 = arg_24_1.resCfg[5] == true and 180 or 0
		var_24_1, var_24_2, var_24_3 = 0, 90, DungeonPuzzleEnum.mazeUILineVerticalUIWidth
		arg_24_1.image.fillOrigin = arg_24_1.resCfg[5] == true and arg_24_0._imagelinetemplatel.fillOrigin or arg_24_0._imagelinetemplater.fillOrigin
	end

	transformhelper.setLocalRotation(arg_24_1.imageTf, var_24_0, var_24_1, var_24_2)
	recthelper.setWidth(arg_24_1.imageTf, var_24_3)

	arg_24_1.dir = arg_24_2
end

function var_0_0.refreshLineProgress(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_1.dir == nil and arg_25_2 ~= nil then
		arg_25_0:refreshLineDir(arg_25_1, arg_25_2)
	end

	if arg_25_1.dir ~= nil then
		if arg_25_0:isReverseDir(arg_25_1.dir) then
			arg_25_3 = 1 - arg_25_3
		end

		arg_25_1.image.fillAmount = arg_25_3
	end
end

function var_0_0.isReverseDir(arg_26_0, arg_26_1)
	return arg_26_1 == DungeonPuzzleEnum.dir.left or arg_26_1 == DungeonPuzzleEnum.dir.down
end

function var_0_0.cleanDragLine(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0._lineMap) do
		local var_27_0 = iter_27_1.image.fillAmount

		if var_27_0 <= 0.999 and var_27_0 >= 0.01 then
			iter_27_1.image.fillAmount = 0
		end
	end
end

function var_0_0.refreshAlertColor(arg_28_0)
	local var_28_0 = DungeonPuzzleMazeDrawController.instance:hasAlertObj()
	local var_28_1 = DungeonPuzzleMazeDrawController.instance:getAlertMap()

	for iter_28_0, iter_28_1 in pairs(arg_28_0._lineMap) do
		UISpriteSetMgr.instance:setPuzzleSprite(iter_28_1.image, var_28_0 and iter_28_1.resCfg[4] or iter_28_1.resCfg[1], false)
	end

	for iter_28_2, iter_28_3 in pairs(arg_28_0._objectMap) do
		local var_28_2 = DungeonPuzzleMazeDrawModel.instance:getObjByLineKey(iter_28_2)

		if var_28_2 and var_28_2.objType == DungeonPuzzleEnum.MazeObjType.Block then
			local var_28_3 = var_28_1[var_28_2]
			local var_28_4 = DungeonPuzzleEnum.mazeBlockResMap[var_28_2.val]
			local var_28_5 = var_28_3 and var_28_4[4] or var_28_4[1]

			UISpriteSetMgr.instance:setPuzzleSprite(iter_28_3.image, var_28_5, true)
		end
	end
end

function var_0_0.refreshCheckPoints(arg_29_0)
	local var_29_0 = DungeonPuzzleMazeDrawModel.instance:getList()
	local var_29_1 = ""
	local var_29_2 = 0

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		if iter_29_1.objType == DungeonPuzzleEnum.MazeObjType.CheckPoint then
			arg_29_0:drawCheckPoint(iter_29_1, iter_29_1.x, iter_29_1.y)

			if DungeonPuzzleMazeDrawController.instance:alreadyCheckPoint(iter_29_1) then
				var_29_1 = var_29_1 .. tostring(iter_29_1)
				var_29_2 = var_29_2 + 1
			end
		end
	end

	if arg_29_0._lastCheckSum ~= nil and arg_29_0._lastCheckSum ~= var_29_1 and var_29_2 >= arg_29_0._lastCheckCount then
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_unlock)
	end

	arg_29_0._lastCheckSum = var_29_1
	arg_29_0._lastCheckCount = var_29_2
end

function var_0_0.getOrCreateLine(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5)
	local var_30_0 = arg_30_0._lineMap[arg_30_1]

	if not var_30_0 then
		var_30_0 = arg_30_0:getUserDataTb_()

		local var_30_1 = arg_30_0.viewContainer:getSetting().otherRes[2]
		local var_30_2 = arg_30_0:getResInst(var_30_1, arg_30_0._goconnect, arg_30_1)

		var_30_0.go = var_30_2
		var_30_0.image = gohelper.findChildImage(var_30_2, "image_horizon")
		var_30_0.imageTf = var_30_0.image.transform
		var_30_0.x1, var_30_0.y1, var_30_0.x2, var_30_0.y2 = arg_30_2, arg_30_3, arg_30_4, arg_30_5

		local var_30_3 = DungeonPuzzleEnum.SpecLineResMap[arg_30_1] or DungeonPuzzleEnum.NormalLineResPath

		var_30_0.resCfg = var_30_3

		local var_30_4 = var_30_3[1]

		UISpriteSetMgr.instance:setPuzzleSprite(var_30_0.image, var_30_4, false)

		local var_30_5, var_30_6 = DungeonPuzzleMazeDrawModel.instance:getLineAnchor(arg_30_2, arg_30_3, arg_30_4, arg_30_5)
		local var_30_7 = var_30_2.transform

		recthelper.setAnchor(var_30_7, var_30_5 - 0.5, var_30_6 - 1.3)

		arg_30_0._lineMap[arg_30_1] = var_30_0
	end

	return var_30_0
end

function var_0_0.getOrCreateObject(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	local var_31_0

	if arg_31_1 then
		var_31_0 = DungeonPuzzleMazeDrawModel.getPosKey(arg_31_2, arg_31_3)
	else
		var_31_0 = DungeonPuzzleMazeDrawModel.getLineKey(arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	end

	local var_31_1 = arg_31_0._objectMap[var_31_0]

	if not var_31_1 then
		var_31_1 = arg_31_0:getUserDataTb_()

		local var_31_2 = arg_31_0.viewContainer:getSetting().otherRes[1]
		local var_31_3 = arg_31_0:getResInst(var_31_2, arg_31_0._gomap, var_31_0)

		var_31_1.go = var_31_3
		var_31_1.image = gohelper.findChildImage(var_31_3, "#image_content")
		var_31_1.imageChecked = gohelper.findChildImage(var_31_3, "highlight/#image_content (1)")
		var_31_1.goChecked = gohelper.findChild(var_31_3, "highlight")
		var_31_1.imageTf = var_31_1.image.transform
		var_31_1.anim = var_31_1.goChecked:GetComponent(typeof(UnityEngine.Animator))

		local var_31_4
		local var_31_5

		if arg_31_1 then
			var_31_4, var_31_5 = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(arg_31_2, arg_31_3)
		else
			var_31_4, var_31_5 = DungeonPuzzleMazeDrawModel.instance:getLineObjectAnchor(arg_31_2, arg_31_3, arg_31_4, arg_31_5)
		end

		local var_31_6 = var_31_3.transform

		recthelper.setAnchor(var_31_6, var_31_4, var_31_5)

		arg_31_0._objectMap[var_31_0] = var_31_1
	end

	return var_31_1
end

function var_0_0.getOrCreateAlertObj(arg_32_0)
	local var_32_0

	if #arg_32_0._alertSymbolPool <= 0 then
		var_32_0 = arg_32_0:getUserDataTb_()

		local var_32_1 = arg_32_0.viewContainer:getSetting().otherRes[1]
		local var_32_2 = arg_32_0:getResInst(var_32_1, arg_32_0._gomap, "alertObj")

		var_32_0.go = var_32_2
		var_32_0.image = gohelper.findChildImage(var_32_2, "#image_content")
		var_32_0.imageTf = var_32_0.image.transform
		var_32_0.tf = var_32_2.transform

		UISpriteSetMgr.instance:setPuzzleSprite(var_32_0.image, DungeonPuzzleEnum.MazeAlertResPath, true)
	else
		var_32_0 = table.remove(arg_32_0._alertSymbolPool)

		gohelper.setActive(var_32_0.go, true)
	end

	table.insert(arg_32_0._alertObjList, var_32_0)

	return var_32_0
end

function var_0_0.recycleAlertObjs(arg_33_0)
	for iter_33_0 = #arg_33_0._alertObjList, 1, -1 do
		local var_33_0 = arg_33_0._alertObjList[iter_33_0]

		gohelper.setActive(var_33_0.go, false)
		table.insert(arg_33_0._alertSymbolPool, var_33_0)

		arg_33_0._alertObjList[iter_33_0] = nil
	end
end

function var_0_0.removeAllLine(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0._lineMap) do
		gohelper.destroy(iter_34_1.go)

		iter_34_1.go = nil
		iter_34_1.image = nil
		iter_34_1.imageTf = nil
		arg_34_0._lineMap[iter_34_0] = nil
	end
end

function var_0_0.removeAllObjects(arg_35_0)
	for iter_35_0, iter_35_1 in pairs(arg_35_0._objectMap) do
		gohelper.destroy(iter_35_1.go)

		iter_35_1.go = nil
		iter_35_1.image = nil
		iter_35_1.imageTf = nil
		arg_35_0._objectMap[iter_35_0] = nil
	end
end

function var_0_0.onDragBeginHandler(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_0._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	local var_36_0 = recthelper.screenPosToAnchorPos(arg_36_2.position, arg_36_0._gomap.transform)
	local var_36_1, var_36_2 = DungeonPuzzleMazeDrawController.instance:getLastPos()
	local var_36_3, var_36_4 = DungeonPuzzleMazeDrawModel.instance:getClosePosByTouchPos(var_36_0.x - DungeonPuzzleEnum.mazeMonsterTouchOffsetX, var_36_0.y - DungeonPuzzleEnum.mazeMonsterHeight)

	if var_36_3 ~= -1 and var_36_1 == var_36_3 and var_36_2 == var_36_4 then
		arg_36_0:startDrag()
	end
end

function var_0_0.onDragCallHandler(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0._isPawnMoving then
		local var_37_0 = recthelper.screenPosToAnchorPos(arg_37_2.position, arg_37_0._gomap.transform)
		local var_37_1, var_37_2 = DungeonPuzzleMazeDrawModel.instance:getUIGridSize()
		local var_37_3, var_37_4 = DungeonPuzzleMazeDrawModel.instance:getClosePosByTouchPos(var_37_0.x, var_37_0.y)

		if var_37_3 ~= -1 then
			DungeonPuzzleMazeDrawController.instance:goPassPos(var_37_3, var_37_4)
		else
			local var_37_5, var_37_6, var_37_7, var_37_8, var_37_9, var_37_10, var_37_11 = DungeonPuzzleMazeDrawModel.instance:getLineFieldByTouchPos(var_37_0.x, var_37_0.y)

			if var_37_5 then
				DungeonPuzzleMazeDrawController.instance:goPassLine(var_37_6, var_37_7, var_37_8, var_37_9, var_37_10, var_37_11)
			end
		end

		local var_37_12 = DungeonPuzzleMazeDrawController.instance:isLineDirty()

		if var_37_12 then
			arg_37_0:syncPath()
			arg_37_0:refreshAlertColor()
			arg_37_0:syncAlertObjs()
			arg_37_0:refreshCheckPoints()
		end

		local var_37_13 = arg_37_0:syncDragLine()

		if not var_37_12 and var_37_13 then
			arg_37_0:syncPath()
		end

		local var_37_14 = arg_37_0:getOrCreatePawnObj()

		recthelper.setAnchor(var_37_14.tf, var_37_0.x, var_37_0.y)

		if var_37_12 then
			arg_37_0:checkGameClear()
		end
	end
end

function var_0_0.onDragEndHandler(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0:endDrag()
end

function var_0_0.startDrag(arg_39_0)
	arg_39_0._isPawnMoving = true

	arg_39_0:getOrCreatePawnObj().anim:Play("image_content_drag")

	if not arg_39_0._alreadyDrag then
		local var_39_0, var_39_1 = DungeonPuzzleMazeDrawModel.instance:getStartPoint()

		arg_39_0:closeCheckObject(var_39_0, var_39_1)

		arg_39_0._alreadyDrag = true
	end
end

function var_0_0.endDrag(arg_40_0)
	if arg_40_0._isPawnMoving then
		arg_40_0._isPawnMoving = false

		arg_40_0:getOrCreatePawnObj().anim:Play("open")

		if DungeonPuzzleMazeDrawController.instance:hasAlertObj() then
			DungeonPuzzleMazeDrawController.instance:goBackPos()
			arg_40_0:syncPawn()
			arg_40_0:syncPath()
			arg_40_0:cleanDragLine()
			arg_40_0:refreshAlertColor()
			arg_40_0:syncAlertObjs()
			arg_40_0:refreshCheckPoints()
		else
			arg_40_0:syncPawn()
			arg_40_0:syncPath()
			arg_40_0:cleanDragLine()
			arg_40_0:checkGameClear()
		end
	end
end

function var_0_0.closeCheckObject(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = DungeonPuzzleMazeDrawModel.getPosKey(arg_41_1, arg_41_2)
	local var_41_1 = arg_41_0._objectMap[var_41_0]

	if var_41_1 then
		gohelper.setActive(var_41_1.goChecked, false)
	end
end

function var_0_0.checkGameClear(arg_42_0)
	if arg_42_0._isClear then
		return
	end

	local var_42_0 = DungeonPuzzleMazeDrawController.instance:isGameClear()

	if var_42_0 then
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)

		local var_42_1, var_42_2 = DungeonPuzzleMazeDrawModel.instance:getEndPoint()

		arg_42_0:closeCheckObject(var_42_1, var_42_2)
		DungeonPuzzleMazeDrawModel.instance:setClearStatus(var_42_0)

		arg_42_0._canTouch = false
		arg_42_0._isClear = true

		DungeonPuzzleMazeDrawController.instance:dispatchEvent(DungeonPuzzleEvent.MazeDrawGameClear)
		logNormal("MazeDraw Game Clear!!!")

		if arg_42_0._isPawnMoving then
			arg_42_0:endDrag()
		end
	end
end

return var_0_0
