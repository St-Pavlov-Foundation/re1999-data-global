module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateStrongHoldItem", package.seeall)

slot0 = class("EliminateStrongHoldItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._imageslotBGColor = gohelper.findChildImage(slot0.viewGO, "#go_info/#image_slotBGColor")
	slot0._simageslotBG = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/#simage_slotBG")
	slot0._imageInfoTextBG = gohelper.findChildImage(slot0.viewGO, "#go_info/#image_InfoTextBG")
	slot0._txtInfo = gohelper.findChildText(slot0.viewGO, "#go_info/#image_InfoTextBG/#scroll_ver/viewport/#txt_Info")
	slot0._goEnemyPower = gohelper.findChild(slot0.viewGO, "#go_info/#go_EnemyPower")
	slot0._imageEnemyPower = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_EnemyPower/#image_EnemyPower")
	slot0._imageEnemyPower2 = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_EnemyPower/#image_EnemyPower2")
	slot0._txtEnemyPower = gohelper.findChildText(slot0.viewGO, "#go_info/#go_EnemyPower/#txt_Enemy_Power")
	slot0._txtEnemyPower1 = gohelper.findChildText(slot0.viewGO, "#go_info/#go_EnemyPower/#txt_Enemy_Power1")
	slot0._goPlayerPower = gohelper.findChild(slot0.viewGO, "#go_info/#go_PlayerPower")
	slot0._imagePlayerPower = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_PlayerPower/#image_PlayerPower")
	slot0._imagePlayerPower2 = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_PlayerPower/#image_PlayerPower2")
	slot0._txtPlayerPower = gohelper.findChildText(slot0.viewGO, "#go_info/#go_PlayerPower/#txt_Player_Power")
	slot0._txtPlayerPower1 = gohelper.findChildText(slot0.viewGO, "#go_info/#go_PlayerPower/#txt_Player_Power1")
	slot0._goEnemy = gohelper.findChild(slot0.viewGO, "#go_Enemy")
	slot0._goEnemyWin = gohelper.findChild(slot0.viewGO, "#go_EnemyWin")
	slot0._goPlayer = gohelper.findChild(slot0.viewGO, "#go_Player")
	slot0._goPlayerWin = gohelper.findChild(slot0.viewGO, "#go_PlayerWin")
	slot0._goLine4 = gohelper.findChild(slot0.viewGO, "#go_Line4")
	slot0._goLine6 = gohelper.findChild(slot0.viewGO, "#go_Line6")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = typeof(UnityEngine.Animator)
slot2 = GameUtil.parseColor("#e5d3c3")
slot3 = GameUtil.parseColor("#7ECC66")
slot4 = GameUtil.parseColor("#FF7A66")
slot5 = ZProj.TweenHelper
slot6 = Color.New(1, 1, 1, 1)

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goEnemyWin, false)
	gohelper.setActive(slot0._goPlayerWin, false)

	slot0.enemyWinAni = slot0._goEnemyWin:GetComponent(uv0)
	slot0.playerWinAni = slot0._goPlayerWin:GetComponent(uv0)
	slot0._goEnemyPowerAni = slot0._goEnemyPower:GetComponent(uv0)
	slot0._goPlayerPowerAni = slot0._goPlayerPower:GetComponent(uv0)
	slot0._txtEnemyPower.text = 0
	slot0._txtPlayerPower.text = 0

	slot0:playAni(EliminateTeamChessEnum.TeamChessTeamType.enemy, "idle")
	slot0:playAni(EliminateTeamChessEnum.TeamChessTeamType.player, "idle")
end

function slot0.initData(slot0, slot1, slot2, slot3)
	slot0._data = slot1
	slot0._strongholdIndex = slot2
	slot0._maxLen = slot3

	slot0:initInfo()
	slot0:updateInfo()
end

function slot0.onStart(slot0)
end

