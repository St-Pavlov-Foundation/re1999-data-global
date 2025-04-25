module("modules.logic.room.controller.RoomCritterController", package.seeall)

slot0 = class("RoomCritterController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	if slot0._isInitAddEvent then
		slot0._isInitAddEvent = false

		CritterController.instance:unregisterCallback(CritterEvent.CritterTrainStarted, slot0._onTrainEventStarted, slot0)
		CritterController.instance:unregisterCallback(CritterEvent.CritterTrainFinished, slot0._onTrainEventFinished, slot0)
		CritterController.instance:unregisterCallback(CritterEvent.TrainFinishTrainCritterReply, slot0._startCheckTrainTask, slot0)
		CritterController.instance:unregisterCallback(CritterEvent.TrainCancelTrainReply, slot0._startCheckTrainTask, slot0)
		CritterController.instance:unregisterCallback(CritterEvent.TrainStartTrainCritterReply, slot0._startCheckTrainTask, slot0)
	end

	slot0._isHasCheckeTrainTask = false
	slot0._isPlayTrainEventStory = false

	TaskDispatcher.cancelTask(slot0._onRunCheckTrainTask, slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.init(slot0)
	if not slot0._isInitAddEvent then
		slot0._isInitAddEvent = true

		CritterController.instance:registerCallback(CritterEvent.CritterTrainStarted, slot0._onTrainEventStarted, slot0)
		CritterController.instance:registerCallback(CritterEvent.CritterTrainFinished, slot0._onTrainEventFinished, slot0)
		CritterController.instance:registerCallback(CritterEvent.TrainFinishTrainCritterReply, slot0._startCheckTrainTask, slot0)
		CritterController.instance:registerCallback(CritterEvent.TrainCancelTrainReply, slot0._startCheckTrainTask, slot0)
		CritterController.instance:registerCallback(CritterEvent.TrainStartTrainCritterReply, slot0._startCheckTrainTask, slot0)
	end

	slot0._isPlayTrainEventStory = false
end

function slot0._onTrainEventStarted(slot0)
	if RoomCameraController.instance:getRoomScene() and ViewMgr.instance:isOpen(ViewName.RoomCritterTrainStoryView) then
		gohelper.setActive(slot1.go.characterRoot, false)
		gohelper.setActive(slot1.go.critterRoot, false)

		slot0._isPlayTrainEventStory = true
	end
end

function slot0._onTrainEventFinished(slot0)
	if RoomCameraController.instance:getRoomScene() then
		gohelper.setActive(slot1.go.characterRoot, true)
		gohelper.setActive(slot1.go.critterRoot, true)
	end

	slot0._isPlayTrainEventStory = false

	RoomCharacterController.instance:dispatchEvent(RoomEvent.PauseCharacterMove)
end

function slot0.getPlayingInteractionParam(slot0)
	return slot0._interactionParam
end

function slot0.setInteractionParam(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		slot0._interactionParam = {
			heroId = slot1
		}
	else
		slot0._interactionParam = nil
	end
end

function slot0.isPlayTrainEventStory(slot0)
	return slot0._isPlayTrainEventStory
end

function slot0.initMapTrainCritter(slot0)
	slot1 = CritterModel.instance:getCultivatingCritters()
	slot3 = {}
	slot4 = 0.001

	for slot8, slot9 in ipairs(RoomConfig.instance:getBlockPlacePositionCfgList()) do
		table.insert(slot3, Vector3(slot9.x * slot4, slot9.y * slot4, slot9.z * slot4))
	end

	RoomHelper.randomArray(slot3)

	for slot9, slot10 in ipairs(slot1) do
		slot0:_addMapTrainCritter(slot10, slot3[(slot9 - 1) % #slot3 + 1])
	end
end

function slot0._startCheckTrainTask(slot0)
	if not slot0._isHasCheckeTrainTask then
		slot0._isHasCheckeTrainTask = true

		TaskDispatcher.runDelay(slot0._onRunCheckTrainTask, slot0, 0.1)
	end
end

function slot0._onRunCheckTrainTask(slot0)
	slot0._isHasCheckeTrainTask = false

	if not RoomCameraController.instance:getRoomScene() then
		return
	end

	slot0:initMapTrainCritter()

	slot3 = {
		[slot10.uid] = true
	}
	slot4 = {
		[slot11] = true
	}

	for slot9, slot10 in ipairs(CritterModel.instance:getCultivatingCritters()) do
		slot11 = slot10.trainInfo.heroId

		if slot1.charactermgr:getCharacterEntity(slot11, SceneTag.RoomCharacter) == nil and RoomCharacterModel.instance:getCharacterMOById(slot11) then
			slot13 = slot1.charactermgr:spawnRoomCharacter(slot14)

			table.insert(nil or {}, slot14)
		end

		if slot1.crittermgr:getCritterEntity(slot12, SceneTag.RoomCharacter) == nil and RoomCritterModel.instance:getCritterMOById(slot12) then
			slot14 = slot1.crittermgr:spawnRoomCritter(slot15)
		end

		if slot14 then
			slot14.critterfollower:delaySetFollow()
		end
	end

	slot6 = {}
	slot9 = RoomCritterModel.instance
	slot10 = slot9

	tabletool.addValues(slot6, slot9.getTrainCritterMOList(slot10))

	for slot10, slot11 in ipairs(slot6) do
		if not slot3[slot11.uid] then
			if slot1.crittermgr:getCritterEntity(slot11.uid, SceneTag.RoomCharacter) then
				slot1.crittermgr:destroyCritter(slot12)
			end

			RoomCritterModel.instance:removeTrainCritterMO(slot11)
		end
	end

	slot7 = {}
	slot10 = RoomCharacterModel.instance
	slot11 = slot10

	tabletool.addValues(slot7, slot10.getList(slot11))

	for slot11, slot12 in ipairs(slot7) do
		slot13 = slot12.id

		if slot12:isTrainSourceState() and not slot4[slot13] then
			if slot1.charactermgr:getCharacterEntity(slot13, SceneTag.RoomCharacter) then
				slot1.charactermgr:destroyCharacter(slot14)
			end

			RoomCharacterModel.instance:deleteCharacterMO(slot13)
		end
	end

	if slot5 and #slot5 > 0 then
		RoomCharacterController.instance:tryRandomByCharacterList(slot5)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.SceneTrainChangeSpine)
end

function slot0._addMapTrainCritter(slot0, slot1, slot2)
	slot3 = slot1.trainInfo.heroId

	if RoomCritterModel.instance:getCritterMOById(slot1.uid) == nil then
		slot5 = RoomCritterMO.New()

		slot5:init({
			uid = slot4,
			critterId = slot1.defineId,
			skinId = slot1:getSkinId(),
			currentPosition = slot2
		})
		RoomCritterModel.instance:addAtLast(slot5)
	end

	slot5.characterId = slot3
	slot5.heroId = slot3

	if RoomCharacterModel.instance:getCharacterMOById(slot3) == nil then
		slot7 = 0

		if HeroModel.instance:getByHeroId(slot3) then
			slot7 = slot8.skin
		elseif HeroConfig.instance:getHeroCO(slot3) then
			slot7 = slot9.skinId
		end

		slot6 = RoomCharacterMO.New()

		slot6:init(RoomInfoHelper.generateTrainCharacterInfo(slot3, slot2, slot7))
		RoomCharacterModel.instance:addAtLast(slot6)
	end

	slot6.trainCritterUid = slot4
end

function slot0.showTrainSceneHero(slot0, slot1, slot2, slot3)
	if not RoomCameraController.instance:getRoomScene() then
		return
	end

	if not slot1 then
		slot4.charactermgr:spawnTempCharacterByMO(nil)

		return
	end

	slot6 = 0
	slot7 = 0
	slot8 = 0

	if slot4.buildingmgr:getBuildingEntity(slot2) and slot5:getCritterPoint(slot3) then
		slot6, slot7, slot8 = transformhelper.getPos(slot9.transform)
	end

	if RoomCharacterModel.instance:getTrainTempMO() and slot9.heroId ~= slot1.heroId then
		slot9:init(RoomInfoHelper.generateTempCharacterInfo(slot1.heroId, Vector3(slot6, slot7, slot8), slot1.skinId))

		slot9.id = "train_" .. slot1.heroId
	end

	slot4.charactermgr:spawnTempCharacterByMO(slot9):setLocalPos(slot6, slot7, slot8)
end

function slot0.showTrainSceneCritter(slot0, slot1, slot2, slot3)
	if not RoomCameraController.instance:getRoomScene() then
		return
	end

	if not slot1 then
		slot4.crittermgr:spawnTempCritterByMO(nil)

		return
	end

	if RoomCritterModel.instance:getTempCritterMO().skinId ~= slot1:getSkinId() then
		slot5:init({
			uid = "train_" .. slot6,
			critterId = slot1:getDefineId(),
			skinId = slot6
		})
	end

	if slot4.buildingmgr:getBuildingEntity(slot2) and slot8:getCritterPoint(slot3) then
		slot10, slot11, slot12 = transformhelper.getPos(slot9.transform)

		slot4.crittermgr:spawnTempCritterByMO(slot5):setLocalPos(slot10, slot11, slot12)
	end
end

function slot0.openTrainAccelerateView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomTrainAccelerateView, {
		critterUid = slot1
	})
end

function slot0.openTrainReporView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.RoomCritterTrainReportView, {
		critterUid = slot1,
		heroId = slot2,
		tranNum = slot3,
		finishCount = slot3
	})
end

function slot0.openTrainEventView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomCritterTrainEventView, {
		critterUid = slot1
	})
end

function slot0.openRenameView(slot0, slot1)
	if CritterModel.instance:getCritterMOByUid(slot1) then
		ViewMgr.instance:openView(ViewName.RoomCritterRenameView, {
			critterMO = slot2
		})
	end
end

function slot0.openExchangeView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomCritterExchangeView, slot1)
end

