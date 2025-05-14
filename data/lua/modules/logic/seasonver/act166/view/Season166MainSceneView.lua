module("modules.logic.seasonver.act166.view.Season166MainSceneView", package.seeall)

local var_0_0 = class("Season166MainSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._goTrainEntrance = gohelper.findChild(arg_1_0.viewGO, "trainEntrance")
	arg_1_0._gospotEntrance = gohelper.findChild(arg_1_0.viewGO, "spotEntrance")
	arg_1_0._goMainContent = gohelper.findChild(arg_1_0.viewGO, "#go_mainContent")
	arg_1_0._goTrainEpisodeContent = gohelper.findChild(arg_1_0.viewGO, "trainEntrance/#go_episodeContent")
	arg_1_0._goStarCollect = gohelper.findChild(arg_1_0.viewGO, "starCollect")
	arg_1_0._goTrainEntranceNew = gohelper.findChild(arg_1_0.viewGO, "trainEntrance/Title/#go_trainEntranceNew")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.CloseBaseSpotView, arg_2_0.playBaseSpotAnim, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OpenBaseSpotView, arg_2_0.playBaseSpotAnim, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OpenTrainView, arg_2_0.playTrainViewAnim, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.CloseTrainView, arg_2_0.playTrainViewAnim, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Season166Controller.instance, Season166Event.CloseBaseSpotView, arg_3_0.playBaseSpotAnim, arg_3_0)
	arg_3_0:removeEventCb(Season166Controller.instance, Season166Event.OpenBaseSpotView, arg_3_0.playBaseSpotAnim, arg_3_0)
	arg_3_0:removeEventCb(Season166Controller.instance, Season166Event.OpenTrainView, arg_3_0.playTrainViewAnim, arg_3_0)
	arg_3_0:removeEventCb(Season166Controller.instance, Season166Event.CloseTrainView, arg_3_0.playTrainViewAnim, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.viewAnim = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_4_0.trainEntranceAnim = arg_4_0._goTrainEntrance:GetComponent(gohelper.Type_Animator)
	arg_4_0.basespotEntranceAnim = arg_4_0._gospotEntrance:GetComponent(gohelper.Type_Animator)
	arg_4_0.mainContentAnim = arg_4_0._goMainContent:GetComponent(gohelper.Type_Animator)
	arg_4_0.starCollectAnim = arg_4_0._goStarCollect:GetComponent(gohelper.Type_Animator)
	arg_4_0.trainEpisodeContentAnim = arg_4_0._goTrainEpisodeContent:GetComponent(gohelper.Type_Animator)
	arg_4_0.trainEpisodeContentCanvasGroup = arg_4_0._goTrainEpisodeContent:GetComponent(gohelper.Type_CanvasGroup)
	arg_4_0.spotEntranceCanvasGroup = arg_4_0._gospotEntrance:GetComponent(gohelper.Type_CanvasGroup)
	arg_4_0.mainContentCanvasGroup = arg_4_0._goMainContent:GetComponent(gohelper.Type_CanvasGroup)
	arg_4_0.trainLevelAlphaTab = {
		0,
		0.2,
		0.35,
		0.5,
		0.65,
		0.8,
		1
	}
	arg_4_0.trainItemTab = arg_4_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.actId = arg_6_0.viewParam.actId
	arg_6_0.sceneUrl = Season166Config.instance:getSeasonConstStr(arg_6_0.actId, Season166Enum.MainSceneUrl)
	arg_6_0.sceneGo = arg_6_0.viewContainer:getResInst(arg_6_0.sceneUrl, arg_6_0._gobg, "SeasonBG")
	arg_6_0.sceneTrans = arg_6_0.sceneGo.transform
	arg_6_0.sceneAnim = arg_6_0.sceneGo:GetComponent(gohelper.Type_Animator)
	arg_6_0.trainLevelBgCanvasGroup1 = gohelper.findChild(arg_6_0.sceneGo, "#simage_building_5a2"):GetComponent(gohelper.Type_CanvasGroup)
	arg_6_0.trainLevelBgCanvasGroup2 = gohelper.findChild(arg_6_0.sceneGo, "#simage_building_5_1a"):GetComponent(gohelper.Type_CanvasGroup)

	gohelper.setActive(arg_6_0._goStarCollect, false)
	gohelper.setActive(arg_6_0._gospotEntrance, true)

	arg_6_0.spotEntranceCanvasGroup.blocksRaycasts = true
	arg_6_0.mainContentCanvasGroup.blocksRaycasts = true
	arg_6_0.trainEpisodeContentCanvasGroup.blocksRaycasts = false
end

function var_0_0.playInViewAnim(arg_7_0, arg_7_1)
	arg_7_0.jumpId = arg_7_1
	arg_7_0.isJump = arg_7_1 and arg_7_1 > 0

	arg_7_0.viewAnim:Play(arg_7_0.isJump and "open1" or "open", 0, 0)

	if not arg_7_0.isJump then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_wulu_kerandian_enter_level)
	end
