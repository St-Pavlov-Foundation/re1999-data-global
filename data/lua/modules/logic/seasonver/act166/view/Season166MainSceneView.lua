module("modules.logic.seasonver.act166.view.Season166MainSceneView", package.seeall)

slot0 = class("Season166MainSceneView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._goTrainEntrance = gohelper.findChild(slot0.viewGO, "trainEntrance")
	slot0._gospotEntrance = gohelper.findChild(slot0.viewGO, "spotEntrance")
	slot0._goMainContent = gohelper.findChild(slot0.viewGO, "#go_mainContent")
	slot0._goTrainEpisodeContent = gohelper.findChild(slot0.viewGO, "trainEntrance/#go_episodeContent")
	slot0._goStarCollect = gohelper.findChild(slot0.viewGO, "starCollect")
	slot0._goTrainEntranceNew = gohelper.findChild(slot0.viewGO, "trainEntrance/Title/#go_trainEntranceNew")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.CloseBaseSpotView, slot0.playBaseSpotAnim, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OpenBaseSpotView, slot0.playBaseSpotAnim, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OpenTrainView, slot0.playTrainViewAnim, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.CloseTrainView, slot0.playTrainViewAnim, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.CloseBaseSpotView, slot0.playBaseSpotAnim, slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.OpenBaseSpotView, slot0.playBaseSpotAnim, slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.OpenTrainView, slot0.playTrainViewAnim, slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.CloseTrainView, slot0.playTrainViewAnim, slot0)
end

function slot0._editableInitView(slot0)
	slot0.viewAnim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.trainEntranceAnim = slot0._goTrainEntrance:GetComponent(gohelper.Type_Animator)
	slot0.basespotEntranceAnim = slot0._gospotEntrance:GetComponent(gohelper.Type_Animator)
	slot0.mainContentAnim = slot0._goMainContent:GetComponent(gohelper.Type_Animator)
	slot0.starCollectAnim = slot0._goStarCollect:GetComponent(gohelper.Type_Animator)
	slot0.trainEpisodeContentAnim = slot0._goTrainEpisodeContent:GetComponent(gohelper.Type_Animator)
	slot0.trainEpisodeContentCanvasGroup = slot0._goTrainEpisodeContent:GetComponent(gohelper.Type_CanvasGroup)
	slot0.spotEntranceCanvasGroup = slot0._gospotEntrance:GetComponent(gohelper.Type_CanvasGroup)
	slot0.mainContentCanvasGroup = slot0._goMainContent:GetComponent(gohelper.Type_CanvasGroup)
	slot0.trainLevelAlphaTab = {
		0,
		0.2,
		0.35,
		0.5,
		0.65,
		0.8,
		1
	}
	slot0.trainItemTab = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.sceneUrl = Season166Config.instance:getSeasonConstStr(slot0.actId, Season166Enum.MainSceneUrl)
	slot0.sceneGo = slot0.viewContainer:getResInst(slot0.sceneUrl, slot0._gobg, "SeasonBG")
	slot0.sceneTrans = slot0.sceneGo.transform
	slot0.sceneAnim = slot0.sceneGo:GetComponent(gohelper.Type_Animator)
	slot0.trainLevelBgCanvasGroup1 = gohelper.findChild(slot0.sceneGo, "#simage_building_5a2"):GetComponent(gohelper.Type_CanvasGroup)
	slot0.trainLevelBgCanvasGroup2 = gohelper.findChild(slot0.sceneGo, "#simage_building_5_1a"):GetComponent(gohelper.Type_CanvasGroup)

	gohelper.setActive(slot0._goStarCollect, false)
	gohelper.setActive(slot0._gospotEntrance, true)

	slot0.spotEntranceCanvasGroup.blocksRaycasts = true
	slot0.mainContentCanvasGroup.blocksRaycasts = true
	slot0.trainEpisodeContentCanvasGroup.blocksRaycasts = false
end

function slot0.playInViewAnim(slot0, slot1)
	slot0.jumpId = slot1
	slot0.isJump = slot1 and slot1 > 0

	slot0.viewAnim:Play(slot0.isJump and "open1" or "open", 0, 0)

	if not slot0.isJump then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_wulu_kerandian_enter_level)
	end
end

function slot0.playTrainAnim(slot0, slot1)
	if slot0.sceneAnim then
		slot0.sceneAnim:Play(slot1 and "inTrain" or "outTrain", 0, 0)
	else
		logError("self.sceneAnim is nil")
	end

	gohelper.setActive(slot0._goMainContent, true)
	gohelper.setActive(slot0._gospotEntrance, true)
	gohelper.setActive(slot0._goStarCollect, true)
	gohelper.setActive(slot0._goTrainEntranceNew, false)

	slot2 = slot0.isJump and 1 or 0

	slot0.trainEntranceAnim:Play(slot1 and "in" or "out", 0, slot2)
	slot0.mainContentAnim:Play(slot1 and "out" or "in", 0, slot2)
	slot0.basespotEntranceAnim:Play(slot1 and "in" or "out", 0, slot2)
	slot0.starCollectAnim:Play(slot1 and "in" or "out", 0, slot2)

	slot0.spotEntranceCanvasGroup.blocksRaycasts = not slot1
	slot0.mainContentCanvasGroup.blocksRaycasts = not slot1
	slot0.trainEpisodeContentCanvasGroup.blocksRaycasts = slot1

	TaskDispatcher.cancelTask(slot0.refreshItemUnlockState, slot0)

	if slot1 then
		if slot0.isJump and slot0.jumpId == Season166Enum.JumpId.TrainView then
			TaskDispatcher.runDelay(slot0.refreshTrainItemFinishEffect, slot0, 0.6)
		else
			slot0:refreshItemUnlockState()
		end
	else
		slot0:saveUnlockState()
		slot0:saveTrainItemFinishState()
	end
