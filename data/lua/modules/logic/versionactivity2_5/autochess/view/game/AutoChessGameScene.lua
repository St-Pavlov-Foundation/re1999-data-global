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
	arg_1_0.goGlow4 = gohelper.findChild(arg_1_0.viewGO, "Scene/BgLayerGlow/go_Glow4")

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
	arg_4_0.moduleId = AutoChessModel.instance.moduleId
	arg_4_0.chessMo = AutoChessModel.instance:getChessMo()
	arg_4_0._tfTouch = arg_4_0.gotouch.transform
	arg_4_0._click = gohelper.getClickWithDefaultAudio(arg_4_0.gotouch)

	CommonDragHelper.instance:registerDragObj(arg_4_0.gotouch, arg_4_0._beginDrag, arg_4_0._onDrag, arg_4_0._endDrag, arg_4_0._checkDrag, arg_4_0, nil, true)
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

	if arg_5_0.moduleId == AutoChessEnum.ModuleId.Friend then
		arg_5_0:changeScene(AutoChessEnum.ViewType.All)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.StartFight)
	else
		arg_5_0:changeScene(AutoChessEnum.ViewType.Player)
		arg_5_0:checkBeforeBuy()
	end
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

	AutoChessGameModel.instance:initTileNodes(arg_8_1)

	local var_8_0 = arg_8_0.moduleId ~= 0 and 1 or arg_8_0.moduleId

	if arg_8_1 == AutoChessEnum.ViewType.Player then
		arg_8_0.simageBg:LoadImage(ResUrl.getAutoChessIcon("scene_player_" .. var_8_0, "scene"))
	elseif arg_8_1 == AutoChessEnum.ViewType.All then
		arg_8_0.simageBg:LoadImage(ResUrl.getAutoChessIcon("scene_all_" .. var_8_0, "scene"))
	elseif arg_8_1 == AutoChessEnum.ViewType.Enemy then
		arg_8_0.simageBg:LoadImage(ResUrl.getAutoChessIcon("scene_enemy_" .. var_8_0, "scene"))
	end

	AutoChessEntityMgr.instance:cacheAllEntity()

	if not arg_8_2 then
		arg_8_0:initEntity()
	end
end

function var_0_0.initTile(arg_9_0)
	local var_9_0 = AutoChessGameModel.instance.tileNodes
	local var_9_1 = AutoChessEnum.BoardSize.Row
	local var_9_2

	if arg_9_0.viewType == AutoChessEnum.ViewType.All then
		var_9_2 = AutoChessEnum.BoardSize.Column * 2
	else
		var_9_2 = AutoChessEnum.BoardSize.Column
	end

	for iter_9_0 = 1, var_9_1 do
		local var_9_3 = AutoChessEnum.TileSize[arg_9_0.viewType][iter_9_0]

		for iter_9_1 = 1, var_9_2 do
			local var_9_4 = var_9_0[iter_9_0][iter_9_1]
			local var_9_5 = gohelper.cloneInPlace(arg_9_0.goBoarder, string.format("Boarder%d_%d", iter_9_0, iter_9_1))

			recthelper.setSize(var_9_5.transform, var_9_3.x, var_9_3.y)
			recthelper.setAnchor(var_9_5.transform, var_9_4.x, var_9_4.y)
			gohelper.setActive(var_9_5, true)
		end

		if arg_9_0.viewType == AutoChessEnum.ViewType.Player then
			local var_9_6 = var_9_0[4][iter_9_0]
			local var_9_7 = gohelper.cloneInPlace(arg_9_0.goBoarder, string.format("Boarder%d_%d", 0, iter_9_0))

			recthelper.setSize(var_9_7.transform, var_9_3.x, var_9_3.y)
			recthelper.setAnchor(var_9_7.transform, var_9_6.x, var_9_6.y)
			gohelper.setActive(var_9_7, true)
		end
	end
end

function var_0_0.createLeaderEntity(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getResInst(AutoChessStrEnum.ResPath.LeaderEntity, arg_10_0.layerChess, "Leader" .. arg_10_1.uid)
	local var_10_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_0, AutoChessLeaderEntity, arg_10_0)

	var_10_1:setData(arg_10_1)

	return var_10_1
