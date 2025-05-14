module("modules.logic.room.controller.RoomCritterController", package.seeall)

local var_0_0 = class("RoomCritterController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	if arg_3_0._isInitAddEvent then
		arg_3_0._isInitAddEvent = false

		CritterController.instance:unregisterCallback(CritterEvent.CritterTrainStarted, arg_3_0._onTrainEventStarted, arg_3_0)
		CritterController.instance:unregisterCallback(CritterEvent.CritterTrainFinished, arg_3_0._onTrainEventFinished, arg_3_0)
		CritterController.instance:unregisterCallback(CritterEvent.TrainFinishTrainCritterReply, arg_3_0._startCheckTrainTask, arg_3_0)
		CritterController.instance:unregisterCallback(CritterEvent.TrainCancelTrainReply, arg_3_0._startCheckTrainTask, arg_3_0)
		CritterController.instance:unregisterCallback(CritterEvent.TrainStartTrainCritterReply, arg_3_0._startCheckTrainTask, arg_3_0)
	end

	arg_3_0._isHasCheckeTrainTask = false
	arg_3_0._isPlayTrainEventStory = false

	TaskDispatcher.cancelTask(arg_3_0._onRunCheckTrainTask, arg_3_0)
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.init(arg_5_0)
	if not arg_5_0._isInitAddEvent then
		arg_5_0._isInitAddEvent = true

		CritterController.instance:registerCallback(CritterEvent.CritterTrainStarted, arg_5_0._onTrainEventStarted, arg_5_0)
		CritterController.instance:registerCallback(CritterEvent.CritterTrainFinished, arg_5_0._onTrainEventFinished, arg_5_0)
		CritterController.instance:registerCallback(CritterEvent.TrainFinishTrainCritterReply, arg_5_0._startCheckTrainTask, arg_5_0)
		CritterController.instance:registerCallback(CritterEvent.TrainCancelTrainReply, arg_5_0._startCheckTrainTask, arg_5_0)
		CritterController.instance:registerCallback(CritterEvent.TrainStartTrainCritterReply, arg_5_0._startCheckTrainTask, arg_5_0)
	end

	arg_5_0._isPlayTrainEventStory = false
end

function var_0_0._onTrainEventStarted(arg_6_0)
	local var_6_0 = RoomCameraController.instance:getRoomScene()

	if var_6_0 and ViewMgr.instance:isOpen(ViewName.RoomCritterTrainStoryView) then
		gohelper.setActive(var_6_0.go.characterRoot, false)
		gohelper.setActive(var_6_0.go.critterRoot, false)

		arg_6_0._isPlayTrainEventStory = true
	end
end

function var_0_0._onTrainEventFinished(arg_7_0)
	local var_7_0 = RoomCameraController.instance:getRoomScene()

	if var_7_0 then
		gohelper.setActive(var_7_0.go.characterRoot, true)
		gohelper.setActive(var_7_0.go.critterRoot, true)
	end

	arg_7_0._isPlayTrainEventStory = false

	RoomCharacterController.instance:dispatchEvent(RoomEvent.PauseCharacterMove)
end

function var_0_0.getPlayingInteractionParam(arg_8_0)
	return arg_8_0._interactionParam
end

function var_0_0.setInteractionParam(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1 ~= 0 then
		arg_9_0._interactionParam = {
			heroId = arg_9_1
		}
	else
		arg_9_0._interactionParam = nil
	end
end

function var_0_0.isPlayTrainEventStory(arg_10_0)
	return arg_10_0._isPlayTrainEventStory
end

function var_0_0.initMapTrainCritter(arg_11_0)
	local var_11_0 = CritterModel.instance:getCultivatingCritters()
	local var_11_1 = RoomConfig.instance:getBlockPlacePositionCfgList()
	local var_11_2 = {}
	local var_11_3 = 0.001

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		table.insert(var_11_2, Vector3(iter_11_1.x * var_11_3, iter_11_1.y * var_11_3, iter_11_1.z * var_11_3))
	end

	RoomHelper.randomArray(var_11_2)

	local var_11_4 = #var_11_2

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_5 = var_11_2[(iter_11_2 - 1) % var_11_4 + 1]

		arg_11_0:_addMapTrainCritter(iter_11_3, var_11_5)
	end
end

function var_0_0._startCheckTrainTask(arg_12_0)
	if not arg_12_0._isHasCheckeTrainTask then
		arg_12_0._isHasCheckeTrainTask = true

		TaskDispatcher.runDelay(arg_12_0._onRunCheckTrainTask, arg_12_0, 0.1)
	end
end

function var_0_0._onRunCheckTrainTask(arg_13_0)
	arg_13_0._isHasCheckeTrainTask = false

	local var_13_0 = RoomCameraController.instance:getRoomScene()

	if not var_13_0 then
		return
	end

	arg_13_0:initMapTrainCritter()

	local var_13_1 = CritterModel.instance:getCultivatingCritters()
	local var_13_2 = {}
	local var_13_3 = {}
	local var_13_4

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_5 = iter_13_1.trainInfo.heroId
		local var_13_6 = iter_13_1.uid

		var_13_2[var_13_6] = true
		var_13_3[var_13_5] = true

		if var_13_0.charactermgr:getCharacterEntity(var_13_5, SceneTag.RoomCharacter) == nil then
			local var_13_7 = RoomCharacterModel.instance:getCharacterMOById(var_13_5)

			if var_13_7 then
				local var_13_8 = var_13_0.charactermgr:spawnRoomCharacter(var_13_7)

				var_13_4 = var_13_4 or {}

				table.insert(var_13_4, var_13_7)
			end
		end

		local var_13_9 = var_13_0.crittermgr:getCritterEntity(var_13_6, SceneTag.RoomCharacter)

		if var_13_9 == nil then
			local var_13_10 = RoomCritterModel.instance:getCritterMOById(var_13_6)

			if var_13_10 then
				var_13_9 = var_13_0.crittermgr:spawnRoomCritter(var_13_10)
			end
		end

		if var_13_9 then
			var_13_9.critterfollower:delaySetFollow()
		end
	end

	local var_13_11 = {}

	tabletool.addValues(var_13_11, RoomCritterModel.instance:getTrainCritterMOList())

	for iter_13_2, iter_13_3 in ipairs(var_13_11) do
		if not var_13_2[iter_13_3.uid] then
			local var_13_12 = var_13_0.crittermgr:getCritterEntity(iter_13_3.uid, SceneTag.RoomCharacter)

			if var_13_12 then
				var_13_0.crittermgr:destroyCritter(var_13_12)
			end

			RoomCritterModel.instance:removeTrainCritterMO(iter_13_3)
		end
	end

	local var_13_13 = {}

	tabletool.addValues(var_13_13, RoomCharacterModel.instance:getList())

	for iter_13_4, iter_13_5 in ipairs(var_13_13) do
		local var_13_14 = iter_13_5.id

		if iter_13_5:isTrainSourceState() and not var_13_3[var_13_14] then
			local var_13_15 = var_13_0.charactermgr:getCharacterEntity(var_13_14, SceneTag.RoomCharacter)

			if var_13_15 then
				var_13_0.charactermgr:destroyCharacter(var_13_15)
			end

			RoomCharacterModel.instance:deleteCharacterMO(var_13_14)
		end
	end

	if var_13_4 and #var_13_4 > 0 then
		RoomCharacterController.instance:tryRandomByCharacterList(var_13_4)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.SceneTrainChangeSpine)
end

function var_0_0._addMapTrainCritter(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1.trainInfo.heroId
	local var_14_1 = arg_14_1.uid
	local var_14_2 = RoomCritterModel.instance:getCritterMOById(var_14_1)

	if var_14_2 == nil then
		var_14_2 = RoomCritterMO.New()

		local var_14_3 = {
			uid = var_14_1,
			critterId = arg_14_1.defineId,
			skinId = arg_14_1:getSkinId(),
			currentPosition = arg_14_2
		}

		var_14_2:init(var_14_3)
		RoomCritterModel.instance:addAtLast(var_14_2)
	end

	var_14_2.characterId = var_14_0
	var_14_2.heroId = var_14_0

	local var_14_4 = RoomCharacterModel.instance:getCharacterMOById(var_14_0)

	if var_14_4 == nil then
		local var_14_5 = 0
		local var_14_6 = HeroModel.instance:getByHeroId(var_14_0)

		if var_14_6 then
			var_14_5 = var_14_6.skin
		else
			local var_14_7 = HeroConfig.instance:getHeroCO(var_14_0)

			if var_14_7 then
				var_14_5 = var_14_7.skinId
			end
		end

		var_14_4 = RoomCharacterMO.New()

		local var_14_8 = RoomInfoHelper.generateTrainCharacterInfo(var_14_0, arg_14_2, var_14_5)

		var_14_4:init(var_14_8)
		RoomCharacterModel.instance:addAtLast(var_14_4)
	end

	var_14_4.trainCritterUid = var_14_1
end

function var_0_0.showTrainSceneHero(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = RoomCameraController.instance:getRoomScene()

	if not var_15_0 then
		return
	end

	if not arg_15_1 then
		var_15_0.charactermgr:spawnTempCharacterByMO(nil)

		return
	end

	local var_15_1 = var_15_0.buildingmgr:getBuildingEntity(arg_15_2)
	local var_15_2 = 0
	local var_15_3 = 0
	local var_15_4 = 0

	if var_15_1 then
		local var_15_5 = var_15_1:getCritterPoint(arg_15_3)

		if var_15_5 then
			var_15_2, var_15_3, var_15_4 = transformhelper.getPos(var_15_5.transform)
		end
	end

	local var_15_6 = RoomCharacterModel.instance:getTrainTempMO()

	if var_15_6 and var_15_6.heroId ~= arg_15_1.heroId then
		local var_15_7 = RoomInfoHelper.generateTempCharacterInfo(arg_15_1.heroId, Vector3(var_15_2, var_15_3, var_15_4), arg_15_1.skinId)

		var_15_6:init(var_15_7)

		var_15_6.id = "train_" .. arg_15_1.heroId
	end

	var_15_0.charactermgr:spawnTempCharacterByMO(var_15_6):setLocalPos(var_15_2, var_15_3, var_15_4)
end

function var_0_0.showTrainSceneCritter(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = RoomCameraController.instance:getRoomScene()

	if not var_16_0 then
		return
	end

	if not arg_16_1 then
		var_16_0.crittermgr:spawnTempCritterByMO(nil)

		return
	end

	local var_16_1 = RoomCritterModel.instance:getTempCritterMO()
	local var_16_2 = arg_16_1:getSkinId()

	if var_16_1.skinId ~= var_16_2 then
		local var_16_3 = {
			uid = "train_" .. var_16_2,
			critterId = arg_16_1:getDefineId(),
			skinId = var_16_2
		}

		var_16_1:init(var_16_3)
	end

	local var_16_4 = var_16_0.crittermgr:spawnTempCritterByMO(var_16_1)
	local var_16_5 = var_16_0.buildingmgr:getBuildingEntity(arg_16_2)

	if var_16_5 then
		local var_16_6 = var_16_5:getCritterPoint(arg_16_3)

		if var_16_6 then
			local var_16_7, var_16_8, var_16_9 = transformhelper.getPos(var_16_6.transform)

			var_16_4:setLocalPos(var_16_7, var_16_8, var_16_9)
		end
	end
end

function var_0_0.openTrainAccelerateView(arg_17_0, arg_17_1)
	ViewMgr.instance:openView(ViewName.RoomTrainAccelerateView, {
		critterUid = arg_17_1
	})
end

function var_0_0.openTrainReporView(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	ViewMgr.instance:openView(ViewName.RoomCritterTrainReportView, {
		critterUid = arg_18_1,
		heroId = arg_18_2,
		tranNum = arg_18_3,
		finishCount = arg_18_3
	})
end

function var_0_0.openTrainEventView(arg_19_0, arg_19_1)
	ViewMgr.instance:openView(ViewName.RoomCritterTrainEventView, {
		critterUid = arg_19_1
	})
end

function var_0_0.openRenameView(arg_20_0, arg_20_1)
	local var_20_0 = CritterModel.instance:getCritterMOByUid(arg_20_1)

	if var_20_0 then
		ViewMgr.instance:openView(ViewName.RoomCritterRenameView, {
			critterMO = var_20_0
		})
	end
end

function var_0_0.openExchangeView(arg_21_0, arg_21_1)
	ViewMgr.instance:openView(ViewName.RoomCritterExchangeView, arg_21_1)
end

function var_0_0.sendCritterRename(arg_22_0, arg_22_1, arg_22_2)
	CritterRpc.instance:sendCritterRenameRequest(arg_22_1, arg_22_2, arg_22_0._onCritterRenameReply, arg_22_0)
end

function var_0_0._onCritterRenameReply(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2 == 0 then
		GameFacade.showToast(ToastEnum.RoomCritterRenameSuccess)
		ViewMgr.instance:closeView(ViewName.RoomCritterRenameView)
	end
end

function var_0_0.sendFinishTrainCritter(arg_24_0, arg_24_1)
	if not arg_24_0._lastSendFinishTrainCritterTime or arg_24_0._lastSendFinishTrainCritterTime + 3 < Time.time then
		arg_24_0._lastSendFinishTrainCritterTime = Time.time

		CritterRpc.instance:sendFinishTrainCritterRequest(arg_24_1, arg_24_0._onFinishTrainCritterReply, arg_24_0)
	end
end

function var_0_0._onFinishTrainCritterReply(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0._lastSendFinishTrainCritterTime = nil

	if arg_25_2 == 0 then
		var_0_0.instance:openTrainReporView(arg_25_3.uid, arg_25_3.heroId, arg_25_3.totalFinishCount)
	end
end

function var_0_0.sendFastForwardTrain(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	CritterRpc.instance:sendFastForwardTrainRequest(arg_26_1, arg_26_2, arg_26_3, arg_26_0._onFastForwardTrainReply, arg_26_0)
end

function var_0_0._onFastForwardTrainReply(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	return
end

function var_0_0.startTrain(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = CritterConfig.instance:getCritterTrainEventCfg(arg_28_1)

	if not var_28_0 then
		return
	end

	local var_28_1 = string.splitToNumber(var_28_0.cost, "#")
	local var_28_2 = var_28_1 and var_28_1[1]
	local var_28_3 = var_28_1 and var_28_1[2]
	local var_28_4 = var_28_1 and var_28_1[3]

	if var_28_4 and var_28_4 > 0 and var_28_4 > ItemModel.instance:getItemQuantity(var_28_2, var_28_3) then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainItemInsufficiency, MsgBoxEnum.BoxType.Yes_No, arg_28_0._onYesOpenTradeView, nil, nil, arg_28_0, nil, nil)

		return
	end

	if var_28_0.type == CritterEnum.EventType.Special then
		local var_28_5 = RoomConfig.instance:getCharacterInteractionConfig(var_28_0.roomDialogId)

		if var_28_5 then
			RoomCharacterController.instance:startDialogTrainCritter(var_28_5, arg_28_2, arg_28_3)
		else
			CritterController.instance:finishTrainSpecialEventByUid(arg_28_2)
		end
	elseif var_28_0.type == CritterEnum.EventType.ActiveTime then
		RoomTrainCritterModel.instance:clearSelectOptionInfos()

		local var_28_6 = CritterModel.instance:getCritterMOByUid(arg_28_2).trainInfo:getEvents(arg_28_1)

		RoomTrainCritterModel.instance:setOptionsSelectTotalCount(var_28_6.remainCount)

		if not RoomTrainCritterModel.instance:isEventTrainStoryPlayed(arg_28_3) then
			arg_28_0:_startEnterTrainWithStory(arg_28_1, arg_28_3, arg_28_2, var_28_0)
		else
			arg_28_0:_directEnterTrain(arg_28_1, arg_28_3, arg_28_2, var_28_0)
		end
	end

	return true
end

function var_0_0._onYesOpenTradeView(arg_29_0)
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function var_0_0._startEnterTrainWithStory(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	arg_30_0._trainData = {}
	arg_30_0._trainData.eventId = arg_30_1
	arg_30_0._trainData.heroId = arg_30_2
	arg_30_0._trainData.critterUid = arg_30_3
	arg_30_0._trainData.skipStory = false

	local var_30_0 = RoomTrainCritterModel.instance:getCritterTrainStory(arg_30_2, arg_30_4.initStoryId)
	local var_30_1 = {}

	var_30_1.hideStartAndEndDark = true
	var_30_1.hideBtn = true

	StoryController.instance:playStory(var_30_0, var_30_1)
	StoryController.instance:registerCallback(StoryEvent.StartFirstStep, arg_30_0._onStoryStart, arg_30_0)
end

function var_0_0._onStoryStart(arg_31_0)
	StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, arg_31_0._onStoryStart, arg_31_0)
	StoryController.instance:dispatchEvent(StoryEvent.HideTopBtns, true)
	StoryModel.instance:setNeedWaitStoryFinish(true)

	ViewMgr.instance:getSetting(ViewName.RoomCritterTrainStoryView).viewType = ViewType.Normal

	ViewMgr.instance:openView(ViewName.RoomCritterTrainStoryView, arg_31_0._trainData)
end

function var_0_0._directEnterTrain(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	arg_32_0._trainData = {}
	arg_32_0._trainData.eventId = arg_32_1
	arg_32_0._trainData.heroId = arg_32_2
	arg_32_0._trainData.critterUid = arg_32_3
	arg_32_0._trainData.skipStory = true
	ViewMgr.instance:getSetting(ViewName.RoomCritterTrainStoryView).viewType = ViewType.Normal

	ViewMgr.instance:openView(ViewName.RoomCritterTrainStoryView, arg_32_0._trainData)
end

function var_0_0.startAttributeResult(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	arg_33_0._trainData = {}
	arg_33_0._trainData.eventId = arg_33_1
	arg_33_0._trainData.heroId = arg_33_3
	arg_33_0._trainData.critterUid = arg_33_2

	local var_33_0 = CritterConfig.instance:getCritterHeroPreferenceCfg(arg_33_3)
	local var_33_1 = CritterConfig.instance:getCritterTrainEventCfg(arg_33_1)
	local var_33_2 = RoomTrainCritterModel.instance:getCritterTrainStory(arg_33_3, var_33_1.normalStoryId)

	if var_33_0.effectAttribute == arg_33_4 then
		var_33_2 = RoomTrainCritterModel.instance:getCritterTrainStory(arg_33_3, var_33_1.skilledStoryId)
	end

	local var_33_3 = {}

	var_33_3.hideStartAndEndDark = true
	var_33_3.hideBtn = true

	StoryController.instance:playStory(var_33_2, var_33_3)
	StoryController.instance:registerCallback(StoryEvent.StartFirstStep, arg_33_0._onStoryAttributeStart, arg_33_0)
end

function var_0_0._onStoryAttributeStart(arg_34_0)
	StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, arg_34_0._onStoryAttributeStart, arg_34_0)
	StoryController.instance:dispatchEvent(StoryEvent.HideTopBtns, true)
	StoryModel.instance:setNeedWaitStoryFinish(false)
	ViewMgr.instance:openView(ViewName.RoomCritterTrainStoryView, arg_34_0._trainData)
end

function var_0_0.endTrain(arg_35_0, arg_35_1)
	local var_35_0 = CritterConfig.instance:getCritterTrainEventCfg(arg_35_1)

	if not var_35_0 then
		return
	end

	if var_35_0.type == CritterEnum.EventType.Special then
		-- block empty
	elseif var_35_0.type == CritterEnum.EventType.ActiveTime then
		StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, arg_35_0._onStoryStart, arg_35_0)
		StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, arg_35_0._onStoryAttributeStart, arg_35_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
