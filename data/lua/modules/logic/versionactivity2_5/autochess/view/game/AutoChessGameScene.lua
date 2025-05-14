module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessGameScene", package.seeall)

local var_0_0 = class("AutoChessGameScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.gotouch = gohelper.findChild(arg_1_0.viewGO, "UI/#go_touch")
	arg_1_0.layerBg = gohelper.findChild(arg_1_0.viewGO, "Scene/BgLayer")
	arg_1_0.simageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Scene/BgLayer/simage_Bg")
	arg_1_0.layerChess = gohelper.findChild(arg_1_0.viewGO, "Scene/ChessLayer")
	arg_1_0.goBoarder = gohelper.findChild(arg_1_0.viewGO, "Scene/BoardLayer/Boader")
	arg_1_0.goChess = gohelper.findChild(arg_1_0.viewGO, "Scene/ChessLayer/Chess")
	arg_1_0.goGlow1 = gohelper.findChild(arg_1_0.viewGO, "Scene/BgLayerGlow/go_Glow1")
	arg_1_0.goGlow2 = gohelper.findChild(arg_1_0.viewGO, "Scene/BgLayerGlow/go_Glow2")
	arg_1_0.goGlow3 = gohelper.findChild(arg_1_0.viewGO, "Scene/BgLayerGlow/go_Glow3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0.onClickScene, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.moduleId = AutoChessModel.instance:getCurModuleId()
	arg_4_0.chessMo = AutoChessModel.instance:getChessMo()
	arg_4_0._tfTouch = arg_4_0.gotouch.transform
	arg_4_0._click = gohelper.getClickWithDefaultAudio(arg_4_0.gotouch)

	CommonDragHelper.instance:registerDragObj(arg_4_0.gotouch, arg_4_0._beginDrag, arg_4_0._onDrag, arg_4_0._endDrag, arg_4_0._checkDrag, arg_4_0, nil, true)

	arg_4_0.tileItemDic = {}
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_5_0.onCloseViewFinish, arg_5_0)
	arg_5_0:addEventCb(AutoChessController.instance, AutoChessEvent.PlayStepList, arg_5_0.startImmediatelyFlow, arg_5_0)
	arg_5_0:addEventCb(AutoChessController.instance, AutoChessEvent.EnterFightReply, arg_5_0.onEnterFightReply, arg_5_0)
	arg_5_0:addEventCb(AutoChessController.instance, AutoChessEvent.StopFight, arg_5_0.onStopFight, arg_5_0)
	arg_5_0:addEventCb(AutoChessController.instance, AutoChessEvent.SkipFight, arg_5_0.onSkipFight, arg_5_0)
	arg_5_0:addEventCb(AutoChessController.instance, AutoChessEvent.NextRound, arg_5_0.onNextRound, arg_5_0)
	arg_5_0:addEventCb(AutoChessController.instance, AutoChessEvent.CheckEnemyTeam, arg_5_0.onCheckEnemy, arg_5_0)
	arg_5_0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItem, arg_5_0.activeGlow, arg_5_0)
	arg_5_0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItemEnd, arg_5_0.inactiveGlow, arg_5_0)
	AutoChessEntityMgr.instance:init(arg_5_0)
	AutoChessEffectMgr.instance:init()
	arg_5_0:changeScene(AutoChessEnum.ViewType.Player)
	arg_5_0:checkBeforeBuy()
end

function var_0_0.onClose(arg_6_0)
	if arg_6_0.fightFlow then
		arg_6_0.fightFlow:stop()
		arg_6_0.fightFlow:unregisterDoneListener(arg_6_0.fightFlowDone, arg_6_0)
		arg_6_0.fightFlow:destroy()

		arg_6_0.fightFlow = nil
	end

	AutoChessHelper.lockScreen("AutoChessGameScene", false)
end

function var_0_0.onDestroyView(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.delayEnterFightScene, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.delayAddEnemy, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.startFightFlow, arg_7_0)
	CommonDragHelper.instance:unregisterDragObj(arg_7_0.gotouch)
	AutoChessEntityMgr.instance:dispose()
	AutoChessEffectMgr.instance:dispose()
end

