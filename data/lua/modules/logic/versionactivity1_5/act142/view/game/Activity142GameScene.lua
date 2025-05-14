module("modules.logic.versionactivity1_5.act142.view.game.Activity142GameScene", package.seeall)

local var_0_0 = class("Activity142GameScene", Va3ChessGameScene)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._baffleItems = {}
	arg_1_0._baffleItemPools = {}

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.TileTriggerUpdate, arg_2_0._onTileTriggerUpdate, arg_2_0)
	arg_2_0:addEventCb(Activity142Controller.instance, Activity142Event.Back2CheckPoint, arg_2_0._onMapChange, arg_2_0)
	arg_2_0:addEventCb(Activity142Controller.instance, Activity142Event.PlaySwitchPlayerEff, arg_2_0.playSwitchPlayerEff, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, arg_2_0._onMapChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.TileTriggerUpdate, arg_3_0._onTileTriggerUpdate, arg_3_0)
	arg_3_0:removeEventCb(Activity142Controller.instance, Activity142Event.Back2CheckPoint, arg_3_0._onMapChange, arg_3_0)
	arg_3_0:removeEventCb(Activity142Controller.instance, Activity142Event.PlaySwitchPlayerEff, arg_3_0.playSwitchPlayerEff, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, arg_3_0._onMapChange, arg_3_0)
end

function var_0_0._onTileTriggerUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = Va3ChessGameModel.instance:getTileMO(arg_4_1, arg_4_2)

	if not var_4_0 or not var_4_0:isHasTrigger(arg_4_3) then
		return
	end

	local var_4_1 = arg_4_0:getBaseTile(arg_4_1, arg_4_2)

	if arg_4_3 == Va3ChessEnum.TileTrigger.Broken then
		arg_4_0:updateBrokenTile(var_4_1, var_4_0, true)
	end
end

function var_0_0._onMapChange(arg_5_0)
	arg_5_0:resetTiles()
	arg_5_0:resetBaffle()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer(true)
end

function var_0_0.onResetMapView(arg_6_0)
	arg_6_0:resetBaffle()
	var_0_0.super.onResetMapView(arg_6_0)
end

function var_0_0.onResetGame(arg_7_0)
	arg_7_0:resetBaffle()
	var_0_0.super.onResetGame(arg_7_0)
end

function var_0_0.onLoadRes(arg_8_0)
	local var_8_0 = arg_8_0:_getGroundItemUrlList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		arg_8_0._loader:addPath(iter_8_1)
	end

	arg_8_0._loader:addPath(Activity142Enum.BrokenGroundItemPath)
	arg_8_0._loader:addPath(Activity142Enum.SwitchPlayerEffPath)
end

function var_0_0._getGroundItemUrlList(arg_9_0)
	local var_9_0 = Va3ChessGameModel.instance:getMapId()
	local var_9_1 = Va3ChessGameModel.instance:getActId()
	local var_9_2 = Activity142Config.instance:getGroundItemUrlList(var_9_1, var_9_0)

	if not var_9_2 or #var_9_2 < 0 then
		var_9_2 = {
			Va3ChessEnum.SceneResPath.GroundItem
		}
	end

	return var_9_2
end