end

function var_0_0.playTrainAnim(arg_8_0, arg_8_1)
	if arg_8_0.sceneAnim then
		arg_8_0.sceneAnim:Play(arg_8_1 and "inTrain" or "outTrain", 0, 0)
	else
		logError("self.sceneAnim is nil")
	end

	gohelper.setActive(arg_8_0._goMainContent, true)
	gohelper.setActive(arg_8_0._gospotEntrance, true)
	gohelper.setActive(arg_8_0._goStarCollect, true)
	gohelper.setActive(arg_8_0._goTrainEntranceNew, false)

	local var_8_0 = arg_8_0.isJump and 1 or 0

	arg_8_0.trainEntranceAnim:Play(arg_8_1 and "in" or "out", 0, var_8_0)
	arg_8_0.mainContentAnim:Play(arg_8_1 and "out" or "in", 0, var_8_0)
	arg_8_0.basespotEntranceAnim:Play(arg_8_1 and "in" or "out", 0, var_8_0)
	arg_8_0.starCollectAnim:Play(arg_8_1 and "in" or "out", 0, var_8_0)

	arg_8_0.spotEntranceCanvasGroup.blocksRaycasts = not arg_8_1
	arg_8_0.mainContentCanvasGroup.blocksRaycasts = not arg_8_1
	arg_8_0.trainEpisodeContentCanvasGroup.blocksRaycasts = arg_8_1

	TaskDispatcher.cancelTask(arg_8_0.refreshItemUnlockState, arg_8_0)

	if arg_8_1 then
		if arg_8_0.isJump and arg_8_0.jumpId == Season166Enum.JumpId.TrainView then
			TaskDispatcher.runDelay(arg_8_0.refreshTrainItemFinishEffect, arg_8_0, 0.6)
		else
			arg_8_0:refreshItemUnlockState()
		end
	else
		arg_8_0:saveUnlockState()
		arg_8_0:saveTrainItemFinishState()
	end
end

function var_0_0.playBaseSpotAnim(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.isEnter
	local var_9_1 = arg_9_1.baseSpotId
	local var_9_2 = var_9_0 and "inBaseSpot" .. var_9_1 or "outBaseSpot" .. var_9_1

	if arg_9_0.sceneAnim then
		arg_9_0.sceneAnim:Play(var_9_2, 0, 0)
	else
		logError("self.sceneAnim is nil")
	end

	gohelper.setActive(arg_9_0._goMainContent, true)
	gohelper.setActive(arg_9_0._gospotEntrance, true)
	gohelper.setActive(arg_9_0._goStarCollect, false)
	arg_9_0.trainEntranceAnim:Play(var_9_0 and "close" or "open", 0, 0)
	arg_9_0.basespotEntranceAnim:Play(var_9_0 and "in" or "out", 0, 0)
	arg_9_0.mainContentAnim:Play(var_9_0 and "out" or "in", 0, 0)

	arg_9_0.spotEntranceCanvasGroup.blocksRaycasts = not var_9_0
	arg_9_0.mainContentCanvasGroup.blocksRaycasts = not var_9_0
	arg_9_0.trainEpisodeContentCanvasGroup.blocksRaycasts = false
end

function var_0_0.playTrainViewAnim(arg_10_0, arg_10_1)
	if not arg_10_0.sceneAnim then
		logError("self.sceneAnim is nil")

		return
	end

	local var_10_0 = arg_10_1.isEnter

	arg_10_0.trainEntranceAnim:Play(var_10_0 and "trainentrance_indetail" or "trainentrance_outdetail", 0, 0)
	arg_10_0.sceneAnim:Play(var_10_0 and "inTrainView" or "outTrainView", 0, 0)
	arg_10_0.trainEpisodeContentAnim:Play(var_10_0 and "out" or "in", 0, 0)
	arg_10_0.starCollectAnim:Play(var_10_0 and "out" or "in", 0, 0)
	gohelper.setActive(arg_10_0._goMainContent, false)
	gohelper.setActive(arg_10_0._gospotEntrance, false)
	gohelper.setActive(arg_10_0._goTrainEntranceNew, false)

	if arg_10_0.isJump and arg_10_0.jumpId == Season166Enum.JumpId.TrainEpisode then
		arg_10_0.spotEntranceCanvasGroup.blocksRaycasts = not var_10_0
		arg_10_0.mainContentCanvasGroup.blocksRaycasts = not var_10_0
		arg_10_0.trainEpisodeContentCanvasGroup.blocksRaycasts = var_10_0

		arg_10_0:refreshItemUnlockState()
		arg_10_0:cleanJumpData()
	end
end

function var_0_0.playTrainEpisodeAnim(arg_11_0, arg_11_1)
	arg_11_0.trainEpisodeContentAnim:Play(arg_11_1 and "in" or "out", 0, 0)
end

function var_0_0.setTrainLevelBg(arg_12_0)
	local var_12_0 = Season166TrainModel.instance:getCurTrainPassCount(arg_12_0.actId)

	arg_12_0.trainLevelBgCanvasGroup1.alpha = arg_12_0.trainLevelAlphaTab[var_12_0 + 1]
	arg_12_0.trainLevelBgCanvasGroup2.alpha = arg_12_0.trainLevelAlphaTab[var_12_0 + 1]
end

function var_0_0.setTrainItemTab(arg_13_0, arg_13_1)
	arg_13_0.trainItemTab = arg_13_1
end

function var_0_0.checkHasNewUnlock(arg_14_0)
	local var_14_0 = Season166Model.instance:getLocalUnlockState(Season166Enum.MainTrainLockSaveKey)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.trainItemTab) do
		local var_14_1 = var_14_0[iter_14_0]
		local var_14_2 = iter_14_1.item:getUnlockState()

		if var_14_2 == Season166Enum.UnlockState and var_14_2 ~= var_14_1 then
			return true
		end
	end

	return false