function slot0.sendCritterRename(slot0, slot1, slot2)
	CritterRpc.instance:sendCritterRenameRequest(slot1, slot2, slot0._onCritterRenameReply, slot0)
end

function slot0._onCritterRenameReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		GameFacade.showToast(ToastEnum.RoomCritterRenameSuccess)
		ViewMgr.instance:closeView(ViewName.RoomCritterRenameView)
	end
end

function slot0.sendFinishTrainCritter(slot0, slot1)
	if not slot0._lastSendFinishTrainCritterTime or slot0._lastSendFinishTrainCritterTime + 3 < Time.time then
		slot0._lastSendFinishTrainCritterTime = Time.time

		CritterRpc.instance:sendFinishTrainCritterRequest(slot1, slot0._onFinishTrainCritterReply, slot0)
	end
end

function slot0._onFinishTrainCritterReply(slot0, slot1, slot2, slot3)
	slot0._lastSendFinishTrainCritterTime = nil

	if slot2 == 0 then
		uv0.instance:openTrainReporView(slot3.uid, slot3.heroId, slot3.totalFinishCount)
	end
end

function slot0.sendFastForwardTrain(slot0, slot1, slot2, slot3)
	CritterRpc.instance:sendFastForwardTrainRequest(slot1, slot2, slot3, slot0._onFastForwardTrainReply, slot0)
