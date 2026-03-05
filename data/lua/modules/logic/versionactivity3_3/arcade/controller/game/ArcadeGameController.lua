-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameController.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameController", package.seeall)

local ArcadeGameController = class("ArcadeGameController", BaseController)

function ArcadeGameController:onInit()
	return
end

function ArcadeGameController:onInitFinish()
	return
end

function ArcadeGameController:addConstEvents()
	self:registerCallback(ArcadeEvent.OnSkillKillDeathSettle, self._enterDeathSettleFlow, self)
end

function ArcadeGameController:reInit()
	return
end

function ArcadeGameController:getGameScene()
	return self._gameScene
end

function ArcadeGameController:getCurRoom()
	if self._gameScene and self._gameScene.roomMgr then
		return self._gameScene.roomMgr:getCurRoom()
	end
end

function ArcadeGameController:getArcadeInSideInfo()
	local isOpen = ArcadeModel.instance:isAct222Open(true)

	if not isOpen then
		return
	end

	ArcadeInSideRpc.instance:sendArcadeGetInSideInfoRequest(self._onGetInsideInfo, self)
end

function ArcadeGameController:_onGetInsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.hasSaveGame then
		self._tmpInsideInfo = msg.info

		local prop = msg.info.prop
		local difficulty = prop.difficulty
		local isInGuide = ArcadeGameModel.instance:getIsInGuideLevel(difficulty)

		if isInGuide then
			self:_restartGame()
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.ContinueArcadeGame, MsgBoxEnum.BoxType.Yes_No, self._restartGame, self._abandonGame, nil, self, self, nil)
		end
	else
		ArcadeController.instance:openHallView()
	end
end

function ArcadeGameController:_restartGame()
	if not self._tmpInsideInfo then
		ArcadeController.instance:openHallView()

		return
	end

	ArcadeGameModel.instance:onRestartArcadeGame(self._tmpInsideInfo)

	self._gameScene = ArcadeGameScene.New()

	self._gameScene:onEnterArcadeGame(true)
	ViewMgr.instance:openView(ViewName.ArcadeGameView)

	self._tmpInsideInfo = nil
end

function ArcadeGameController:_abandonGame()
	ArcadeController.instance:openHallView()
	self:endGame(ArcadeGameEnum.SettleType.Abandon, false, false, self._tmpInsideInfo)

	self._tmpInsideInfo = nil
end

function ArcadeGameController:enterGame(difficulty)
	local isFinishGuide = ArcadeGameModel.instance:isFinishGameGuide()

	if not isFinishGuide then
		difficulty = ArcadeGameEnum.Const.GuideDifficulty
	end

	if not difficulty then
		return
	end

	ArcadeGameModel.instance:setDifficulty(difficulty)
	ArcadeOutSideRpc.instance:sendArcadeGetOutSideInfoRequest(self._enterGameAfterGetOutsideInfo, self)
end

function ArcadeGameController:_enterGameAfterGetOutsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ArcadeGameModel.instance:onEnterArcadeGame()

	self._gameScene = ArcadeGameScene.New()

	self._gameScene:onEnterArcadeGame()
	ViewMgr.instance:openView(ViewName.ArcadeGameView)
end

function ArcadeGameController:resetGame()
	ArcadeOutSideRpc.instance:sendArcadeGetOutSideInfoRequest(self._resetGameAfterGetOutsideInfo, self)
end

function ArcadeGameController:_resetGameAfterGetOutsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local removeBuffIdList = {}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		local buffSetMO = characterMO:getBuffSetMO()
		local buffList = buffSetMO and buffSetMO:getBuffList()

		if buffList then
			for i, buffMO in ipairs(buffList) do
				local buffId = buffMO:getId()

				removeBuffIdList[i] = buffId
			end
		end
	end

	self:removeEntityBuffs(removeBuffIdList, ArcadeGameEnum.EntityType.Character)
	ArcadeGameModel.instance:onResetArcadeGame()
	self:startGame()
	self:dispatchEvent(ArcadeEvent.OnResetArcadeGame)
end

function ArcadeGameController:pauseGame()
	ArcadeGameModel.instance:setIsPauseGame(true)
end

function ArcadeGameController:resumeGame()
	ArcadeGameModel.instance:setIsPauseGame(false)
end

function ArcadeGameController:saveGame()
	local info = ArcadeGameHelper.getServerArcadeInsideInfo()

	ArcadeInSideRpc.instance:sendArcadeSaveGameRequest(info)
end

function ArcadeGameController:endGame(settleType, isWin, isReset, serverInfo)
	local isEnd = ArcadeGameModel.instance:getIsEndGame()

	if isEnd then
		return
	end

	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.ChangingRoom)
	ArcadeGameModel.instance:setGameIsEnd(true)

	self._resultViewInfo = ArcadeGameHelper.getResultViewInfo(isWin, isReset, serverInfo)
	self._resultViewInfo.settleType = settleType

	local settleInfo

	if serverInfo then
		settleInfo = serverInfo
		self._resultViewInfo.serverInfo = serverInfo
	else
		settleInfo = ArcadeGameHelper.getServerArcadeInsideInfo(isWin, true)

		local characterMO = ArcadeGameModel.instance:getCharacterMO()

		if characterMO then
			local diamondResMO = characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.Diamond)

			if diamondResMO then
				diamondResMO:setCount(0)
			end

			local cassetteResMO = characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.Cassette)

			if cassetteResMO then
				cassetteResMO:setCount(0)
			end
		end
	end

	ArcadeInSideRpc.instance:sendArcadeSettleGameRequest(settleType, settleInfo, self._openResultViewAfterSettle, self)
