module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianGameController", package.seeall)

local var_0_0 = class("YaXianGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.release(arg_3_0)
	if arg_3_0.state then
		arg_3_0.state:removeAll()
	end

	if arg_3_0.stepMgr then
		arg_3_0.stepMgr:removeAll()
		arg_3_0.stepMgr:dispose()
	end

	arg_3_0.interactItemList = nil
	arg_3_0.state = nil
	arg_3_0.stepMgr = nil
	arg_3_0.searchTree = nil
	arg_3_0.selectInteractObjId = nil
	arg_3_0.clickStatus = YaXianGameEnum.SelectPosStatus.None
end

function var_0_0.enterChessGame(arg_4_0, arg_4_1)
	Activity115Rpc.instance:sendAct115StartEpisodeRequest(YaXianGameEnum.ActivityId, arg_4_1, arg_4_0._openGame, arg_4_0)
end

function var_0_0._openGame(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 ~= 0 then
		return
	end

	local var_5_0 = YaXianGameModel.instance:getInteractMo(YaXianGameEnum.BossInteractId)

	if var_5_0 then
		var_5_0:setXY(YaXianGameEnum.FakeBossStartPos.posX, YaXianGameEnum.FakeBossStartPos.posY)
		var_5_0:setDirection(YaXianGameEnum.FakeBossDirection)
		YaXianGameModel.instance:setNeedFeatureInteractMo(var_5_0)
	else
		YaXianGameModel.instance:clearFeatureInteract()
	end

	Stat1_2Controller.instance:yaXianStatStart()
	ViewMgr.instance:openView(ViewName.YaXianGameView)
end

function var_0_0.initMapByMapMsg(arg_6_0, arg_6_1, arg_6_2)
	YaXianGameModel.instance:release()
	YaXianGameModel.instance:initLocalConfig(arg_6_1, arg_6_2.id)
	YaXianGameModel.instance:initServerDataByServerData(arg_6_2)
	arg_6_0:setSelectObj()

	arg_6_0.state = arg_6_0.state or YaXianStateMgr.New()

	arg_6_0.state:removeAll()
	arg_6_0.state:setCurEvent(arg_6_2.currentEvent)

	arg_6_0.stepMgr = arg_6_0.stepMgr or YaXianStepMgr.New()

	arg_6_0.stepMgr:disposeAllStep()
end

function var_0_0.initMapByMapMo(arg_7_0, arg_7_1)
	YaXianGameModel.instance:release()
	YaXianGameModel.instance:initLocalConfig(arg_7_1.actId, arg_7_1.episodeId)
	YaXianGameModel.instance:initServerDataByMapMo(arg_7_1)
	arg_7_0:setSelectObj()

	arg_7_0.state = arg_7_0.state or YaXianStateMgr.New()

	arg_7_0.state:removeAll()
	arg_7_0.state:setCurEvent(arg_7_1.currentEvent)

	arg_7_0.stepMgr = arg_7_0.stepMgr or YaXianStepMgr.New()

	arg_7_0.stepMgr:disposeAllStep()
end

function var_0_0.setInteractItemList(arg_8_0, arg_8_1)
	arg_8_0.interactItemList = arg_8_1
end

function var_0_0.setPlayerInteractItem(arg_9_0, arg_9_1)
	arg_9_0.playerInteractItem = arg_9_1
end

function var_0_0.getInteractItemList(arg_10_0)
	return arg_10_0.interactItemList
end

function var_0_0.getInteractItem(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.interactItemList) do
		if iter_11_1.id == arg_11_1 then
			return iter_11_1
		end
	end
end

function var_0_0.getPlayerInteractItem(arg_12_0)
	return arg_12_0.playerInteractItem
end

function var_0_0.getSelectedInteractItem(arg_13_0)
	return arg_13_0:getInteractItem(arg_13_0.selectInteractObjId)
end

function var_0_0.initSceneTree(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.searchTree = YaXianGameTree.New()

	local var_14_0 = arg_14_0.searchTree:createLeaveNode()
	local var_14_1, var_14_2 = YaXianGameModel.instance:getGameSize()

	for iter_14_0 = 1, var_14_1 do
		for iter_14_1 = 1, var_14_2 do
			local var_14_3 = {}
			local var_14_4, var_14_5, var_14_6 = YaXianGameHelper.calcTilePosInScene(iter_14_0 - 1, iter_14_1 - 1)
			local var_14_7 = recthelper.worldPosToAnchorPos(Vector3.New(var_14_4, var_14_5 + arg_14_2, 0), arg_14_1.transform)

			var_14_3.x, var_14_3.y = var_14_7.x, var_14_7.y
			var_14_3.tileX, var_14_3.tileY = iter_14_0 - 1, iter_14_1 - 1

			table.insert(var_14_0.nodes, var_14_3)

			var_14_0.keys = var_14_3
		end
	end

	arg_14_0.searchTree:growToBranch(var_14_0)
	arg_14_0.searchTree:buildTree(var_14_0)
end

function var_0_0.searchInteractByPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = YaXianGameModel.instance:getInteractMoList()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if iter_15_1.posX == arg_15_1 and iter_15_1.posY == arg_15_2 and (not arg_15_3 or arg_15_3(iter_15_1.config)) then
			table.insert(var_15_1, iter_15_1)
		end
	end

	if #var_15_1 > 1 then
		table.sort(var_15_1, arg_15_0.sortSelectObj)
	end

	return var_15_1
end

function var_0_0.sortSelectObj(arg_16_0, arg_16_1)
	return (YaXianGameEnum.InteractSelectPriority[arg_16_0.config.interactType] or arg_16_0.id) < (YaXianGameEnum.InteractSelectPriority[arg_16_1.config.interactType] or arg_16_1.id)
end

function var_0_0.updateAllPosInteractActive(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(YaXianGameModel.instance:getInteractMoList()) do
		local var_17_1 = YaXianGameHelper.getPosHashKey(iter_17_1.posX, iter_17_1.posY)

		if not var_17_0[var_17_1] then
			arg_17_0:updatePosInteractActive(iter_17_1.posX, iter_17_1.posY)

			var_17_0[var_17_1] = true
		end
	end
end

function var_0_0.updatePosInteractActive(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:searchInteractByPos(arg_18_1, arg_18_2)

	if #var_18_0 < 1 then
		return
	end

	if #var_18_0 == 1 then
		arg_18_0:getInteractItem(var_18_0[1].id):updateActiveByShowPriority(YaXianGameEnum.MinShowPriority)

		return
	end

	local var_18_1 = YaXianGameEnum.MinShowPriority
	local var_18_2 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		table.insert(var_18_2, arg_18_0:getInteractItem(iter_18_1.id))
	end

	for iter_18_2, iter_18_3 in ipairs(var_18_2) do
		if var_18_1 < iter_18_3:getShowPriority() then
			var_18_1 = iter_18_3:getShowPriority()
		end
	end

	for iter_18_4, iter_18_5 in ipairs(var_18_2) do
		iter_18_5:updateActiveByShowPriority(var_18_1)
	end
end

function var_0_0.setSelectObj(arg_19_0, arg_19_1)
	if arg_19_0.selectInteractObjId and arg_19_0.selectInteractObjId ~= arg_19_1 then
		arg_19_0:dispatchEvent(YaXianEvent.OnCancelSelectInteract, arg_19_0.selectInteractObjId)
	end

	arg_19_0.selectInteractObjId = arg_19_1

	if arg_19_1 ~= nil and arg_19_1 ~= 0 then
		arg_19_0:dispatchEvent(YaXianEvent.OnSelectInteract, arg_19_0.selectInteractObjId)
	end
end

function var_0_0.getSelectInteractId(arg_20_0)
	return arg_20_0.selectInteractObjId
end

function var_0_0.isSelectingPlayer(arg_21_0)
	return arg_21_0.selectInteractObjId and arg_21_0.selectInteractObjId == YaXianGameModel.instance:getPlayerInteractMo().id
end

function var_0_0.autoSelectPlayer(arg_22_0)
	arg_22_0:setSelectObj(YaXianGameModel.instance:getPlayerInteractMo().id)
end

function var_0_0.sortInteractObjById(arg_23_0, arg_23_1)
	return arg_23_0.id < arg_23_1.id
end

function var_0_0.gameVictory(arg_24_0)
	YaXianGameModel.instance:setResult(true)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Success)
	arg_24_0:dispatchEvent(YaXianEvent.OnGameVictory)
end

function var_0_0.gameOver(arg_25_0)
	YaXianGameModel.instance:setResult(false)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Fail)
	arg_25_0:dispatchEvent(YaXianEvent.OnGameFail)
end

function var_0_0.posCanWalk(arg_26_0, arg_26_1, arg_26_2)
	if YaXianGameModel.instance:isPosInChessBoard(arg_26_1, arg_26_2) and YaXianGameModel.instance:getBaseTile(arg_26_1, arg_26_2) ~= YaXianGameEnum.TileBaseType.None then
		return arg_26_0:posObjCanWalk(arg_26_1, arg_26_2)
	end

	return false
end

function var_0_0.posObjCanWalk(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:searchInteractByPos(arg_27_1, arg_27_2)

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if YaXianGameHelper.canBlock(iter_27_1.config) then
			return false
		end
	end

	return true
end

function var_0_0.getMoveTargetPos(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.posX
	local var_28_1 = arg_28_1.posY
	local var_28_2 = arg_28_1.moveDirection
	local var_28_3 = arg_28_1.throughDistance
	local var_28_4 = arg_28_1.isHide
	local var_28_5 = arg_28_1.isBafflePos
	local var_28_6 = arg_28_1.lastCanWalkPosX
	local var_28_7 = arg_28_1.lastCanWalkPosY
	local var_28_8 = arg_28_1.usedThrough
	local var_28_9 = arg_28_1.level and arg_28_1.level + 1 or 1

	if var_28_8 and not var_28_5 and arg_28_0:posObjCanWalk(var_28_0, var_28_1) then
		return var_28_0, var_28_1, var_28_8
	end

	var_28_6 = var_28_6 or var_28_0
	var_28_7 = var_28_7 or var_28_1

	if var_28_9 > 1 and not var_28_4 and YaXianGameModel.instance:isAlertArea(var_28_6, var_28_7) then
		return var_28_6, var_28_7, var_28_8
	end

	if YaXianGameModel.instance:hasInteract(var_28_6, var_28_7) then
		return var_28_6, var_28_7, var_28_8
	end

	local var_28_10
	local var_28_11
	local var_28_12
	local var_28_13

	if var_28_2 == YaXianGameEnum.MoveDirection.Bottom then
		var_28_10 = var_28_0
		var_28_11 = var_28_1 - 1
		var_28_12 = YaXianGameEnum.BaffleDirectionPowerPos.Bottom
		var_28_13 = YaXianGameEnum.BaffleDirectionPowerPos.Top
	elseif var_28_2 == YaXianGameEnum.MoveDirection.Left then
		var_28_10 = var_28_0 - 1
		var_28_11 = var_28_1
		var_28_12 = YaXianGameEnum.BaffleDirectionPowerPos.Left
		var_28_13 = YaXianGameEnum.BaffleDirectionPowerPos.Right
	elseif var_28_2 == YaXianGameEnum.MoveDirection.Right then
		var_28_10 = var_28_0 + 1
		var_28_11 = var_28_1
		var_28_12 = YaXianGameEnum.BaffleDirectionPowerPos.Right
		var_28_13 = YaXianGameEnum.BaffleDirectionPowerPos.Left
	elseif var_28_2 == YaXianGameEnum.MoveDirection.Top then
		var_28_10 = var_28_0
		var_28_11 = var_28_1 + 1
		var_28_12 = YaXianGameEnum.BaffleDirectionPowerPos.Top
		var_28_13 = YaXianGameEnum.BaffleDirectionPowerPos.Bottom
	else
		logError(string.format("un support direction, x : %s, y : %s, direction : %s", var_28_0, var_28_1, var_28_2))

		return var_28_6, var_28_7, var_28_8
	end

	if not YaXianGameModel.instance:isPosInChessBoard(var_28_10, var_28_11) then
		return var_28_6, var_28_7, var_28_8
	end

	if YaXianGameModel.instance:getBaseTile(var_28_10, var_28_11) == 0 then
		return var_28_6, var_28_7, var_28_8
	end

	if var_28_5 then
		if arg_28_0:posObjCanWalk(var_28_10, var_28_11) then
			return var_28_10, var_28_11, var_28_8
		else
			return arg_28_0:getMoveTargetPos({
				isBafflePos = false,
				posX = var_28_10,
				posY = var_28_11,
				moveDirection = var_28_2,
				throughDistance = var_28_3 - 1,
				isHide = var_28_4,
				lastCanWalkPosX = var_28_6,
				lastCanWalkPosY = var_28_7,
				usedThrough = var_28_8,
				level = var_28_9
			})
		end
	end

	if YaXianGameHelper.hasBaffle(YaXianGameModel.instance:getBaseTile(var_28_0, var_28_1), var_28_12) or YaXianGameHelper.hasBaffle(YaXianGameModel.instance:getBaseTile(var_28_10, var_28_11), var_28_13) then
		if var_28_3 <= 0 then
			return var_28_6, var_28_7, var_28_8
		else
			return arg_28_0:getMoveTargetPos({
				isBafflePos = true,
				usedThrough = true,
				posX = var_28_0,
				posY = var_28_1,
				moveDirection = var_28_2,
				throughDistance = var_28_3 - 1,
				isHide = var_28_4,
				lastCanWalkPosX = var_28_6,
				lastCanWalkPosY = var_28_7,
				level = var_28_9
			})
		end
	elseif arg_28_0:posObjCanWalk(var_28_10, var_28_11) then
		return arg_28_0:getMoveTargetPos({
			isBafflePos = false,
			posX = var_28_10,
			posY = var_28_11,
			moveDirection = var_28_2,
			throughDistance = var_28_3,
			isHide = var_28_4,
			usedThrough = var_28_8,
			level = var_28_9
		})
	elseif var_28_3 <= 0 then
		return var_28_6, var_28_7, var_28_8
	else
		return arg_28_0:getMoveTargetPos({
			isBafflePos = false,
			usedThrough = true,
			posX = var_28_10,
			posY = var_28_11,
			moveDirection = var_28_2,
			throughDistance = var_28_3 - 1,
			isHide = var_28_4,
			lastCanWalkPosX = var_28_6,
			lastCanWalkPosY = var_28_7,
			level = var_28_9
		})
	end
end

function var_0_0.getNearestScenePos(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0.searchTree then
		return nil
	end

	local var_29_0 = arg_29_0.searchTree:search(arg_29_1, arg_29_2)
	local var_29_1 = 99999999
	local var_29_2
	local var_29_3 = YaXianGameEnum.ClickYWeight

	if var_29_0 then
		for iter_29_0 = 1, #var_29_0 do
			local var_29_4 = var_29_0[iter_29_0]
			local var_29_5 = var_29_4.x - arg_29_1
			local var_29_6 = var_29_4.y - arg_29_2

			if math.abs(var_29_5) <= YaXianGameEnum.ClickRangeX and math.abs(var_29_6) <= YaXianGameEnum.ClickRangeY then
				local var_29_7 = var_29_5 * var_29_5 + var_29_6 * var_29_6 * var_29_3

				if var_29_7 < var_29_1 then
					var_29_2 = var_29_4
					var_29_1 = var_29_7
				end
			end
		end
	end

	if var_29_2 then
		return var_29_2.tileX, var_29_2.tileY
	else
		return nil
	end
end

function var_0_0.getInteractStatusPool(arg_30_0)
	if not arg_30_0.interactStatusPool then
		arg_30_0.interactStatusPool = LuaObjPool.New(16, YaXianGameStatusMo.NewFunc, YaXianGameStatusMo.releaseFunc, YaXianGameStatusMo.resetFunc)
	end

	return arg_30_0.interactStatusPool
end

function var_0_0.stopRunningStep(arg_31_0)
	if arg_31_0.stepMgr then
		arg_31_0.stepMgr:disposeAllStep()
	end
end

function var_0_0.playEffectAudio(arg_32_0, arg_32_1)
	if not arg_32_1 or arg_32_1 == 0 then
		return
	end

	arg_32_0.lastPlayTimeDict = arg_32_0.lastPlayTimeDict or {}

	local var_32_0 = arg_32_0.lastPlayTimeDict[arg_32_1]
	local var_32_1 = Time.realtimeSinceStartup

	if not var_32_0 or var_32_1 - var_32_0 >= YaXianGameEnum.EffectInterval then
		AudioMgr.instance:trigger(arg_32_1)

		arg_32_0.lastPlayTimeDict[arg_32_1] = var_32_1
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