end

function slot0._onFastForwardTrainReply(slot0, slot1, slot2, slot3)
end

function slot0.startTrain(slot0, slot1, slot2, slot3)
	if not CritterConfig.instance:getCritterTrainEventCfg(slot1) then
		return
	end

	if slot5 and slot5[3] and slot8 > 0 and ItemModel.instance:getItemQuantity(string.splitToNumber(slot4.cost, "#") and slot5[1], slot5 and slot5[2]) < slot8 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainItemInsufficiency, MsgBoxEnum.BoxType.Yes_No, slot0._onYesOpenTradeView, nil, , slot0, nil, )

		return
	end

	if slot4.type == CritterEnum.EventType.Special then
		if RoomConfig.instance:getCharacterInteractionConfig(slot4.roomDialogId) then
			RoomCharacterController.instance:startDialogTrainCritter(slot9, slot2, slot3)
		else
			CritterController.instance:finishTrainSpecialEventByUid(slot2)
		end
	elseif slot4.type == CritterEnum.EventType.ActiveTime then
		RoomTrainCritterModel.instance:clearSelectOptionInfos()
		RoomTrainCritterModel.instance:setOptionsSelectTotalCount(CritterModel.instance:getCritterMOByUid(slot2).trainInfo:getEvents(slot1).remainCount)

		if not RoomTrainCritterModel.instance:isEventTrainStoryPlayed(slot3) then
			slot0:_startEnterTrainWithStory(slot1, slot3, slot2, slot4)
		else
			slot0:_directEnterTrain(slot1, slot3, slot2, slot4)
		end
	end

	return true