end

function ArcadeGameController:_openResultViewAfterSettle(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._resultViewInfo.bookAddScore = msg and msg.bookAddScore or 0
	self._resultViewInfo.hasUnlockCharacter = false

	if msg and msg.unlockRoleIds then
		self._resultViewInfo.hasUnlockCharacter = #msg.unlockRoleIds > 0
	end

	ViewMgr.instance:openView(ViewName.ArcadeGameResultView, self._resultViewInfo)

	local gameCassetteCount = self._resultViewInfo.attrDict[ArcadeGameEnum.CharacterResource.Cassette] or 0
	local totalCassetteCount = gameCassetteCount + self._resultViewInfo.bookAddScore

	ArcadeStatHelper.instance:sendEndGame(self._resultViewInfo.settleType, totalCassetteCount, self._resultViewInfo.serverInfo)

	self._resultViewInfo = nil
end

function ArcadeGameController:closeGameView()
	ViewMgr.instance:closeView(ViewName.ArcadeGameView)
end

function ArcadeGameController:exitGame()
	if self._gameScene then
		self._gameScene:onExitArcadeGame()
	end

	self._gameScene = nil
	self._resultViewInfo = nil

	ArcadeGameModel.instance:onExitArcadeGame()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.ChangingRoom)
end

function ArcadeGameController:startGame(isRestart)
	ArcadeStatHelper.instance:sendStartGame()

	if isRestart then
		local curRoomId = ArcadeGameModel.instance:getCurRoomId()

		self:change2Room(curRoomId)
	else
		local characterMO = ArcadeGameModel.instance:getCharacterMO()

		ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.GameStart, characterMO)
		self:enterNextArea()
	end
end

function ArcadeGameController:checkCharacterNearUnit(isCharacterMove)
	local eventEntityType, eventEntityUid
	local curRoom = self:getCurRoom()

	if not curRoom then
		return
	end

	local scene = self:getGameScene()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local curEventEntityType, curEventEntityUid = ArcadeGameModel.instance:getNearEventEntity()
	local borderGridList = characterMO:getBorderGridList()

	for _, gridData in ipairs(borderGridList) do
		local borderGridX = gridData.gridX
		local borderGridY = gridData.gridY
		local adjEntityData = curRoom:getEntityDataInTargetGrid(borderGridX, borderGridY)
		local adjEntityType = adjEntityData and adjEntityData.entityType
		local adjUid = adjEntityData and adjEntityData.uid
		local adjMO = ArcadeGameModel.instance:getMOWithType(adjEntityType, adjUid)

		if adjMO and adjMO.getEventOptionList then
			local isDead = adjMO:getIsDead()

			if not isDead then
				if eventEntityType and eventEntityUid then
					if curEventEntityType and curEventEntityUid and curEventEntityType == adjEntityType and curEventEntityUid == adjUid then
						eventEntityType = adjEntityType
						eventEntityUid = adjUid
					end
				else
					eventEntityType = adjEntityType
					eventEntityUid = adjUid
				end
			end
		end

		local entity = scene and scene.entityMgr:getEntityWithType(adjEntityType, adjUid)

		if entity then
			entity:refreshShowHpBar()
		end
	end

	self:changeNearEventEntity(eventEntityType, eventEntityUid, isCharacterMove)
end

function ArcadeGameController:changeNearEventEntity(eventEntityType, eventEntityUid, isCharacterMove)
	local curEventEntityType, curEventEntityUid = ArcadeGameModel.instance:getNearEventEntity()

	if eventEntityType == curEventEntityType and eventEntityUid == curEventEntityUid then
		return
	end

	ArcadeGameModel.instance:setNearEventEntity(eventEntityType, eventEntityUid)
	self:dispatchEvent(ArcadeEvent.RefreshGameEventTip, eventEntityType, eventEntityUid, isCharacterMove)
end

function ArcadeGameController:triggerEventOption(entityType, entityId, uid, eventOptionId, eventOptionParam, noCanInteractCheck, noConditionCheck, extraParam)
	local isChangingRoom = ArcadeGameModel.instance:getIsChangingRoom()
	local isGamePause = ArcadeGameModel.instance:getIsPauseGame()
	local isGameEnd = ArcadeGameModel.instance:getIsEndGame()

	if not eventOptionId or isChangingRoom or isGamePause or isGameEnd then
		return
	end

	local canInteract = false
	local eventEntityMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)

	if noCanInteractCheck then
		canInteract = true
	elseif eventEntityMO and eventEntityMO.isCanInteract then
		canInteract = eventEntityMO:isCanInteract()
	end

	local checkResult = true

	if not noConditionCheck then
		local checkCondition = ArcadeConfig.instance:getEventOptionCondition(eventOptionId)

		if not string.nilorempty(checkCondition) then
			checkResult = false

			local arr = string.split(checkCondition, "#")
			local conditionType = arr[1]
			local checkHandler = ArcadeGameHelper.getEventOptionConditionCheckFunc(conditionType)

			if checkHandler then
				checkResult = checkHandler(arr)
			end
		end
	end

	if not checkResult or not canInteract then
		GameFacade.showToast(ToastEnum.NotSatisfy)

		return
	end

	local eventOptionType = ArcadeConfig.instance:getEventOptionType(eventOptionId)
	local handler = ArcadeGameHelper.getEventOptionHandleFunc(eventOptionType)

	if handler then
		local result = handler(entityType, entityId, uid, eventOptionParam, extraParam)

		if result and eventEntityMO then
			eventEntityMO:addTriggerEventOptionId(eventOptionId)

			local scene = self:getGameScene()
			local entity = scene and scene.entityMgr:getEntityWithType(entityType, uid)

			if entity then
				entity:playActionShow(ArcadeGameEnum.ActionShowId.Interactive, nil, entityId)
			end
		end

		return result
	end
