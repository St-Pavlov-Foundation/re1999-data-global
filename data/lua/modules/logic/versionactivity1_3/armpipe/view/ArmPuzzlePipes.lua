module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipes", package.seeall)

local var_0_0 = class("ArmPuzzlePipes", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
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
	arg_4_0._gomapTrs = arg_4_0._gomap.transform

	arg_4_0:initConst()

	arg_4_0._canTouch = true
	arg_4_0._btnUIClick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._gomap)

	arg_4_0._btnUIClick:AddClickListener(arg_4_0._onbtnUIClick, arg_4_0)
end

function var_0_0.initConst(arg_5_0)
	arg_5_0._itemSizeX = 123
	arg_5_0._itemSizeY = 123
	arg_5_0._gameWidth, arg_5_0._gameHeight = ArmPuzzlePipeModel.instance:getGameSize()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._gridItemDict = {}
	arg_7_0._gridItemList = {}

	for iter_7_0 = 1, arg_7_0._gameWidth do
		arg_7_0._gridItemDict[iter_7_0] = arg_7_0._gridItemDict[iter_7_0] or {}

		for iter_7_1 = 1, arg_7_0._gameHeight do
			arg_7_0:addNewItem(iter_7_0, iter_7_1)
		end
	end

	arg_7_0:_refreshEntryItem()
	arg_7_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.GuideClickGrid, arg_7_0._onGuideClickGrid, arg_7_0)
	arg_7_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, arg_7_0._onPlaceRefreshPipesGrid, arg_7_0)
	arg_7_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PipeGameClear, arg_7_0._onGameClear, arg_7_0)
end

function var_0_0._onGuideClickGrid(arg_8_0, arg_8_1)
	local var_8_0 = string.splitToNumber(arg_8_1, "_")
	local var_8_1 = var_8_0[1]
	local var_8_2 = var_8_0[2]

	arg_8_0:_onClickGridItem(var_8_1, var_8_2)
end

function var_0_0._onPlaceRefreshPipesGrid(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = ArmPuzzlePipeModel.instance:getData(arg_9_1, arg_9_2)

	if not var_9_0 then
		return
	end

	ArmPuzzlePipeController.instance:refreshConnection(var_9_0)
	ArmPuzzlePipeController.instance:updateConnection()
	arg_9_0:initItem(arg_9_1, arg_9_2)
	arg_9_0:_refreshConnection()
	arg_9_0:_refreshEntryItem()

	arg_9_0._canTouch = not ArmPuzzlePipeModel.instance:getGameClear()

	ArmPuzzlePipeController.instance:checkDispatchClear()
end

function var_0_0._btnresetOnClick(arg_10_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Va3Act124ResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		arg_10_0:_resetGame()
	end)
end

function var_0_0._resetGame(arg_12_0)
	Stat1_3Controller.instance:puzzleStatReset()
	ArmPuzzlePipeController.instance:resetGame()

	for iter_12_0 = 1, arg_12_0._gameWidth do
		for iter_12_1 = 1, arg_12_0._gameHeight do
			arg_12_0:initItem(iter_12_0, iter_12_1)
			arg_12_0:_refreshConnectItem(iter_12_0, iter_12_1)
		end
	end

	arg_12_0:_refreshEntryItem()

	arg_12_0._canTouch = not ArmPuzzlePipeModel.instance:getGameClear()
end

function var_0_0.addNewItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:_newPipeItem(arg_13_1, arg_13_2)
	arg_13_0:initItem(arg_13_1, arg_13_2)
	arg_13_0:_refreshConnectItem(arg_13_1, arg_13_2)
end

function var_0_0._newPipeItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ArmPuzzlePipeItem.prefabPath
	local var_14_1 = arg_14_0:getResInst(var_14_0, arg_14_0._gomap, arg_14_1 .. "_" .. arg_14_2)
	local var_14_2 = var_14_1.transform
	local var_14_3, var_14_4 = ArmPuzzlePipeModel.instance:getRelativePosition(arg_14_1, arg_14_2, arg_14_0._itemSizeX, arg_14_0._itemSizeY)

	recthelper.setAnchor(var_14_2, var_14_3, var_14_4)

	local var_14_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_1, ArmPuzzlePipeItem)

	table.insert(arg_14_0._gridItemList, var_14_5)

	arg_14_0._gridItemDict[arg_14_1][arg_14_2] = var_14_5
