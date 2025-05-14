module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateStrongHoldItem", package.seeall)

local var_0_0 = class("EliminateStrongHoldItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._imageslotBGColor = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#image_slotBGColor")
	arg_1_0._simageslotBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/#simage_slotBG")
	arg_1_0._imageInfoTextBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#image_InfoTextBG")
	arg_1_0._txtInfo = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#image_InfoTextBG/#scroll_ver/viewport/#txt_Info")
	arg_1_0._goEnemyPower = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_EnemyPower")
	arg_1_0._imageEnemyPower = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_EnemyPower/#image_EnemyPower")
	arg_1_0._imageEnemyPower2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_EnemyPower/#image_EnemyPower2")
	arg_1_0._txtEnemyPower = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_EnemyPower/#txt_Enemy_Power")
	arg_1_0._txtEnemyPower1 = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_EnemyPower/#txt_Enemy_Power1")
	arg_1_0._goPlayerPower = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_PlayerPower")
	arg_1_0._imagePlayerPower = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_PlayerPower/#image_PlayerPower")
	arg_1_0._imagePlayerPower2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_PlayerPower/#image_PlayerPower2")
	arg_1_0._txtPlayerPower = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_PlayerPower/#txt_Player_Power")
	arg_1_0._txtPlayerPower1 = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_PlayerPower/#txt_Player_Power1")
	arg_1_0._goEnemy = gohelper.findChild(arg_1_0.viewGO, "#go_Enemy")
	arg_1_0._goEnemyWin = gohelper.findChild(arg_1_0.viewGO, "#go_EnemyWin")
	arg_1_0._goPlayer = gohelper.findChild(arg_1_0.viewGO, "#go_Player")
	arg_1_0._goPlayerWin = gohelper.findChild(arg_1_0.viewGO, "#go_PlayerWin")
	arg_1_0._goLine4 = gohelper.findChild(arg_1_0.viewGO, "#go_Line4")
	arg_1_0._goLine6 = gohelper.findChild(arg_1_0.viewGO, "#go_Line6")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = typeof(UnityEngine.Animator)
local var_0_2 = GameUtil.parseColor("#e5d3c3")
local var_0_3 = GameUtil.parseColor("#7ECC66")
local var_0_4 = GameUtil.parseColor("#FF7A66")
local var_0_5 = ZProj.TweenHelper
local var_0_6 = Color.New(1, 1, 1, 1)

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goEnemyWin, false)
	gohelper.setActive(arg_4_0._goPlayerWin, false)

	arg_4_0.enemyWinAni = arg_4_0._goEnemyWin:GetComponent(var_0_1)
	arg_4_0.playerWinAni = arg_4_0._goPlayerWin:GetComponent(var_0_1)
	arg_4_0._goEnemyPowerAni = arg_4_0._goEnemyPower:GetComponent(var_0_1)
	arg_4_0._goPlayerPowerAni = arg_4_0._goPlayerPower:GetComponent(var_0_1)
	arg_4_0._txtEnemyPower.text = 0
	arg_4_0._txtPlayerPower.text = 0

	arg_4_0:playAni(EliminateTeamChessEnum.TeamChessTeamType.enemy, "idle")
	arg_4_0:playAni(EliminateTeamChessEnum.TeamChessTeamType.player, "idle")
end

function var_0_0.initData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._data = arg_5_1
	arg_5_0._strongholdIndex = arg_5_2
	arg_5_0._maxLen = arg_5_3

	arg_5_0:initInfo()
	arg_5_0:updateInfo()
end

function var_0_0.onStart(arg_6_0)
	return
end

