-- chunkname: @modules/logic/summon/controller/SummonController.lua

module("modules.logic.summon.controller.SummonController", package.seeall)

local SummonController = class("SummonController", BaseController)

SummonController.SummonType = {
	SimulationPick = 2,
	Normal = 1
}

local s_sdkDataTrackLastPoolId

function SummonController:onInit()
	self.summonViewParam = nil
	self._lastViewPoolId = 0
	self._viewTime = nil
	self._lastPoolId = nil
	self.isWaitingSummonResult = false
	self._poolInfoParam = nil
	self._sendPoolId = nil
	self._isInGuideAnim = false
	self._isSkipInited = false
end

function SummonController:reInit()
	GameUtil.onDestroyViewMember(self, "_simpleFlow")

	self.summonViewParam = nil
	self._lastViewPoolId = 0
	self._viewTime = nil
	self._lastPoolId = nil
	self.isWaitingSummonResult = false
	self._poolInfoParam = nil
	self._sendPoolId = nil
	self._isInGuideAnim = false
	self._isSkipInited = false
	s_sdkDataTrackLastPoolId = nil
end

function SummonController:onInitFinish()
	return
end

function SummonController:addConstEvents()
	GuideController.instance:registerCallback(GuideEvent.SpecialEventStart, self._guideSpecialEventStart, self)
	self:registerCallback(SummonEvent.onSummonPoolHistorySummonRequest, self._onSummonPoolHistorySummonRequest, self)
end

function SummonController:_onSummonPoolHistorySummonRequest(poolId)
	SummonPoolHistoryModel.instance:addRequestHistoryPool(poolId)

	s_sdkDataTrackLastPoolId = poolId
end

function SummonController:_guideSpecialEventStart(eventEnum, guideId, stepId)
	if eventEnum == GuideEnum.SpecialEventEnum.SummonOpen then
		self:_playerGuideOpenAnimation()
	elseif eventEnum == GuideEnum.SpecialEventEnum.SummonFog then
		self:_playGuideWaterAnimation()
	elseif eventEnum == GuideEnum.SpecialEventEnum.SummonWheel then
		self:_playGuideWheelAnimation()
	elseif eventEnum == GuideEnum.SpecialEventEnum.SummonTouch then
		self:_guideTouch(guideId, stepId)
	end
end

function SummonController:jumpSummon(jumpPoolId)
	local param = {}

	param.jumpPoolId = jumpPoolId

	self:enterSummonScene(param)
end

function SummonController:jumpSummonByGroup(groupId)
	local param = {}

	param.jumpGroupId = groupId

	self:enterSummonScene(param)
end

function SummonController:enterSummonScene(param)
	self.summonViewParam = param or {}

	GameGCMgr.instance:dispatchEvent(GameGCEvent.CancelDelayFullGC)

	local needQuery = true

	if self:isInSummonGuide() then
		self.summonViewParam.jumpPoolId = SummonEnum.GuidePoolId
		needQuery = false
	end

	if not needQuery then
		ViewMgr.instance:openView(ViewName.SummonView)
		VirtualSummonScene.instance:openSummonScene(true)
	else
		SummonRpc.instance:sendGetSummonInfoRequest(self.jumpCheckWhenReceiveInfo, self)
	end
end

function SummonController:jumpCheckWhenReceiveInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if not LoginController.instance:isEnteredGame() then
		return
	end

	if self.summonViewParam ~= nil then
		if self:jumpCheckGroupParam() then
			return
		end

		if SummonMainModel.instance:hasPoolAvailable(self.summonViewParam.jumpPoolId) then
			SummonMainController.instance:openSummonView(self.summonViewParam, true, self.onSummonADOpened)

			return
		end
	end

	GameFacade.showToast(ToastEnum.SummonNoOpen)
end

function SummonController:jumpCheckGroupParam()
	if self.summonViewParam.jumpGroupId then
		local result = SummonMainModel.instance:hasPoolGroupAvailable(self.summonViewParam.jumpGroupId)

		if result then
			self.summonViewParam.jumpPoolId = result.id

			logNormal("jump group id = " .. tostring(result.id))
			SummonMainController.instance:openSummonView(self.summonViewParam, true, self.onSummonADOpened)

			return true
		end

		GameFacade.showToast(ToastEnum.SummonGroupNoOpen)

		return true
	end

	return false
end

function SummonController.onSummonADOpened()
	if not LoginController.instance:isEnteredGame() then
		return
	end

	VirtualSummonScene.instance:openSummonScene(false)