end

function ArcadeGameController:enterNextArea(playExcessive)
	local difficulty = ArcadeGameModel.instance:getDifficulty()
	local curAreaIndex = ArcadeGameModel.instance:getCurAreaIndex()
	local nextAreaIndex = curAreaIndex + 1
	local nextAreaId = ArcadeConfig.instance:getDifficultyAreaIdByIndex(difficulty, nextAreaIndex)

	if not nextAreaId then
		logError(string.format("ArcadeGameController:enterNextArea error, no next Area, difficulty:%s, curAreaIndex:%s", difficulty, curAreaIndex))

		return
	end

	ArcadeGameModel.instance:setCurAreaIndex(nextAreaIndex)
	ArcadeGameModel.instance:setTransferNodeIndex()

	local firstRoom = ArcadeConfig.instance:getAreaFirstRoom(nextAreaId)

	self:change2Room(firstRoom, playExcessive)
end

function ArcadeGameController:change2Room(roomId, playExcessive)
	if not roomId then
		return
	end

	logNormal(string.format("ArcadeGame change to room :%s", roomId))
	ArcadeGameModel.instance:setChangingRoom(true)
	ArcadeGameModel.instance:setCurRoomId(roomId)

	if playExcessive then
		local isOpenGameView = ViewMgr.instance:isOpen(ViewName.ArcadeGameView)

		if isOpenGameView then
			UIBlockMgr.instance:startBlock(ArcadeEnum.BlockKey.ChangingRoom)
		end

		self:dispatchEvent(ArcadeEvent.PlayChangeRoomExcessive)
	elseif self._gameScene then
		UIBlockMgr.instance:startBlock(ArcadeEnum.BlockKey.ChangingRoom)
		self._gameScene.roomMgr:switchRoom()
	end
end

function ArcadeGameController:changeRoomFinish()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.ChangingRoom)
	ArcadeGameModel.instance:setChangingRoom(false)

	local roomId = ArcadeGameModel.instance:getCurRoomId()

	self:checkCharacterNearUnit()
	self:dispatchEvent(ArcadeEvent.OnChangeArcadeRoomFinish, roomId)
end

function ArcadeGameController:tryAddEntityList(entityDataList, needGenUid, canOverY, cb, cbObj)
	local curRoom = self:getCurRoom()

	if not entityDataList or not curRoom then
		ArcadeGameHelper.callCallbackFunc(cb, cbObj)

		return
	end

	local canPlaceDataList = curRoom:filterCanPlaceEntityList(entityDataList, canOverY)
	local moList = ArcadeGameModel.instance:addEntityMOByList(canPlaceDataList, needGenUid)

	if self._gameScene then
		self._gameScene.entityMgr:addEntityByList(moList, canOverY, cb, cbObj)
	end

	self:checkCharacterNearUnit()
	self:dispatchEvent(ArcadeEvent.OnAddEntities, moList)
end