function var_0_0.changeScene(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.viewType = arg_8_1
	arg_8_0.tileNodes = AutoChessGameModel.instance:initTileNodes(arg_8_1)

	if arg_8_1 == AutoChessEnum.ViewType.Player then
		arg_8_0.simageBg:LoadImage(ResUrl.getAutoChessIcon("scene_player_" .. arg_8_0.moduleId, "scene"))
	elseif arg_8_1 == AutoChessEnum.ViewType.All then
		arg_8_0.simageBg:LoadImage(ResUrl.getAutoChessIcon("scene_all_" .. arg_8_0.moduleId, "scene"))
	elseif arg_8_1 == AutoChessEnum.ViewType.Enemy then
		arg_8_0.simageBg:LoadImage(ResUrl.getAutoChessIcon("scene_enemy_" .. arg_8_0.moduleId, "scene"))
	end

	AutoChessEntityMgr.instance:cacheAllEntity()

	if not arg_8_2 then
		arg_8_0:initEntity()
	end
end

function var_0_0.initTile(arg_9_0)
	arg_9_0:clearTile()

	local var_9_0 = AutoChessEnum.BoardSize.Row
	local var_9_1

	if arg_9_0.viewType == AutoChessEnum.ViewType.All then
		var_9_1 = AutoChessEnum.BoardSize.Column * 2
	else
		var_9_1 = AutoChessEnum.BoardSize.Column
	end

	for iter_9_0 = 1, var_9_0 do
		arg_9_0.tileItemDic[iter_9_0] = arg_9_0.tileItemDic[iter_9_0] or {}

		for iter_9_1 = 1, var_9_1 do
			local var_9_2 = arg_9_0.tileItemDic[iter_9_0][iter_9_1]
			local var_9_3 = arg_9_0.tileNodes[iter_9_0][iter_9_1]
			local var_9_4 = AutoChessEnum.TileSize[arg_9_0.viewType][iter_9_0]

			if not var_9_2 then
				var_9_2 = arg_9_0:getUserDataTb_()
				var_9_2.go = gohelper.cloneInPlace(arg_9_0.goBoarder, string.format("Boarder%d_%d", iter_9_0, iter_9_1))
				var_9_2.transform = var_9_2.go.transform
				arg_9_0.tileItemDic[iter_9_0][iter_9_1] = var_9_2
			end

			recthelper.setSize(var_9_2.transform, var_9_4.x, var_9_4.y)
			recthelper.setAnchor(var_9_2.transform, var_9_3.x, var_9_3.y)
			gohelper.setActive(var_9_2.go, true)
		end
	end
end

function var_0_0.clearTile(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.tileItemDic) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
			gohelper.setActive(iter_10_3.go, false)
		end
	end
end

function var_0_0.createLeaderEntity(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getResInst(AutoChessEnum.ChessLeaderEntityPath, arg_11_0.layerChess, "Leader" .. arg_11_1.uid)
	local var_11_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0, AutoChessLeaderEntity, arg_11_0)

	var_11_1:setData(arg_11_1)

	return var_11_1
end

function var_0_0.initEntity(arg_12_0)
	local var_12_0 = arg_12_0.chessMo.svrFight

	if arg_12_0.viewType == AutoChessEnum.ViewType.Player then
		AutoChessEntityMgr.instance:addLeaderEntity(var_12_0.mySideMaster)
	else
		AutoChessEntityMgr.instance:addLeaderEntity(var_12_0.enemyMaster)
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_0.warZones) do
		local var_12_1 = iter_12_1.id

		for iter_12_2 = 1, #iter_12_1.positions do
			local var_12_2 = iter_12_1.positions[iter_12_2]
			local var_12_3 = var_12_2.chess.uid

			if tonumber(var_12_3) ~= 0 and (arg_12_0.viewType == AutoChessEnum.ViewType.Player and var_12_2.index < AutoChessEnum.BoardSize.Column or arg_12_0.viewType == AutoChessEnum.ViewType.Enemy and var_12_2.index > AutoChessEnum.BoardSize.Column - 1) then
				AutoChessEntityMgr.instance:addEntity(var_12_1, var_12_2.chess, var_12_2.index)
			end
		end
	end