end

function SummonController:isPreloadReadyToSummon(isChar)
	local scene = VirtualSummonScene.instance:getSummonScene()

	return scene.director:isPreloadReady(isChar)
end

function SummonController:isSelectorReadyToSummon(isChar)
	local scene = VirtualSummonScene.instance:getSummonScene()

	return scene.selector:isSceneGOInited(isChar)
end

SummonController.GachaBlockKey = "SummonSuccessAnim"

function SummonController:summonSuccess(summonResult, callingType)
	local poolId = self:getSendPoolId()

	self.callingType = callingType or SummonEnum.SummonCallingType.Summon

	SummonModel.instance:updateSummonResult(summonResult, poolId)
	SummonPoolHistoryModel.instance:updateSummonResult(summonResult)

	local resultType = SummonMainModel.getResultTypeById(poolId)
	local isChar = resultType == SummonEnum.ResultType.Char

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(SummonController.GachaBlockKey)
	self:dispatchEvent(SummonEvent.summonShowExitAnim)

	if self:isSelectorReadyToSummon(isChar) and self:isPreloadReadyToSummon(isChar) then
		TaskDispatcher.runDelay(self.onExitSceneAnimFinish, self, 0.3)
		self:dispatchEvent(SummonEvent.summonShowBlackScreen)
	else
		logNormal("waiting for summon preload")
		self:dispatchEvent(SummonEvent.summonShowBlackScreen)
	end
end

function SummonController:getResultViewName()
	if self.callingType == SummonEnum.SummonCallingType.SummonSimulation then
		return ViewName.SummonSimulationResultView
	else
		return ViewName.SummonResultView
	end
end

function SummonController:closeBlockMask()
	UIBlockMgr.instance:endBlock(SummonController.GachaBlockKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function SummonController:onExitSceneAnimFinish()
	self:closeBlockMask()

	if SummonMainController.instance:getNeedGetInfo() then
		SummonRpc.instance:sendGetSummonInfoRequest()
	end

	self:dispatchEvent(SummonEvent.summonMainCloseImmediately)
	self:dispatchEvent(SummonEvent.onSummonReply)
end

function SummonController:onFirstLoadSceneBlock()
	if SummonMainController.instance:getNeedGetInfo() then
		SummonRpc.instance:sendGetSummonInfoRequest()
	end

	local resultType = SummonMainModel.getResultTypeById(self:getSendPoolId())
	local isChar = resultType == SummonEnum.ResultType.Char

	if not self:isPreloadReadyToSummon(isChar) then
		VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinishAtScene, self.onSummonPreloadFinish, self)
		VirtualSummonScene.instance:checkNeedLoad(isChar, true)
	elseif not self:isSelectorReadyToSummon(isChar) then
		local scene = VirtualSummonScene.instance:getSummonScene()

		scene.selector:initSceneGO(isChar)
		self:closeBlackLoading()
	end
end

function SummonController:onSummonPreloadFinish(targetIsChar)
	local resultType = SummonMainModel.getResultTypeById(self:getSendPoolId())
	local isChar = resultType == SummonEnum.ResultType.Char

	if isChar == targetIsChar then
		VirtualSummonScene.instance:unregisterCallback(SummonSceneEvent.OnPreloadFinishAtScene, self.onSummonPreloadFinish, self)

		if not self:isSelectorReadyToSummon(isChar) then
			local scene = VirtualSummonScene.instance:getSummonScene()

			scene.selector:initSceneGO(isChar)
		end

		logNormal("load SceneEnter completed")
		self:closeBlackLoading()
	end
end

function SummonController:closeBlackLoading()
	self:dispatchEvent(SummonEvent.summonCloseBlackScreen)
	self:dispatchEvent(SummonEvent.onSummonReply)
	self:closeBlockMask()
end

function SummonController:getSceneNode(nodePath)
	local scene = VirtualSummonScene.instance:getSummonScene()
	local sceneGO = scene.selector:getCurSceneGo()

	if sceneGO then
		return gohelper.findChild(sceneGO, nodePath)
	end
end

function SummonController:getAnim()
	local animGO = self:getSceneNode("anim")

	if not animGO then
		return
	end

	local anim = animGO:GetComponent(typeof(UnityEngine.Animator))

	return anim
end

function SummonController:getAnimEventWrap()
	local animGO = self:getSceneNode("anim")

	if not animGO then
		return
	end

	local animEventWrap = animGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	return animEventWrap