function slot0.initInfo(slot0)
	if slot0._data then
		if slot0._data:getStrongholdConfig() then
			slot0:updateInfoText(EliminateConfig.instance:getStrongHoldRuleRuleConfig(slot1.ruleId) and EliminateLevelModel.instance.formatString(slot4.desc) or "")

			slot6 = slot0._maxLen > 1 and slot0._strongholdIndex ~= slot0._maxLen
			slot7 = math.max(slot1.friendCapacity, slot1.enemyCapacity)

			gohelper.setActive(slot0._goLine4, slot6 and slot7 == 4)
			gohelper.setActive(slot0._goLine6, slot6 and slot7 == 6)

			if not string.nilorempty(EliminateLevelEnum.scenePathToStrongLandImageName[EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig().chessScene]) then
				UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageslotBGColor, slot8, false)
			else
				gohelper.setActive(slot0._imageslotBGColor.gameObject, false)
			end

			if not string.nilorempty(slot1.strongholdBg) then
				slot0._simageslotBG:LoadImage(slot9, nil, )
			end
		end
	end
end

function slot0.initStrongHoldChess(slot0, slot1, slot2, slot3, slot4)
	slot0:_initPlayerStrongHoldChess(slot1, slot3, slot4)
	slot0:_initEnemyStrongHoldChess(slot2, slot3, slot4)
end

function slot0._initPlayerStrongHoldChess(slot0, slot1, slot2, slot3)
	slot0._playerChessList = slot0:getUserDataTb_()
	slot0._playerPowerList = slot0:getUserDataTb_()
	slot0._playerGrowUpList = slot0:getUserDataTb_()
	slot0._playerChessGO = slot1
	slot0._playerChessTr = slot0._playerChessGO.transform
	slot0._playerSelectGo = gohelper.findChild(slot0._playerChessGO, "#go_Selected")

	transformhelper.setLocalPos(slot0._playerChessTr, 0, 0, 0)

	if slot0._data then
		slot5 = gohelper.findChild(slot0._playerChessGO, "#go_slots")
		slot0._playerChessGoAni = slot5:GetComponent(uv0)

		for slot11 = 1, slot5.transform.childCount do
			if slot0._data:getStrongholdConfig().friendCapacity < slot11 then
				gohelper.setActive(gohelper.findChild(slot0._playerChessGO, "#go_slots/slot_" .. slot11), false)
			else
				slot0._playerChessList[slot11] = {
					item = slot12,
					imgItem = gohelper.findChildImage(slot0._playerChessGO, "#go_slots/slot_" .. slot11)
				}
				slot14 = gohelper.clone(slot2, slot12, "slot_power_" .. slot11)

				recthelper.setAnchorX(slot14.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosX)
				recthelper.setAnchorY(slot14.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosY)
				gohelper.setActive(slot14, false)

				slot0._playerPowerList[slot11] = {
					item = slot14,
					powerImage = gohelper.findChildImage(slot14, "#image_chessPower"),
					powerText = gohelper.findChildText(slot14, "#image_chessPower/#txt_chessPower"),
					ani = slot14:GetComponent(uv0)
				}
				slot18 = gohelper.clone(slot3, slot12, "slot_growUp_" .. slot11)

				slot18.transform:SetParent(slot5.transform)

				slot19, slot20, slot21 = transformhelper.getLocalPos(slot12.transform)

				transformhelper.setLocalPos(slot18.transform, slot19, slot20 + EliminateTeamChessEnum.powerOffsetY, slot21)
				gohelper.setActive(slot18, false)
				table.insert(slot0._playerGrowUpList, {
					item = slot18,
					progressImage = gohelper.findChildImage(slot18, "image_FG"),
					progressImageEff = gohelper.findChildImage(slot18, "image_FG/image_FG_eff")
				})
			end
		end

		recthelper.setWidth(slot0.viewGO.transform, recthelper.getWidth(slot0._playerChessTr))
	end
end