function ArcadeGameController:removeEntityListByType(entityType)
	local moList = ArcadeGameModel.instance:getEntityMOList(entityType)

	if not moList or #moList <= 0 then
		return
	end

	local uidList = {}

	if self._gameScene then
		for _, mo in ipairs(moList) do
			local uid = mo:getUid()

			self._gameScene.entityMgr:removeEntityWithType(entityType, uid)

			uidList[#uidList + 1] = uid
		end
	end

	ArcadeGameModel.instance:removeEntityMOByType(entityType)
	self:checkCharacterNearUnit()
	self:dispatchEvent(ArcadeEvent.OnRemoveEntity, entityType, uidList)
end

function ArcadeGameController:removeEntity(entityType, uid, needWaitRemoveAnim)
	if self._gameScene then
		self._gameScene.entityMgr:removeEntityWithType(entityType, uid, needWaitRemoveAnim)
	end

	ArcadeGameModel.instance:removeEntityMO(entityType, uid)
	self:checkCharacterNearUnit()
	self:dispatchEvent(ArcadeEvent.OnRemoveEntity, entityType, {
		uid
	})
end

function ArcadeGameController:removeDeadEntityAndDrop(mo, isPlay)
	local isDead = mo and mo:getIsDead()

	if not isDead then
		return
	end

	local entityType = mo:getEntityType()
	local uid = mo:getUid()
	local isRemoving = mo:getIsRemoving()

	if isRemoving then
		self:_afterPlayRemove({
			entityType = entityType,
			uid = uid
		})

		return
	end

	local gridX, gridY = mo:getGridPos()
	local dropList = mo:getDropList()

	if dropList then
		for _, dropId in ipairs(dropList) do
			self:gainDropItemById(dropId, gridX, gridY)
		end
	end

	local scene = self:getGameScene()
	local entity = scene and scene.entityMgr:getEntityWithType(entityType, uid)

	if isPlay and entity then
		entity:playActionShow(ArcadeGameEnum.ActionShowId.Remove, nil, nil, self._afterPlayRemove, self, {
			entity = entity
		})
		mo:setIsRemoving(true)
		self:removeEntity(entityType, uid, true)
	else
		self:removeEntity(entityType, uid)
	end
end

function ArcadeGameController:_afterPlayRemove(param)
	if param and param.entity then
		param.entity:destroy()
	end
end

function ArcadeGameController:gainDropItemById(dropId, gridX, gridY)
	local x, y, z = ArcadeGameHelper.getGridWorldPos(gridX, gridY)
	local gainPos = {
		x = x,
		y = y,
		z = z
	}
	local dropItem = ArcadeGameHelper.getDropItem(dropId)

	if dropItem then
		local type = dropItem.dropItemType
		local id = dropItem.id
		local count = dropItem.count

		if type == ArcadeGameEnum.DropItemType.Resource then
			local scene = self:getGameScene()

			if id == ArcadeGameEnum.CharacterResource.GameCoin and scene then
				local dropCoinEffectIdList = ArcadeGameHelper.getActionShowEffect(ArcadeGameEnum.ActionShowId.DropCoin)
				local dropCoinEffId = dropCoinEffectIdList and dropCoinEffectIdList[1]

				scene.effectMgr:playEffect2Grid(dropCoinEffId, gridX, gridY)
			end

			self:changeResCount(id, count, gainPos)
		elseif type == ArcadeGameEnum.DropItemType.Collection then
			self:gainCollection(id, gainPos)
		elseif type == ArcadeGameEnum.DropItemType.Character then
			ArcadeGameModel.instance:addUnlockCharacter(id)
		end
	end

	return dropItem
end

function ArcadeGameController:gainCollection(collectionId, gainPos)
	local isUnique = ArcadeConfig.instance:getCollectionIsUnique(collectionId)
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local collectionMO

	if characterMO then
		local characterHas = characterMO:getHasCollection(collectionId)

		if isUnique and characterHas then
			return
		end

		collectionMO = characterMO:addCollection(collectionId)

		if collectionMO then
			local name = ArcadeConfig.instance:getCollectionName(collectionId)

			GameFacade.showToast(ToastEnum.V3a3ArcadeGainCollection, name)
			ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.Collection501, characterMO, {
				collectionMO = collectionMO
			})
			ArcadeGameModel.instance:addUnlockHandBookItem(ArcadeGameEnum.HandBookType.Collection, collectionId)
		end
	end

	local weaponGainPosList = {}
	local collectionGainPosList = {}
	local type = ArcadeConfig.instance:getCollectionType(collectionId)

	if type == ArcadeGameEnum.CollectionType.Weapon then
		table.insert(weaponGainPosList, gainPos)
	elseif type == ArcadeGameEnum.CollectionType.Jewelry then
		table.insert(collectionGainPosList, gainPos)
	end

	self:dispatchEvent(ArcadeEvent.OnCollectionChange, weaponGainPosList, collectionGainPosList)

	return collectionMO
end

function ArcadeGameController:tryUseCollection(uid, useTime)
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local collectionMO = characterMO and characterMO:getCollectionMO(uid)

	if not collectionMO then
		return
	end

	collectionMO:addUsedTimes(useTime)

	local remainDurability = collectionMO:getRemainDurability()

	if remainDurability and remainDurability <= 0 then
		self:lossCollection(uid)
	else
		self:dispatchEvent(ArcadeEvent.OnWeaponDurabilityChange)
	end
end

function ArcadeGameController:lossCollection(uid)
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		characterMO:removeCollection(uid)
	end

	self:dispatchEvent(ArcadeEvent.OnCollectionChange)
end

function ArcadeGameController:addBuff2Entity(buffId, entityType, uid)
	local result = false
	local buffEntityTypeDict = ArcadeConfig.instance:getArcadeBuffEntityTypeDict(buffId)

	if not entityType or not buffEntityTypeDict[entityType] then
		return result
	end

	local entityMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)
	local buffSetMO = entityMO and entityMO:getBuffSetMO()

	if buffSetMO then
		buffSetMO:addBuffById(buffId)

		result = true
	end

	local scene = self:getGameScene()
	local entity = scene and scene.entityMgr:getEntityWithType(entityType, uid)

	if entity then
		entity:playActionShow(ArcadeGameEnum.ActionShowId.GainBuff, nil, buffId)
	end

	self:dispatchEvent(ArcadeEvent.OnBuffChange, entityType, uid)

	return result
end

function ArcadeGameController:removeEntityBuffs(buffIdList, entityType, uid)
	if not buffIdList or #buffIdList <= 0 then
		return
	end

	local entityMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)
	local buffSetMO = entityMO and entityMO:getBuffSetMO()

	if buffSetMO then
		local scene = self:getGameScene()
		local entity = scene and scene.entityMgr:getEntityWithType(entityType, uid)

		for _, buffId in ipairs(buffIdList) do
			buffSetMO:removeBuffById(buffId)

			if entity then
				local loopBuffEffect = ArcadeConfig.instance:getArcadeBuffLoopEffect(buffId)

				if loopBuffEffect and loopBuffEffect ~= 0 then
					entity:stopStateLoopEffect(loopBuffEffect)
				end
			end
		end
	end

	self:dispatchEvent(ArcadeEvent.OnBuffChange, entityType, uid)