end

function SummonController:playAnim(name, layer, normalizedTime)
	local anim = self:getAnim()

	if not anim then
		return
	end

	anim.enabled = true

	if layer and normalizedTime then
		anim:Play(name, layer, normalizedTime)
	else
		anim:Play(name)
	end

	anim.speed = 1

	return anim
end

function SummonController:resetAnim(isOpen)
	local anim = self:getAnim()

	if not anim then
		return
	end

	anim.enabled = true

	local poolId = self:getLastPoolId()
	local resultType = SummonMainModel.getResultTypeById(poolId)
	local isGuide = self:isInSummonGuide()

	if isGuide and isOpen then
		if resultType == SummonEnum.ResultType.Char then
			anim:Play(SummonEnum.GuideInitialStateAnimationName, 0, 0)

			self._isInGuideAnim = true
		else
			anim:Play(SummonEnum.InitialStateEquipAnimationName, 0, 0)

			self._isInGuideAnim = false
		end
	elseif not isGuide then
		if resultType == SummonEnum.ResultType.Char then
			anim:Play(SummonEnum.InitialStateAnimationName, 0, 0)
		else
			anim:Play(SummonEnum.InitialStateEquipAnimationName, 0, 0)
		end

		self._isInGuideAnim = false
	end

	anim:Update(0)

	anim.speed = 0

	if not isOpen then
		local animEventWrap = self:getAnimEventWrap()

		if animEventWrap then
			animEventWrap:RemoveAllEventListener()
		end
	end

	local scene = VirtualSummonScene.instance:getSummonScene()
	local drawComp = scene.director:getDrawComp(resultType)

	if drawComp then
		drawComp:setEffect(1)
	end
end

function SummonController:startPlayAnim()
	local animEventWrap = self:getAnimEventWrap()

	if animEventWrap and not self:getIsGuideAnim() then
		animEventWrap:AddEventListener("show_guide", self.onSummonStartShowGuide, self)
		animEventWrap:AddEventListener("enter_finish", self.onSummonStartAnimFinish, self)
	end

	local anim = self:getAnim()

	if not anim then
		return
	end

	anim.enabled = true
	anim.speed = 1
end

function SummonController:onSummonStartShowGuide()
	self:dispatchEvent(SummonEvent.onSummonAnimShowGuide)
end

function SummonController:onSummonStartAnimFinish()
	self:dispatchEvent(SummonEvent.onSummonAnimEnterDraw)
end

function SummonController:forbidAnim()
	local anim = self:getAnim()

	if not anim then
		return
	end

	anim.enabled = false
end

function SummonController:resetAnimScale()
	local anim = self:getAnim()

	if not gohelper.isNil(anim) then
		transformhelper.setLocalScale(anim.transform, 1, 1, 1)
	end
end

function SummonController:drawAnim()
	self:playAnim(SummonEnum.TenAnimationName, 0, 0)

	local animEventWrap = self:getAnimEventWrap()

	if animEventWrap then
		animEventWrap:AddEventListener("rare_effect", self.onSummonAnimRareEffect, self)
		animEventWrap:AddEventListener("draw_end", self.onSummonAnimEnd, self)
	end
end

function SummonController:drawOnlyAnim()
	self:playAnim(SummonEnum.SingleAnimationName, 0, 0)

	local animEventWrap = self:getAnimEventWrap()

	if animEventWrap then
		animEventWrap:AddEventListener("rare_effect", self.onSummonAnimRareEffect, self)
		animEventWrap:AddEventListener("draw_end", self.onSummonAnimEnd, self)
	end
end

function SummonController:drawEquipAnim()
	self:playAnim(SummonEnum.EquipTenAnimationName, 0, 0)

	local animEventWrap = self:getAnimEventWrap()

	if animEventWrap then
		animEventWrap:AddEventListener("rare_effect", self.onSummonAnimRareEffect, self)
		animEventWrap:AddEventListener("draw_end", self.onSummonAnimEnd, self)
	end
end

function SummonController:drawEquipOnlyAnim()
	self:playAnim(SummonEnum.EquipSingleAnimationName, 0, 0)

	local animEventWrap = self:getAnimEventWrap()

	if animEventWrap then
		animEventWrap:AddEventListener("rare_effect", self.onSummonAnimRareEffect, self)
		animEventWrap:AddEventListener("draw_end", self.onSummonAnimEnd, self)
	end
end