end

function var_0_0.initEntity(arg_11_0)
	local var_11_0 = arg_11_0.chessMo.svrFight

	if arg_11_0.viewType == AutoChessEnum.ViewType.Player then
		AutoChessEntityMgr.instance:addLeaderEntity(var_11_0.mySideMaster)

		if var_11_0.unwarZone then
			for iter_11_0, iter_11_1 in ipairs(var_11_0.unwarZone.positions) do
				if tonumber(iter_11_1.chess.uid) ~= 0 then
					AutoChessEntityMgr.instance:addEntity(var_11_0.unwarZone.id, iter_11_1.chess, iter_11_1.index)
				end
			end
		end
	else
		AutoChessEntityMgr.instance:addLeaderEntity(var_11_0.enemyMaster)
	end

	for iter_11_2, iter_11_3 in ipairs(var_11_0.warZones) do
		local var_11_1 = iter_11_3.id

		for iter_11_4 = 1, #iter_11_3.positions do
			local var_11_2 = iter_11_3.positions[iter_11_4]
			local var_11_3 = var_11_2.chess.uid

			if tonumber(var_11_3) ~= 0 and (arg_11_0.viewType == AutoChessEnum.ViewType.Player and var_11_2.index < AutoChessEnum.BoardSize.Column or arg_11_0.viewType == AutoChessEnum.ViewType.Enemy and var_11_2.index > AutoChessEnum.BoardSize.Column - 1) then
				AutoChessEntityMgr.instance:addEntity(var_11_1, var_11_2.chess, var_11_2.index)
			end
		end
	end
end

function var_0_0.createEntity(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:getResInst(AutoChessStrEnum.ResPath.ChessEntity, arg_12_0.layerChess, "Chess" .. arg_12_2.uid)
	local var_12_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_0, AutoChessEntity, arg_12_0)

	var_12_1:setData(arg_12_2, arg_12_1, arg_12_3)

	return var_12_1
end