end

function var_0_0.refreshTrainEntranceNew(arg_15_0)
	local var_15_0 = arg_15_0:checkHasNewUnlock()

	gohelper.setActive(arg_15_0._goTrainEntranceNew, var_15_0)
end

function var_0_0.refreshItemUnlockState(arg_16_0)
	local var_16_0 = Season166Model.instance:getLocalUnlockState(Season166Enum.MainTrainLockSaveKey)

	for iter_16_0, iter_16_1 in pairs(arg_16_0.trainItemTab) do
		if GameUtil.getTabLen(var_16_0) == 0 then
			iter_16_1.item:refreshUnlockState(Season166Enum.LockState)
		else
			local var_16_1 = var_16_0[iter_16_0]

			iter_16_1.item:refreshUnlockState(var_16_1)
		end
	end

	arg_16_0:saveUnlockState()
end

function var_0_0.saveUnlockState(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.trainItemTab) do
		local var_17_1 = iter_17_1.item:getUnlockState()
		local var_17_2 = string.format("%s|%s", iter_17_0, var_17_1)

		table.insert(var_17_0, var_17_2)
	end

	local var_17_3 = cjson.encode(var_17_0)

	Season166Controller.instance:savePlayerPrefs(Season166Enum.MainTrainLockSaveKey, var_17_3)
end

function var_0_0.refreshTrainItemFinishEffect(arg_18_0)
	local var_18_0 = Season166Model.instance:getLocalPrefsTab(Season166Enum.MainTrainFinishSaveKey)

	for iter_18_0, iter_18_1 in pairs(arg_18_0.trainItemTab) do
		if var_18_0[iter_18_0] ~= 1 then
			iter_18_1.item:playFinishEffect()
		end
	end

	arg_18_0:saveTrainItemFinishState()
end

function var_0_0.saveTrainItemFinishState(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.trainItemTab) do
		local var_19_0 = iter_19_1.item:getFinishState()

		Season166Model.instance:setLocalPrefsTab(Season166Enum.MainTrainFinishSaveKey, iter_19_0, var_19_0 and 1 or 0)
	end
end

function var_0_0.cleanJumpData(arg_20_0)
	arg_20_0.isJump = false
	arg_20_0.jumpId = 0
end

function var_0_0.onClose(arg_21_0)
	arg_21_0:saveUnlockState()
	arg_21_0:saveTrainItemFinishState()
	TaskDispatcher.cancelTask(arg_21_0.refreshItemUnlockState, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	gohelper.destroy(arg_22_0._sceneRoot)

	if arg_22_0.sceneGo then
		gohelper.destroy(arg_22_0.sceneGo)

		arg_22_0.sceneGo = nil
	end

	if arg_22_0._bgLoader then
		arg_22_0._bgLoader:dispose()

		arg_22_0._bgLoader = nil
	end
end

return var_0_0
