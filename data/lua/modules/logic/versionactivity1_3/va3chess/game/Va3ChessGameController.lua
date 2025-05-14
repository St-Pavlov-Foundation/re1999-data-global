module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessGameController", package.seeall)

local var_0_0 = class("Va3ChessGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0._registerGameController(arg_3_0)
	return {
		[Va3ChessEnum.ActivityId.Act122] = Activity1_3ChessGameController.instance
	}
end

function var_0_0._getActiviyXGameControllerIns(arg_4_0, arg_4_1)
	if not arg_4_0._actXGameCtlInsMap then
		arg_4_0._actXGameCtrlInsMap = arg_4_0:_registerGameController()
	end

	return arg_4_0._actXGameCtrlInsMap[arg_4_1]
end

function var_0_0.release(arg_5_0)
	if arg_5_0.interacts then
		arg_5_0.interacts:removeAll()
	end

	if arg_5_0.event then
		arg_5_0.event:removeAll()
	end

	arg_5_0._treeComp = nil
	arg_5_0.interacts = nil
	arg_5_0.event = nil
	arg_5_0._hasMap = false
end

function var_0_0.setViewName(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0._viewName = arg_6_1
	end
end

function var_0_0.getViewName(arg_7_0)
	return arg_7_0._viewName or ViewName.Va3ChessGameScene
end

function var_0_0.enterChessGame(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	logNormal("Va3ChessGameController : enterChessGame!")

	local var_8_0 = Va3ChessModel.instance:getEpisodeId()

	GuideController.instance:dispatchEvent(GuideEvent["OnChessEnter" .. var_8_0])
	arg_8_0:initData(arg_8_1, arg_8_2)

	arg_8_0._viewName = arg_8_3 or arg_8_0._viewName

	ViewMgr.instance:openView(arg_8_0._viewName, arg_8_0:packViewParam())
end

function var_0_0.packViewParam(arg_9_0)
	return {
		fromRefuseBattle = Va3ChessController.instance:getFromRefuseBattle()
	}
end

function var_0_0.initData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._treeComp = Va3ChessGameTree.New()

	Va3ChessGameModel.instance:initData(arg_10_1, arg_10_2)

	arg_10_0._tempSelectObjId = nil

	local var_10_0 = Va3ChessConfig.instance:getMapCo(arg_10_1, arg_10_2)

	if var_10_0 and not string.nilorempty(var_10_0.offset) then
		local var_10_1 = string.splitToNumber(var_10_0.offset, ",")

		arg_10_0._cacheOffsetX = var_10_1[1]
		arg_10_0._cacheOffsetY = var_10_1[2]
	else
		arg_10_0._cacheOffsetX = nil
		arg_10_0._cacheOffsetY = nil
	end
end

function var_0_0.initServerMap(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2.mapId then
		Va3ChessGameModel.instance:initData(arg_11_1, arg_11_2.mapId)
	end

	Va3ChessGameModel.instance:setRound(arg_11_2.currentRound)
	Va3ChessGameModel.instance:setHp(arg_11_2.hp)
	Va3ChessGameModel.instance:setFinishedTargetNum(arg_11_2.targetNum)
	Va3ChessGameModel.instance:setResult(nil)
	Va3ChessGameModel.instance:setFireBallCount(arg_11_2.fireballNum)
	Va3ChessGameModel.instance:updateFinishInteracts(arg_11_2.finishInteracts)
	Va3ChessGameModel.instance:updateAllFinishInteracts(arg_11_2.allFinishInteracts)

	if arg_11_2.fragileTilebases then
		Va3ChessGameModel.instance:updateFragileTilebases(arg_11_1, arg_11_2.fragileTilebases)
	end

	if arg_11_2.brokenTilebases then
		Va3ChessGameModel.instance:updateBrokenTilebases(arg_11_1, arg_11_2.brokenTilebases)
	end

	arg_11_0:setClickStatus(Va3ChessEnum.SelectPosStatus.None)

	arg_11_0._selectObj = nil

	arg_11_0:setSelectObj(nil)

	arg_11_0.interacts = arg_11_0.interacts or Va3ChessInteractMgr.New()

	arg_11_0.interacts:removeAll()
	Va3ChessGameModel.instance:initObjects(arg_11_1, arg_11_2.interactObjects or arg_11_2.id2Interact)

	if arg_11_2.brazierIds then
		Va3ChessGameModel.instance:updateLightUpBrazier(arg_11_1, arg_11_2.brazierIds)
	end

	arg_11_0:initObjects()

	arg_11_0.event = arg_11_0.event or Va3ChessEventMgr.New()

	arg_11_0.event:removeAll()
	arg_11_0.event:setCurEvent(arg_11_2.currentEvent)
	arg_11_0:onInitServerMap(arg_11_1, arg_11_2)

	arg_11_0._hasMap = true
end

function var_0_0.isNeedBlock(arg_12_0)
	if arg_12_0.event and arg_12_0.event:isNeedBlock() then
		return true
	end

	return false
end

function var_0_0.onInitServerMap(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:_getActiviyXGameControllerIns(arg_13_1)

	if var_13_0 and var_13_0.onInitServerMap then
		var_13_0:onInitServerMap(arg_13_2)
	end
end

function var_0_0.updateServerMap(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:_getActiviyXGameControllerIns(arg_14_1)

	if var_14_0 and var_14_0.onUpdateServerMap then
		var_14_0:onUpdateServerMap(arg_14_2)
	end
end

function var_0_0.initObjects(arg_15_0)
	local var_15_0 = Va3ChessGameModel.instance:getInteractDatas()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = Va3ChessInteractObject.New()

		var_15_1:init(iter_15_1)

		if var_15_1.config ~= nil then
			arg_15_0.interacts:add(var_15_1)
		end
	end

	arg_15_0:onInitObjects()

	local var_15_2 = arg_15_0.interacts:getList()

	for iter_15_2, iter_15_3 in ipairs(var_15_2) do
		iter_15_3.goToObject:init()
	end

	arg_15_0:dispatchEvent(Va3ChessEvent.AllObjectCreated)
end

function var_0_0.onInitObjects(arg_16_0)
	local var_16_0 = Va3ChessModel.instance:getActId()
	local var_16_1 = arg_16_0:_getActiviyXGameControllerIns(var_16_0)

	if var_16_1 and var_16_1.onInitObjects then
		var_16_1:onInitObjects()
	end
end

function var_0_0.initSceneTree(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._treeSceneComp = Va3ChessGameTree.New()
	arg_17_0._offsetSceneY = arg_17_2

	local var_17_0 = arg_17_0._treeSceneComp:createLeaveNode()
	local var_17_1, var_17_2 = Va3ChessGameModel.instance:getGameSize()

	for iter_17_0 = 1, var_17_1 do
		for iter_17_1 = 1, var_17_2 do
			local var_17_3 = {}
			local var_17_4, var_17_5, var_17_6 = arg_17_0:calcTilePosInScene(iter_17_0 - 1, iter_17_1 - 1)
			local var_17_7 = recthelper.worldPosToAnchorPos(Vector3.New(var_17_4, var_17_5 + arg_17_2, 0), arg_17_1.transform)

			var_17_3.x, var_17_3.y = var_17_7.x, var_17_7.y
			var_17_3.tileX, var_17_3.tileY = iter_17_0 - 1, iter_17_1 - 1

			table.insert(var_17_0.nodes, var_17_3)

			var_17_0.keys = var_17_3
		end
	end

	arg_17_0._treeSceneComp:growToBranch(var_17_0)
	arg_17_0._treeSceneComp:buildTree(var_17_0)
end

function var_0_0.calcTilePosInScene(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = Va3ChessEnum.TileShowSettings
	local var_18_1 = arg_18_0._cacheOffsetX or Va3ChessEnum.ChessBoardOffsetX
	local var_18_2 = arg_18_0._cacheOffsetY or Va3ChessEnum.ChessBoardOffsetY
	local var_18_3 = arg_18_1 * var_18_0.width + var_18_0.offsetX * arg_18_2 + var_18_0.offsetXY * (arg_18_1 + arg_18_2) + var_18_1
	local var_18_4 = arg_18_2 * var_18_0.height + var_18_0.offsetY * arg_18_1 + var_18_0.offsetYX * (arg_18_1 + arg_18_2) + var_18_2
	local var_18_5 = var_18_3 * 0.01
	local var_18_6 = var_18_4 * 0.01
	local var_18_7 = 0
	local var_18_8 = (arg_18_3 or 0) * 0.001

	if arg_18_4 then
		var_18_7 = arg_18_0:getPosZ(arg_18_1, arg_18_2) + var_18_8
	else
		var_18_7 = var_18_6 * 0.001 + var_18_8
	end

	return var_18_5, var_18_6, var_18_7
end

function var_0_0.getPosZ(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0, var_19_1 = Va3ChessGameModel.instance:getGameSize()
	local var_19_2 = arg_19_1 / var_19_0
	local var_19_3 = Mathf.Lerp(Va3ChessEnum.ScenePosZRange.Min, Va3ChessEnum.ScenePosZRange.Max, var_19_2)
	local var_19_4 = arg_19_2 / var_19_1

	return var_19_3 + Mathf.Lerp(Va3ChessEnum.ScenePosZRange.Max, Va3ChessEnum.ScenePosZRange.Min, var_19_4)
end

function var_0_0.getOffsetSceneY(arg_20_0)
	return arg_20_0._offsetSceneY
end

function var_0_0.addInteractObj(arg_21_0, arg_21_1)
	local var_21_0 = Va3ChessInteractObject.New()

	var_21_0:init(arg_21_1)
	arg_21_0.interacts:add(var_21_0)
	var_21_0.goToObject:init()
	arg_21_0:dispatchEvent(Va3ChessEvent.AddInteractObj, var_21_0)
end

function var_0_0.deleteInteractObj(arg_22_0, arg_22_1)
	arg_22_0.interacts:remove(arg_22_1)
	arg_22_0:dispatchEvent(Va3ChessEvent.DeleteInteractObj, arg_22_1)
end

function var_0_0.searchInteractByPos(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0.interacts:getList()
	local var_23_1
	local var_23_2
	local var_23_3 = 0

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if iter_23_1.originData.posX == arg_23_1 and iter_23_1.originData.posY == arg_23_2 and (not arg_23_3 or arg_23_3(iter_23_1)) then
			if var_23_1 ~= nil then
				var_23_2 = var_23_2 or {
					var_23_1
				}

				table.insert(var_23_2, iter_23_1)
			else
				var_23_1 = iter_23_1
			end

			var_23_3 = var_23_3 + 1
		end
	end

	if var_23_3 > 1 then
		table.sort(var_23_2, var_0_0.sortSelectObj)
	end

	return var_23_3, var_23_2 or var_23_1
end

function var_0_0.sortSelectObj(arg_24_0, arg_24_1)
	return arg_24_0:getSelectPriority() < arg_24_1:getSelectPriority()
end

function var_0_0.filterSelectable(arg_25_0)
	return arg_25_0.config and (arg_25_0.config.interactType == Va3ChessEnum.InteractType.Player or arg_25_0.config.interactType == Va3ChessEnum.InteractType.AssistPlayer)
end

function var_0_0.existGame(arg_26_0)
	return arg_26_0._hasMap
end

function var_0_0.setSelectObj(arg_27_0, arg_27_1)
	if arg_27_0._selectObj == arg_27_1 then
		return
	end

	if arg_27_0._selectObj ~= nil then
		arg_27_0._selectObj:onCancelSelect()
	end

	arg_27_0._selectObj = arg_27_1

	if arg_27_1 ~= nil then
		arg_27_1:onSelected()
	end
end

function var_0_0.forceRefreshObjSelectedView(arg_28_0)
	if arg_28_0._selectObj ~= nil then
		arg_28_0._selectObj:onSelected()
	end
end

function var_0_0.saveTempSelectObj(arg_29_0)
	if arg_29_0._selectObj then
		arg_29_0._tempSelectObjId = arg_29_0._selectObj.id
	end
end

function var_0_0.isTempSelectObj(arg_30_0, arg_30_1)
	return arg_30_0._tempSelectObjId == arg_30_1
end

function var_0_0.tryResumeSelectObj(arg_31_0)
	if arg_31_0.interacts and arg_31_0._tempSelectObjId then
		local var_31_0 = arg_31_0.interacts:get(arg_31_0._tempSelectObjId)

		if var_31_0 then
			arg_31_0:setSelectObj(var_31_0)

			arg_31_0._tempSelectObjId = nil

			return true
		end
	end

	arg_31_0:autoSelectPlayer(true)

	return false
end

function var_0_0.refreshAllInteractKillEff(arg_32_0)
	local var_32_0 = arg_32_0.interacts:getList()

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		if iter_32_1 and iter_32_1.chessEffectObj and iter_32_1.chessEffectObj.refreshKillEffect then
			iter_32_1.chessEffectObj:refreshKillEffect()
		end
	end
end

function var_0_0.syncServerMap(arg_33_0)
	local var_33_0 = Va3ChessGameModel.instance:getActId()
	local var_33_1 = Va3ChessGameModel.instance:getMapId()

	arg_33_0._tempInteractMgr = arg_33_0.interacts
	arg_33_0._tempEventMgr = arg_33_0.event

	if var_33_0 and var_33_1 then
		arg_33_0.interacts = nil
		arg_33_0.event = nil

		Va3ChessGameModel.instance:release()
		Va3ChessGameModel.instance:initData(var_33_0, var_33_1)
		Va3ChessRpcController.instance:sendGetActInfoRequest(var_33_0, arg_33_0.onReceiveWhenSync, arg_33_0)
		arg_33_0:dispatchEvent(Va3ChessEvent.ResetMapView)
	end
end

function var_0_0.onReceiveWhenSync(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_2 ~= 0 then
		return
	end

	local var_34_0 = Va3ChessGameModel.instance:getActId()
	local var_34_1 = Va3ChessGameModel.instance:getMapId()

	if var_34_0 and var_34_1 then
		if arg_34_0._tempInteractMgr then
			arg_34_0._tempInteractMgr:dispose()

			arg_34_0._tempInteractMgr = nil
		end

		if arg_34_0._tempEventMgr then
			arg_34_0._tempEventMgr:removeAll()

			arg_34_0._tempEventMgr = nil
		end

		arg_34_0:initData(var_34_0, var_34_1)
		arg_34_0:initObjects()
	end
end

function var_0_0.getSelectObj(arg_35_0)
	return arg_35_0._selectObj
end

function var_0_0.setClickStatus(arg_36_0, arg_36_1)
	arg_36_0._clickStatus = arg_36_1
end

function var_0_0.getClickStatus(arg_37_0)
	return arg_37_0._clickStatus
end

function var_0_0.autoSelectPlayer(arg_38_0, arg_38_1)
	if not arg_38_0.interacts then
		return
	end

	local var_38_0 = arg_38_0.interacts:getList()

	if not var_38_0 then
		return
	end

	local var_38_1 = {}

	for iter_38_0, iter_38_1 in pairs(var_38_0) do
		local var_38_2 = iter_38_1.config and iter_38_1.config.interactType or nil
		local var_38_3 = var_38_2 == Va3ChessEnum.InteractType.Player
		local var_38_4 = arg_38_1 and var_38_2 == Va3ChessEnum.InteractType.AssistPlayer

		if var_38_3 or var_38_4 then
			table.insert(var_38_1, iter_38_1)
		end
	end

	table.sort(var_38_1, var_0_0.sortInteractObjById)

	if #var_38_1 > 0 then
		arg_38_0:setSelectObj(var_38_1[1])
	end
end

function var_0_0.sortInteractObjById(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.config.interactType
	local var_39_1 = arg_39_1.config.interactType

	if var_39_0 ~= var_39_1 then
		return var_39_0 < var_39_1
	end

	return arg_39_0.id < arg_39_1.id
end

function var_0_0.gameClear(arg_40_0)
	Va3ChessGameModel.instance:setResult(true)
	arg_40_0:dispatchEvent(Va3ChessEvent.SetViewVictory)
	arg_40_0:dispatchEvent(Va3ChessEvent.CurrentConditionUpdate)
end

function var_0_0.gameOver(arg_41_0)
	Va3ChessGameModel.instance:setResult(false)
	arg_41_0:dispatchEvent(Va3ChessEvent.SetViewFail)
	arg_41_0:dispatchEvent(Va3ChessEvent.CurrentConditionUpdate)
end

function var_0_0.posCanWalk(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = false

	if not Va3ChessGameModel.instance:isPosInChessBoard(arg_42_1, arg_42_2) then
		return var_42_0
	end

	local var_42_1 = Va3ChessGameModel.instance:getTileMO(arg_42_1, arg_42_2)

	if not var_42_1 or var_42_1.tileType == Va3ChessEnum.TileBaseType.None then
		return var_42_0
	end

	local var_42_2 = var_42_1:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui)
	local var_42_3 = var_42_1:isFinishTrigger(Va3ChessEnum.TileTrigger.Broken)

	if not var_42_2 and not var_42_3 and not arg_42_0:isBaffleBlock(arg_42_1, arg_42_2, arg_42_3) then
		var_42_0 = arg_42_0:posObjCanWalk(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	end

	return var_42_0
end

function var_0_0.getPlayerNextCanWalkPosDict(arg_43_0)
	local var_43_0 = {}
	local var_43_1 = arg_43_0.interacts and arg_43_0.interacts:getMainPlayer(true) or nil

	if not var_43_1 then
		return var_43_0
	end

	local var_43_2 = var_43_1.originData.posX
	local var_43_3 = var_43_1.originData.posY
	local var_43_4 = {
		{
			x = var_43_2,
			y = var_43_3 + 1
		},
		{
			x = var_43_2,
			y = var_43_3 - 1
		},
		{
			x = var_43_2 - 1,
			y = var_43_3
		},
		{
			x = var_43_2 + 1,
			y = var_43_3
		}
	}

	for iter_43_0, iter_43_1 in ipairs(var_43_4) do
		local var_43_5 = Va3ChessMapUtils.ToDirection(var_43_2, var_43_3, iter_43_1.x, iter_43_1.y)

		if arg_43_0:posCanWalk(iter_43_1.x, iter_43_1.y, var_43_5, var_43_1.objType) then
			var_43_0[Activity142Helper.getPosHashKey(iter_43_1.x, iter_43_1.y)] = true
		end
	end

	return var_43_0
end

function var_0_0.isBaffleBlock(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = false
	local var_44_1
	local var_44_2
	local var_44_3

	if arg_44_3 == Va3ChessEnum.Direction.Down then
		var_44_1 = arg_44_1
		var_44_2 = arg_44_2 + 1
		var_44_3 = Va3ChessEnum.Direction.Up
	elseif arg_44_3 == Va3ChessEnum.Direction.Left then
		var_44_1 = arg_44_1 + 1
		var_44_2 = arg_44_2
		var_44_3 = Va3ChessEnum.Direction.Right
	elseif arg_44_3 == Va3ChessEnum.Direction.Right then
		var_44_1 = arg_44_1 - 1
		var_44_2 = arg_44_2
		var_44_3 = Va3ChessEnum.Direction.Left
	elseif arg_44_3 == Va3ChessEnum.Direction.Up then
		var_44_1 = arg_44_1
		var_44_2 = arg_44_2 - 1
		var_44_3 = Va3ChessEnum.Direction.Down
	else
		logError(string.format("Va3ChessGameController:isBaffleBlock error, un support direction, x : %s, y : %s, direction : %s", arg_44_1, arg_44_2, arg_44_3))

		return var_44_0
	end

	local var_44_4 = true
	local var_44_5 = Va3ChessGameModel.instance:getTileMO(var_44_1, var_44_2)

	if var_44_5 then
		var_44_4 = var_44_5:isHasBaffleInDir(arg_44_3)
	end

	local var_44_6 = true
	local var_44_7 = Va3ChessGameModel.instance:getTileMO(arg_44_1, arg_44_2)

	if var_44_7 then
		var_44_6 = var_44_7:isHasBaffleInDir(var_44_3)
	end

	return var_44_4 or var_44_6
end

function var_0_0.posObjCanWalk(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	local var_45_0, var_45_1 = arg_45_0:searchInteractByPos(arg_45_1, arg_45_2)

	if var_45_0 == 1 then
		if var_45_1 then
			if var_45_1:canBlock(arg_45_3, arg_45_4) then
				return false
			else
				local var_45_2 = {
					dir = arg_45_3,
					objType = arg_45_4
				}

				var_45_1:showStateView(Va3ChessEnum.ObjState.Interoperable, var_45_2)
			end
		end
	elseif var_45_0 > 1 then
		for iter_45_0 = 1, var_45_0 do
			if var_45_1[iter_45_0] then
				if var_45_1[iter_45_0]:canBlock(arg_45_3, arg_45_4) then
					return false
				else
					local var_45_3 = {
						dir = arg_45_3,
						objType = arg_45_4
					}

					var_45_1[iter_45_0]:showStateView(Va3ChessEnum.ObjState.Interoperable, var_45_3)
				end
			end
		end
	else
		return true
	end

	return true
end

function var_0_0.resetObjStateOnNewRound(arg_46_0)
	local var_46_0 = arg_46_0.interacts:getList()

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		iter_46_1:showStateView(Va3ChessEnum.ObjState.Idle)
	end
end

function var_0_0.getNearestScenePos(arg_47_0, arg_47_1, arg_47_2)
	if not arg_47_0._treeSceneComp then
		return nil
	end

	local var_47_0 = arg_47_0._treeSceneComp:search(arg_47_1, arg_47_2)
	local var_47_1 = 99999999
	local var_47_2
	local var_47_3 = Va3ChessEnum.ClickYWeight

	if var_47_0 then
		for iter_47_0 = 1, #var_47_0 do
			local var_47_4 = var_47_0[iter_47_0]
			local var_47_5 = var_47_4.x - arg_47_1
			local var_47_6 = var_47_4.y - arg_47_2

			if math.abs(var_47_5) <= Va3ChessEnum.ClickRangeX and math.abs(var_47_6) <= Va3ChessEnum.ClickRangeY then
				local var_47_7 = var_47_5 * var_47_5 + var_47_6 * var_47_6 * var_47_3

				if var_47_7 < var_47_1 then
					var_47_2 = var_47_4
					var_47_1 = var_47_7
				end
			end
		end
	end

	if var_47_2 then
		return var_47_2.tileX, var_47_2.tileY
	else
		return nil
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