function var_0_0.onCloseViewFinish(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.AutoChessStartFightView then
		AutoChessHelper.lockScreen("AutoChessGameScene", true)

		local var_13_0 = arg_13_0.chessMo.lastSvrFight

		AutoChessEntityMgr.instance:addLeaderEntity(var_13_0.mySideMaster, true)
		AutoChessEntityMgr.instance:addLeaderEntity(var_13_0.enemyMaster, true)

		for iter_13_0, iter_13_1 in ipairs(var_13_0.warZones) do
			local var_13_1 = iter_13_1.id

			for iter_13_2 = 1, #iter_13_1.positions do
				local var_13_2 = iter_13_1.positions[iter_13_2]
				local var_13_3 = var_13_2.chess.uid

				if iter_13_2 <= AutoChessEnum.BoardSize.Column and tonumber(var_13_3) ~= 0 then
					AutoChessEntityMgr.instance:addEntity(var_13_1, var_13_2.chess, var_13_2.index)
				end
			end
		end

		TaskDispatcher.runDelay(arg_13_0.delayAddEnemy, arg_13_0, 0.5)
		TaskDispatcher.runDelay(arg_13_0.startFightFlow, arg_13_0, 0.8)
	end
end

function var_0_0.delayAddEnemy(arg_14_0)
	local var_14_0 = arg_14_0.chessMo.lastSvrFight

	for iter_14_0, iter_14_1 in ipairs(var_14_0.warZones) do
		local var_14_1 = iter_14_1.id

		for iter_14_2 = 1, #iter_14_1.positions do
			local var_14_2 = iter_14_1.positions[iter_14_2]
			local var_14_3 = var_14_2.chess.uid

			if iter_14_2 > AutoChessEnum.BoardSize.Column and tonumber(var_14_3) ~= 0 then
				AutoChessEntityMgr.instance:addEntity(var_14_1, var_14_2.chess, var_14_2.index)
			end
		end
	end
end

function var_0_0.onNextRound(arg_15_0)
	AutoChessEntityMgr.instance:clearEntity()
	arg_15_0:changeScene(AutoChessEnum.ViewType.Player)
	arg_15_0:checkBeforeBuy()
end

function var_0_0.onStopFight(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0.fightFlow:stop()
	else
		arg_16_0.fightFlow:resume()
	end
end

function var_0_0.onSkipFight(arg_17_0)
	arg_17_0:fightFlowDone()
end

function var_0_0.onEnterFightReply(arg_18_0)
	arg_18_0:checkAfterBuy()
end

function var_0_0.onCheckEnemy(arg_19_0, arg_19_1)
	if arg_19_1 then
		arg_19_0:changeScene(AutoChessEnum.ViewType.Enemy)
	else
		arg_19_0:changeScene(AutoChessEnum.ViewType.Player)
	end
end

function var_0_0.activeGlow(arg_20_0, arg_20_1)
	if arg_20_1.type == AutoChessStrEnum.ChessType.Attack then
		gohelper.setActive(arg_20_0.goGlow1, true)
		gohelper.setActive(arg_20_0.goGlow3, true)
	elseif arg_20_1.type == AutoChessStrEnum.ChessType.Support then
		gohelper.setActive(arg_20_0.goGlow2, true)
	else
		gohelper.setActive(arg_20_0.goGlow4, true)
	end
end

function var_0_0.inactiveGlow(arg_21_0)
	gohelper.setActive(arg_21_0.goGlow1, false)
	gohelper.setActive(arg_21_0.goGlow2, false)
	gohelper.setActive(arg_21_0.goGlow3, false)
	gohelper.setActive(arg_21_0.goGlow4, false)
end

function var_0_0.onClickScene(arg_22_0)
	if arg_22_0.isDraging then
		return
	end

	local var_22_0 = AutoChessGameModel.instance.usingLeaderSkill
	local var_22_1 = GamepadController.instance:getMousePosition()
	local var_22_2 = recthelper.screenPosToAnchorPos(var_22_1, arg_22_0._tfTouch)
	local var_22_3, var_22_4 = AutoChessGameModel.instance:getNearestTileXY(var_22_2.x, var_22_2.y)

	if var_22_4 then
		if arg_22_0.viewType == AutoChessEnum.ViewType.Enemy then
			var_22_4 = var_22_4 + 5
		end

		local var_22_5 = arg_22_0.viewType == AutoChessEnum.ViewType.All and arg_22_0.chessMo.lastSvrFight or arg_22_0.chessMo.svrFight
		local var_22_6 = arg_22_0.chessMo:getChessPosition(var_22_3, var_22_4, var_22_5)
		local var_22_7 = var_22_6.chess.uid

		if tonumber(var_22_7) ~= 0 then
			local var_22_8 = AutoChessEntityMgr.instance:getEntity(var_22_7)

			if var_22_0 then
				local var_22_9 = AutoChessGameModel.instance.targetTypes

				if tabletool.indexOf(var_22_9, var_22_8.config.type) then
					local var_22_10 = arg_22_0.chessMo.svrFight.mySideMaster

					AutoChessRpc.instance:sendAutoChessUseMasterSkillRequest(arg_22_0.moduleId, var_22_10.skill.id, tonumber(var_22_7))
				end
			elseif var_22_8.config.type == AutoChessStrEnum.ChessType.Incubate and var_22_6.chess.cd == 0 then
				AutoChessRpc.instance:sendAutoChessUseSkillRequest(arg_22_0.moduleId, var_22_7)
			else
				local var_22_11 = {
					chessEntity = var_22_8
				}

				AutoChessController.instance:openCardInfoView(var_22_11)
			end
		end

		AutoChessGameModel.instance:setUsingLeaderSkill(false)
	else
		local var_22_12 = AutoChessGameModel.instance:getNearestLeader(var_22_2)

		if var_22_12 then
			if lua_auto_chess_master.configDict[var_22_12.id].skillId ~= 0 then
				ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
					leader = var_22_12
				})
			end
		elseif var_22_0 then
			AutoChessGameModel.instance:setUsingLeaderSkill(false)
		end
	end