function slot0._initEnemyStrongHoldChess(slot0, slot1, slot2, slot3)
	slot0._enemyChessList = slot0:getUserDataTb_()
	slot0._enemyPowerList = slot0:getUserDataTb_()
	slot0._enemyGrowUpList = slot0:getUserDataTb_()
	slot0._enemyChessGO = slot1
	slot0._enemyChessTr = slot0._enemyChessGO.transform

	transformhelper.setLocalPos(slot0._enemyChessTr, 0, 0, 0)

	if slot0._data then
		slot5 = gohelper.findChild(slot0._enemyChessGO, "#go_slots")
		slot0._enemyChessGoAni = slot5:GetComponent(uv0)

		for slot11 = slot5.transform.childCount, 1, -1 do
			if slot0._data:getStrongholdConfig().enemyCapacity < slot11 then
				gohelper.setActive(gohelper.findChild(slot0._enemyChessGO, "#go_slots/slot_" .. slot11), false)
			else
				table.insert(slot0._enemyChessList, {
					item = slot12,
					imgItem = gohelper.findChildImage(slot0._enemyChessGO, "#go_slots/slot_" .. slot11)
				})

				slot14 = gohelper.clone(slot2, slot12, "slot_power_" .. slot11)

				recthelper.setAnchorX(slot14.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosX)
				recthelper.setAnchorY(slot14.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosY)
				slot14.transform:SetParent(slot5.transform)
				gohelper.setActive(slot14, false)
				table.insert(slot0._enemyPowerList, {
					item = slot14,
					powerImage = gohelper.findChildImage(slot14, "#image_chessPower"),
					powerText = gohelper.findChildText(slot14, "#image_chessPower/#txt_chessPower")
				})

				slot17 = gohelper.clone(slot3, slot12, "slot_growUp_" .. slot11)

				slot17.transform:SetParent(slot5.transform)

				slot18, slot19, slot20 = transformhelper.getLocalPos(slot12.transform)

				transformhelper.setLocalPos(slot17.transform, slot18, slot19 + EliminateTeamChessEnum.powerOffsetY, slot20)
				gohelper.setActive(slot17, false)
				table.insert(slot0._enemyGrowUpList, {
					item = slot17,
					progressImage = gohelper.findChildImage(slot17, "image_FG"),
					progressImageEff = gohelper.findChildImage(slot17, "image_FG/image_FG_eff")
				})
			end
		end
	end
end

function slot0.addStrongholdChess(slot0, slot1, slot2, slot3)
	if slot0._data.id ~= slot2 then
		return
	end

	slot4, slot5 = nil

	if slot1.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot4 = slot0._playerChessList[slot3]
		slot5 = slot0._playerPowerList[slot3]
	end

	if slot1.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot4 = slot0._enemyChessList[slot3]
		slot5 = slot0._enemyPowerList[slot3]
	end

	slot0:refreshItemInfo(slot3, slot1, slot4, slot5, nil)
end

function slot0.removeStrongholdChess(slot0, slot1, slot2, slot3, slot4)
	if slot0._data.id ~= slot1 then
		return
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.RemoveStronghold3DChess, slot2)
	slot0:hideIndexInfo(slot3, slot4)

	if slot2 == EliminateTeamChessEnum.tempPieceUid then
		slot0:refreshSlotItemView()
	else
		TaskDispatcher.runDelay(slot0.refreshSlotItemView, slot0, EliminateTeamChessEnum.teamChessPlaceStep)
	end
end

function slot0.hideIndexInfo(slot0, slot1, slot2)
	slot3, slot4, slot5 = nil

	if slot2 == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot3 = slot0._playerChessList[slot1]
		slot4 = slot0._playerPowerList[slot1]
		slot5 = slot0._playerGrowUpList[slot1]
	end

	if slot2 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot3 = slot0._enemyChessList[slot1]
		slot4 = slot0._enemyPowerList[slot1]
		slot5 = slot0._enemyGrowUpList[slot1]
	end

	if slot3 ~= nil then
		uv0.a = 0
		slot3.imgItem.color = uv0
	end

	if slot4 ~= nil then
		gohelper.setActive(slot4.item, false)
	end

	if slot5 ~= nil then
		gohelper.setActive(slot5.item, false)
	end
