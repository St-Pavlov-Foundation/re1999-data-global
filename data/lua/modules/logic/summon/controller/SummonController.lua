module("modules.logic.summon.controller.SummonController", package.seeall)

slot0 = class("SummonController", BaseController)
slot0.SummonType = {
	SimulationPick = 2,
	Normal = 1
}
slot1 = nil

function slot0.onInit(slot0)
	slot0.summonViewParam = nil
	slot0._lastViewPoolId = 0
	slot0._viewTime = nil
	slot0._lastPoolId = nil
	slot0.isWaitingSummonResult = false
	slot0._poolInfoParam = nil
	slot0._sendPoolId = nil
	slot0._isInGuideAnim = false
	slot0._isSkipInited = false
end

function slot0.reInit(slot0)
	slot0.summonViewParam = nil
	slot0._lastViewPoolId = 0
	slot0._viewTime = nil
	slot0._lastPoolId = nil
	slot0.isWaitingSummonResult = false
	slot0._poolInfoParam = nil
	slot0._sendPoolId = nil
	slot0._isInGuideAnim = false
	slot0._isSkipInited = false
	uv0 = nil
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	GuideController.instance:registerCallback(GuideEvent.SpecialEventStart, slot0._guideSpecialEventStart, slot0)
	slot0:registerCallback(SummonEvent.onSummonPoolHistorySummonRequest, slot0._onSummonPoolHistorySummonRequest, slot0)
end

function slot0._onSummonPoolHistorySummonRequest(slot0, slot1)
	SummonPoolHistoryModel.instance:addRequestHistoryPool(slot1)

	uv0 = slot1
end

function slot0._guideSpecialEventStart(slot0, slot1, slot2, slot3)
	if slot1 == GuideEnum.SpecialEventEnum.SummonOpen then
		slot0:_playerGuideOpenAnimation()
	elseif slot1 == GuideEnum.SpecialEventEnum.SummonFog then
		slot0:_playGuideWaterAnimation()
	elseif slot1 == GuideEnum.SpecialEventEnum.SummonWheel then
		slot0:_playGuideWheelAnimation()
	elseif slot1 == GuideEnum.SpecialEventEnum.SummonTouch then
		slot0:_guideTouch(slot2, slot3)
	end
end

function slot0.jumpSummon(slot0, slot1)
	slot0:enterSummonScene({
		jumpPoolId = slot1
	})
end

function slot0.jumpSummonByGroup(slot0, slot1)
	slot0:enterSummonScene({
		jumpGroupId = slot1
	})
end

function slot0.enterSummonScene(slot0, slot1)
	slot0.summonViewParam = slot1 or {}

	GameGCMgr.instance:dispatchEvent(GameGCEvent.CancelDelayFullGC)

	slot2 = true

	if slot0:isInSummonGuide() then
		slot0.summonViewParam.jumpPoolId = SummonEnum.GuidePoolId
		slot2 = false
	end

	if not slot2 then
		ViewMgr.instance:openView(ViewName.SummonView)
		VirtualSummonScene.instance:openSummonScene(true)
	else
		SummonRpc.instance:sendGetSummonInfoRequest(slot0.jumpCheckWhenReceiveInfo, slot0)
	end
end