end

function var_0_0._beginDrag(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.isDraging = true

	local var_23_0 = recthelper.screenPosToAnchorPos(arg_23_2.position, arg_23_0._tfTouch)
	local var_23_1, var_23_2 = AutoChessGameModel.instance:getNearestTileXY(var_23_0.x, var_23_0.y)

	if var_23_1 then
		local var_23_3 = arg_23_0.chessMo:getChessPosition(var_23_1, var_23_2)
		local var_23_4 = var_23_3.chess.uid

		if tonumber(var_23_4) ~= 0 then
			local var_23_5 = var_23_3.chess.id
			local var_23_6 = AutoChessEntityMgr.instance:getEntity(var_23_4)

			if var_23_6.teamType == AutoChessEnum.TeamType.Player then
				arg_23_0.chessAvatar = AutoChessGameModel.instance.avatar

				if arg_23_0.chessAvatar then
					arg_23_0.selectChess = var_23_6

					arg_23_0.selectChess:hide()

					local var_23_7 = transformhelper.getLocalScale(var_23_6.dirTrs)
					local var_23_8 = var_23_6.meshComp
					local var_23_9 = gohelper.findChildUIMesh(arg_23_0.chessAvatar)

					var_23_9.material = var_23_8.uiMesh.material
					var_23_9.mesh = var_23_8.uiMesh.mesh

					var_23_9:SetVerticesDirty()
					var_23_9:SetMaterialDirty()
					recthelper.setAnchor(arg_23_0.chessAvatar.transform, var_23_0.x, var_23_0.y)
					transformhelper.setLocalScale(arg_23_0.chessAvatar.transform, var_23_7, 1, 1)

					local var_23_10 = gohelper.findChildImage(arg_23_0.chessAvatar, "role")

					var_23_10.sprite = var_23_8.imageRole.sprite

					var_23_10:SetNativeSize()
					gohelper.setActive(arg_23_0.chessAvatar, true)

					local var_23_11 = AutoChessConfig.instance:getChessCfgById(var_23_5, var_23_3.chess.star)

					AutoChessController.instance:dispatchEvent(AutoChessEvent.DragChessEntity, var_23_11)
					arg_23_0:activeGlow(var_23_11)
				end
			end
		end
	end
end

function var_0_0._onDrag(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.selectChess then
		local var_24_0 = arg_24_2.position
		local var_24_1 = recthelper.screenPosToAnchorPos(var_24_0, arg_24_0._tfTouch)

		arg_24_0:_moveToPos(arg_24_0.chessAvatar.transform, var_24_1)
	end
end

function var_0_0._endDrag(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.isDraging = false

	if arg_25_0.selectChess then
		local var_25_0 = arg_25_0.selectChess.data.uid
		local var_25_1 = arg_25_0.selectChess.warZone
		local var_25_2 = arg_25_0.selectChess.index
		local var_25_3 = arg_25_2.position
		local var_25_4 = recthelper.screenPosToAnchorPos(var_25_3, arg_25_0._tfTouch)
		local var_25_5, var_25_6 = AutoChessGameModel.instance:getNearestTileXY(var_25_4.x, var_25_4.y)

		if var_25_6 and var_25_6 < 6 then
			if var_25_1 == AutoChessEnum.WarZone.Four or var_25_5 == AutoChessEnum.WarZone.Four then
				if var_25_1 == AutoChessEnum.WarZone.Four and var_25_5 == AutoChessEnum.WarZone.Four then
					if var_25_2 + 1 == var_25_6 then
						arg_25_0.selectChess:show()
					else
						local var_25_7 = arg_25_0.chessMo:getChessPosition(var_25_5, var_25_6)

						if AutoChessEntityMgr.instance:tryGetEntity(var_25_7.chess.uid) then
							arg_25_0.selectChess:show()
						else
							AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
							AutoChessRpc.instance:sendAutoChessBuildRequest(arg_25_0.moduleId, AutoChessEnum.BuildType.Exchange, var_25_1, var_25_2, var_25_0, var_25_5, var_25_6 - 1)
						end
					end
				else
					GameFacade.showToast(ToastEnum.AutoChessExchangeError)
					arg_25_0.selectChess:show()
				end
			elseif var_25_5 == var_25_1 and var_25_6 == var_25_2 + 1 then
				arg_25_0.selectChess:show()
			else
				local var_25_8 = arg_25_0.chessMo:getChessPosition(var_25_5, var_25_6)
				local var_25_9 = AutoChessEntityMgr.instance:tryGetEntity(var_25_8.chess.uid)

				if var_25_9 then
					if AutoChessHelper.sameWarZoneType(var_25_1, var_25_5) or AutoChessHelper.canMix(var_25_8.chess, arg_25_0.selectChess.data) then
						if var_25_9.data.id == arg_25_0.selectChess.data.id then
							AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
						else
							AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
						end

						AutoChessRpc.instance:sendAutoChessBuildRequest(arg_25_0.moduleId, AutoChessEnum.BuildType.Exchange, var_25_1, var_25_2, var_25_0, var_25_5, var_25_6 - 1, var_25_9.data.uid)
					else
						GameFacade.showToast(ToastEnum.AutoChessExchangeError)
						arg_25_0.selectChess:show()
					end
				elseif AutoChessHelper.sameWarZoneType(var_25_1, var_25_5) then
					AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
					AutoChessRpc.instance:sendAutoChessBuildRequest(arg_25_0.moduleId, AutoChessEnum.BuildType.Exchange, var_25_1, var_25_2, var_25_0, var_25_5, var_25_6 - 1)
				else
					GameFacade.showToast(ToastEnum.AutoChessExchangeError)
					arg_25_0.selectChess:show()
				end
			end
		else
			local var_25_10 = arg_25_2.pointerEnter

			if var_25_10 and var_25_10.name == "#go_CheckSell" then
				AutoChessRpc.instance:sendAutoChessBuildRequest(arg_25_0.moduleId, AutoChessEnum.BuildType.Sell, var_25_1, var_25_2, var_25_0)
			else
				arg_25_0.selectChess:show()
			end
		end

		gohelper.setActive(arg_25_0.chessAvatar, false)

		arg_25_0.chessAvatar = nil
		arg_25_0.selectChess = nil

		AutoChessController.instance:dispatchEvent(AutoChessEvent.DragChessEntityEnd)
		arg_25_0:inactiveGlow()
	end
end

function var_0_0._checkDrag(arg_26_0)
	if arg_26_0.fightFlow then
		return true
	end
end

function var_0_0._moveToPos(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0, var_27_1 = transformhelper.getPos(arg_27_1)

	if math.abs(var_27_0 - arg_27_2.x) > 50 or math.abs(var_27_1 - arg_27_2.y) > 50 then
		if arg_27_0.tweenId then
			ZProj.TweenHelper.KillById(arg_27_0.tweenId)

			arg_27_0.tweenId = nil
		end

		arg_27_0.tweenId = ZProj.TweenHelper.DOAnchorPos(arg_27_1, arg_27_2.x, arg_27_2.y, 0.2)
	else
		recthelper.setAnchor(arg_27_1, arg_27_2.x, arg_27_2.y)
	end
end

function var_0_0.startImmediatelyFlow(arg_28_0, arg_28_1)
	arg_28_0.immediatelyFlow = FlowSequence.New()

	local var_28_0 = AutoChessSideWork.New(arg_28_1)

	arg_28_0.immediatelyFlow:addWork(var_28_0)
	arg_28_0.immediatelyFlow:registerDoneListener(arg_28_0.immediatelyFlowDone, arg_28_0)
	AutoChessHelper.lockScreen("AutoChessGameScene", true)
	arg_28_0.immediatelyFlow:start(AutoChessEnum.ContextType.Immediately)
end

function var_0_0.immediatelyFlowDone(arg_29_0)
	if arg_29_0.immediatelyFlow then
		arg_29_0.immediatelyFlow:unregisterDoneListener(arg_29_0.immediatelyFlowDone, arg_29_0)
		arg_29_0.immediatelyFlow:destroy()

		arg_29_0.immediatelyFlow = nil
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.ImmediatelyFlowFinish)
	AutoChessHelper.lockScreen("AutoChessGameScene", false)
end

function var_0_0.startFightFlow(arg_30_0)
	AutoChessHelper.lockScreen("AutoChessGameScene", false)

	local var_30_0 = arg_30_0.chessMo.fightEffectList

	if var_30_0 then
		arg_30_0.fightFlow = FlowSequence.New()

		local var_30_1 = AutoChessSideWork.New(var_30_0)

		arg_30_0.fightFlow:addWork(var_30_1)
		arg_30_0.fightFlow:registerDoneListener(arg_30_0.fightFlowDone, arg_30_0)
		arg_30_0.fightFlow:start(AutoChessEnum.ContextType.Fight)

		arg_30_0.chessMo.fightEffectList = nil
	else
		AutoChessController.instance:dispatchEvent(AutoChessEvent.EndFight)
	end
end

function var_0_0.fightFlowDone(arg_31_0)
	if arg_31_0.fightFlow then
		arg_31_0.fightFlow:unregisterDoneListener(arg_31_0.fightFlowDone, arg_31_0)
		arg_31_0.fightFlow:destroy()

		arg_31_0.fightFlow = nil
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.EndFight)
end

function var_0_0.checkBeforeBuy(arg_32_0)
	local var_32_0 = arg_32_0.chessMo.startBuyEffectList

	if var_32_0 then
		arg_32_0.beforeBuyFlow = FlowSequence.New()

		local var_32_1 = AutoChessSideWork.New(var_32_0)

		arg_32_0.beforeBuyFlow:addWork(var_32_1)
		arg_32_0.beforeBuyFlow:registerDoneListener(arg_32_0.beforeBuyFlowDone, arg_32_0)
		AutoChessHelper.lockScreen("AutoChessGameScene", true)
		arg_32_0.beforeBuyFlow:start(AutoChessEnum.ContextType.StartBuy)

		arg_32_0.chessMo.startBuyEffectList = nil
	else
		AutoChessController.instance:dispatchEvent(AutoChessEvent.StartBuyStepFinih)
	end
end

function var_0_0.beforeBuyFlowDone(arg_33_0)
	arg_33_0.beforeBuyFlow:unregisterDoneListener(arg_33_0.beforeBuyFlowDone, arg_33_0)
	arg_33_0.beforeBuyFlow:destroy()

	arg_33_0.beforeBuyFlow = nil

	AutoChessHelper.lockScreen("AutoChessGameScene", false)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StartBuyStepFinih)
end

function var_0_0.checkAfterBuy(arg_34_0)
	AutoChessHelper.lockScreen("AutoChessGameScene", true)

	local var_34_0 = arg_34_0.chessMo.endBuyEffectList

	if var_34_0 then
		arg_34_0.afterBuyFlow = FlowSequence.New()

		local var_34_1 = AutoChessSideWork.New(var_34_0)

		arg_34_0.afterBuyFlow:addWork(var_34_1)
		arg_34_0.afterBuyFlow:registerDoneListener(arg_34_0.afterBuyFlowDone, arg_34_0)
		arg_34_0.afterBuyFlow:start(AutoChessEnum.ContextType.EndBuy)

		arg_34_0.chessMo.endBuyEffectList = nil
	else
		arg_34_0:afterBuyFlowDone()
	end
end

function var_0_0.afterBuyFlowDone(arg_35_0)
	if arg_35_0.afterBuyFlow then
		arg_35_0.afterBuyFlow:unregisterDoneListener(arg_35_0.beforeBuyFlowDone, arg_35_0)
		arg_35_0.afterBuyFlow:destroy()

		arg_35_0.afterBuyFlow = nil
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.StartFight)
	TaskDispatcher.runDelay(arg_35_0.delayEnterFightScene, arg_35_0, 0.5)
	AutoChessHelper.lockScreen("AutoChessGameScene", false)
end

function var_0_0.delayEnterFightScene(arg_36_0)
	arg_36_0:changeScene(AutoChessEnum.ViewType.All, true)
end

return var_0_0