function SummonController:playSkipAnimation(isChar)
	if isChar then
		self:playAnim(SummonEnum.SummonSkipCharacterAnimationName, 0, 0)
	else
		self:playAnim(SummonEnum.SummonSkipAnimationName, 0, 0)
	end
end

function SummonController:onSummonAnimRareEffect()
	self:dispatchEvent(SummonEvent.onSummonAnimRareEffect)
end

function SummonController:onSummonAnimEnd()
	self:dispatchEvent(SummonEvent.onSummonAnimEnd)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonDraw)
end

function SummonController:getUINodes()
	local uiNodes = {}
	local uiContainer = self:getSceneNode("anim/StandStill/UI")

	if uiContainer then
		local childNames = {
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
		}

		for i = 1, 10 do
			local uiNode = gohelper.findChild(uiContainer, childNames[i])

			table.insert(uiNodes, uiNode)
		end
	end

	return uiNodes
end

function SummonController:getOnlyUINode()
	local uiNodes = {}
	local uiContainer = self:getSceneNode("anim/StandStill/Only/UI")
	local uiNode = gohelper.findChild(uiContainer, "001")

	table.insert(uiNodes, uiNode)

	return uiNodes
end

function SummonController:getBoomNode(resultType)
	return self:getSceneNode(resultType == SummonEnum.ResultType.Equip and "anim/boom" or "anim/StandStill/boom")
end

function SummonController:statViewPoolDetail(poolId)
	self:statExitPoolDetail()

	if not poolId then
		return
	end

	self._viewTime = ServerTime.now()
	self._lastViewPoolId = poolId
end

function SummonController:statExitPoolDetail()
	if self._viewTime and self._lastViewPoolId then
		local lastViewPoolConfig = SummonConfig.instance:getSummonPool(self._lastViewPoolId)

		if lastViewPoolConfig then
			local duration = ServerTime.now() - self._viewTime

			StatController.instance:track(StatEnum.EventName.ClickPoolInfo, {
				[StatEnum.EventProperties.PoolId] = tonumber(self._lastViewPoolId),
				[StatEnum.EventProperties.PoolName] = lastViewPoolConfig.nameCn,
				[StatEnum.EventProperties.Time] = duration
			})
		end
	end

	self._viewTime = nil
	self._lastViewPoolId = nil
end

function SummonController:prepareSummon()
	self:resetAnim(true)
end

function SummonController:_playerGuideOpenAnimation()
	TaskDispatcher.runDelay(function(self)
		self:playAnim(SummonEnum.SummonOpenAnimationName, 0, 0)
	end, self, 0.3)

	local animEventWrap = self:getAnimEventWrap()

	if animEventWrap then
		animEventWrap:AddEventListener("anim_story01_end", function()
			GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonOpen)
		end, nil)
	end
end

function SummonController:_playGuideWaterAnimation()
	TaskDispatcher.runDelay(function(self)
		self:playAnim(SummonEnum.SummonFogAnimationName, 0, 0)
	end, self, 0.3)

	local animEventWrap = self:getAnimEventWrap()

	if animEventWrap then
		animEventWrap:AddEventListener("anim_story02_end", function()
			GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonFog)
		end, nil)
	end
end

function SummonController:_playGuideWheelAnimation()
	self:playAnim(SummonEnum.SummonWheelAnimationName, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_Chap0_SpinningWheel_Appear)

	local animEventWrap = self:getAnimEventWrap()

	if animEventWrap then
		animEventWrap:AddEventListener("anim_story03_end", function()
			GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonWheel)
		end, nil)
	end
end

function SummonController:_guideTouch(guideId, stepId)
	SummonModel.instance:setSendEquipFreeSummon(false)
	SummonRpc.instance:sendSummonRequest(SummonEnum.GuidePoolId, 1, guideId, stepId, self._guideTouchReply, self)
end

function SummonController:_guideTouchReply(cmd, resultCode, msg)
	if resultCode == 0 then
		GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonTouch)
	end
end

function SummonController:setLastPoolId(lastPoolId)
	self._lastPoolId = lastPoolId
end

function SummonController:getLastPoolId()
	return self._lastPoolId
end

function SummonController:setPoolInfo(param)
	self._poolInfoParam = param
end

function SummonController:getPoolInfo()
	return self._poolInfoParam
end

function SummonController:getIsGuideAnim()
	return self._isInGuideAnim
end

function SummonController:setSendPoolId(poolId)
	self._sendPoolId = poolId

	self:setLastPoolId(poolId)
end

function SummonController:getSendPoolId()
	return self._sendPoolId