function slot0.jumpCheckWhenReceiveInfo(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	if not LoginController.instance:isEnteredGame() then
		return
	end

	if slot0.summonViewParam ~= nil then
		if slot0:jumpCheckGroupParam() then
			return
		end

		if SummonMainModel.instance:hasPoolAvailable(slot0.summonViewParam.jumpPoolId) then
			SummonMainController.instance:openSummonView(slot0.summonViewParam, true, slot0.onSummonADOpened)

			return
		end
	end

	GameFacade.showToast(ToastEnum.SummonNoOpen)
end

function slot0.jumpCheckGroupParam(slot0)
	if slot0.summonViewParam.jumpGroupId then
		if SummonMainModel.instance:hasPoolGroupAvailable(slot0.summonViewParam.jumpGroupId) then
			slot0.summonViewParam.jumpPoolId = slot1.id

			logNormal("jump group id = " .. tostring(slot1.id))
			SummonMainController.instance:openSummonView(slot0.summonViewParam, true, slot0.onSummonADOpened)

			return true
		end

		GameFacade.showToast(ToastEnum.SummonGroupNoOpen)

		return true
	end

	return false
end

function slot0.onSummonADOpened()
	if not LoginController.instance:isEnteredGame() then
		return
	end

	VirtualSummonScene.instance:openSummonScene(false)
end

function slot0.isPreloadReadyToSummon(slot0, slot1)
	return VirtualSummonScene.instance:getSummonScene().director:isPreloadReady(slot1)
end

function slot0.isSelectorReadyToSummon(slot0, slot1)
	return VirtualSummonScene.instance:getSummonScene().selector:isSceneGOInited(slot1)
end

slot0.GachaBlockKey = "SummonSuccessAnim"

function slot0.summonSuccess(slot0, slot1, slot2)
	slot3 = slot0:getSendPoolId()
	slot0.callingType = slot2 or SummonEnum.SummonCallingType.Summon

	SummonModel.instance:updateSummonResult(slot1, slot3)
	SummonPoolHistoryModel.instance:updateSummonResult(slot1)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(uv0.GachaBlockKey)
	slot0:dispatchEvent(SummonEvent.summonShowExitAnim)

	if slot0:isSelectorReadyToSummon(SummonMainModel.getResultTypeById(slot3) == SummonEnum.ResultType.Char) and slot0:isPreloadReadyToSummon(slot5) then
		TaskDispatcher.runDelay(slot0.onExitSceneAnimFinish, slot0, 0.3)
		slot0:dispatchEvent(SummonEvent.summonShowBlackScreen)
	else
		logNormal("waiting for summon preload")
		slot0:dispatchEvent(SummonEvent.summonShowBlackScreen)
	end
end

function slot0.getResultViewName(slot0)
	if slot0.callingType == SummonEnum.SummonCallingType.SummonSimulation then
		return ViewName.SummonSimulationResultView
	else
		return ViewName.SummonResultView
	end
end

function slot0.closeBlockMask(slot0)
	UIBlockMgr.instance:endBlock(uv0.GachaBlockKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onExitSceneAnimFinish(slot0)
	slot0:closeBlockMask()

	if SummonMainController.instance:getNeedGetInfo() then
		SummonRpc.instance:sendGetSummonInfoRequest()
	end

	slot0:dispatchEvent(SummonEvent.summonMainCloseImmediately)
	slot0:dispatchEvent(SummonEvent.onSummonReply)
end

function slot0.onFirstLoadSceneBlock(slot0)
	if SummonMainController.instance:getNeedGetInfo() then
		SummonRpc.instance:sendGetSummonInfoRequest()
	end

	if not slot0:isPreloadReadyToSummon(SummonMainModel.getResultTypeById(slot0:getSendPoolId()) == SummonEnum.ResultType.Char) then
		VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinishAtScene, slot0.onSummonPreloadFinish, slot0)
		VirtualSummonScene.instance:checkNeedLoad(slot2, true)
	elseif not slot0:isSelectorReadyToSummon(slot2) then
		VirtualSummonScene.instance:getSummonScene().selector:initSceneGO(slot2)
		slot0:closeBlackLoading()
	end
end

function slot0.onSummonPreloadFinish(slot0, slot1)
	if SummonMainModel.getResultTypeById(slot0:getSendPoolId()) == SummonEnum.ResultType.Char == slot1 then
		VirtualSummonScene.instance:unregisterCallback(SummonSceneEvent.OnPreloadFinishAtScene, slot0.onSummonPreloadFinish, slot0)

		if not slot0:isSelectorReadyToSummon(slot3) then
			VirtualSummonScene.instance:getSummonScene().selector:initSceneGO(slot3)
		end

		logNormal("load SceneEnter completed")
		slot0:closeBlackLoading()
	end
end

function slot0.closeBlackLoading(slot0)
	slot0:dispatchEvent(SummonEvent.summonCloseBlackScreen)
	slot0:dispatchEvent(SummonEvent.onSummonReply)
	slot0:closeBlockMask()
end

function slot0.getSceneNode(slot0, slot1)
	if VirtualSummonScene.instance:getSummonScene().selector:getCurSceneGo() then
		return gohelper.findChild(slot3, slot1)
	end
end

function slot0.getAnim(slot0)
	if not slot0:getSceneNode("anim") then
		return
	end

	return slot1:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.getAnimEventWrap(slot0)
	if not slot0:getSceneNode("anim") then
		return
	end

	return slot1:GetComponent(typeof(ZProj.AnimationEventWrap))
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	if not slot0:getAnim() then
		return
	end

	slot4.enabled = true

	if slot2 and slot3 then
		slot4:Play(slot1, slot2, slot3)
	else
		slot4:Play(slot1)
	end

	slot4.speed = 1

	return slot4
end

function slot0.resetAnim(slot0, slot1)
	if not slot0:getAnim() then
		return
	end

	slot2.enabled = true

	if slot0:isInSummonGuide() and slot1 then
		if SummonMainModel.getResultTypeById(slot0:getLastPoolId()) == SummonEnum.ResultType.Char then
			slot2:Play(SummonEnum.GuideInitialStateAnimationName, 0, 0)

			slot0._isInGuideAnim = true
		else
			slot2:Play(SummonEnum.InitialStateEquipAnimationName, 0, 0)

			slot0._isInGuideAnim = false
		end
	elseif not slot5 then
		if slot4 == SummonEnum.ResultType.Char then
			slot2:Play(SummonEnum.InitialStateAnimationName, 0, 0)
		else
			slot2:Play(SummonEnum.InitialStateEquipAnimationName, 0, 0)
		end

		slot0._isInGuideAnim = false
	end

	slot2:Update(0)

	slot2.speed = 0

	if not slot1 and slot0:getAnimEventWrap() then
		slot6:RemoveAllEventListener()
	end

	if VirtualSummonScene.instance:getSummonScene().director:getDrawComp(slot4) then
		slot7:setEffect(1)
	end
end

function slot0.startPlayAnim(slot0)
	if slot0:getAnimEventWrap() and not slot0:getIsGuideAnim() then
		slot1:AddEventListener("show_guide", slot0.onSummonStartShowGuide, slot0)
		slot1:AddEventListener("enter_finish", slot0.onSummonStartAnimFinish, slot0)
	end

	if not slot0:getAnim() then
		return
	end

	slot2.enabled = true
	slot2.speed = 1
end

function slot0.onSummonStartShowGuide(slot0)
	slot0:dispatchEvent(SummonEvent.onSummonAnimShowGuide)
end

function slot0.onSummonStartAnimFinish(slot0)
	slot0:dispatchEvent(SummonEvent.onSummonAnimEnterDraw)
end

function slot0.forbidAnim(slot0)
	if not slot0:getAnim() then
		return
	end

	slot1.enabled = false
end

function slot0.resetAnimScale(slot0)
	if not gohelper.isNil(slot0:getAnim()) then
		transformhelper.setLocalScale(slot1.transform, 1, 1, 1)
	end
end

function slot0.drawAnim(slot0)
	slot0:playAnim(SummonEnum.TenAnimationName, 0, 0)

	if slot0:getAnimEventWrap() then
		slot1:AddEventListener("rare_effect", slot0.onSummonAnimRareEffect, slot0)
		slot1:AddEventListener("draw_end", slot0.onSummonAnimEnd, slot0)
	end
end

function slot0.drawOnlyAnim(slot0)
	slot0:playAnim(SummonEnum.SingleAnimationName, 0, 0)

	if slot0:getAnimEventWrap() then
		slot1:AddEventListener("rare_effect", slot0.onSummonAnimRareEffect, slot0)
		slot1:AddEventListener("draw_end", slot0.onSummonAnimEnd, slot0)
	end
end

function slot0.drawEquipAnim(slot0)
	slot0:playAnim(SummonEnum.EquipTenAnimationName, 0, 0)

	if slot0:getAnimEventWrap() then
		slot1:AddEventListener("rare_effect", slot0.onSummonAnimRareEffect, slot0)
		slot1:AddEventListener("draw_end", slot0.onSummonAnimEnd, slot0)
	end
end

function slot0.drawEquipOnlyAnim(slot0)
	slot0:playAnim(SummonEnum.EquipSingleAnimationName, 0, 0)

	if slot0:getAnimEventWrap() then
		slot1:AddEventListener("rare_effect", slot0.onSummonAnimRareEffect, slot0)
		slot1:AddEventListener("draw_end", slot0.onSummonAnimEnd, slot0)
	end
end

function slot0.playSkipAnimation(slot0, slot1)
	if slot1 then
		slot0:playAnim(SummonEnum.SummonSkipCharacterAnimationName, 0, 0)
	else
		slot0:playAnim(SummonEnum.SummonSkipAnimationName, 0, 0)
	end
end

function slot0.onSummonAnimRareEffect(slot0)
	slot0:dispatchEvent(SummonEvent.onSummonAnimRareEffect)
end

function slot0.onSummonAnimEnd(slot0)
	slot0:dispatchEvent(SummonEvent.onSummonAnimEnd)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonDraw)
