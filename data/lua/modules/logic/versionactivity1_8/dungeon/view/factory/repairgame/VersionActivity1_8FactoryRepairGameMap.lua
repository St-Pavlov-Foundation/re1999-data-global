module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairGameMap", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryRepairGameMap", BaseView)
local var_0_1 = 123
local var_0_2 = 123

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._gomapTrs = arg_1_0._gomap.transform
	arg_1_0._btnMapClick = SLFramework.UGUI.UIClickListener.Get(arg_1_0._gomap)
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.GuideClickGrid, arg_2_0._onGuideClickGrid, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, arg_2_0._onPlaceRefreshPipesGrid, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, arg_2_0._onGameClear, arg_2_0)
	arg_2_0._btnMapClick:AddClickListener(arg_2_0._btnMapOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.GuideClickGrid, arg_3_0._onGuideClickGrid, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, arg_3_0._onPlaceRefreshPipesGrid, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, arg_3_0._onGameClear, arg_3_0)
	arg_3_0._btnMapClick:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._onGuideClickGrid(arg_4_0, arg_4_1)
	local var_4_0 = string.splitToNumber(arg_4_1, "_")
	local var_4_1 = var_4_0[1]
	local var_4_2 = var_4_0[2]

	arg_4_0:_onClickGridItem(var_4_1, var_4_2)
end

function var_0_0._onPlaceRefreshPipesGrid(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Activity157RepairGameModel.instance:getData(arg_5_1, arg_5_2)

	if not var_5_0 then
		return
	end

	Activity157Controller.instance:refreshConnection(var_5_0)
	Activity157Controller.instance:updateConnection()
	arg_5_0:initItem(arg_5_1, arg_5_2)
	arg_5_0:_refreshConnection()
	arg_5_0:_refreshEntryItem()

	arg_5_0._canTouch = not Activity157RepairGameModel.instance:getGameClear()

	Activity157Controller.instance:checkDispatchClear()
end

function var_0_0._onGameClear(arg_6_0)
	VersionActivity1_8StatController.instance:statSuccess()
end

function var_0_0._btnMapOnClick(arg_7_0)
	local var_7_0 = GamepadController.instance:getMousePosition()

	arg_7_0:_onClickContainer(var_7_0)
end

function var_0_0._onClickContainer(arg_8_0, arg_8_1)
	local var_8_0 = recthelper.screenPosToAnchorPos(arg_8_1, arg_8_0._gomapTrs)
	local var_8_1, var_8_2 = Activity157RepairGameModel.instance:getIndexByTouchPos(var_8_0.x, var_8_0.y, var_0_1, var_0_2)

	if var_8_1 ~= -1 then
		arg_8_0:_onClickGridItem(var_8_1, var_8_2)
	end
end

function var_0_0._onClickGridItem(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._canTouch then
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairComplete)

		return
	end

	local var_9_0 = Activity157RepairGameModel.instance:getData(arg_9_1, arg_9_2)

	if var_9_0:isEntry() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	Activity157Controller.instance:changeDirection(arg_9_1, arg_9_2, true)
	Activity157Controller.instance:updateConnection()
	arg_9_0:_syncRotation(arg_9_1, arg_9_2, var_9_0)
	arg_9_0:_refreshConnection()
	arg_9_0:_refreshEntryItem()

	arg_9_0._canTouch = not Activity157RepairGameModel.instance:getGameClear()

	Activity157Controller.instance:checkDispatchClear()
end

function var_0_0._syncRotation(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3:isEntry() then
		return
	end

	arg_10_0._gridItemDict[arg_10_1][arg_10_2]:syncRotation(arg_10_3)
end

function var_0_0._btnresetOnClick(arg_11_0)
	if not arg_11_0._canTouch then
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairComplete)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.v1a8Activity157RestTip, MsgBoxEnum.BoxType.Yes_No, function()
		arg_11_0:_resetGame()
	end)
end

