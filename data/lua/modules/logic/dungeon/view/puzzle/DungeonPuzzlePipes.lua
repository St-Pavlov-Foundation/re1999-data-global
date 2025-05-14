module("modules.logic.dungeon.view.puzzle.DungeonPuzzlePipes", package.seeall)

local var_0_0 = class("DungeonPuzzlePipes", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._goconnect = gohelper.findChild(arg_1_0.viewGO, "#go_connect")
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
	arg_4_0:initConst()

	arg_4_0._touch = TouchEventMgrHepler.getTouchEventMgr(arg_4_0._gomap)

	arg_4_0._touch:SetOnlyTouch(true)
	arg_4_0._touch:SetIgnoreUI(true)
	arg_4_0._touch:SetOnClickCb(arg_4_0._onClickContainer, arg_4_0)

	arg_4_0._canTouch = true
end

function var_0_0.initConst(arg_5_0)
	arg_5_0._itemSizeX = 132
	arg_5_0._itemSizeY = 130
	arg_5_0._gameWidth, arg_5_0._gameHeight = DungeonPuzzlePipeModel.instance:getGameSize()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._gridObjs = {}
	arg_7_0._connectObjs = {}

	for iter_7_0 = 1, arg_7_0._gameWidth do
		for iter_7_1 = 1, arg_7_0._gameHeight do
			arg_7_0._gridObjs[iter_7_0] = arg_7_0._gridObjs[iter_7_0] or {}
			arg_7_0._connectObjs[iter_7_0] = arg_7_0._connectObjs[iter_7_0] or {}

			arg_7_0:addNewItem(iter_7_0, iter_7_1)
		end
	end

	arg_7_0:_refreshEntryItem()
	arg_7_0:addEventCb(DungeonPuzzlePipeController.instance, DungeonPuzzleEvent.GuideClickGrid, arg_7_0._onGuideClickGrid, arg_7_0)
end

function var_0_0._onGuideClickGrid(arg_8_0, arg_8_1)
	local var_8_0 = string.splitToNumber(arg_8_1, "_")
	local var_8_1 = var_8_0[1]
	local var_8_2 = var_8_0[2]

	arg_8_0:_onClickGridItem(var_8_1, var_8_2)
end

function var_0_0._btnresetOnClick(arg_9_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		arg_9_0:_resetGame()
	end)
end

function var_0_0._resetGame(arg_11_0)
	if not arg_11_0._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	DungeonPuzzlePipeController.instance:resetGame()

	for iter_11_0 = 1, arg_11_0._gameWidth do
		for iter_11_1 = 1, arg_11_0._gameHeight do
			arg_11_0:initItem(iter_11_0, iter_11_1)
			arg_11_0:_refreshConnectItem(iter_11_0, iter_11_1)
		end
	end

	arg_11_0:_refreshEntryItem()
end

function var_0_0.addNewItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:_newPipeItem(arg_12_1, arg_12_2)
	arg_12_0:initItem(arg_12_1, arg_12_2)
	arg_12_0:_refreshConnectItem(arg_12_1, arg_12_2)
end

function var_0_0._newPipeItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.viewContainer:getSetting().otherRes[1]
	local var_13_1 = arg_13_0:getResInst(var_13_0, arg_13_0._gomap, arg_13_1 .. "_" .. arg_13_2)
	local var_13_2 = var_13_1.transform
	local var_13_3, var_13_4 = DungeonPuzzlePipeModel.instance:getRelativePosition(arg_13_1, arg_13_2, arg_13_0._itemSizeX, arg_13_0._itemSizeY)

	recthelper.setAnchor(var_13_2, var_13_3, var_13_4)

	local var_13_5 = arg_13_0:getUserDataTb_()

	var_13_5.go = var_13_1
	var_13_5.image = gohelper.findChildImage(var_13_1, "#image_content")
	var_13_5.imageTf = var_13_5.image.transform
	var_13_5.tf = var_13_2
	arg_13_0._gridObjs[arg_13_1][arg_13_2] = var_13_5
end

function var_0_0.initItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = DungeonPuzzlePipeModel.instance:getData(arg_14_1, arg_14_2)
	local var_14_1 = DungeonPuzzleEnum.backgroundRes[var_14_0.value]
	local var_14_2 = var_14_1[1]
	local var_14_3 = var_14_1[2]
	local var_14_4 = arg_14_0._gridObjs[arg_14_1][arg_14_2]

	UISpriteSetMgr.instance:setPuzzleSprite(var_14_4.image, var_14_2, true)
	transformhelper.setLocalRotation(var_14_4.tf, 0, 0, var_14_3)
	recthelper.setAnchor(var_14_4.imageTf, var_14_1[3], var_14_1[4])
end

function var_0_0._refreshConnectItem(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 > 0 and arg_15_1 <= arg_15_0._gameWidth and arg_15_2 > 0 and arg_15_2 <= arg_15_0._gameHeight then
		local var_15_0 = DungeonPuzzlePipeModel.instance:getData(arg_15_1, arg_15_2)
		local var_15_1 = var_15_0:getConnectValue()
		local var_15_2 = arg_15_0._connectObjs[arg_15_1][arg_15_2]

		if var_15_1 ~= 0 then
			var_15_2 = var_15_2 or arg_15_0:_newConnectObj(arg_15_1, arg_15_2)

			arg_15_0:_initConnectObj(var_15_2, var_15_0, var_15_1)
		else
			arg_15_0:hideConnectItem(var_15_2)
		end
	end
end

function var_0_0._newConnectObj(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.viewContainer:getSetting().otherRes[2]
	local var_16_1 = arg_16_0:getResInst(var_16_0, arg_16_0._goconnect, arg_16_1 .. "_" .. arg_16_2)
	local var_16_2 = var_16_1.transform
	local var_16_3, var_16_4 = DungeonPuzzlePipeModel.instance:getRelativePosition(arg_16_1, arg_16_2, arg_16_0._itemSizeX, arg_16_0._itemSizeY)

	recthelper.setAnchor(var_16_2, var_16_3, var_16_4)

	local var_16_5 = arg_16_0:getUserDataTb_()

	var_16_5.go = var_16_1
	var_16_5.image = gohelper.findChildImage(var_16_1, "#image_content")
	var_16_5.imageTf = var_16_5.image.transform
	var_16_5.tf = var_16_2
	arg_16_0._connectObjs[arg_16_1][arg_16_2] = var_16_5

	return var_16_5
end

function var_0_0._initConnectObj(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0

	if arg_17_2:isEntry() then
		var_17_0 = DungeonPuzzleEnum.connectRes[0]
	else
		var_17_0 = DungeonPuzzleEnum.connectRes[arg_17_3]
	end

	if var_17_0 then
		arg_17_1.go:SetActive(true)

		local var_17_1 = var_17_0[1]
		local var_17_2 = var_17_0[2]

		UISpriteSetMgr.instance:setPuzzleSprite(arg_17_1.image, var_17_1, true)
		transformhelper.setLocalRotation(arg_17_1.tf, 0, 0, var_17_2)
		recthelper.setAnchor(arg_17_1.imageTf, var_17_0[3], var_17_0[4])
	else
		arg_17_0:hideConnectItem(arg_17_1)
	end
end

function var_0_0.hideConnectItem(arg_18_0, arg_18_1)
	if arg_18_1 and arg_18_1.go ~= nil then
		arg_18_1.go:SetActive(false)
	end
end

function var_0_0._syncRotation(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_3:isEntry() then
		return
	end

	local var_19_0 = DungeonPuzzleEnum.backgroundRes[arg_19_3.value]
	local var_19_1 = arg_19_0._gridObjs[arg_19_1][arg_19_2]
	local var_19_2 = var_19_0[2]

	transformhelper.setLocalRotation(var_19_1.tf, 0, 0, var_19_2)
end

function var_0_0._onClickContainer(arg_20_0, arg_20_1)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local var_20_0 = recthelper.screenPosToAnchorPos(arg_20_1, arg_20_0._gomap.transform)
	local var_20_1, var_20_2 = DungeonPuzzlePipeModel.instance:getIndexByTouchPos(var_20_0.x, var_20_0.y, arg_20_0._itemSizeX, arg_20_0._itemSizeY)

	if var_20_1 ~= -1 then
		arg_20_0:_onClickGridItem(var_20_1, var_20_2)
	end
end

function var_0_0._refreshConnection(arg_21_0)
	for iter_21_0 = 1, arg_21_0._gameWidth do
		for iter_21_1 = 1, arg_21_0._gameHeight do
			arg_21_0:_refreshConnectItem(iter_21_0, iter_21_1)
		end
	end
end

function var_0_0._refreshEntryItem(arg_22_0)
	local var_22_0 = DungeonPuzzlePipeModel.instance:getEntryList()

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		local var_22_1 = iter_22_1.x
		local var_22_2 = iter_22_1.y
		local var_22_3 = arg_22_0._gridObjs[var_22_1][var_22_2]
		local var_22_4 = arg_22_0._connectObjs[var_22_1][var_22_2]
		local var_22_5 = DungeonPuzzlePipeController.instance:getIsEntryClear(iter_22_1)

		var_22_3.go:SetActive(not var_22_5)

		if var_22_4 then
			var_22_4.go:SetActive(var_22_5)

			if var_22_5 then
				DungeonPuzzlePipeModel.instance._connectEntryX = var_22_1
				DungeonPuzzlePipeModel.instance._connectEntryY = var_22_2

				DungeonPuzzlePipeController.instance:dispatchEvent(DungeonPuzzleEvent.GuideEntryConnectClear)
			end
		end

		local var_22_6 = arg_22_0:getOrderGO(var_22_1, var_22_2)

		if not gohelper.isNil(var_22_6) then
			gohelper.setActive(var_22_6, not var_22_5)
		end
	end
end

function var_0_0.getOrderGO(arg_23_0, arg_23_1, arg_23_2)
	return (gohelper.findChild(arg_23_0.viewGO, string.format("indexs/#go_index_%s_%s", arg_23_1, arg_23_2)))
end

function var_0_0._onClickGridItem(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_0._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	local var_24_0 = DungeonPuzzlePipeModel.instance:getData(arg_24_1, arg_24_2)

	if var_24_0:isEntry() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	DungeonPuzzlePipeController.instance:changeDirection(arg_24_1, arg_24_2, true)
	DungeonPuzzlePipeController.instance:updateConnection()
	arg_24_0:_syncRotation(arg_24_1, arg_24_2, var_24_0)
	arg_24_0:_refreshConnection()
	arg_24_0:_refreshEntryItem()

	arg_24_0._canTouch = not DungeonPuzzlePipeModel.instance:getGameClear()

	DungeonPuzzlePipeController.instance:checkDispatchClear()
end

function var_0_0.onClose(arg_25_0)
	if arg_25_0._touch then
		TouchEventMgrHepler.remove(arg_25_0._touch)

		arg_25_0._touch = nil
	end
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0