end

function var_0_0.createEntity(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getResInst(AutoChessEnum.ChessEntityPath, arg_13_0.layerChess, "Chess" .. arg_13_2.uid)
	local var_13_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_0, AutoChessEntity, arg_13_0)

	var_13_1:setData(arg_13_2, arg_13_1, arg_13_3)

	return var_13_1
end

function var_0_0.onCloseViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.AutoChessStartFightView then
		AutoChessHelper.lockScreen("AutoChessGameScene", true)

		local var_14_0 = arg_14_0.chessMo.lastSvrFight

		AutoChessEntityMgr.instance:addLeaderEntity(var_14_0.mySideMaster, true)
		AutoChessEntityMgr.instance:addLeaderEntity(var_14_0.enemyMaster, true)

		for iter_14_0, iter_14_1 in ipairs(var_14_0.warZones) do
			local var_14_1 = iter_14_1.id

			for iter_14_2 = 1, #iter_14_1.positions do
				local var_14_2 = iter_14_1.positions[iter_14_2]
				local var_14_3 = var_14_2.chess.uid

				if iter_14_2 <= AutoChessEnum.BoardSize.Column and tonumber(var_14_3) ~= 0 then
					AutoChessEntityMgr.instance:addEntity(var_14_1, var_14_2.chess, var_14_2.index)
				end
			end
		end

		TaskDispatcher.runDelay(arg_14_0.delayAddEnemy, arg_14_0, 0.5)
		TaskDispatcher.runDelay(arg_14_0.startFightFlow, arg_14_0, 0.8)
	end
end

function var_0_0.delayAddEnemy(arg_15_0)
	local var_15_0 = arg_15_0.chessMo.lastSvrFight

	for iter_15_0, iter_15_1 in ipairs(var_15_0.warZones) do
		local var_15_1 = iter_15_1.id

		for iter_15_2 = 1, #iter_15_1.positions do
			local var_15_2 = iter_15_1.positions[iter_15_2]
			local var_15_3 = var_15_2.chess.uid

			if iter_15_2 > AutoChessEnum.BoardSize.Column and tonumber(var_15_3) ~= 0 then
				AutoChessEntityMgr.instance:addEntity(var_15_1, var_15_2.chess, var_15_2.index)
			end
		end
	end
end

function var_0_0.onNextRound(arg_16_0)
	AutoChessEntityMgr.instance:clearEntity()
	arg_16_0:changeScene(AutoChessEnum.ViewType.Player)
	arg_16_0:checkBeforeBuy()
end

function var_0_0.onStopFight(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0.fightFlow:stop()
	else
		arg_17_0.fightFlow:resume()
	end
end

function var_0_0.onSkipFight(arg_18_0)
	arg_18_0:fightFlowDone()
end

function var_0_0.onEnterFightReply(arg_19_0)
	arg_19_0:checkAfterBuy()
end

function var_0_0.onCheckEnemy(arg_20_0, arg_20_1)
	if arg_20_1 then
		arg_20_0:changeScene(AutoChessEnum.ViewType.Enemy)
	else
		arg_20_0:changeScene(AutoChessEnum.ViewType.Player)
	end
end

function var_0_0.activeGlow(arg_21_0, arg_21_1)
	if lua_auto_chess.configDict[arg_21_1][1].type == AutoChessStrEnum.ChessType.Attack then
		gohelper.setActive(arg_21_0.goGlow1, true)
		gohelper.setActive(arg_21_0.goGlow3, true)
	else
		gohelper.setActive(arg_21_0.goGlow2, true)
	end
end

function var_0_0.inactiveGlow(arg_22_0)
	gohelper.setActive(arg_22_0.goGlow1, false)
	gohelper.setActive(arg_22_0.goGlow2, false)
	gohelper.setActive(arg_22_0.goGlow3, false)
end

function var_0_0.onClickScene(arg_23_0)
	if arg_23_0.isDraging then
		return
	end

	local var_23_0 = GamepadController.instance:getMousePosition()
	local var_23_1 = recthelper.screenPosToAnchorPos(var_23_0, arg_23_0._tfTouch)
	local var_23_2, var_23_3 = AutoChessGameModel.instance:getNearestTileXY(var_23_1.x, var_23_1.y)

	if var_23_3 then
		if arg_23_0.viewType == AutoChessEnum.ViewType.Enemy then
			var_23_3 = var_23_3 + 5
		end

		local var_23_4 = arg_23_0.viewType == AutoChessEnum.ViewType.All and arg_23_0.chessMo.lastSvrFight or arg_23_0.chessMo.svrFight
		local var_23_5 = arg_23_0.chessMo:getChessPosition(var_23_2, var_23_3, var_23_4).chess.uid

		if tonumber(var_23_5) ~= 0 then
			local var_23_6 = AutoChessEntityMgr.instance:getEntity(var_23_5)
			local var_23_7 = {
				chessEntity = var_23_6
			}

			AutoChessController.instance:openCardInfoView(var_23_7)
		end

		return
	end

	local var_23_8 = AutoChessGameModel.instance:getNearestLeader(var_23_1)

	if var_23_8 and lua_auto_chess_master.configDict[var_23_8.id].skillId ~= 0 then
		ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
			leader = var_23_8
		})
	end