end

function slot0.getUINodes(slot0)
	slot1 = {}

	if slot0:getSceneNode("anim/StandStill/UI") then
		for slot7 = 1, 10 do
			table.insert(slot1, gohelper.findChild(slot2, ({
				"001",
				"002",
				"003",
				"004",
				"005",
				"006",
				"007",
				"008",
				"009",
				"010"
			})[slot7]))
		end
	end

	return slot1
end

function slot0.getOnlyUINode(slot0)
	slot1 = {}

	table.insert(slot1, gohelper.findChild(slot0:getSceneNode("anim/StandStill/Only/UI"), "001"))

	return slot1
end

function slot0.getBoomNode(slot0, slot1)
	return slot0:getSceneNode(slot1 == SummonEnum.ResultType.Equip and "anim/boom" or "anim/StandStill/boom")
end

function slot0.statViewPoolDetail(slot0, slot1)
	slot0:statExitPoolDetail()

	if not slot1 then
		return
	end

	slot0._viewTime = ServerTime.now()
	slot0._lastViewPoolId = slot1
end

function slot0.statExitPoolDetail(slot0)
	if slot0._viewTime and slot0._lastViewPoolId and SummonConfig.instance:getSummonPool(slot0._lastViewPoolId) then
		StatController.instance:track(StatEnum.EventName.ClickPoolInfo, {
			[StatEnum.EventProperties.PoolId] = tonumber(slot0._lastViewPoolId),
			[StatEnum.EventProperties.PoolName] = slot1.nameCn,
			[StatEnum.EventProperties.Time] = ServerTime.now() - slot0._viewTime
		})
	end

	slot0._viewTime = nil
	slot0._lastViewPoolId = nil