end

function slot0.playBaseSpotAnim(slot0, slot1)
	slot3 = slot1.baseSpotId

	if slot0.sceneAnim then
		slot0.sceneAnim:Play(slot1.isEnter and "inBaseSpot" .. slot3 or "outBaseSpot" .. slot3, 0, 0)
	else
		logError("self.sceneAnim is nil")
	end

	gohelper.setActive(slot0._goMainContent, true)
	gohelper.setActive(slot0._gospotEntrance, true)
	gohelper.setActive(slot0._goStarCollect, false)
	slot0.trainEntranceAnim:Play(slot2 and "close" or "open", 0, 0)
	slot0.basespotEntranceAnim:Play(slot2 and "in" or "out", 0, 0)
	slot0.mainContentAnim:Play(slot2 and "out" or "in", 0, 0)

	slot0.spotEntranceCanvasGroup.blocksRaycasts = not slot2
	slot0.mainContentCanvasGroup.blocksRaycasts = not slot2
	slot0.trainEpisodeContentCanvasGroup.blocksRaycasts = false
end

function slot0.playTrainViewAnim(slot0, slot1)
	if not slot0.sceneAnim then
		logError("self.sceneAnim is nil")

		return
	end

	slot0.trainEntranceAnim:Play(slot1.isEnter and "trainentrance_indetail" or "trainentrance_outdetail", 0, 0)
	slot0.sceneAnim:Play(slot2 and "inTrainView" or "outTrainView", 0, 0)
	slot0.trainEpisodeContentAnim:Play(slot2 and "out" or "in", 0, 0)
	slot0.starCollectAnim:Play(slot2 and "out" or "in", 0, 0)
	gohelper.setActive(slot0._goMainContent, false)
	gohelper.setActive(slot0._gospotEntrance, false)
	gohelper.setActive(slot0._goTrainEntranceNew, false)

	if slot0.isJump and slot0.jumpId == Season166Enum.JumpId.TrainEpisode then
		slot0.spotEntranceCanvasGroup.blocksRaycasts = not slot2
		slot0.mainContentCanvasGroup.blocksRaycasts = not slot2
		slot0.trainEpisodeContentCanvasGroup.blocksRaycasts = slot2

		slot0:refreshItemUnlockState()
		slot0:cleanJumpData()
	end
end

function slot0.playTrainEpisodeAnim(slot0, slot1)
	slot0.trainEpisodeContentAnim:Play(slot1 and "in" or "out", 0, 0)
end

function slot0.setTrainLevelBg(slot0)
	slot1 = Season166TrainModel.instance:getCurTrainPassCount(slot0.actId)
	slot0.trainLevelBgCanvasGroup1.alpha = slot0.trainLevelAlphaTab[slot1 + 1]
	slot0.trainLevelBgCanvasGroup2.alpha = slot0.trainLevelAlphaTab[slot1 + 1]
end

function slot0.setTrainItemTab(slot0, slot1)
	slot0.trainItemTab = slot1
end

function slot0.checkHasNewUnlock(slot0)
	for slot5, slot6 in pairs(slot0.trainItemTab) do
		if slot6.item:getUnlockState() == Season166Enum.UnlockState and slot8 ~= Season166Model.instance:getLocalUnlockState(Season166Enum.MainTrainLockSaveKey)[slot5] then
			return true
		end
	end

	return false
end

function slot0.refreshTrainEntranceNew(slot0)
	gohelper.setActive(slot0._goTrainEntranceNew, slot0:checkHasNewUnlock())
end

function slot0.refreshItemUnlockState(slot0)
	for slot5, slot6 in pairs(slot0.trainItemTab) do
		if GameUtil.getTabLen(Season166Model.instance:getLocalUnlockState(Season166Enum.MainTrainLockSaveKey)) == 0 then
			slot6.item:refreshUnlockState(Season166Enum.LockState)
		else
			slot6.item:refreshUnlockState(slot1[slot5])
		end
	end

	slot0:saveUnlockState()
end

function slot0.saveUnlockState(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.trainItemTab) do
		table.insert(slot1, string.format("%s|%s", slot5, slot6.item:getUnlockState()))
	end

	Season166Controller.instance:savePlayerPrefs(Season166Enum.MainTrainLockSaveKey, cjson.encode(slot1))
end

function slot0.refreshTrainItemFinishEffect(slot0)
	for slot5, slot6 in pairs(slot0.trainItemTab) do
		if Season166Model.instance:getLocalPrefsTab(Season166Enum.MainTrainFinishSaveKey)[slot5] ~= 1 then
			slot6.item:playFinishEffect()
		end
	end

	slot0:saveTrainItemFinishState()
end

function slot0.saveTrainItemFinishState(slot0)
	for slot4, slot5 in pairs(slot0.trainItemTab) do
		Season166Model.instance:setLocalPrefsTab(Season166Enum.MainTrainFinishSaveKey, slot4, slot5.item:getFinishState() and 1 or 0)
	end
end

function slot0.cleanJumpData(slot0)
	slot0.isJump = false
	slot0.jumpId = 0
end

function slot0.onClose(slot0)
	slot0:saveUnlockState()
	slot0:saveTrainItemFinishState()
	TaskDispatcher.cancelTask(slot0.refreshItemUnlockState, slot0)
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0._sceneRoot)

	if slot0.sceneGo then
		gohelper.destroy(slot0.sceneGo)

		slot0.sceneGo = nil
	end

	if slot0._bgLoader then
		slot0._bgLoader:dispose()

		slot0._bgLoader = nil
	end
end

return slot0