end

function slot0.enemyGoPlayAni(slot0, slot1)
	if slot0._enemyChessGoAni then
		slot0._enemyChessGoAni:Play(slot1, 0, 0)
	end
end

function slot0.playerGoPlayAni(slot0, slot1)
	if slot0._playerChessGoAni then
		slot0._playerChessGoAni:Play(slot1, 0, 0)
	end
end

function slot0.strongHoldSettle(slot0, slot1)
	if slot0._data.id ~= slot1 then
		return
	end

	slot0:enemyGoPlayAni("close")
	slot0:playerGoPlayAni("close")
	slot0:setInfoActive(false)
	slot0:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.enemy, false)
	slot0:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.player, false)

	slot2 = recthelper.getWidth(slot0._imageslotBGColor.gameObject.transform) - 70
	slot3 = recthelper.getHeight(slot0._imageslotBGColor.gameObject.transform) - 60

	TeamChessUnitEntityMgr.instance:moveEntityByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.player, slot1, slot0._goinfo.transform, slot2, slot3)
	TeamChessUnitEntityMgr.instance:moveEntityByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.enemy, slot1, slot0._goinfo.transform, slot2, slot3)

	if slot0._data:getPlayerSoliderCount() > 0 or slot0._data:getEnemySoliderCount() > 0 then
		TaskDispatcher.runDelay(slot0.showResultFight, slot0, EliminateTeamChessEnum.entityMoveTime)
	else
		slot0:strongHoldSettleShowResult()
	end
end

function slot0.showResultFight(slot0)
	TaskDispatcher.cancelTask(slot0.showResultFight, slot0)

	slot1, slot2, slot3 = transformhelper.getPos(slot0._goinfo.transform)

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessEffect, EliminateTeamChessEnum.VxEffectType.StrongHoldBattle, slot1, slot2, slot3)
	TaskDispatcher.runDelay(slot0.strongHoldSettleShowResult, slot0, EliminateTeamChessEnum.StrongHoldBattleVxTime)
end

function slot0.strongHoldSettleShowResult(slot0)
	TaskDispatcher.cancelTask(slot0.strongHoldSettleShowResult, slot0)

	slot2 = slot0._data.status == EliminateTeamChessEnum.StrongHoldState.enemySide

	gohelper.setActive(slot0._goEnemyWin, slot2)
	gohelper.setActive(slot0._goPlayerWin, slot1 == EliminateTeamChessEnum.StrongHoldState.mySide)

	if slot2 or slot3 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_checkpoint_extrafall_eliminate)
	end

	if slot2 then
		TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.player, slot0._data.id)
		slot0:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.player, true)

		if slot0.enemyWinAni then
			slot0.enemyWinAni:Play("open", 0, 0)
		end
	end

	if slot3 then
		TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.enemy, slot0._data.id)
		slot0:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.enemy, true)

		if slot0.playerWinAni then
			slot0.playerWinAni:Play("open", 0, 0)
		end
	end
end

function slot0.strongHoldSettleResetShow(slot0)
	logNormal("EliminateStrongHoldItem:strongHoldSettleResetShow")
	gohelper.setActive(slot0._goEnemyWin, false)
	gohelper.setActive(slot0._goPlayerWin, false)
	slot0:enemyGoPlayAni("open")
	slot0:playerGoPlayAni("open")
	slot0:setInfoActive(true)
	slot0:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.enemy, true)
	slot0:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.player, true)
	TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.enemy, slot0._data.id)
	TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.player, slot0._data.id)
	slot0:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.enemy, false)
	slot0:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.player, false)