end

function ArcadeGameController:changeEntityHp(entityMO, changValue)
	if not entityMO or not changValue or changValue == 0 then
		return
	end

	local realChangeVal = entityMO:addHp(changValue)

	if changValue > 0 then
		local scene = self:getGameScene()
		local uid = entityMO:getUid()
		local entityType = entityMO:getEntityType()
		local entity = scene and scene.entityMgr:getEntityWithType(entityType, uid)

		if entity then
			entity:playActionShow(ArcadeGameEnum.ActionShowId.AddHp)
		end
	end

	self:dispatchEvent(ArcadeEvent.OnChangeEntityHp, entityMO, realChangeVal)
end

function ArcadeGameController:changeResCount(resId, changeValue, gainPos)
	if not changeValue or changeValue == 0 then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local resMO = characterMO and characterMO:getResourceMO(resId)

	if not resMO then
		return
	end

	if changeValue < 0 then
		resMO:subCount(math.abs(changeValue))
	elseif changeValue > 0 then
		resMO:addCount(changeValue)
	end

	if resId == ArcadeGameEnum.CharacterResource.Score then
		ArcadeGameModel.instance:refreshMaxScore()

		local curScore = resMO:getCount()
		local addCoinRate = ArcadeConfig.instance:getGradeAddCoinRate(curScore)
		local coinResMO = characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.GameCoin)

		if coinResMO then
			coinResMO:setGainRate(addCoinRate)
		end
	end

	self:dispatchEvent(ArcadeEvent.OnCharacterResourceCountUpdate, resId, {
		gainPos
	})
end

function ArcadeGameController:enterAttackFlow(attackType, attackerMO, targetMOList, attackDirection, skillId, notTriggerAtkPoint)
	if not attackerMO then
		return
	end

	if notTriggerAtkPoint ~= true then
		ArcadeGameTriggerController.instance:atkTriggerTarget(ArcadeGameEnum.TriggerPoint.AtkBefor201, attackType, attackerMO, targetMOList)
		ArcadeGameTriggerController.instance:hitTriggerTargetList(ArcadeGameEnum.TriggerPoint.HitBefor202, attackType, attackerMO, targetMOList)
	end

	ArcadeGameTriggerController.instance:hitTriggerTargetList(ArcadeGameEnum.TriggerPoint.HitBefor251, attackType, attackerMO, targetMOList)

	local attackActionShowId, hitActionShowId, actionShowParam = self:_getAttackAndHitShow(attackerMO, attackType, skillId)
	local scene = self:getGameScene()
	local attackerUid = attackerMO:getUid()
	local attackerEntityType = attackerMO:getEntityType()
	local attackerEntity = scene and scene.entityMgr:getEntityWithType(attackerEntityType, attackerUid)

	if attackerEntity and attackActionShowId then
		attackerEntity:playActionShow(attackActionShowId, attackDirection, actionShowParam)
	end

	self:_calAttackDamage(attackerMO, attackType, targetMOList, attackDirection, hitActionShowId, actionShowParam, skillId)
	self:_updateScoreAndSkillEnergy(attackerMO, attackType, targetMOList, skillId)

	if notTriggerAtkPoint ~= true then
		ArcadeGameTriggerController.instance:atkTriggerTarget(ArcadeGameEnum.TriggerPoint.Atk203, attackType, attackerMO, targetMOList)
		ArcadeGameTriggerController.instance:clearTargetTempAttr(attackerMO)
		ArcadeGameTriggerController.instance:hitTriggerTargetList(ArcadeGameEnum.TriggerPoint.Hit204, attackType, attackerMO, targetMOList)
		ArcadeGameTriggerController.instance:clearTargetListTempAttr(targetMOList)
		ArcadeGameModel.instance:clearGameTempAttribute()
	end

	self:_enterDeathSettleFlow(attackerMO)

	if targetMOList then
		for _, targetMO in ipairs(targetMOList) do
			self:_enterDeathSettleFlow(targetMO, attackerMO)
		end
	end
end

function ArcadeGameController:_getAttackAndHitShow(attackerMO, attackType, skillId)
	local attackActionShowId, hitActionShowId, actionShowParam
	local isBasicAttack = attackType == ArcadeGameEnum.AttackType.Normal or attackType == ArcadeGameEnum.AttackType.Link

	if isBasicAttack then
		attackActionShowId = ArcadeGameEnum.ActionShowId.BaseAttack
		hitActionShowId = ArcadeGameEnum.ActionShowId.BaseHit
	elseif attackType == ArcadeGameEnum.AttackType.Bomb then
		attackActionShowId = ArcadeGameEnum.ActionShowId.BombAttack
		hitActionShowId = ArcadeGameEnum.ActionShowId.BombHit
	elseif attackType == ArcadeGameEnum.AttackType.Skill then
		if not skillId then
			local characterId = attackerMO:getId()

			skillId = ArcadeConfig.instance:getCharacterSkill(characterId)
		end

		attackActionShowId = ArcadeGameEnum.ActionShowId.ActiveSkill
		hitActionShowId = ArcadeGameEnum.ActionShowId.ActiveSkillHit
		actionShowParam = skillId
	end

	return attackActionShowId, hitActionShowId, actionShowParam