end

function SummonController:updateSummonInfo(info)
	SummonModel.instance:setFreeEquipSummon(info.freeEquipSummon)
	SummonMainModel.instance:setNewbiePoolExist(info.isShowNewSummon)
	SummonMainModel.instance:setNewbieProgress(info.newSummonCount)
	SummonMainModel.instance:setServerPoolInfos(info.poolInfos)
	SummonMainModel.instance:updateByServerData()

	if SummonMainModel.instance:getCount() <= 0 then
		local errStr = "没有卡池定位 time = %s, cfgCount = %s, info = %s"
		local cfgList = SummonConfig.instance:getValidPoolList()

		if cfgList then
			logError(string.format(errStr, ServerTime.now(), #cfgList, tostring(info)))
		end
	end

	self:dispatchEvent(SummonEvent.onSummonInfoGot)
end

function SummonController:summonProgressRewards(msg)
	local poolMO = SummonMainModel.instance:getPoolServerMO(msg.poolId)

	if poolMO and poolMO.customPickMO then
		poolMO.customPickMO.hasGetRewardProgresses = msg.hasGetRewardProgresses or {}
	end

	self:dispatchEvent(SummonEvent.onSummonProgressRewards)
end

function SummonController:insertSummonPopupList(priority, viewName, param)
	self._popupParams = self._popupParams or {}

	local popupInfo = {
		priority = priority,
		viewName = viewName,
		param = param
	}

	table.insert(self._popupParams, popupInfo)
end

function SummonController:nextSummonPopupParam()
	if self._popupParams then
		local len = #self._popupParams

		if len > 0 then
			local info = table.remove(self._popupParams, 1)

			PopupController.instance:addPopupView(info.priority, info.viewName, info.param)

			return true
		end
	end

	return false
end

function SummonController:clearSummonPopupList()
	self._popupParams = {}
end

function SummonController.getCharScenePrefabPath()
	return SummonEnum.SummonCharScenePath
end

function SummonController:isInSummonGuide()
	return GuideController.instance:isGuiding() and SummonEnum.GuideIdSet[GuideModel.instance:getDoingGuideId()]
end

function SummonController:doVirtualSummonBehavior(heroIds, haveGetReward, hideADView, callBack, callBackObj, needAutoCloseBlur)
	if not heroIds then
		return
	end

	local resultLength = #heroIds

	if resultLength <= 0 then
		return
	end

	local param = {
		hideADView = hideADView,
		jumpPoolId = SummonEnum.PoolId.Normal
	}

	self:enterSummonScene(param)

	local result = self:getVirtualSummonResult(heroIds, false, haveGetReward)

	self:summonSuccess(result, SummonEnum.SummonCallingType.SummonSimulation)
	SummonController.instance:setSummonEndOpenCallBack(callBack, callBackObj)

	if needAutoCloseBlur then
		TaskDispatcher.runDelay(self.autoCloseBlur, self, 1.5)
	end
end

function SummonController:autoCloseBlur()
	TaskDispatcher.cancelTask(self.autoCloseBlur, self)
	UIBlockMgr.instance:endAll()
	PostProcessingMgr.instance:forceRefreshCloseBlur()
end

function SummonController:getVirtualSummonResult(heroIds, sort, haveGetReward)
	sort = sort or false

	local result = {}

	if not heroIds then
		return result
	end

	local resultLength = #heroIds

	if resultLength <= 0 then
		return result
	end

	local tempDuplicateCountDic = {}
	local tempRewardCountDic = {}

	for i = 1, resultLength do
		local heroId = heroIds[i]

		if tempRewardCountDic[heroId] then
			local rewardCount = tempRewardCountDic[heroId]

			tempRewardCountDic[heroId] = rewardCount + 1
		else
			tempRewardCountDic[heroId] = 1
		end
	end

	for i = 1, resultLength do
		local heroId = heroIds[i]
		local haveHero = self:haveHero(heroId)
		local duplicateCount = self:getHeroDuplicateCount(heroId)

		if haveGetReward then
			local rewardCount = tempRewardCountDic[heroId]

			duplicateCount = math.max(0, duplicateCount - rewardCount)
			haveHero = duplicateCount > 0
		end

		if tempDuplicateCountDic[heroId] then
			duplicateCount = tempDuplicateCountDic[heroId] + 1
			tempDuplicateCountDic[heroId] = duplicateCount
		else
			tempDuplicateCountDic[heroId] = duplicateCount
		end

		local tempNew = not haveHero
		local summonResult = {}

		summonResult.heroId = heroId
		summonResult.duplicateCount = duplicateCount
		summonResult.isNew = tempNew

		table.insert(result, summonResult)
	end

	if sort then
		SummonModel.sortResult(result, nil)
	end

	return result
end

function SummonController:haveHero(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local haveHero = heroMo ~= nil and heroMo.exSkillLevel >= 0

	return haveHero
end

function SummonController:getHeroDuplicateCount(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if heroMo then
		return heroMo.duplicateCount + 1
	end

	return 0
end

function SummonController:getSummonEndOpenCallBack()
	return self.summonEndOpenCallBack
end

function SummonController:setSummonEndOpenCallBack(callBack, callBackObj)
	if self.summonEndOpenCallBack then
		LuaGeneralCallback.getPool():putObject(self.summonEndOpenCallBack)

		self.summonEndOpenCallBack = nil
	end

	if callBack ~= nil and callBackObj ~= nil then
		local luaCb = LuaGeneralCallback.getPool():getObject()

		luaCb.callback = callBack

		luaCb:setCbObj(callBackObj)

		self.summonEndOpenCallBack = luaCb
	end
end

function SummonController:getLimitedHeroSkinIdsByPopupParam()
	if not self._popupParams then
		return
	end

	local limitedHeroSkinIDs = {}

	if #self._popupParams <= 0 then
		for index = 1, 10 do
			local summonResultMO, duplicateCount = SummonModel.instance:openSummonResult(index)

			if summonResultMO then
				local heroId = summonResultMO.heroId
				local mvskinId = self:getMvSkinIdByHeroId(heroId)

				if mvskinId then
					limitedHeroSkinIDs[heroId] = mvskinId
				end
			end
		end
	end

	for i = 1, #self._popupParams do
		local info = self._popupParams[i]

		if info.viewName == ViewName.CharacterGetView then
			local heroId = info.param.heroId
			local mvskinId = self:getMvSkinIdByHeroId(heroId)

			if mvskinId then
				limitedHeroSkinIDs[heroId] = mvskinId
			end
		end
	end

	return limitedHeroSkinIDs
end

function SummonController:getMvSkinIdByHeroId(heroId)
	if VersionValidator.instance:isInReviewing() then
		return nil
	end

	if not heroId then
		return nil
	end

	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if heroMo and heroMo.config then
		local heroCo = heroMo.config
		local limitedCO = lua_character_limited.configDict[heroCo.mvskinId]

		if heroCo and heroCo.mvskinId and limitedCO and not string.nilorempty(limitedCO.entranceMv) then
			return heroCo.mvskinId
		end
	end

	return nil
end

function SummonController:_trackSummonClientEvent(poolid, entrance, position_list)
	SDKDataTrackMgr.instance:track("summon_client", {
		poolid = poolid or -1,
		entrance = entrance or "",
		position_list = position_list or ""
	})
end

function SummonController:trackSummonClientEvent(isSkip, dragPosInfo)
	local poolId = s_sdkDataTrackLastPoolId
	local entrance = isSkip and "skip" or "rotate"
	local dragStartEndStr = ""

	if isSkip then
		if type(dragPosInfo) == "table" then
			local st = dragPosInfo.st
			local x = string.format("%0.2f", st.x)
			local y = string.format("%0.2f", st.y)

			dragStartEndStr = string.format("[(%s, %s)]", x, y)
		end

		SummonController.instance:_trackSummonClientEvent(poolId, entrance, dragStartEndStr)
	else
		if type(dragPosInfo) == "table" then
			local st = dragPosInfo.st
			local ed = dragPosInfo.ed
			local x1 = string.format("%0.2f", st.x)
			local y1 = string.format("%0.2f", st.y)
			local x2 = string.format("%0.2f", ed.x)
			local y2 = string.format("%0.2f", ed.y)

			dragStartEndStr = string.format("[(%s, %s), (%s, %s)]", x1, y1, x2, y2)
		end

		SummonController.instance:_trackSummonClientEvent(poolId, entrance, dragStartEndStr)
	end
end

function SummonController:simpleEnterSummonScene(heroIdList, backToMainSceneCallBack)
	GameUtil.onDestroyViewMember(self, "_simpleFlow")

	self._simpleFlow = VirtualSummonBehaviorFlow.New()

	self._simpleFlow:start(heroIdList, backToMainSceneCallBack)
end

SummonController.instance = SummonController.New()

return SummonController