function var_0_0.initInfo(arg_7_0)
	if arg_7_0._data then
		local var_7_0 = arg_7_0._data:getStrongholdConfig()
		local var_7_1 = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()

		if var_7_0 then
			local var_7_2 = var_7_0.ruleId
			local var_7_3 = EliminateConfig.instance:getStrongHoldRuleRuleConfig(var_7_2)
			local var_7_4 = var_7_3 and EliminateLevelModel.instance.formatString(var_7_3.desc) or ""

			arg_7_0:updateInfoText(var_7_4)

			local var_7_5 = arg_7_0._maxLen > 1 and arg_7_0._strongholdIndex ~= arg_7_0._maxLen
			local var_7_6 = math.max(var_7_0.friendCapacity, var_7_0.enemyCapacity)

			gohelper.setActive(arg_7_0._goLine4, var_7_5 and var_7_6 == 4)
			gohelper.setActive(arg_7_0._goLine6, var_7_5 and var_7_6 == 6)

			local var_7_7 = EliminateLevelEnum.scenePathToStrongLandImageName[var_7_1.chessScene]

			if not string.nilorempty(var_7_7) then
				UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_7_0._imageslotBGColor, var_7_7, false)
			else
				gohelper.setActive(arg_7_0._imageslotBGColor.gameObject, false)
			end

			local var_7_8 = var_7_0.strongholdBg

			if not string.nilorempty(var_7_8) then
				arg_7_0._simageslotBG:LoadImage(var_7_8, nil, nil)
			end
		end
	end
end