end

function slot0.prepareSummon(slot0)
	slot0:resetAnim(true)
end

function slot0._playerGuideOpenAnimation(slot0)
	TaskDispatcher.runDelay(function (slot0)
		slot0:playAnim(SummonEnum.SummonOpenAnimationName, 0, 0)
	end, slot0, 0.3)

	if slot0:getAnimEventWrap() then
		slot1:AddEventListener("anim_story01_end", function ()
			GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonOpen)
		end, nil)
	end
end

function slot0._playGuideWaterAnimation(slot0)
	TaskDispatcher.runDelay(function (slot0)
		slot0:playAnim(SummonEnum.SummonFogAnimationName, 0, 0)
	end, slot0, 0.3)

	if slot0:getAnimEventWrap() then
		slot1:AddEventListener("anim_story02_end", function ()
			GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonFog)
		end, nil)
	end
end

function slot0._playGuideWheelAnimation(slot0)
	slot0:playAnim(SummonEnum.SummonWheelAnimationName, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_Chap0_SpinningWheel_Appear)

	if slot0:getAnimEventWrap() then
		slot1:AddEventListener("anim_story03_end", function ()
			GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonWheel)
		end, nil)
	end
end

function slot0._guideTouch(slot0, slot1, slot2)
	SummonModel.instance:setSendEquipFreeSummon(false)
	SummonRpc.instance:sendSummonRequest(SummonEnum.GuidePoolId, 1, slot1, slot2, slot0._guideTouchReply, slot0)