end

function slot0._onYesOpenTradeView(slot0)
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function slot0._startEnterTrainWithStory(slot0, slot1, slot2, slot3, slot4)
	slot0._trainData = {
		eventId = slot1,
		heroId = slot2,
		critterUid = slot3,
		skipStory = false
	}

	StoryController.instance:playStory(RoomTrainCritterModel.instance:getCritterTrainStory(slot2, slot4.initStoryId), {
		hideStartAndEndDark = true,
		hideBtn = true
	})
	StoryController.instance:registerCallback(StoryEvent.StartFirstStep, slot0._onStoryStart, slot0)
end

function slot0._onStoryStart(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, slot0._onStoryStart, slot0)
	StoryController.instance:dispatchEvent(StoryEvent.HideTopBtns, true)
	StoryModel.instance:setNeedWaitStoryFinish(true)

	ViewMgr.instance:getSetting(ViewName.RoomCritterTrainStoryView).viewType = ViewType.Normal

	ViewMgr.instance:openView(ViewName.RoomCritterTrainStoryView, slot0._trainData)
end

function slot0._directEnterTrain(slot0, slot1, slot2, slot3, slot4)
	slot0._trainData = {
		eventId = slot1,
		heroId = slot2,
		critterUid = slot3,
		skipStory = true
	}
	ViewMgr.instance:getSetting(ViewName.RoomCritterTrainStoryView).viewType = ViewType.Normal

	ViewMgr.instance:openView(ViewName.RoomCritterTrainStoryView, slot0._trainData)
end

function slot0.startAttributeResult(slot0, slot1, slot2, slot3, slot4)
	slot0._trainData = {
		eventId = slot1,
		heroId = slot3,
		critterUid = slot2
	}
	slot7 = RoomTrainCritterModel.instance:getCritterTrainStory(slot3, CritterConfig.instance:getCritterTrainEventCfg(slot1).normalStoryId)

	if CritterConfig.instance:getCritterHeroPreferenceCfg(slot3).effectAttribute == slot4 then
		slot7 = RoomTrainCritterModel.instance:getCritterTrainStory(slot3, slot6.skilledStoryId)
	end

	StoryController.instance:playStory(slot7, {
		hideStartAndEndDark = true,
		hideBtn = true
	})
	StoryController.instance:registerCallback(StoryEvent.StartFirstStep, slot0._onStoryAttributeStart, slot0)
end

function slot0._onStoryAttributeStart(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, slot0._onStoryAttributeStart, slot0)
	StoryController.instance:dispatchEvent(StoryEvent.HideTopBtns, true)
	StoryModel.instance:setNeedWaitStoryFinish(false)
	ViewMgr.instance:openView(ViewName.RoomCritterTrainStoryView, slot0._trainData)
end

function slot0.endTrain(slot0, slot1)
	if not CritterConfig.instance:getCritterTrainEventCfg(slot1) then
		return
	end

	if slot2.type == CritterEnum.EventType.Special then
		-- Nothing
	elseif slot2.type == CritterEnum.EventType.ActiveTime then
		StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, slot0._onStoryStart, slot0)
		StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, slot0._onStoryAttributeStart, slot0)
	end
end

slot0.instance = slot0.New()

return slot0