end

function var_0_0._beginDrag(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.isDraging = true

	local var_24_0 = recthelper.screenPosToAnchorPos(arg_24_2.position, arg_24_0._tfTouch)
	local var_24_1, var_24_2 = AutoChessGameModel.instance:getNearestTileXY(var_24_0.x, var_24_0.y)

	if var_24_1 then
		local var_24_3 = arg_24_0.chessMo:getChessPosition(var_24_1, var_24_2)
		local var_24_4 = var_24_3.chess.uid

		if tonumber(var_24_4) ~= 0 then
			local var_24_5 = var_24_3.chess.id
			local var_24_6 = AutoChessEntityMgr.instance:getEntity(var_24_4)

			if var_24_6.teamType == AutoChessEnum.TeamType.Player then
				arg_24_0.chessAvatar = AutoChessGameModel.instance.avatar

				if arg_24_0.chessAvatar then
					arg_24_0.selectChess = var_24_6

					arg_24_0.selectChess:hide()

					local var_24_7 = transformhelper.getLocalScale(var_24_6.dirTrs)
					local var_24_8 = var_24_6.meshComp
					local var_24_9 = gohelper.findChildUIMesh(arg_24_0.chessAvatar)

					var_24_9.material = var_24_8.uiMesh.material
					var_24_9.mesh = var_24_8.uiMesh.mesh

					var_24_9:SetVerticesDirty()
					var_24_9:SetMaterialDirty()
					recthelper.setAnchor(arg_24_0.chessAvatar.transform, var_24_0.x, var_24_0.y)
					transformhelper.setLocalScale(arg_24_0.chessAvatar.transform, var_24_7, 1, 1)

					local var_24_10 = gohelper.findChildImage(arg_24_0.chessAvatar, "role")

					var_24_10.sprite = var_24_8.imageRole.sprite

					var_24_10:SetNativeSize()
					gohelper.setActive(arg_24_0.chessAvatar, true)
					AutoChessController.instance:dispatchEvent(AutoChessEvent.DragChessEntity, var_24_5)
					arg_24_0:activeGlow(var_24_5)
				end
			end
		end
	end
end

function var_0_0._onDrag(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0.selectChess then
		local var_25_0 = arg_25_2.position
		local var_25_1 = recthelper.screenPosToAnchorPos(var_25_0, arg_25_0._tfTouch)

		arg_25_0:_moveToPos(arg_25_0.chessAvatar.transform, var_25_1)
	end
end

function var_0_0._endDrag(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.isDraging = false

	if arg_26_0.selectChess then
		local var_26_0 = arg_26_0.selectChess.data.uid
		local var_26_1 = arg_26_0.selectChess.warZone
		local var_26_2 = arg_26_0.selectChess.index
		local var_26_3 = arg_26_2.position
		local var_26_4 = recthelper.screenPosToAnchorPos(var_26_3, arg_26_0._tfTouch)
		local var_26_5, var_26_6 = AutoChessGameModel.instance:getNearestTileXY(var_26_4.x, var_26_4.y)

		if var_26_6 and var_26_6 < 6 then
			if var_26_5 == var_26_1 and var_26_6 == var_26_2 + 1 then
				arg_26_0.selectChess:show()
			else
				local var_26_7 = arg_26_0.chessMo:getChessPosition(var_26_5, var_26_6)
				local var_26_8 = AutoChessEntityMgr.instance:tryGetEntity(var_26_7.chess.uid)

				if var_26_8 then
					local var_26_9 = AutoChessHelper.hasUniversalBuff(arg_26_0.selectChess.data.buffContainer.buffs)

					if AutoChessController.instance:isDragDisable() then
						arg_26_0.selectChess:show()
					elseif var_26_9 or AutoChessHelper.sameWarZoneType(var_26_1, var_26_5) then
						if var_26_8.data.id == arg_26_0.selectChess.data.id then
							AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
						else
							AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
						end

						AutoChessRpc.instance:sendAutoChessBuildRequest(arg_26_0.moduleId, AutoChessEnum.BuildType.Exchange, var_26_1, var_26_2, var_26_0, var_26_5, var_26_6 - 1, var_26_8.data.uid)
					else
						GameFacade.showToast(ToastEnum.AutoChessExchangeError)
						arg_26_0.selectChess:show()
					end
				elseif AutoChessHelper.sameWarZoneType(var_26_1, var_26_5) then
					AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
					AutoChessRpc.instance:sendAutoChessBuildRequest(arg_26_0.moduleId, AutoChessEnum.BuildType.Exchange, var_26_1, var_26_2, var_26_0, var_26_5, var_26_6 - 1, 0)
				else
					GameFacade.showToast(ToastEnum.AutoChessExchangeError)
					arg_26_0.selectChess:show()
				end
			end
		else
			local var_26_10 = arg_26_2.pointerEnter

			if var_26_10 and var_26_10.name == "#go_CheckSell" and not AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableSale, arg_26_0.selectChess.data.id) then
				AutoChessRpc.instance:sendAutoChessBuildRequest(arg_26_0.moduleId, AutoChessEnum.BuildType.Sell, var_26_1, var_26_2, var_26_0)
			else
				arg_26_0.selectChess:show()
			end
		end

		gohelper.setActive(arg_26_0.chessAvatar, false)

		arg_26_0.chessAvatar = nil
		arg_26_0.selectChess = nil

		AutoChessController.instance:dispatchEvent(AutoChessEvent.DragChessEntityEnd)
		arg_26_0:inactiveGlow()
	end
end

function var_0_0._checkDrag(arg_27_0)
	if arg_27_0.fightFlow then
		return true
	end
end

function var_0_0._moveToPos(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0, var_28_1 = transformhelper.getPos(arg_28_1)

	if math.abs(var_28_0 - arg_28_2.x) > 50 or math.abs(var_28_1 - arg_28_2.y) > 50 then
		if arg_28_0.tweenId then
			ZProj.TweenHelper.KillById(arg_28_0.tweenId)

			arg_28_0.tweenId = nil
		end

		arg_28_0.tweenId = ZProj.TweenHelper.DOAnchorPos(arg_28_1, arg_28_2.x, arg_28_2.y, 0.2)
	else
		recthelper.setAnchor(arg_28_1, arg_28_2.x, arg_28_2.y)
	end
end

function var_0_0.startImmediatelyFlow(arg_29_0, arg_29_1)
	arg_29_0.immediatelyFlow = FlowSequence.New()

	local var_29_0 = AutoChessSideWork.New(arg_29_1)

	arg_29_0.immediatelyFlow:addWork(var_29_0)
	arg_29_0.immediatelyFlow:registerDoneListener(arg_29_0.immediatelyFlowDone, arg_29_0)
	AutoChessHelper.lockScreen("AutoChessGameScene", true)
	arg_29_0.immediatelyFlow:start(AutoChessEnum.ContextType.Immediately)
end

function var_0_0.immediatelyFlowDone(arg_30_0)
	if arg_30_0.immediatelyFlow then
		arg_30_0.immediatelyFlow:unregisterDoneListener(arg_30_0.immediatelyFlowDone, arg_30_0)
		arg_30_0.immediatelyFlow:destroy()

		arg_30_0.immediatelyFlow = nil
	end

	AutoChessHelper.lockScreen("AutoChessGameScene", false)
end

function var_0_0.startFightFlow(arg_31_0)
	AutoChessHelper.lockScreen("AutoChessGameScene", false)

	local var_31_0 = arg_31_0.chessMo.fightEffectList

	if var_31_0 then
		arg_31_0.fightFlow = FlowSequence.New()

		local var_31_1 = AutoChessSideWork.New(var_31_0)

		arg_31_0.fightFlow:addWork(var_31_1)
		arg_31_0.fightFlow:registerDoneListener(arg_31_0.fightFlowDone, arg_31_0)
		arg_31_0.fightFlow:start(AutoChessEnum.ContextType.Fight)

		arg_31_0.chessMo.fightEffectList = nil
	else
		AutoChessController.instance:dispatchEvent(AutoChessEvent.EndFight)
	end
end

function var_0_0.fightFlowDone(arg_32_0)
	if arg_32_0.fightFlow then
		arg_32_0.fightFlow:unregisterDoneListener(arg_32_0.fightFlowDone, arg_32_0)
		arg_32_0.fightFlow:destroy()

		arg_32_0.fightFlow = nil
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.EndFight)
end

function var_0_0.checkBeforeBuy(arg_33_0)
	local var_33_0 = arg_33_0.chessMo.startBuyEffectList

	if var_33_0 then
		arg_33_0.beforeBuyFlow = FlowSequence.New()

		local var_33_1 = AutoChessSideWork.New(var_33_0)

		arg_33_0.beforeBuyFlow:addWork(var_33_1)
		arg_33_0.beforeBuyFlow:registerDoneListener(arg_33_0.beforeBuyFlowDone, arg_33_0)
		AutoChessHelper.lockScreen("AutoChessGameScene", true)
		arg_33_0.beforeBuyFlow:start(AutoChessEnum.ContextType.StartBuy)

		arg_33_0.chessMo.startBuyEffectList = nil
	else
		AutoChessController.instance:dispatchEvent(AutoChessEvent.StartBuyStepFinih)
	end
end

function var_0_0.beforeBuyFlowDone(arg_34_0)
	arg_34_0.beforeBuyFlow:unregisterDoneListener(arg_34_0.beforeBuyFlowDone, arg_34_0)
	arg_34_0.beforeBuyFlow:destroy()

	arg_34_0.beforeBuyFlow = nil

	AutoChessHelper.lockScreen("AutoChessGameScene", false)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StartBuyStepFinih)
end

function var_0_0.checkAfterBuy(arg_35_0)
	AutoChessHelper.lockScreen("AutoChessGameScene", true)

	local var_35_0 = arg_35_0.chessMo.endBuyEffectList

	if var_35_0 then
		arg_35_0.afterBuyFlow = FlowSequence.New()

		local var_35_1 = AutoChessSideWork.New(var_35_0)

		arg_35_0.afterBuyFlow:addWork(var_35_1)
		arg_35_0.afterBuyFlow:registerDoneListener(arg_35_0.afterBuyFlowDone, arg_35_0)
		arg_35_0.afterBuyFlow:start(AutoChessEnum.ContextType.EndBuy)

		arg_35_0.chessMo.endBuyEffectList = nil
	else
		arg_35_0:afterBuyFlowDone()
	end
end

function var_0_0.afterBuyFlowDone(arg_36_0)
	if arg_36_0.afterBuyFlow then
		arg_36_0.afterBuyFlow:unregisterDoneListener(arg_36_0.beforeBuyFlowDone, arg_36_0)
		arg_36_0.afterBuyFlow:destroy()

		arg_36_0.afterBuyFlow = nil
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.StartFight)
	TaskDispatcher.runDelay(arg_36_0.delayEnterFightScene, arg_36_0, 0.5)
	AutoChessHelper.lockScreen("AutoChessGameScene", false)
end

function var_0_0.delayEnterFightScene(arg_37_0)
	arg_37_0:changeScene(AutoChessEnum.ViewType.All, true)
end

return var_0_0