end

function var_0_0.initItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = ArmPuzzlePipeModel.instance:getData(arg_15_1, arg_15_2)

	arg_15_0._gridItemDict[arg_15_1][arg_15_2]:initItem(var_15_0)
end

function var_0_0._refreshConnectItem(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 > 0 and arg_16_1 <= arg_16_0._gameWidth and arg_16_2 > 0 and arg_16_2 <= arg_16_0._gameHeight then
		local var_16_0 = ArmPuzzlePipeModel.instance:getData(arg_16_1, arg_16_2)

		arg_16_0._gridItemDict[arg_16_1][arg_16_2]:initConnectObj(var_16_0)
	end
end

function var_0_0._syncRotation(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3:isEntry() then
		return
	end

	arg_17_0._gridItemDict[arg_17_1][arg_17_2]:syncRotation(arg_17_3)
end

function var_0_0._onbtnUIClick(arg_18_0)
	local var_18_0 = GamepadController.instance:getMousePosition()

	arg_18_0:_onClickContainer(var_18_0)
end

function var_0_0._onClickContainer(arg_19_0, arg_19_1)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local var_19_0 = recthelper.screenPosToAnchorPos(arg_19_1, arg_19_0._gomapTrs)
	local var_19_1, var_19_2 = ArmPuzzlePipeModel.instance:getIndexByTouchPos(var_19_0.x, var_19_0.y, arg_19_0._itemSizeX, arg_19_0._itemSizeY)

	if var_19_1 ~= -1 then
		arg_19_0:_onClickGridItem(var_19_1, var_19_2)
	end
end

function var_0_0.getXYByPostion(arg_20_0, arg_20_1)
	local var_20_0 = recthelper.screenPosToAnchorPos(arg_20_1, arg_20_0._gomapTrs)
	local var_20_1, var_20_2 = ArmPuzzlePipeModel.instance:getIndexByTouchPos(var_20_0.x, var_20_0.y, arg_20_0._itemSizeX, arg_20_0._itemSizeY)

	if var_20_1 ~= -1 then
		return var_20_1, var_20_2
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
	local var_22_0 = ArmPuzzlePipeModel.instance:getEntryList()

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		local var_22_1 = iter_22_1.x
		local var_22_2 = iter_22_1.y
		local var_22_3 = arg_22_0._gridItemDict[var_22_1][var_22_2]

		var_22_3:initItem(iter_22_1)
		var_22_3:initConnectObj(iter_22_1)
	end
end

function var_0_0._onClickGridItem(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_0._canTouch then
		GameFacade.showToast(ToastEnum.Va3Act124GameFinish)

		return
	end

	local var_23_0 = ArmPuzzlePipeModel.instance:getData(arg_23_1, arg_23_2)

	if var_23_0:isEntry() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	ArmPuzzlePipeController.instance:changeDirection(arg_23_1, arg_23_2, true)
	ArmPuzzlePipeController.instance:updateConnection()
	arg_23_0:_syncRotation(arg_23_1, arg_23_2, var_23_0)
	arg_23_0:_refreshConnection()
	arg_23_0:_refreshEntryItem()

	arg_23_0._canTouch = not ArmPuzzlePipeModel.instance:getGameClear()

	ArmPuzzlePipeController.instance:checkDispatchClear()
end

function var_0_0.onClose(arg_24_0)
	if arg_24_0._btnUIClick then
		arg_24_0._btnUIClick:RemoveClickListener()

		arg_24_0._btnUIClick = nil
	end
end

function var_0_0._onGameClear(arg_25_0)
	Stat1_3Controller.instance:puzzleStatSuccess()
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0