function var_0_0.initStrongHoldChess(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0:_initPlayerStrongHoldChess(arg_8_1, arg_8_3, arg_8_4)
	arg_8_0:_initEnemyStrongHoldChess(arg_8_2, arg_8_3, arg_8_4)
end

function var_0_0._initPlayerStrongHoldChess(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0._playerChessList = arg_9_0:getUserDataTb_()
	arg_9_0._playerPowerList = arg_9_0:getUserDataTb_()
	arg_9_0._playerGrowUpList = arg_9_0:getUserDataTb_()
	arg_9_0._playerChessGO = arg_9_1
	arg_9_0._playerChessTr = arg_9_0._playerChessGO.transform
	arg_9_0._playerSelectGo = gohelper.findChild(arg_9_0._playerChessGO, "#go_Selected")

	transformhelper.setLocalPos(arg_9_0._playerChessTr, 0, 0, 0)

	if arg_9_0._data then
		local var_9_0 = arg_9_0._data:getStrongholdConfig()
		local var_9_1 = gohelper.findChild(arg_9_0._playerChessGO, "#go_slots")

		arg_9_0._playerChessGoAni = var_9_1:GetComponent(var_0_1)

		local var_9_2 = var_9_1.transform.childCount
		local var_9_3 = var_9_0.friendCapacity

		for iter_9_0 = 1, var_9_2 do
			local var_9_4 = gohelper.findChild(arg_9_0._playerChessGO, "#go_slots/slot_" .. iter_9_0)

			if var_9_3 < iter_9_0 then
				gohelper.setActive(var_9_4, false)
			else
				local var_9_5 = gohelper.findChildImage(arg_9_0._playerChessGO, "#go_slots/slot_" .. iter_9_0)

				arg_9_0._playerChessList[iter_9_0] = {
					item = var_9_4,
					imgItem = var_9_5
				}

				local var_9_6 = gohelper.clone(arg_9_2, var_9_4, "slot_power_" .. iter_9_0)

				recthelper.setAnchorX(var_9_6.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosX)
				recthelper.setAnchorY(var_9_6.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosY)
				gohelper.setActive(var_9_6, false)

				local var_9_7 = gohelper.findChildImage(var_9_6, "#image_chessPower")
				local var_9_8 = gohelper.findChildText(var_9_6, "#image_chessPower/#txt_chessPower")
				local var_9_9 = var_9_6:GetComponent(var_0_1)

				arg_9_0._playerPowerList[iter_9_0] = {
					item = var_9_6,
					powerImage = var_9_7,
					powerText = var_9_8,
					ani = var_9_9
				}

				local var_9_10 = gohelper.clone(arg_9_3, var_9_4, "slot_growUp_" .. iter_9_0)

				var_9_10.transform:SetParent(var_9_1.transform)

				local var_9_11, var_9_12, var_9_13 = transformhelper.getLocalPos(var_9_4.transform)

				transformhelper.setLocalPos(var_9_10.transform, var_9_11, var_9_12 + EliminateTeamChessEnum.powerOffsetY, var_9_13)
				gohelper.setActive(var_9_10, false)

				local var_9_14 = gohelper.findChildImage(var_9_10, "image_FG")
				local var_9_15 = gohelper.findChildImage(var_9_10, "image_FG/image_FG_eff")

				table.insert(arg_9_0._playerGrowUpList, {
					item = var_9_10,
					progressImage = var_9_14,
					progressImageEff = var_9_15
				})
			end
		end

		local var_9_16 = recthelper.getWidth(arg_9_0._playerChessTr)

		recthelper.setWidth(arg_9_0.viewGO.transform, var_9_16)
	end
end

function var_0_0._initEnemyStrongHoldChess(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._enemyChessList = arg_10_0:getUserDataTb_()
	arg_10_0._enemyPowerList = arg_10_0:getUserDataTb_()
	arg_10_0._enemyGrowUpList = arg_10_0:getUserDataTb_()
	arg_10_0._enemyChessGO = arg_10_1
	arg_10_0._enemyChessTr = arg_10_0._enemyChessGO.transform

	transformhelper.setLocalPos(arg_10_0._enemyChessTr, 0, 0, 0)

	if arg_10_0._data then
		local var_10_0 = arg_10_0._data:getStrongholdConfig()
		local var_10_1 = gohelper.findChild(arg_10_0._enemyChessGO, "#go_slots")

		arg_10_0._enemyChessGoAni = var_10_1:GetComponent(var_0_1)

		local var_10_2 = var_10_1.transform.childCount
		local var_10_3 = var_10_0.enemyCapacity

		for iter_10_0 = var_10_2, 1, -1 do
			local var_10_4 = gohelper.findChild(arg_10_0._enemyChessGO, "#go_slots/slot_" .. iter_10_0)

			if var_10_3 < iter_10_0 then
				gohelper.setActive(var_10_4, false)
			else
				local var_10_5 = gohelper.findChildImage(arg_10_0._enemyChessGO, "#go_slots/slot_" .. iter_10_0)

				table.insert(arg_10_0._enemyChessList, {
					item = var_10_4,
					imgItem = var_10_5
				})

				local var_10_6 = gohelper.clone(arg_10_2, var_10_4, "slot_power_" .. iter_10_0)

				recthelper.setAnchorX(var_10_6.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosX)
				recthelper.setAnchorY(var_10_6.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosY)
				var_10_6.transform:SetParent(var_10_1.transform)
				gohelper.setActive(var_10_6, false)

				local var_10_7 = gohelper.findChildImage(var_10_6, "#image_chessPower")
				local var_10_8 = gohelper.findChildText(var_10_6, "#image_chessPower/#txt_chessPower")

				table.insert(arg_10_0._enemyPowerList, {
					item = var_10_6,
					powerImage = var_10_7,
					powerText = var_10_8
				})

				local var_10_9 = gohelper.clone(arg_10_3, var_10_4, "slot_growUp_" .. iter_10_0)

				var_10_9.transform:SetParent(var_10_1.transform)

				local var_10_10, var_10_11, var_10_12 = transformhelper.getLocalPos(var_10_4.transform)

				transformhelper.setLocalPos(var_10_9.transform, var_10_10, var_10_11 + EliminateTeamChessEnum.powerOffsetY, var_10_12)
				gohelper.setActive(var_10_9, false)

				local var_10_13 = gohelper.findChildImage(var_10_9, "image_FG")
				local var_10_14 = gohelper.findChildImage(var_10_9, "image_FG/image_FG_eff")

				table.insert(arg_10_0._enemyGrowUpList, {
					item = var_10_9,
					progressImage = var_10_13,
					progressImageEff = var_10_14
				})
			end
		end
	end
end

function var_0_0.addStrongholdChess(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0._data.id ~= arg_11_2 then
		return
	end

	local var_11_0
	local var_11_1

	if arg_11_1.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		var_11_0 = arg_11_0._playerChessList[arg_11_3]
		var_11_1 = arg_11_0._playerPowerList[arg_11_3]
	end

	if arg_11_1.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		var_11_0 = arg_11_0._enemyChessList[arg_11_3]
		var_11_1 = arg_11_0._enemyPowerList[arg_11_3]
	end

	arg_11_0:refreshItemInfo(arg_11_3, arg_11_1, var_11_0, var_11_1, nil)
end

function var_0_0.removeStrongholdChess(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0._data.id ~= arg_12_1 then
		return
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.RemoveStronghold3DChess, arg_12_2)
	arg_12_0:hideIndexInfo(arg_12_3, arg_12_4)

	if arg_12_2 == EliminateTeamChessEnum.tempPieceUid then
		arg_12_0:refreshSlotItemView()
	else
		TaskDispatcher.runDelay(arg_12_0.refreshSlotItemView, arg_12_0, EliminateTeamChessEnum.teamChessPlaceStep)
	end
end

function var_0_0.hideIndexInfo(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0
	local var_13_1
	local var_13_2

	if arg_13_2 == EliminateTeamChessEnum.TeamChessTeamType.player then
		var_13_0 = arg_13_0._playerChessList[arg_13_1]
		var_13_1 = arg_13_0._playerPowerList[arg_13_1]
		var_13_2 = arg_13_0._playerGrowUpList[arg_13_1]
	end

	if arg_13_2 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		var_13_0 = arg_13_0._enemyChessList[arg_13_1]
		var_13_1 = arg_13_0._enemyPowerList[arg_13_1]
		var_13_2 = arg_13_0._enemyGrowUpList[arg_13_1]
	end

	if var_13_0 ~= nil then
		var_0_6.a = 0
		var_13_0.imgItem.color = var_0_6
	end

	if var_13_1 ~= nil then
		gohelper.setActive(var_13_1.item, false)
	end

	if var_13_2 ~= nil then
		gohelper.setActive(var_13_2.item, false)
	end
end

function var_0_0.enemyGoPlayAni(arg_14_0, arg_14_1)
	if arg_14_0._enemyChessGoAni then
		arg_14_0._enemyChessGoAni:Play(arg_14_1, 0, 0)
	end
end

function var_0_0.playerGoPlayAni(arg_15_0, arg_15_1)
	if arg_15_0._playerChessGoAni then
		arg_15_0._playerChessGoAni:Play(arg_15_1, 0, 0)
	end
end

function var_0_0.strongHoldSettle(arg_16_0, arg_16_1)
	if arg_16_0._data.id ~= arg_16_1 then
		return
	end

	arg_16_0:enemyGoPlayAni("close")
	arg_16_0:playerGoPlayAni("close")
	arg_16_0:setInfoActive(false)
	arg_16_0:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.enemy, false)
	arg_16_0:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.player, false)

	local var_16_0 = recthelper.getWidth(arg_16_0._imageslotBGColor.gameObject.transform) - 70
	local var_16_1 = recthelper.getHeight(arg_16_0._imageslotBGColor.gameObject.transform) - 60

	TeamChessUnitEntityMgr.instance:moveEntityByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.player, arg_16_1, arg_16_0._goinfo.transform, var_16_0, var_16_1)
	TeamChessUnitEntityMgr.instance:moveEntityByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.enemy, arg_16_1, arg_16_0._goinfo.transform, var_16_0, var_16_1)

	local var_16_2 = arg_16_0._data:getPlayerSoliderCount()
	local var_16_3 = arg_16_0._data:getEnemySoliderCount()

	if var_16_2 > 0 or var_16_3 > 0 then
		TaskDispatcher.runDelay(arg_16_0.showResultFight, arg_16_0, EliminateTeamChessEnum.entityMoveTime)
	else
		arg_16_0:strongHoldSettleShowResult()
	end
end

function var_0_0.showResultFight(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.showResultFight, arg_17_0)

	local var_17_0, var_17_1, var_17_2 = transformhelper.getPos(arg_17_0._goinfo.transform)

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessEffect, EliminateTeamChessEnum.VxEffectType.StrongHoldBattle, var_17_0, var_17_1, var_17_2)
	TaskDispatcher.runDelay(arg_17_0.strongHoldSettleShowResult, arg_17_0, EliminateTeamChessEnum.StrongHoldBattleVxTime)