end

function slot0.setChessGray(slot0, slot1, slot2)
	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player and slot0._data.mySidePiece then
		for slot7 = 1, #slot3 do
			if slot3[slot7] then
				TeamChessUnitEntityMgr.instance:setGrayActive(slot8.uid, slot2)
			end
		end
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy and slot0._data.enemySidePiece then
		for slot7 = 1, #slot3 do
			if slot3[slot7] then
				TeamChessUnitEntityMgr.instance:setGrayActive(slot8.uid, slot2)
			end
		end
	end
end

function slot0.teamChessUpdateActiveMoveState(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot3 = slot0._data:getChess(slot1)

	if TeamChessUnitEntityMgr.instance:getEntity(slot1) and slot3 then
		slot2:setShowModeType(slot3:canActiveMove() and EliminateTeamChessEnum.ModeType.Outline or EliminateTeamChessEnum.ModeType.Normal)
	end
end

function slot0.setStrongHoldSelect(slot0, slot1, slot2)
	if slot0._playerSelectGo then
		gohelper.setActiveCanvasGroup(slot0._playerSelectGo, slot2 and slot0._data.id == slot2 or false)
	end
end

function slot0.refreshViewByRoundState(slot0, slot1)
	if slot0._enemyChessList == nil then
		return
	end

	for slot5 = 1, #slot0._enemyChessList do
		if slot0._enemyChessList[slot5] then
			gohelper.setActive(slot6.item, slot1 == EliminateTeamChessEnum.TeamChessRoundType.enemy)
		end
	end
end

function slot0.setInfoActive(slot0, slot1)
	gohelper.setActive(slot0._imageInfoTextBG.gameObject, slot1)
end

function slot0.refreshSlotItemView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshSlotItemView, slot0)

	if slot0._data then
		for slot5 = 1, slot0._data:getStrongholdConfig().friendCapacity do
			slot0:refreshItemInfo(slot5, slot0._data.mySidePiece[slot5], slot0._playerChessList[slot5], slot0._playerPowerList[slot5], slot0._playerGrowUpList[slot5])
		end

		for slot5 = 1, slot1.enemyCapacity do
			slot0:refreshItemInfo(slot5, slot0._data.enemySidePiece[slot5], slot0._enemyChessList[slot5], slot0._enemyPowerList[slot5], slot0._enemyGrowUpList[slot5])
		end
	end
end

function slot0.refreshItemInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot3 == nil or slot3.item == nil or slot4 == nil or slot4.item == nil then
		return
	end

	gohelper.setActive(slot4.item, slot2 ~= nil)

	if slot5 ~= nil then
		slot6 = false

		if slot2 and slot2.skill then
			for slot10 = 1, #slot2.skill do
				if slot2.skill[slot10] and slot11:needShowGrowUp() then
					slot6 = true

					break
				end
			end
		end

		gohelper.setActive(slot5.item, slot6)
	end

	if slot2 ~= nil then
		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.RefreshStronghold3DChess, slot2, slot0._data.id, slot1, slot3.item.transform)

		if slot4 and slot4.powerText then
			slot0:updatePowerNumber(slot4.powerText, slot2.battle, slot2.id)
		end

		if slot2:getActiveSkill() ~= nil then
			slot0:teamChessGrowUpValueChange(slot2.uid, slot6.id, nil)
		end
	end

	if slot2 == nil then
		uv0.a = 1
	else
		uv0.a = 0
	end

	slot3.imgItem.color = uv0
end

function slot0.updatePowerNumber(slot0, slot1, slot2, slot3)
	slot5 = uv0

	if EliminateConfig.instance:getSoldierChessConfig(slot3).defaultPower < slot2 then
		slot5 = uv1
	end

	if slot2 < slot4.defaultPower then
		slot5 = uv2
	end

	slot1.text = slot2
	slot1.color = slot5
end