end

function ArcadeGameController:_calAttackDamage(attackerMO, attackType, targetMOList, attackDirection, hitActionShowId, actionShowParam, skillId)
	if not targetMOList or #targetMOList <= 0 then
		return
	end

	local attackDamage = 0
	local attackerId = attackerMO:getId()
	local attackerEntityType = attackerMO:getEntityType()
	local isCharacterAttack = attackerEntityType == ArcadeGameEnum.EntityType.Character
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local isCharacterBomb = false

	if attackType == ArcadeGameEnum.AttackType.Bomb then
		local addBombDamage = 0

		isCharacterBomb = attackerMO:isCharacterBomb()

		if isCharacterBomb then
			addBombDamage = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.AddBombDamage)
		end

		attackDamage = ArcadeConfig.instance:getBombDamage(attackerId) + addBombDamage
	elseif attackType == ArcadeGameEnum.AttackType.Skill then
		local addSkillDamage = 0

		if isCharacterAttack then
			local characterSkillId = ArcadeConfig.instance:getCharacterSkill(characterId)

			skillId = skillId or characterSkillId

			if skillId == characterSkillId then
				addSkillDamage = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.AddSkillDamage)
			end
		end

		attackDamage = ArcadeConfig.instance:getActiveSkillDamage(skillId) + addSkillDamage
	end

	local isBasicAttack = attackType == ArcadeGameEnum.AttackType.Normal or attackType == ArcadeGameEnum.AttackType.Link
	local attackerX, attackerY = attackerMO:getGridPos()
	local defenseGridX, defenseGridY, defenseTargetMO

	if attackDirection then
		defenseGridX = attackerX + (ArcadeEnum.DirChangeGridX[attackDirection] or 0)
		defenseGridY = attackerY + (ArcadeEnum.DirChangeGridY[attackDirection] or 0)
	end

	for _, targetMO in ipairs(targetMOList) do
		local targetEntityType = targetMO:getEntityType()
		local targetUid = targetMO:getUid()
		local targetX, targetY = targetMO:getGridPos()
		local targetSizeX, targetSizeY = targetMO:getSize()
		local hitDirection = ArcadeGameHelper.getDirection(targetX, targetY, targetSizeX, targetSizeY, attackerX, attackerY)
		local canBeAttacked = true
		local needPlayActionShow = true

		if isBasicAttack then
			local buffSetMO = targetMO:getBuffSetMO()
			local buffEffectName = string.format("NotBeAttack_%s", hitDirection)
			local haveNotBeAttackBuff = buffSetMO:hasEffectParamBuff(ArcadeGameEnum.BuffEffectParam[buffEffectName])

			if haveNotBeAttackBuff then
				canBeAttacked = false
				needPlayActionShow = false

				local removeBuffList = buffSetMO:reduceBuffRoundByEffectParam(ArcadeGameEnum.BuffEffectParam[buffEffectName])

				self:removeEntityBuffs(removeBuffList, targetEntityType, targetUid)
			else
				local attackValue = attackerMO:getAttributeValue(ArcadeGameEnum.BaseAttr.attack)
				local defenseValue = targetMO:getAttributeValue(ArcadeGameEnum.BaseAttr.defense)

				attackDamage = math.max(0, attackValue - defenseValue)
			end

			if isCharacterAttack and targetX <= defenseGridX and defenseGridX <= targetX + targetSizeX - 1 and targetY <= defenseGridY and defenseGridY <= targetY + targetSizeY - 1 then
				defenseTargetMO = targetMO
			end
		elseif attackType == ArcadeGameEnum.AttackType.Bomb then
			local isBombNotAttackSelf = ArcadeGameModel.instance:getGameSwitchIsOn(ArcadeGameEnum.GameSwitch.BombNotAttackSelf)

			if isCharacterBomb and targetEntityType == ArcadeGameEnum.EntityType.Character and isBombNotAttackSelf then
				canBeAttacked = false
				needPlayActionShow = false
			elseif targetEntityType == ArcadeGameEnum.EntityType.BaseInteractive then
				canBeAttacked = false

				self:_onBombAttackInteractive(targetMO)
			end
		end

		if needPlayActionShow and hitActionShowId then
			local scene = self:getGameScene()
			local targetEntity = scene and scene.entityMgr:getEntityWithType(targetEntityType, targetUid)

			if targetEntity then
				targetEntity:playActionShow(hitActionShowId, hitDirection, actionShowParam)
			end
		end

		if canBeAttacked then
			self:changeEntityHp(targetMO, -attackDamage)
		end
	end

	if isCharacterAttack and defenseTargetMO then
		local buffSetMO = attackerMO:getBuffSetMO()
		local haveNotBeCounteredBuff = buffSetMO:hasEffectParamBuff(ArcadeGameEnum.BuffEffectParam.NotBeCountered)

		if not haveNotBeCounteredBuff then
			local curHP = defenseTargetMO:getHp()

			if isBasicAttack and curHP > 0 then
				local targetAttackValue = defenseTargetMO:getAttributeValue(ArcadeGameEnum.BaseAttr.attack)
				local attackerDefenseValue = attackerMO:getAttributeValue(ArcadeGameEnum.BaseAttr.defense)
				local counterDamage = math.max(0, targetAttackValue - attackerDefenseValue)

				self:changeEntityHp(attackerMO, -counterDamage)
			end
		end
	end
end