end

function var_0_0.strongHoldSettleShowResult(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.strongHoldSettleShowResult, arg_18_0)

	local var_18_0 = arg_18_0._data.status
	local var_18_1 = var_18_0 == EliminateTeamChessEnum.StrongHoldState.enemySide
	local var_18_2 = var_18_0 == EliminateTeamChessEnum.StrongHoldState.mySide

	gohelper.setActive(arg_18_0._goEnemyWin, var_18_1)
	gohelper.setActive(arg_18_0._goPlayerWin, var_18_2)

	if var_18_1 or var_18_2 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_checkpoint_extrafall_eliminate)
	end

	if var_18_1 then
		TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.player, arg_18_0._data.id)
		arg_18_0:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.player, true)

		if arg_18_0.enemyWinAni then
			arg_18_0.enemyWinAni:Play("open", 0, 0)
		end
	end

	if var_18_2 then
		TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.enemy, arg_18_0._data.id)
		arg_18_0:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.enemy, true)

		if arg_18_0.playerWinAni then
			arg_18_0.playerWinAni:Play("open", 0, 0)
		end
	end
end

function var_0_0.strongHoldSettleResetShow(arg_19_0)
	logNormal("EliminateStrongHoldItem:strongHoldSettleResetShow")
	gohelper.setActive(arg_19_0._goEnemyWin, false)
	gohelper.setActive(arg_19_0._goPlayerWin, false)
	arg_19_0:enemyGoPlayAni("open")
	arg_19_0:playerGoPlayAni("open")
	arg_19_0:setInfoActive(true)
	arg_19_0:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.enemy, true)
	arg_19_0:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.player, true)
	TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.enemy, arg_19_0._data.id)
	TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.player, arg_19_0._data.id)
	arg_19_0:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.enemy, false)
	arg_19_0:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.player, false)
