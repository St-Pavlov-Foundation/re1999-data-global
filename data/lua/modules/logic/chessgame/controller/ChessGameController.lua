module("modules.logic.chessgame.controller.ChessGameController", package.seeall)

local var_0_0 = class("ChessGameController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	return
end

function var_0_0.initServerMap(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if arg_2_2.episodeId and arg_2_2.currMapIndex then
		local var_2_1 = arg_2_2.currMapIndex + 1

		ChessGameModel.instance:clear()
		arg_2_0:checkShowEffect()
		ChessGameInteractModel.instance:clear()
		ChessGameModel.instance:initData(arg_2_1, arg_2_2.episodeId, var_2_1)
		ChessGameModel.instance:setNowMapIndex(var_2_1)
		ChessGameModel.instance:setCompletedCount(arg_2_2.completedCount)

		local var_2_2 = ChessConfig.instance:getEpisodeCo(arg_2_1, arg_2_2.episodeId).mapIds

		ChessGameConfig.instance:setCurrentMapGroupId(var_2_2)

		local var_2_3 = ChessGameConfig.instance:getMapCo(var_2_2)

		ChessGameNodeModel.instance:setNodeDatas(var_2_3[var_2_1].nodes)

		if arg_2_2.interact then
			ChessGameInteractModel.instance:setInteractDatas(arg_2_2.interact, var_2_1)
		end
	end

	arg_2_0:setClickStatus(ChessGameEnum.SelectPosStatus.None)

	arg_2_0._selectObj = nil

	arg_2_0:setSelectObj(nil)

	arg_2_0.interactsMgr = arg_2_0.interactsMgr or ChessInteractMgr.New()

	if not arg_2_0:existGame() then
		arg_2_0.interactsMgr:removeAll()
	end

	arg_2_0:initObjects(arg_2_2.currMapIndex + 1)

	arg_2_0.eventMgr = arg_2_0.eventMgr or ChessEventMgr.New()

	arg_2_0.eventMgr:removeAll()
	arg_2_0.eventMgr:setCurEvent(nil)

	arg_2_0._isPlaying = true

	var_0_0.instance:dispatchEvent(ChessGameEvent.CurrentConditionUpdate)
end

function var_0_0.enterChessGame(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	logNormal("ChessGameController : enterChessGame!")

	arg_3_0._viewName = arg_3_3 or arg_3_0._viewName

	ViewMgr.instance:openView(arg_3_0._viewName, arg_3_0:packViewParam())
	ChessGameModel.instance:clearRollbackNum()
	ChessStatController.instance:startStat()
end

function var_0_0.exitGame(arg_4_0)
	ChessGameModel.instance:clear()
	ChessGameInteractModel.instance:clear()
	ChessGameNodeModel.instance:clear()
	ChessGameModel.instance:clearRollbackNum()
	arg_4_0:abortGame()

	local var_4_0 = 0

	;(ChessGameJumpHandler["jump" .. var_4_0] or ChessGameJumpHandler.defaultJump)()
end

function var_0_0.reInit(arg_5_0)
	arg_5_0:release()
end

function var_0_0.release(arg_6_0)
	if arg_6_0.interactsMgr then
		arg_6_0.interactsMgr:removeAll()
	end

	if arg_6_0.eventMgr then
		arg_6_0.eventMgr:removeAll()
	end

	arg_6_0._treeComp = nil
	arg_6_0.interactsMgr = nil
	arg_6_0.eventMgr = nil
	arg_6_0._isPlaying = false
end

function var_0_0.setViewName(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0._viewName = arg_7_1
	end
end

function var_0_0.getViewName(arg_8_0)
	return arg_8_0._viewName or ViewName.ChessGameScene
end

function var_0_0.packViewParam(arg_9_0)
	return
end

function var_0_0.deleteInteractObj(arg_10_0, arg_10_1)
	if not ChessGameInteractModel.instance:getInteractById(arg_10_1) then
		return
	end

	ChessGameInteractModel.instance:deleteInteractById(arg_10_1)
	arg_10_0.interactsMgr:remove(arg_10_1)
end

function var_0_0.addInteractObj(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.id
	local var_11_1 = var_0_0.instance.interactsMgr:get(var_11_0)

	if var_11_1 and var_11_1:tryGetGameObject() then
		return
	end

	local var_11_2 = arg_11_1.mapGroupId or ChessGameConfig.instance:getCurrentMapGroupId()
	local var_11_3 = ChessGameModel.instance:getNowMapIndex()
	local var_11_4 = ChessGameConfig.instance:getInteractCoById(var_11_2, var_11_0)
	local var_11_5 = ChessGameInteractModel.instance:addInteractMo(var_11_4, arg_11_1)

	if var_11_5:isShow() then
		local var_11_6 = ChessInteractComp.New()

		var_11_6:init(var_11_3, var_11_5)

		if var_11_6.config ~= nil then
			arg_11_0.interactsMgr:add(var_11_6)
		end

		arg_11_0:dispatchEvent(ChessGameEvent.AddInteractObj, var_11_6)
	end
end

function var_0_0.getSelectObj(arg_12_0)
	return arg_12_0._selectObj
end

function var_0_0.isNeedBlock(arg_13_0)
	if arg_13_0.eventMgr and arg_13_0.eventMgr:isNeedBlock() then
		return true
	end

	return false
end

function var_0_0.initObjects(arg_14_0, arg_14_1)
	local var_14_0 = ChessGameInteractModel.instance:getInteractsByMapIndex(arg_14_1)
	local var_14_1 = arg_14_0.interactsMgr:getList()

	if #var_14_1 > 0 then
		for iter_14_0, iter_14_1 in pairs(var_14_0) do
			local var_14_2 = arg_14_0.interactsMgr:get(iter_14_1.id)

			if not var_14_2 then
				arg_14_0:addInteractObj(iter_14_1)
			elseif var_14_2 and iter_14_1:isShow() and not var_14_2:isShow() then
				arg_14_0.interactsMgr:remove(iter_14_1.id)
				arg_14_0:addInteractObj(iter_14_1)
			else
				var_14_2:updateComp(iter_14_1)
			end
		end

		for iter_14_2 = #var_14_1, 1, -1 do
			local var_14_3 = var_14_1[iter_14_2]
			local var_14_4 = ChessGameInteractModel.instance:getInteractById(var_14_3.mo.id)

			if not var_14_4 or not var_14_4:isShow() then
				arg_14_0.interactsMgr:hideCompById(var_14_3.mo.id)
				arg_14_0.interactsMgr:remove(var_14_3.mo.id)
			end
		end
	else
		for iter_14_3, iter_14_4 in pairs(var_14_0) do
			local var_14_5 = ChessInteractComp.New()

			var_14_5:init(arg_14_1, iter_14_4)

			if var_14_5.config ~= nil then
				arg_14_0.interactsMgr:add(var_14_5)
			end
		end

		arg_14_0:dispatchEvent(ChessGameEvent.AllObjectCreated)
	end
end

function var_0_0.setClickStatus(arg_15_0, arg_15_1)
	arg_15_0._clickStatus = arg_15_1
end

function var_0_0.getClickStatus(arg_16_0)
	return arg_16_0._clickStatus
end

function var_0_0.setSelectObj(arg_17_0, arg_17_1)
	if arg_17_0._selectObj == arg_17_1 then
		return
	end

	if arg_17_0._selectObj ~= nil then
		arg_17_0._selectObj:onCancelSelect()
	end

	arg_17_0._selectObj = arg_17_1

	if arg_17_1 ~= nil then
		arg_17_1:onSelected()
	end
end

function var_0_0.filterSelectable(arg_18_0)
	return arg_18_0.config and arg_18_0.config.interactType == ChessGameEnum.InteractType.Role
end

function var_0_0.searchInteractByPos(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0.interactsMgr:getList()
	local var_19_1
	local var_19_2
	local var_19_3 = 0

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1.mo.posX == arg_19_1 and iter_19_1.mo.posY == arg_19_2 and iter_19_1:isShow() and (not arg_19_3 or arg_19_3(iter_19_1)) then
			if var_19_1 ~= nil then
				var_19_2 = var_19_2 or {
					var_19_1
				}

				table.insert(var_19_2, iter_19_1)
			else
				var_19_1 = iter_19_1
			end

			var_19_3 = var_19_3 + 1
		end
	end

	return var_19_3, var_19_2 or var_19_1
end

function var_0_0.sortSelectObj(arg_20_0, arg_20_1)
	return arg_20_0:getSelectPriority() < arg_20_1:getSelectPriority()
end

function var_0_0.autoSelectPlayer(arg_21_0)
	if not arg_21_0.interactsMgr then
		return
	end

	local var_21_0 = arg_21_0.interactsMgr:getList()

	if not var_21_0 then
		return
	end

	local var_21_1 = {}

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		if (iter_21_1.config and iter_21_1.config.interactType or nil) == ChessGameEnum.InteractType.Role then
			table.insert(var_21_1, iter_21_1)
		end
	end

	table.sort(var_21_1, var_0_0.sortInteractObjById)

	if #var_21_1 > 0 then
		arg_21_0:setSelectObj(var_21_1[1])
	end
end

function var_0_0.sortInteractObjById(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.config.interactType
	local var_22_1 = arg_22_1.config.interactType

	if var_22_0 ~= var_22_1 then
		return var_22_0 < var_22_1
	end

	return arg_22_0.id < arg_22_1.id
end

function var_0_0.posCanWalk(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = true
	local var_23_1 = ChessGameNodeModel.instance:getNode(arg_23_1, arg_23_2)

	if not var_23_1 then
		return false
	end

	if var_23_1.tileType == ChessGameEnum.TileBaseType.None then
		return false
	end

	return (arg_23_0:checkInteractCanWalk(arg_23_1, arg_23_2))
end

function var_0_0.checkInteractCanWalk(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0, var_24_1 = arg_24_0:searchInteractByPos(arg_24_1, arg_24_2)

	if not var_24_1 then
		return true
	end

	local var_24_2
	local var_24_3 = ChessGameModel.instance:getCatchObj()

	if var_24_0 > 1 then
		for iter_24_0, iter_24_1 in ipairs(var_24_1) do
			local var_24_4 = iter_24_1.mo

			if not var_24_4.walkable then
				return false
			end

			if var_24_3 then
				if var_24_4.interactType == ChessGameEnum.InteractType.Prey or var_24_4.interactType == ChessGameEnum.InteractType.Hunter then
					return false
				end

				if iter_24_1:checkShowAvatar() then
					return false
				end
			end
		end
	else
		local var_24_5 = var_24_1.mo

		if not var_24_5.walkable then
			return false
		end

		if var_24_3 then
			if var_24_5.interactType == ChessGameEnum.InteractType.Prey or var_24_5.interactType == ChessGameEnum.InteractType.Hunter then
				return false
			end

			if var_24_1:checkShowAvatar() then
				return false
			end
		end
	end

	return true
end

function var_0_0.saveTempSelectObj(arg_25_0)
	if arg_25_0._selectObj then
		arg_25_0._tempSelectObjId = arg_25_0._selectObj.id
	end
end

function var_0_0.isTempSelectObj(arg_26_0, arg_26_1)
	return arg_26_0._tempSelectObjId == arg_26_1
end

function var_0_0.tryResumeSelectObj(arg_27_0)
	if arg_27_0.interactsMgr and arg_27_0._tempSelectObjId then
		local var_27_0 = arg_27_0.interactsMgr:get(arg_27_0._tempSelectObjId)

		if var_27_0 then
			arg_27_0:setSelectObj(var_27_0)

			arg_27_0._tempSelectObjId = nil

			return true
		end
	end

	arg_27_0:autoSelectPlayer(true)

	return false
end

function var_0_0.setCatchObj(arg_28_0, arg_28_1)
	arg_28_0._catchObj = arg_28_1
end

function var_0_0.getCatchObj(arg_29_0)
	return arg_29_0._catchObj
end

function var_0_0.forceRefreshObjSelectedView(arg_30_0)
	if arg_30_0._selectObj ~= nil then
		arg_30_0._selectObj:onSelected()
	end
end

function var_0_0.setLoadingScene(arg_31_0, arg_31_1)
	arg_31_0._isLoadingScene = arg_31_1
end

function var_0_0.isLoadingScene(arg_32_0)
	return arg_32_0._isLoadingScene
end

function var_0_0.setSceneCamera(arg_33_0, arg_33_1)
	if arg_33_1 then
		local var_33_0 = CameraMgr.instance:getMainCamera()
		local var_33_1 = CameraMgr.instance:getUnitCamera()

		var_33_1.orthographic = true
		var_33_1.orthographicSize = var_33_0.orthographicSize

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
		gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
		PostProcessingMgr.instance:setUnitActive(true)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", 0)
	else
		CameraMgr.instance:getUnitCamera().orthographic = false

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)
		PostProcessingMgr.instance:setUnitActive(false)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", true)
	end
end

function var_0_0.existGame(arg_34_0)
	return arg_34_0._isPlaying
end

function var_0_0.abortGame(arg_35_0)
	arg_35_0._isPlaying = false
end

function var_0_0.gameOver(arg_36_0)
	ChessGameModel.instance:setGameState(ChessGameEnum.GameState.Fail)
	ChessStatController.instance:statFail()

	arg_36_0._isPlaying = false
end

function var_0_0.gameWin(arg_37_0)
	ChessGameModel.instance:setGameState(ChessGameEnum.GameState.Win)
	ChessStatController.instance:statSuccess()

	arg_37_0._isPlaying = false
end

function var_0_0.checkInteractCanUse(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0

	for iter_38_0 = 1, #arg_38_1 do
		local var_38_1 = arg_38_1[iter_38_0]
		local var_38_2 = arg_38_2[iter_38_0]
		local var_38_3 = arg_38_0:getPosCanClickInteract(var_38_1, var_38_2)

		if var_38_3 then
			local var_38_4 = var_38_3.mo:getEffectType()

			if var_38_4 and var_38_4 ~= ChessGameEnum.GameEffectType.None then
				var_38_3.chessEffectObj:onAvatarFinish(var_38_4)
			end

			var_38_0 = var_38_0 or {}
			var_38_0[var_38_3.mo.id] = var_38_3
		end
	end

	local var_38_5 = ChessGameInteractModel.instance:getShowEffects()

	if not var_38_5 then
		return
	end

	local var_38_6 = {}

	for iter_38_1, iter_38_2 in pairs(var_38_5) do
		if var_38_0 then
			if not var_38_0[iter_38_1] and iter_38_2 then
				local var_38_7 = arg_38_0.interactsMgr:get(iter_38_1)

				if var_38_7 then
					var_38_7.chessEffectObj:hideEffect()
				end
			end
		elseif iter_38_2 then
			local var_38_8 = arg_38_0.interactsMgr:get(iter_38_1)

			if var_38_8 then
				var_38_8.chessEffectObj:hideEffect()
			end
		end

		local var_38_9 = ChessGameInteractModel.instance:getInteractById(iter_38_1)

		if var_38_9 and ChessGameInteractModel.instance:checkInteractFinish(var_38_9.id) then
			local var_38_10 = arg_38_0.interactsMgr:get(iter_38_1)

			if var_38_10 then
				var_38_10.chessEffectObj:hideEffect()
			end
		end
	end
end

function var_0_0.getPosCanClickInteract(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0, var_39_1 = arg_39_0:searchInteractByPos(arg_39_1, arg_39_2)
	local var_39_2

	if var_39_0 > 1 then
		for iter_39_0, iter_39_1 in ipairs(var_39_1) do
			if iter_39_1:checkShowAvatar() and iter_39_1.config.touchTrigger then
				var_39_2 = iter_39_1

				break
			end
		end
	else
		var_39_2 = var_39_1 and var_39_1:checkShowAvatar() and var_39_1.config.touchTrigger and var_39_1
	end

	return var_39_2
end

function var_0_0.checkShowEffect(arg_40_0)
	local var_40_0 = ChessGameInteractModel.instance:getShowEffects()

	if not var_40_0 or not arg_40_0.interactsMgr then
		return
	end

	for iter_40_0, iter_40_1 in pairs(var_40_0) do
		local var_40_1 = arg_40_0.interactsMgr:get(iter_40_0)

		if var_40_1 then
			var_40_1.chessEffectObj:hideEffect()
		end
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