function ArcadeGameController:_onBombAttackInteractive(mo)
	if not mo then
		return
	end

	local entityType = mo:getEntityType()
	local uid = mo:getUid()
	local id = mo:getId()
	local bombAttackEventList = ArcadeConfig.instance:getInteractiveBombAttackEventIdList(id)

	if bombAttackEventList and #bombAttackEventList > 0 then
		for _, eventOptionId in ipairs(bombAttackEventList) do
			local eventOptionParam = ArcadeConfig.instance:getEventOptionParam(eventOptionId)
			local result = self:triggerEventOption(entityType, id, uid, eventOptionId, eventOptionParam, true, true)

			if result then
				mo:setIsDead(true)
			end
		end

		self:removeDeadEntityAndDrop(mo)
	else
		self:dispatchEvent(ArcadeEvent.CheckEntityTalk, entityType, uid, ArcadeGameEnum.TalkTriggerType.BeBombAttack)
	end
end

function ArcadeGameController:_updateScoreAndSkillEnergy(attackerMO, attackType, targetMOList, skillId)
	local targetCountExceptCharacter = 0

	if targetMOList then
		for _, targetMO in ipairs(targetMOList) do
			local targetEntityType = targetMO:getEntityType()

			if targetEntityType ~= ArcadeGameEnum.EntityType.Character then
				targetCountExceptCharacter = targetCountExceptCharacter + 1
			end
		end
	end

	local isAddScore = false
	local attackerEntityType = attackerMO:getEntityType()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local isCharacterAttack = attackerEntityType == ArcadeGameEnum.EntityType.Character

	if isCharacterAttack then
		isAddScore = true
	elseif attackerEntityType == ArcadeGameEnum.EntityType.Bomb then
		local bombId = ArcadeConfig.instance:getCharacterBomb(characterId)
		local attackBombId = attackerMO:getId()

		isAddScore = bombId == attackBombId
	end

	if isAddScore then
		local targetAddScore = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.TargetAddScore, true)
		local addScore = targetCountExceptCharacter * targetAddScore

		self:changeResCount(ArcadeGameEnum.CharacterResource.Score, addScore)
	end

	local changeEnergy = 0
	local isBasicAttack = attackType == ArcadeGameEnum.AttackType.Normal or attackType == ArcadeGameEnum.AttackType.Link

	if isCharacterAttack and attackType == ArcadeGameEnum.AttackType.Skill then
		local characterSkillId = ArcadeConfig.instance:getCharacterSkill(characterId)

		if skillId and characterSkillId == skillId then
			local curEnergy = characterMO and characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.SkillEnergy) or 0

			changeEnergy = -curEnergy
		end
	elseif isBasicAttack and targetCountExceptCharacter and targetCountExceptCharacter > 0 then
		local targetAddEnergy = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.TargetAddSkillEnergy, true)

		changeEnergy = targetCountExceptCharacter * targetAddEnergy
	end

	self:changeResCount(ArcadeGameEnum.CharacterResource.SkillEnergy, changeEnergy)
end

function ArcadeGameController:_enterDeathSettleFlow(entityMO, attackerMO)
	local isCanDead = entityMO and entityMO:getIsCanDead()

	if not isCanDead then
		return
	end

	local alreadyDead = entityMO:getIsDead()
	local curHP = entityMO:getHp()
	local isDead = curHP <= 0

	if alreadyDead or not isDead then
		return
	end

	ArcadeGameTriggerController.instance:deathTriggerTarget(ArcadeGameEnum.TriggerPoint.Death701, entityMO, attackerMO)
	entityMO:setIsDead(true)
	ArcadeGameTriggerController.instance:deathTriggerTarget(ArcadeGameEnum.TriggerPoint.Death702, entityMO, attackerMO)

	local entityType = entityMO:getEntityType()
	local uid = entityMO:getUid()

	if entityType == ArcadeGameEnum.EntityType.Monster then
		ArcadeGameModel.instance:addKillMonsterNum()
	end

	local scene = self:getGameScene()
	local entity = scene and scene.entityMgr:getEntityWithType(entityType, uid)
	local isCanRespawn = entityMO:getIsCanRespawn()

	if isCanRespawn then
		self:_enterRespawnFlow(entityMO, attackerMO)

		if entity then
			entity:playActionShow(ArcadeGameEnum.ActionShowId.Respawn)
		end
	elseif entityType == ArcadeGameEnum.EntityType.Character then
		self:endGame(ArcadeGameEnum.SettleType.Fail, false)
	else
		local hasCorpse = entityMO:getHasCorpse()

		if hasCorpse then
			if entity then
				entity:playActionShow(ArcadeGameEnum.ActionShowId.EnterDead)
			end
		else
			self:removeDeadEntityAndDrop(entityMO, true)
		end

		ArcadeGameTriggerController.instance:deathTriggerTarget(ArcadeGameEnum.TriggerPoint.DeathAtfer712, entityMO, attackerMO)
	end
end

local RESPAWN_COST = 1

function ArcadeGameController:_enterRespawnFlow(entityMO, attackerMO)
	if not entityMO then
		return
	end

	local hpCap = entityMO:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap)

	entityMO:setHp(hpCap)
	entityMO:setIsDead(false)
	self:changeResCount(ArcadeGameEnum.CharacterResource.RespawnTimes, -RESPAWN_COST)
	ArcadeGameTriggerController.instance:deathTriggerTarget(ArcadeGameEnum.TriggerPoint.DeathAtfer720, entityMO, attackerMO)
	self:dispatchEvent(ArcadeEvent.OnChangeEntityHp, entityMO, hpCap)
	ArcadeStatHelper.instance:AddUseRebornTimes()