function var_0_0._resetGame(arg_13_0)
	VersionActivity1_8StatController.instance:statReset()
	Activity157Controller.instance:resetGame()

	for iter_13_0 = 1, arg_13_0._gameWidth do
		for iter_13_1 = 1, arg_13_0._gameHeight do
			arg_13_0:initItem(iter_13_0, iter_13_1)
			arg_13_0:_refreshConnectItem(iter_13_0, iter_13_1)
		end
	end

	arg_13_0:_refreshEntryItem()

	arg_13_0._canTouch = not Activity157RepairGameModel.instance:getGameClear()
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._canTouch = true
	arg_14_0._gameWidth, arg_14_0._gameHeight = Activity157RepairGameModel.instance:getGameSize()
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)

	arg_16_0._gridItemDict = {}
	arg_16_0._gridItemList = {}

	for iter_16_0 = 1, arg_16_0._gameWidth do
		arg_16_0._gridItemDict[iter_16_0] = arg_16_0._gridItemDict[iter_16_0] or {}

		for iter_16_1 = 1, arg_16_0._gameHeight do
			arg_16_0:addNewItem(iter_16_0, iter_16_1)
		end
	end

	arg_16_0:_refreshEntryItem()
end

function var_0_0.addNewItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:_newPipeItem(arg_17_1, arg_17_2)
	arg_17_0:initItem(arg_17_1, arg_17_2)
	arg_17_0:_refreshConnectItem(arg_17_1, arg_17_2)
end

function var_0_0._newPipeItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.viewContainer._viewSetting.otherRes[1]
	local var_18_1 = arg_18_0:getResInst(var_18_0, arg_18_0._gomap, arg_18_1 .. "_" .. arg_18_2)
	local var_18_2 = var_18_1.transform
	local var_18_3, var_18_4 = Activity157RepairGameModel.instance:getRelativePosition(arg_18_1, arg_18_2, var_0_1, var_0_2)

	recthelper.setAnchor(var_18_2, var_18_3, var_18_4)

	local var_18_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_1, VersionActivity1_8FactoryRepairGameMapItem)

	table.insert(arg_18_0._gridItemList, var_18_5)

	arg_18_0._gridItemDict[arg_18_1][arg_18_2] = var_18_5
end

function var_0_0.initItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = Activity157RepairGameModel.instance:getData(arg_19_1, arg_19_2)

	arg_19_0._gridItemDict[arg_19_1][arg_19_2]:initItem(var_19_0)
end

function var_0_0._refreshConnection(arg_20_0)
	for iter_20_0 = 1, arg_20_0._gameWidth do
		for iter_20_1 = 1, arg_20_0._gameHeight do
			arg_20_0:_refreshConnectItem(iter_20_0, iter_20_1)
		end
	end
end

function var_0_0._refreshConnectItem(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 > 0 and arg_21_1 <= arg_21_0._gameWidth and arg_21_2 > 0 and arg_21_2 <= arg_21_0._gameHeight then
		local var_21_0 = Activity157RepairGameModel.instance:getData(arg_21_1, arg_21_2)

		arg_21_0._gridItemDict[arg_21_1][arg_21_2]:initConnectObj(var_21_0)
	end
end

function var_0_0._refreshEntryItem(arg_22_0)
	local var_22_0 = Activity157RepairGameModel.instance:getEntryList()

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		local var_22_1 = iter_22_1.x
		local var_22_2 = iter_22_1.y
		local var_22_3 = arg_22_0._gridItemDict[var_22_1][var_22_2]

		var_22_3:initItem(iter_22_1)
		var_22_3:initConnectObj(iter_22_1)
	end
end

function var_0_0.getXYByPosition(arg_23_0, arg_23_1)
	local var_23_0 = recthelper.screenPosToAnchorPos(arg_23_1, arg_23_0._gomapTrs)
	local var_23_1, var_23_2 = Activity157RepairGameModel.instance:getIndexByTouchPos(var_23_0.x, var_23_0.y, var_0_1, var_0_2)

	if var_23_1 ~= -1 then
		return var_23_1, var_23_2
	end
end

function var_0_0.onClose(arg_24_0)
	return
end

function var_0_0.onDestroyView(arg_25_0)
	return
end

return var_0_0