function slot0.checkInPlayerChessRect(slot0, slot1, slot2)
	if slot0._playerChessTr == nil then
		return false
	end

	return recthelper.screenPosInRect(slot0._playerChessTr, CameraMgr.instance:getMainCamera(), slot1, slot2)
end

function slot0.updateInfo(slot0)
	if slot0._data then
		slot0:refreshStateByScore(slot0._data.myScore, slot0._data.enemyScore, false)
	end
end

function slot0.strongHoldPowerChange(slot0, slot1, slot2, slot3)
	if slot0._data == nil or slot0._data.id ~= slot1 then
		return
	end

	slot0:refreshStateByScore(slot0._data.myScore, slot0._data.enemyScore, true)
end

function slot0.playAni(slot0, slot1, slot2)
	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player and slot0._goPlayerPowerAni then
		slot0._goPlayerPowerAni:Play(slot2, 0, 0)
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy and slot0._goEnemyPowerAni then
		slot0._goEnemyPowerAni:Play(slot2, 0, 0)
	end
end

function slot0.teamChessPowerChange(slot0, slot1, slot2)
	if slot0._data:getMySideIndexByUid(slot1) ~= -1 and slot0._playerPowerList and slot0._playerPowerList[slot3] and slot4.powerText then
		if slot0._data:getMySideByUid(slot1) then
			slot0:updatePowerNumber(slot4.powerText, slot5.battle, slot5.id)

			if slot2 ~= 0 then
				if slot4.ani then
					slot4.ani:Play(slot2 > 0 and "up" or "down", 0, 0)
				end
			end
		end

		return
	end

	if slot0._data:getEnemySideIndexByUid(slot1) ~= -1 and slot0._enemyPowerList and slot0._enemyPowerList[slot4] and slot5.powerText then
		if slot0._data:getEnemySideByUid(slot1) then
			slot0:updatePowerNumber(slot5.powerText, slot6.battle, slot6.id)

			if slot2 ~= 0 then
				if slot5.ani then
					slot5.ani:Play(slot2 > 0 and "up" or "down", 0, 0)
				end
			end
		end

		return
	end
end

function slot0.teamChessGrowUpValueChange(slot0, slot1, slot2, slot3)
	if slot2 == nil then
		return
	end

	if slot0._data:getMySideIndexByUid(slot1) ~= -1 and slot0._playerGrowUpList and slot0._playerGrowUpList[slot4] and slot5.progressImage then
		slot7 = slot0._data:getMySideByUid(slot1) and slot6:getSkill(slot2)
		slot9 = slot7 and slot7:needShowGrowUp() or false

		if (slot7 and slot7:getGrowUpProgress() or 0) > 0 then
			uv0.DOFillAmount(slot5.progressImage, slot8, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, , , EaseType.OutQuart)
			uv0.DOFillAmount(slot5.progressImageEff, slot8, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, , , EaseType.OutQuart)
		else
			slot5.progressImage.fillAmount = slot8
			slot5.progressImageEff.fillAmount = slot8
		end

		gohelper.setActive(slot5.item, slot9)

		return
	end

	if slot0._data:getEnemySideIndexByUid(slot1) ~= -1 and slot0._enemyGrowUpList and slot0._enemyGrowUpList[slot5] and slot6.progressImage then
		slot8 = slot0._data:getEnemySideByUid(slot1) and slot7:getSkill(slot2)
		slot10 = slot8 and slot8:needShowGrowUp() or false

		if (slot8 and slot8:getGrowUpProgress() or 0) > 0 then
			uv0.DOFillAmount(slot6.progressImage, slot9, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, , , EaseType.OutQuart)
			uv0.DOFillAmount(slot6.progressImageEff, slot9, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, , , EaseType.OutQuart)
		else
			slot6.progressImage.fillAmount = slot9
			slot6.progressImageEff.fillAmount = slot9
		end

		gohelper.setActive(slot6.item, slot10)

		return
	end
end