end

function var_0_0.setChessGray(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		local var_20_0 = arg_20_0._data.mySidePiece

		if var_20_0 then
			for iter_20_0 = 1, #var_20_0 do
				local var_20_1 = var_20_0[iter_20_0]

				if var_20_1 then
					TeamChessUnitEntityMgr.instance:setGrayActive(var_20_1.uid, arg_20_2)
				end
			end
		end
	end

	if arg_20_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		local var_20_2 = arg_20_0._data.enemySidePiece

		if var_20_2 then
			for iter_20_1 = 1, #var_20_2 do
				local var_20_3 = var_20_2[iter_20_1]

				if var_20_3 then
					TeamChessUnitEntityMgr.instance:setGrayActive(var_20_3.uid, arg_20_2)
				end
			end
		end
	end
end

function var_0_0.teamChessUpdateActiveMoveState(arg_21_0, arg_21_1)
	if arg_21_1 == nil then
		return
	end

	local var_21_0 = TeamChessUnitEntityMgr.instance:getEntity(arg_21_1)
	local var_21_1 = arg_21_0._data:getChess(arg_21_1)

	if var_21_0 and var_21_1 then
		local var_21_2 = var_21_1:canActiveMove() and EliminateTeamChessEnum.ModeType.Outline or EliminateTeamChessEnum.ModeType.Normal

		var_21_0:setShowModeType(var_21_2)
	end
end

function var_0_0.setStrongHoldSelect(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._playerSelectGo then
		local var_22_0 = arg_22_2 and arg_22_0._data.id == arg_22_2 or false

		gohelper.setActiveCanvasGroup(arg_22_0._playerSelectGo, var_22_0)
	end
end

function var_0_0.refreshViewByRoundState(arg_23_0, arg_23_1)
	if arg_23_0._enemyChessList == nil then
		return
	end

	for iter_23_0 = 1, #arg_23_0._enemyChessList do
		local var_23_0 = arg_23_0._enemyChessList[iter_23_0]

		if var_23_0 then
			gohelper.setActive(var_23_0.item, arg_23_1 == EliminateTeamChessEnum.TeamChessRoundType.enemy)
		end
	end
end

function var_0_0.setInfoActive(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._imageInfoTextBG.gameObject, arg_24_1)
end

function var_0_0.refreshSlotItemView(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.refreshSlotItemView, arg_25_0)

	if arg_25_0._data then
		local var_25_0 = arg_25_0._data:getStrongholdConfig()

		for iter_25_0 = 1, var_25_0.friendCapacity do
			local var_25_1 = arg_25_0._playerChessList[iter_25_0]
			local var_25_2 = arg_25_0._playerPowerList[iter_25_0]
			local var_25_3 = arg_25_0._playerGrowUpList[iter_25_0]

			arg_25_0:refreshItemInfo(iter_25_0, arg_25_0._data.mySidePiece[iter_25_0], var_25_1, var_25_2, var_25_3)
		end

		for iter_25_1 = 1, var_25_0.enemyCapacity do
			local var_25_4 = arg_25_0._enemyChessList[iter_25_1]
			local var_25_5 = arg_25_0._enemyPowerList[iter_25_1]
			local var_25_6 = arg_25_0._enemyGrowUpList[iter_25_1]

			arg_25_0:refreshItemInfo(iter_25_1, arg_25_0._data.enemySidePiece[iter_25_1], var_25_4, var_25_5, var_25_6)
		end
	end
end

function var_0_0.refreshItemInfo(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	if arg_26_3 == nil or arg_26_3.item == nil or arg_26_4 == nil or arg_26_4.item == nil then
		return
	end

	gohelper.setActive(arg_26_4.item, arg_26_2 ~= nil)

	if arg_26_5 ~= nil then
		local var_26_0 = false

		if arg_26_2 and arg_26_2.skill then
			for iter_26_0 = 1, #arg_26_2.skill do
				local var_26_1 = arg_26_2.skill[iter_26_0]

				if var_26_1 and var_26_1:needShowGrowUp() then
					var_26_0 = true

					break
				end
			end
		end

		gohelper.setActive(arg_26_5.item, var_26_0)
	end

	if arg_26_2 ~= nil then
		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.RefreshStronghold3DChess, arg_26_2, arg_26_0._data.id, arg_26_1, arg_26_3.item.transform)

		if arg_26_4 and arg_26_4.powerText then
			arg_26_0:updatePowerNumber(arg_26_4.powerText, arg_26_2.battle, arg_26_2.id)
		end

		local var_26_2 = arg_26_2:getActiveSkill()

		if var_26_2 ~= nil then
			arg_26_0:teamChessGrowUpValueChange(arg_26_2.uid, var_26_2.id, nil)
		end
	end

	if arg_26_2 == nil then
		var_0_6.a = 1
	else
		var_0_6.a = 0
	end

	arg_26_3.imgItem.color = var_0_6
end

function var_0_0.updatePowerNumber(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = EliminateConfig.instance:getSoldierChessConfig(arg_27_3)
	local var_27_1 = var_0_2

	if arg_27_2 > var_27_0.defaultPower then
		var_27_1 = var_0_3
	end

	if arg_27_2 < var_27_0.defaultPower then
		var_27_1 = var_0_4
	end

	arg_27_1.text = arg_27_2
	arg_27_1.color = var_27_1
end

function var_0_0.checkInPlayerChessRect(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0._playerChessTr == nil then
		return false
	end

	return recthelper.screenPosInRect(arg_28_0._playerChessTr, CameraMgr.instance:getMainCamera(), arg_28_1, arg_28_2)
end

function var_0_0.updateInfo(arg_29_0)
	if arg_29_0._data then
		arg_29_0:refreshStateByScore(arg_29_0._data.myScore, arg_29_0._data.enemyScore, false)
	end
end

function var_0_0.strongHoldPowerChange(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_0._data == nil or arg_30_0._data.id ~= arg_30_1 then
		return
	end

	arg_30_0:refreshStateByScore(arg_30_0._data.myScore, arg_30_0._data.enemyScore, true)
end

function var_0_0.playAni(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 == EliminateTeamChessEnum.TeamChessTeamType.player and arg_31_0._goPlayerPowerAni then
		arg_31_0._goPlayerPowerAni:Play(arg_31_2, 0, 0)
	end

	if arg_31_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy and arg_31_0._goEnemyPowerAni then
		arg_31_0._goEnemyPowerAni:Play(arg_31_2, 0, 0)
	end
end

function var_0_0.teamChessPowerChange(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0._data:getMySideIndexByUid(arg_32_1)

	if var_32_0 ~= -1 and arg_32_0._playerPowerList then
		local var_32_1 = arg_32_0._playerPowerList[var_32_0]

		if var_32_1 and var_32_1.powerText then
			local var_32_2 = arg_32_0._data:getMySideByUid(arg_32_1)

			if var_32_2 then
				arg_32_0:updatePowerNumber(var_32_1.powerText, var_32_2.battle, var_32_2.id)

				if arg_32_2 ~= 0 then
					local var_32_3 = arg_32_2 > 0 and "up" or "down"

					if var_32_1.ani then
						var_32_1.ani:Play(var_32_3, 0, 0)
					end
				end
			end

			return
		end
	end

	local var_32_4 = arg_32_0._data:getEnemySideIndexByUid(arg_32_1)

	if var_32_4 ~= -1 and arg_32_0._enemyPowerList then
		local var_32_5 = arg_32_0._enemyPowerList[var_32_4]

		if var_32_5 and var_32_5.powerText then
			local var_32_6 = arg_32_0._data:getEnemySideByUid(arg_32_1)

			if var_32_6 then
				arg_32_0:updatePowerNumber(var_32_5.powerText, var_32_6.battle, var_32_6.id)

				if arg_32_2 ~= 0 then
					local var_32_7 = arg_32_2 > 0 and "up" or "down"

					if var_32_5.ani then
						var_32_5.ani:Play(var_32_7, 0, 0)
					end
				end
			end

			return
		end
	end
end

function var_0_0.teamChessGrowUpValueChange(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_2 == nil then
		return
	end

	local var_33_0 = arg_33_0._data:getMySideIndexByUid(arg_33_1)

	if var_33_0 ~= -1 and arg_33_0._playerGrowUpList then
		local var_33_1 = arg_33_0._playerGrowUpList[var_33_0]

		if var_33_1 and var_33_1.progressImage then
			local var_33_2 = arg_33_0._data:getMySideByUid(arg_33_1)
			local var_33_3 = var_33_2 and var_33_2:getSkill(arg_33_2)
			local var_33_4 = var_33_3 and var_33_3:getGrowUpProgress() or 0
			local var_33_5 = var_33_3 and var_33_3:needShowGrowUp() or false

			if var_33_4 > 0 then
				var_0_5.DOFillAmount(var_33_1.progressImage, var_33_4, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, nil, nil, EaseType.OutQuart)
				var_0_5.DOFillAmount(var_33_1.progressImageEff, var_33_4, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, nil, nil, EaseType.OutQuart)
			else
				var_33_1.progressImage.fillAmount = var_33_4
				var_33_1.progressImageEff.fillAmount = var_33_4
			end

			gohelper.setActive(var_33_1.item, var_33_5)

			return
		end
	end

	local var_33_6 = arg_33_0._data:getEnemySideIndexByUid(arg_33_1)

	if var_33_6 ~= -1 and arg_33_0._enemyGrowUpList then
		local var_33_7 = arg_33_0._enemyGrowUpList[var_33_6]

		if var_33_7 and var_33_7.progressImage then
			local var_33_8 = arg_33_0._data:getEnemySideByUid(arg_33_1)
			local var_33_9 = var_33_8 and var_33_8:getSkill(arg_33_2)
			local var_33_10 = var_33_9 and var_33_9:getGrowUpProgress() or 0
			local var_33_11 = var_33_9 and var_33_9:needShowGrowUp() or false

			if var_33_10 > 0 then
				var_0_5.DOFillAmount(var_33_7.progressImage, var_33_10, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, nil, nil, EaseType.OutQuart)
				var_0_5.DOFillAmount(var_33_7.progressImageEff, var_33_10, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, nil, nil, EaseType.OutQuart)
			else
				var_33_7.progressImage.fillAmount = var_33_10
				var_33_7.progressImageEff.fillAmount = var_33_10
			end

			gohelper.setActive(var_33_7.item, var_33_11)

			return
		end
	end
end

function var_0_0.setPowerTrParent(arg_34_0, arg_34_1)
	if gohelper.isNil(arg_34_1) then
		return
	end

	arg_34_0._enemyPowerParent = gohelper.create2d(arg_34_1.gameObject, "enemyPowerItem")
	arg_34_0._playerPowerParent = gohelper.create2d(arg_34_1.gameObject, "playerPowerItem")

	local var_34_0 = arg_34_0._enemyPowerParent.transform
	local var_34_1 = arg_34_0._playerPowerParent.transform

	for iter_34_0 = 1, #arg_34_0._enemyPowerList do
		local var_34_2 = arg_34_0._enemyPowerList[iter_34_0]

		if var_34_2 then
			var_34_2.item.transform:SetParent(var_34_0)
		end
	end

	for iter_34_1 = 1, #arg_34_0._playerPowerList do
		local var_34_3 = arg_34_0._playerPowerList[iter_34_1]

		if var_34_3 then
			var_34_3.item.transform:SetParent(var_34_1)
		end
	end
end

function var_0_0.setPowerActive(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 == EliminateTeamChessEnum.TeamChessTeamType.player and not gohelper.isNil(arg_35_0._enemyPowerParent) then
		gohelper.setActive(arg_35_0._enemyPowerParent, arg_35_2)
	end

	if arg_35_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy and not gohelper.isNil(arg_35_0._playerPowerParent) then
		gohelper.setActive(arg_35_0._playerPowerParent, arg_35_2)
	end
end

function var_0_0.updateInfoText(arg_36_0, arg_36_1)
	arg_36_0._txtInfo.text = arg_36_1

	gohelper.setActive(arg_36_0._imageInfoTextBG.gameObject, not string.nilorempty(arg_36_1))
end

function var_0_0.refreshStateByScore(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = tonumber(arg_37_0._txtEnemyPower.text)
	local var_37_1 = tonumber(arg_37_0._txtPlayerPower.text)
	local var_37_2 = var_37_0 < var_37_1

	arg_37_0._txtPlayerPower.text = arg_37_1
	arg_37_0._txtPlayerPower1.text = arg_37_1
	arg_37_0._txtEnemyPower.text = arg_37_2
	arg_37_0._txtEnemyPower1.text = arg_37_2
	arg_37_0._txtEnemyPower.color = arg_37_1 < arg_37_2 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	arg_37_0._txtEnemyPower1.color = arg_37_1 < arg_37_2 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	arg_37_0._txtEnemyPower.fontSize = arg_37_1 < arg_37_2 and EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	arg_37_0._txtEnemyPower1.fontSize = arg_37_1 < arg_37_2 and EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	arg_37_0._txtPlayerPower.color = arg_37_2 < arg_37_1 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	arg_37_0._txtPlayerPower1.color = arg_37_2 < arg_37_1 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	arg_37_0._txtPlayerPower.fontSize = arg_37_2 < arg_37_1 and EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	arg_37_0._txtPlayerPower1.fontSize = arg_37_2 < arg_37_1 and EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize

	local var_37_3 = "idle"
	local var_37_4 = "idle"

	if arg_37_1 ~= arg_37_2 then
		if arg_37_1 < arg_37_2 then
			var_37_3 = var_37_1 == var_37_0 and "idle" or var_37_2 and "down" or "down_refresh"
			var_37_4 = var_37_1 == var_37_0 and "up" or "up_refresh"
		else
			var_37_3 = var_37_1 == var_37_0 and "up" or var_37_2 and "up_refresh" or "up"
			var_37_4 = var_37_1 == var_37_0 and "idle" or "down_refresh"
		end
	end

	arg_37_0:playAni(EliminateTeamChessEnum.TeamChessTeamType.player, var_37_3)
	arg_37_0:playAni(EliminateTeamChessEnum.TeamChessTeamType.enemy, var_37_4)
end

function var_0_0.refreshAni(arg_38_0, arg_38_1)
	if arg_38_1 then
		local var_38_0 = arg_38_0._data.myScore
		local var_38_1 = arg_38_0._data.enemyScore
		local var_38_2 = "idle"
		local var_38_3 = "idle"

		if var_38_0 < var_38_1 then
			var_38_3 = "up"
		elseif var_38_1 < var_38_0 then
			var_38_2 = "up"
		end

		arg_38_0:playAni(EliminateTeamChessEnum.TeamChessTeamType.player, var_38_2)
		arg_38_0:playAni(EliminateTeamChessEnum.TeamChessTeamType.enemy, var_38_3)
	end
end

function var_0_0.clear(arg_39_0)
	return
end

function var_0_0.onDestroy(arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.showResultFight, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.strongHoldSettleShowResult, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.refreshSlotItemView, arg_40_0)

	arg_40_0._playerPowerParent = nil
	arg_40_0._enemyPowerParent = nil
	arg_40_0._enemyChessGoAni = nil
	arg_40_0._playerChessGoAni = nil
end

return var_0_0