end

function ArcadeGameController:resetGoods()
	local isCanReset = ArcadeGameModel.instance:getIsCanResetGoods()

	if not isCanReset then
		return
	end

	local curRoom = self:getCurRoom()

	if not curRoom or not curRoom.resetGoods then
		return
	end

	curRoom:resetGoods()

	local resetCost = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.ResetStoreCost)

	self:changeResCount(ArcadeGameEnum.CharacterResource.GameCoin, -resetCost)
	ArcadeGameModel.instance:addGoodsHasResetTimes()
end

function ArcadeGameController:isPlayerCanAct()
	local result = true
	local curRoom = self:getCurRoom()
	local isPlayerTurn = ArcadeGameModel.instance:getIsPlayerTurn()
	local isChangingRoom = ArcadeGameModel.instance:getIsChangingRoom()
	local isGamePause = ArcadeGameModel.instance:getIsPauseGame()
	local isGameEnd = ArcadeGameModel.instance:getIsEndGame()

	if not curRoom or not isPlayerTurn or isChangingRoom or isGamePause or isGameEnd then
		result = false
	end

	return result
end

function ArcadeGameController:beginPlayerTurn()
	ArcadeGameModel.instance:setIsPlayerTurn(true)
end

function ArcadeGameController:playerActOnDirection(direction)
	if not direction then
		return
	end

	local isPlayerCanAct = self:isPlayerCanAct()

	if not isPlayerCanAct then
		return
	end

	local targetGridEntityUid, targetGridEntityType, targetGridEntityMO
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local curGridX, curGridY = characterMO:getGridPos()
	local targetGridX = curGridX + (ArcadeEnum.DirChangeGridX[direction] or 0)
	local targetGridY = curGridY + (ArcadeEnum.DirChangeGridY[direction] or 0)

	if ArcadeGameHelper.isOutSideRoom(targetGridX, targetGridY) then
		return
	end

	local curRoom = self:getCurRoom()
	local entityData = curRoom:getEntityDataInTargetGrid(targetGridX, targetGridY)

	if entityData then
		targetGridEntityUid = entityData.uid
		targetGridEntityType = entityData.entityType
		targetGridEntityMO = ArcadeGameModel.instance:getMOWithType(targetGridEntityType, targetGridEntityUid)
	end

	if targetGridEntityType == ArcadeGameEnum.EntityType.Monster then
		local isDead = targetGridEntityMO and targetGridEntityMO:getIsDead()

		if isDead then
			self:removeDeadEntityAndDrop(targetGridEntityMO)
			self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.Move, {
				targetGridX = targetGridX,
				targetGridY = targetGridY,
				direction = direction
			})
		else
			self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.Attack, {
				entityType = targetGridEntityType,
				uid = targetGridEntityUid,
				direction = direction
			})
		end
	else
		self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.Move, {
			targetGridX = targetGridX,
			targetGridY = targetGridY,
			direction = direction
		})
	end
end

function ArcadeGameController:playerTryPlaceBomb()
	local isPlayerCanAct = self:isPlayerCanAct()

	if not isPlayerCanAct then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local bombCount = characterMO and characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.Bomb) or 0

	if bombCount <= 0 then
		GameFacade.showToast(ToastEnum.V3a3ArcadeGameNoBomb)

		return
	end

	local gridX, gridY = characterMO:getGridPos()

	self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.UseBomb, {
		targetGridX = gridX,
		targetGridY = gridY
	})
end

local PLACE_BOMB_COST = 1

function ArcadeGameController:placeBomb(bombId, targetGridX, targetGridY)
	self:changeResCount(ArcadeGameEnum.CharacterResource.Bomb, -PLACE_BOMB_COST)

	local sizeX, sizeY = ArcadeConfig.instance:getBombSize(bombId)
	local bombData = {
		entityType = ArcadeGameEnum.EntityType.Bomb,
		id = bombId,
		x = targetGridX,
		y = targetGridY,
		sizeX = sizeX,
		sizeY = sizeY
	}

	self:tryAddEntityList({
		bombData
	}, true)
	ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.Bomb502, ArcadeGameModel.instance:getCharacterMO(), {
		bombMO = bombData
	})
end

function ArcadeGameController:playerTryUseSkill()
	local isPlayerCanAct = self:isPlayerCanAct()

	if not isPlayerCanAct then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local curSkillEnergy = characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.SkillEnergy) or 0
	local characterId = characterMO:getId()
	local needEnergy = ArcadeConfig.instance:getCharacterSkillCost(characterId) or 0

	if needEnergy <= 0 or curSkillEnergy < needEnergy then
		GameFacade.showToast(ToastEnum.V3a3ArcadeGameNoSkillEnergy)

		return
	end

	local gridX, gridY = characterMO:getGridPos()

	self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.UseSkill, {
		targetGridX = gridX,
		targetGridY = gridY
	})
end

function ArcadeGameController:endPlayerTurn()
	ArcadeGameModel.instance:setIsPlayerTurn(false)
end

ArcadeGameController.instance = ArcadeGameController.New()

return ArcadeGameController