function slot0.setPowerTrParent(slot0, slot1)
	if gohelper.isNil(slot1) then
		return
	end

	slot0._enemyPowerParent = gohelper.create2d(slot1.gameObject, "enemyPowerItem")
	slot0._playerPowerParent = gohelper.create2d(slot1.gameObject, "playerPowerItem")
	slot3 = slot0._playerPowerParent.transform

	for slot7 = 1, #slot0._enemyPowerList do
		if slot0._enemyPowerList[slot7] then
			slot8.item.transform:SetParent(slot0._enemyPowerParent.transform)
		end
	end

	for slot7 = 1, #slot0._playerPowerList do
		if slot0._playerPowerList[slot7] then
			slot8.item.transform:SetParent(slot3)
		end
	end
end

function slot0.setPowerActive(slot0, slot1, slot2)
	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player and not gohelper.isNil(slot0._enemyPowerParent) then
		gohelper.setActive(slot0._enemyPowerParent, slot2)
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy and not gohelper.isNil(slot0._playerPowerParent) then
		gohelper.setActive(slot0._playerPowerParent, slot2)
	end
end

function slot0.updateInfoText(slot0, slot1)
	slot0._txtInfo.text = slot1

	gohelper.setActive(slot0._imageInfoTextBG.gameObject, not string.nilorempty(slot1))
end

function slot0.refreshStateByScore(slot0, slot1, slot2)
	slot0._txtPlayerPower.text = slot1
	slot0._txtPlayerPower1.text = slot1
	slot0._txtEnemyPower.text = slot2
	slot0._txtEnemyPower1.text = slot2
	slot0._txtEnemyPower.color = slot1 < slot2 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	slot0._txtEnemyPower1.color = slot1 < slot2 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	slot0._txtEnemyPower.fontSize = slot1 < slot2 and EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	slot0._txtEnemyPower1.fontSize = slot1 < slot2 and EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	slot0._txtPlayerPower.color = slot2 < slot1 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	slot0._txtPlayerPower1.color = slot2 < slot1 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	slot0._txtPlayerPower.fontSize = slot2 < slot1 and EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	slot0._txtPlayerPower1.fontSize = slot2 < slot1 and EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	slot6 = "idle"
	slot7 = "idle"

	if slot1 ~= slot2 then
		if slot1 < slot2 then
			slot6 = slot4 == slot3 and "idle" or tonumber(slot0._txtEnemyPower.text) < tonumber(slot0._txtPlayerPower.text) and "down" or "down_refresh"
			slot7 = slot4 == slot3 and "up" or "up_refresh"
		else
			slot6 = slot4 == slot3 and "up" or slot5 and "up_refresh" or "up"
			slot7 = slot4 == slot3 and "idle" or "down_refresh"
		end
	end

	slot0:playAni(EliminateTeamChessEnum.TeamChessTeamType.player, slot6)
	slot0:playAni(EliminateTeamChessEnum.TeamChessTeamType.enemy, slot7)
end

function slot0.refreshAni(slot0, slot1)
	if slot1 then
		slot4 = "idle"
		slot5 = "idle"

		if slot0._data.myScore < slot0._data.enemyScore then
			slot5 = "up"
		elseif slot3 < slot2 then
			slot4 = "up"
		end

		slot0:playAni(EliminateTeamChessEnum.TeamChessTeamType.player, slot4)
		slot0:playAni(EliminateTeamChessEnum.TeamChessTeamType.enemy, slot5)
	end
end

function slot0.clear(slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.showResultFight, slot0)
	TaskDispatcher.cancelTask(slot0.strongHoldSettleShowResult, slot0)
	TaskDispatcher.cancelTask(slot0.refreshSlotItemView, slot0)

	slot0._playerPowerParent = nil
	slot0._enemyPowerParent = nil
	slot0._enemyChessGoAni = nil
	slot0._playerChessGoAni = nil
end

return slot0