function var_0_0.getGroundItemUrl(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0
	local var_10_1 = arg_10_0:_getGroundItemUrlList()

	if arg_10_1 and arg_10_2 then
		local var_10_2 = Va3ChessGameModel.instance:getTileMO(arg_10_1, arg_10_2)

		if var_10_2 and var_10_2:isHasTrigger(Va3ChessEnum.TileTrigger.Broken) then
			var_10_0 = Activity142Enum.BrokenGroundItemPath
		end
	end

	if string.nilorempty(var_10_0) then
		var_10_0 = var_10_1[math.random(1, #var_10_1)]
	end

	return var_10_0
end

function var_0_0.onTileItemCreate(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_3.animator = arg_11_3.go:GetComponent(Va3ChessEnum.ComponentType.Animator)

	local var_11_0 = Va3ChessGameModel.instance:getTileMO(arg_11_1, arg_11_2)

	arg_11_0:updateBrokenTile(arg_11_3, var_11_0)
end

local var_0_1 = "CtoD"
local var_0_2 = {
	{
		idle = "xianjing_b",
		tween = "xianjing_b"
	},
	{
		idle = "xianjing_c",
		tween = "BtoC"
	},
	{
		idle = "xianjing_d",
		tween = var_0_1
	}
}

function var_0_0.updateBrokenTile(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = Va3ChessEnum.TileTrigger.Broken

	if not arg_12_1 or not arg_12_2 or not arg_12_2:isHasTrigger(var_12_0) then
		return
	end

	local var_12_1 = arg_12_2:getTriggerBrokenStatus()
	local var_12_2 = var_0_2[var_12_1]

	if not var_12_2 then
		return
	end

	local var_12_3

	if arg_12_3 then
		var_12_3 = var_12_2.tween
	else
		var_12_3 = var_12_2.idle
	end

	if var_12_3 and arg_12_1.animator then
		arg_12_1.animator:Play(var_12_3, 0, 0)

		if var_12_3 == var_0_1 then
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.TileBroken)
		end
	end
end

function var_0_0.onloadResCompleted(arg_13_0, arg_13_1)
	arg_13_0:createAllBaffleObj()
end

function var_0_0.createAllBaffleObj(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._baseTiles) do
		for iter_14_2, iter_14_3 in pairs(iter_14_1) do
			local var_14_0 = Va3ChessGameModel.instance:getTileMO(iter_14_0 - 1, iter_14_2 - 1):getBaffleDataList()

			if var_14_0 and #var_14_0 >= 0 then
				arg_14_0:createBaffleItem(iter_14_0 - 1, iter_14_2 - 1, var_14_0)
			end
		end
	end
end

function var_0_0.createBaffleItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_3 or #arg_15_3 <= 0 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_3) do
		local var_15_0
		local var_15_1 = Activity142Helper.getBaffleResPath(iter_15_1)

		if var_15_1 then
			local var_15_2 = arg_15_0._baffleItemPools[var_15_1]
			local var_15_3 = var_15_2 and #var_15_2 or 0

			if var_15_3 > 0 then
				var_15_0 = var_15_2[var_15_3]
				var_15_2[var_15_3] = nil
			end
		end

		if not var_15_0 then
			var_15_0 = Activity142BaffleObject.New(arg_15_0._sceneContainer.transform)

			var_15_0:init()
		end

		iter_15_1.x = arg_15_1
		iter_15_1.y = arg_15_2

		var_15_0:updatePos(iter_15_1)
		table.insert(arg_15_0._baffleItems, var_15_0)
	end
end

function var_0_0.resetBaffle(arg_16_0)
	arg_16_0:recycleAllBaffleItem()
	arg_16_0:createAllBaffleObj()
end

function var_0_0.recycleAllBaffleItem(arg_17_0)
	local var_17_0

	for iter_17_0 = 1, #arg_17_0._baffleItems do
		local var_17_1 = arg_17_0._baffleItems[iter_17_0]

		var_17_1:recycle()

		local var_17_2 = var_17_1:getBaffleResPath()

		if var_17_2 then
			local var_17_3 = arg_17_0._baffleItemPools[var_17_2]

			if not var_17_3 then
				var_17_3 = {}
				arg_17_0._baffleItemPools[var_17_2] = var_17_3
			end

			table.insert(var_17_3, var_17_1)
		else
			var_17_1:dispose()
		end

		arg_17_0._baffleItems[iter_17_0] = nil
	end
end

function var_0_0.playSwitchPlayerEff(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:getSwitchEffGO()

	if gohelper.isNil(var_18_0) or not arg_18_1 or not arg_18_2 then
		return
	end

	Activity142Helper.setAct142UIBlock(true, Activity142Enum.SWITCH_PLAYER)

	local var_18_1, var_18_2, var_18_3 = Va3ChessGameController.instance:calcTilePosInScene(arg_18_1, arg_18_2)

	transformhelper.setLocalPos(var_18_0.transform, var_18_1, var_18_2, var_18_3)
	gohelper.setActive(var_18_0, false)
	gohelper.setActive(var_18_0, true)
	AudioMgr.instance:trigger(AudioEnum.chess_activity142.SwitchPlayer)
	TaskDispatcher.cancelTask(arg_18_0.switchPlayerFinish, arg_18_0)
	TaskDispatcher.runDelay(arg_18_0.switchPlayerFinish, arg_18_0, Activity142Enum.PLAYER_SWITCH_TIME)
end

function var_0_0.getSwitchEffGO(arg_19_0)
	if not arg_19_0._switchEffGO then
		local var_19_0 = arg_19_0._loader:getAssetItem(Activity142Enum.SwitchPlayerEffPath)

		if var_19_0 then
			arg_19_0._switchEffGO = gohelper.clone(var_19_0:GetResource(), arg_19_0._sceneContainer, "switchEff")

			gohelper.setActive(arg_19_0._switchEffGO, false)
		end
	end

	return arg_19_0._switchEffGO
end

function var_0_0.switchPlayerFinish(arg_20_0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.SWITCH_PLAYER)
end

function var_0_0.onDestroyView(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.switchPlayerFinish, arg_21_0)
	arg_21_0:switchPlayerFinish()

	if arg_21_0._switchEffGO then
		gohelper.destroy(arg_21_0._switchEffGO)

		arg_21_0._switchEffGO = nil
	end

	arg_21_0:removeEvents()
	arg_21_0:disposeBaffle()
	var_0_0.super.onDestroyView(arg_21_0)
end

function var_0_0.disposeBaffle(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._baffleItems) do
		iter_22_1:dispose()
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0._baffleItemPools) do
		for iter_22_4, iter_22_5 in ipairs(iter_22_3) do
			iter_22_5:dispose()
		end
	end

	arg_22_0._baffleItems = {}
	arg_22_0._baffleItemPools = {}
end

return var_0_0