end

function slot0._guideTouchReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonTouch)
	end
end

function slot0.setLastPoolId(slot0, slot1)
	slot0._lastPoolId = slot1
end

function slot0.getLastPoolId(slot0)
	return slot0._lastPoolId
end

function slot0.setPoolInfo(slot0, slot1)
	slot0._poolInfoParam = slot1
end

function slot0.getPoolInfo(slot0)
	return slot0._poolInfoParam
end

function slot0.getIsGuideAnim(slot0)
	return slot0._isInGuideAnim
end

function slot0.setSendPoolId(slot0, slot1)
	slot0._sendPoolId = slot1

	slot0:setLastPoolId(slot1)
end

function slot0.getSendPoolId(slot0)
	return slot0._sendPoolId
end

function slot0.updateSummonInfo(slot0, slot1)
	SummonModel.instance:setFreeEquipSummon(slot1.freeEquipSummon)
	SummonMainModel.instance:setNewbiePoolExist(slot1.isShowNewSummon)
	SummonMainModel.instance:setNewbieProgress(slot1.newSummonCount)
	SummonMainModel.instance:setServerPoolInfos(slot1.poolInfos)
	SummonMainModel.instance:updateByServerData()

	if SummonMainModel.instance:getCount() <= 0 then
		if SummonConfig.instance:getValidPoolList() then
			logError(string.format("没有卡池定位 time = %s, cfgCount = %s, info = %s", ServerTime.now(), #slot3, tostring(slot1)))
		end
	end

	slot0:dispatchEvent(SummonEvent.onSummonInfoGot)
end

function slot0.insertSummonPopupList(slot0, slot1, slot2, slot3)
	slot0._popupParams = slot0._popupParams or {}

	table.insert(slot0._popupParams, {
		priority = slot1,
		viewName = slot2,
		param = slot3
	})
end

function slot0.nextSummonPopupParam(slot0)
	if slot0._popupParams and #slot0._popupParams > 0 then
		slot2 = table.remove(slot0._popupParams, 1)

		PopupController.instance:addPopupView(slot2.priority, slot2.viewName, slot2.param)

		return true
	end

	return false
end

function slot0.clearSummonPopupList(slot0)
	slot0._popupParams = {}
end

function slot0.getCharScenePrefabPath()
	return SummonEnum.SummonCharScenePath
end

function slot0.isInSummonGuide(slot0)
	return GuideController.instance:isGuiding() and SummonEnum.GuideIdSet[GuideModel.instance:getDoingGuideId()]
end

function slot0.doVirtualSummonBehavior(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot1 then
		return
	end

	if #slot1 <= 0 then
		return
	end

	slot0:enterSummonScene({
		hideADView = slot3,
		jumpPoolId = SummonEnum.PoolId.Normal
	})
	slot0:summonSuccess(slot0:getVirtualSummonResult(slot1, false, slot2), SummonEnum.SummonCallingType.SummonSimulation)
	uv0.instance:setSummonEndOpenCallBack(slot4, slot5)

	if slot6 then
		TaskDispatcher.runDelay(slot0.autoCloseBlur, slot0, 1.5)
	end
end

function slot0.autoCloseBlur(slot0)
	TaskDispatcher.cancelTask(slot0.autoCloseBlur, slot0)
	UIBlockMgr.instance:endAll()
	PostProcessingMgr.instance:forceRefreshCloseBlur()
end

function slot0.getVirtualSummonResult(slot0, slot1, slot2, slot3)
	slot2 = slot2 or false

	if not slot1 then
		return {}
	end

	if #slot1 <= 0 then
		return slot4
	end

	slot6 = {}
	slot7 = {}

	for slot11 = 1, slot5 do
		if slot7[slot1[slot11]] then
			slot7[slot12] = slot7[slot12] + 1
		else
			slot7[slot12] = 1
		end
	end

	for slot11 = 1, slot5 do
		slot12 = slot1[slot11]
		slot13 = slot0:haveHero(slot12)

		if slot3 then
			slot13 = math.max(0, slot0:getHeroDuplicateCount(slot12) - slot7[slot12]) > 0
		end

		if slot6[slot12] then
			slot6[slot12] = slot6[slot12] + 1
		else
			slot6[slot12] = slot14
		end

		table.insert(slot4, {
			heroId = slot12,
			duplicateCount = slot14,
			isNew = not slot13
		})
	end

	if slot2 then
		SummonModel.sortResult(slot4, nil)
	end

	return slot4
end

function slot0.haveHero(slot0, slot1)
	return HeroModel.instance:getByHeroId(slot1) ~= nil and slot2.exSkillLevel >= 0
end

function slot0.getHeroDuplicateCount(slot0, slot1)
	if HeroModel.instance:getByHeroId(slot1) then
		return slot2.duplicateCount + 1
	end

	return 0
end

function slot0.getSummonEndOpenCallBack(slot0)
	return slot0.summonEndOpenCallBack
end

function slot0.setSummonEndOpenCallBack(slot0, slot1, slot2)
	if slot0.summonEndOpenCallBack then
		LuaGeneralCallback.getPool():putObject(slot0.summonEndOpenCallBack)

		slot0.summonEndOpenCallBack = nil
	end

	if slot1 ~= nil and slot2 ~= nil then
		slot3 = LuaGeneralCallback.getPool():getObject()
		slot3.callback = slot1

		slot3:setCbObj(slot2)

		slot0.summonEndOpenCallBack = slot3
	end
end

function slot0.getLimitedHeroSkinIdsByPopupParam(slot0)
	if not slot0._popupParams then
		return
	end

	slot1 = {}

	if #slot0._popupParams <= 0 then
		for slot5 = 1, 10 do
			slot6, slot7 = SummonModel.instance:openSummonResult(slot5)

			if slot6 and slot0:getMvSkinIdByHeroId(slot6.heroId) then
				slot1[slot8] = slot9
			end
		end
	end

	for slot5 = 1, #slot0._popupParams do
		if slot0._popupParams[slot5].viewName == ViewName.CharacterGetView and slot0:getMvSkinIdByHeroId(slot6.param.heroId) then
			slot1[slot7] = slot8
		end
	end

	return slot1
end

function slot0.getMvSkinIdByHeroId(slot0, slot1)
	if not slot1 then
		return nil
	end

	if HeroModel.instance:getByHeroId(slot1) and slot2.config then
		slot3 = slot2.config
		slot4 = lua_character_limited.configDict[slot3.mvskinId]

		if slot3 and slot3.mvskinId and slot4 and not string.nilorempty(slot4.entranceMv) then
			return slot3.mvskinId
		end
	end

	return nil
end

function slot0._trackSummonClientEvent(slot0, slot1, slot2, slot3)
	SDKDataTrackMgr.instance:track("summon_client", {
		poolid = slot1 or -1,
		entrance = slot2 or "",
		position_list = slot3 or ""
	})
end

function slot0.trackSummonClientEvent(slot0, slot1, slot2)
	slot3 = uv0
	slot4 = slot1 and "skip" or "rotate"
	slot5 = ""

	if slot1 then
		if type(slot2) == "table" then
			slot6 = slot2.st
			slot5 = string.format("[(%s, %s)]", string.format("%0.2f", slot6.x), string.format("%0.2f", slot6.y))
		end

		uv1.instance:_trackSummonClientEvent(slot3, slot4, slot5)
	else
		if type(slot2) == "table" then
			slot6 = slot2.st
			slot7 = slot2.ed
			slot5 = string.format("[(%s, %s), (%s, %s)]", string.format("%0.2f", slot6.x), string.format("%0.2f", slot6.y), string.format("%0.2f", slot7.x), string.format("%0.2f", slot7.y))
		end

		uv1.instance:_trackSummonClientEvent(slot3, slot4, slot5)
	end
end

slot0.instance = slot0.New()

return slot0
