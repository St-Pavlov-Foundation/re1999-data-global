-- chunkname: @modules/logic/summon/controller/SummonMainController.lua

module("modules.logic.summon.controller.SummonMainController", package.seeall)

local SummonMainController = class("SummonMainController", BaseController)

function SummonMainController:onInit()
	self:reInit()
end

function SummonMainController:reInit()
	self._pickHandlerMap = {
		[SummonEnum.TabContentIndex.CharNormal] = self.pickCharNormalRes,
		[SummonEnum.TabContentIndex.EquipNormal] = self.pickEquipNormalRes,
		[SummonEnum.TabContentIndex.CharNewbie] = self.pickCharNewbieRes,
		[SummonEnum.TabContentIndex.CharProbUp] = self.pickCharProbUpRes,
		[SummonEnum.TabContentIndex.EquipProbUp] = self.pickEquipProbUpRes
	}
end

function SummonMainController:onInitFinish()
	return
end

function SummonMainController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.handleDailyRefresh, self)
end

function SummonMainController:openSummonView(param, fromEnterScene, callback, callbackObj)
	SummonMainModel.instance:initCategory()
	SummonMainModel.instance:resetTabResSettings()
	SummonMainCategoryListModel.instance:initCategory()

	local jumpPoolId = param and param.jumpPoolId

	jumpPoolId = jumpPoolId or self:trySetDefaultPoolId(param)

	if jumpPoolId then
		SummonMainModel.instance:trySetSelectPoolId(jumpPoolId)
	end

	if param and param.jumpPoolId ~= nil and param.defaultTabIds == nil then
		local targetPool = SummonConfig.instance:getSummonPool(param.jumpPoolId)

		if targetPool then
			local tabIndex = SummonMainModel.instance:getADPageTabIndexForUI(targetPool)

			param.defaultTabIds = {}
			param.defaultTabIds[3] = tabIndex
		end
	end

	self._openByEnterScene = fromEnterScene

	logNormal("openSummonView jumpPoolId = " .. tostring(jumpPoolId))

	self._callbackOpen = callback
	self._callbackObjOpen = callbackObj

	ViewMgr.instance:openView(ViewName.SummonView)

	if param and param.hideADView then
		self:onViewOpened(ViewName.SummonADView)
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onViewOpened, self)
		ViewMgr.instance:openView(ViewName.SummonADView, param)
	end

	if SummonMainModel.equipPoolIsValid() and SummonModel.instance:getFreeEquipSummon() then
		SummonController.instance:dispatchEvent(SummonEvent.GuideEquipPool)
	end

	SummonModel.instance:clearCacheReward()
end

function SummonMainController:trySetDefaultPoolId(param)
	local jumpPoolId

	if param == nil or param.defaultTabIds == nil then
		local defaultPool = SummonMainModel.instance:getFirstValidPool()

		if defaultPool then
			jumpPoolId = defaultPool.id

			if param ~= nil then
				param.jumpPoolId = jumpPoolId
			end

			return jumpPoolId
		end
	end
end

function SummonMainController:onViewOpened(viewName)
	if viewName == ViewName.SummonADView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onViewOpened, self)

		if self._callbackOpen then
			self._callbackOpen(self._callbackObjOpen)
		end

		self._callbackOpen = nil
		self._callbackObjOpen = nil
	end
end

function SummonMainController:sendStartSummon(poolId, count, isFreeEquip, needGetInfo)
	SummonController.instance:setSendPoolId(poolId)

	self._needGetInfo = false

	if isFreeEquip then
		local isFree = SummonModel.instance:getFreeEquipSummon()

		SummonModel.instance:setSendEquipFreeSummon(isFree)
		SummonRpc.instance:sendSummonRequest(poolId, count)

		if isFree then
			self._needGetInfo = true
		end
	else
		SummonModel.instance:setSendEquipFreeSummon(false)
		SummonRpc.instance:sendSummonRequest(poolId, count)

		if needGetInfo then
			self._needGetInfo = true
		end
	end
end

function SummonMainController:getNeedGetInfo()
	return self._needGetInfo
end

function SummonMainController:openSummonDetail(poolCo, extendData, summonSimulationActId)
	if not poolCo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)

	local param = {}

	param.poolId = poolCo.id
	param.poolDetailId = poolCo.poolDetail
	param.poolAwardTime = poolCo.awardTime
	param.summonSimulationActId = summonSimulationActId

	if SummonConfig.poolIsLuckyBag(poolCo.id) then
		if extendData then
			param.luckyBagId = extendData
		end

		ViewMgr.instance:openView(ViewName.SummonLuckyBagDetailView, param)
	elseif poolCo.type == SummonEnum.Type.CustomPick or poolCo.type == SummonEnum.Type.StrongCustomOnePick then
		ViewMgr.instance:openView(ViewName.SummonCustomPickDetailView, param)
	else
		ViewMgr.instance:openView(ViewName.SummonPoolDetailView, param)
	end
end

function SummonMainController:isFromSceneOpen()
	return self._openByEnterScene
end

function SummonMainController:pickAllUIPreloadRes()
	local resSet = {}
	local resList = {}
	local validPools = SummonMainModel.getValidPools()

	for i = 1, tabletool.len(validPools) do
		local poolCfg = validPools[i]
		local customClz = poolCfg.customClz

		if not string.nilorempty(customClz) then
			local preloadList = SummonCharacterProbUpPreloadConfig.getPreLoadListByName(customClz)

			if preloadList == nil then
				local tabIndex = SummonMainModel.instance:getADPageTabIndexForUI(poolCfg)

				if tabIndex then
					local clz = SummonMainModel.instance:getUIClassDef(tabIndex)

					preloadList = clz.preloadList
				end
			end

			if preloadList ~= nil then
				for _, path in ipairs(preloadList) do
					if not resSet[path] then
						table.insert(resList, path)

						resSet[path] = true
					end
				end
			end
		end
	end

	return resList
end

function SummonMainController:getCurPoolPreloadRes()
	local resSet = {}
	local resList = {}
	local poolId = SummonMainModel.instance:getCurId()
	local poolCo = SummonConfig.instance:getSummonPool(poolId)

	if poolCo then
		local customClz = poolCo.customClz

		if not string.nilorempty(customClz) then
			local preloadList = SummonCharacterProbUpPreloadConfig.getPreLoadListByName(customClz)

			if preloadList == nil then
				local tabIndexByType = SummonMainModel.getADPageTabIndex(poolCo)
				local defaultClz = SummonMainModel.defaultUIClzMap[tabIndexByType]
				local clz

				if not string.nilorempty(poolCo.customClz) then
					clz = _G[poolCo.customClz]
				end

				clz = clz or defaultClz
				preloadList = clz.preloadList
			end

			if preloadList ~= nil then
				for _, path in ipairs(preloadList) do
					if not resSet[path] then
						table.insert(resList, path)

						resSet[path] = true
					end
				end
			end
		end
	end

	return resList
end

function SummonMainController:handleDailyRefresh()
	SummonRpc.instance:sendGetSummonInfoRequest()
end

function SummonMainController:openpPogressRewardView(poolId)
	local poolCfg = SummonConfig.instance:getSummonPool(poolId)

	if not poolCfg then
		return
	end

	if string.nilorempty(poolCfg.progressRewards) then
		logError(string.format("[export_召唤卡池] poolId:%s \"progressRewards\"字段为nil", poolId))

		return
	end

	if string.nilorempty(poolCfg.progressRewardPrefab) then
		logError(string.format("[export_召唤卡池] poolId:%s \"progressRewardPrefab\"字段为nil", poolId))

		return
	end

	local setting = ViewMgr.instance:getSetting(ViewName.SummonPoolPogressRewardView)

	if setting then
		setting.mainRes = string.format("ui/viewres/summon/%s", poolCfg.progressRewardPrefab)
	end

	ViewMgr.instance:openView(ViewName.SummonPoolPogressRewardView, {
		poolId = poolId
	})
end

function SummonMainController:openSummonConfirmView(params)
	self:setDiamondEnoughTipCb(params)

	if not self:canShowMessageOptionBoxView() then
		self:checkFreeDiamondEnough(params)

		return
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, params)
end

function SummonMainController:canShowMessageOptionBoxView()
	local key = self:getOptionLocalKey()
	local canShowView = TimeUtil.getDayFirstLoginRed(key)

	return canShowView
end

function SummonMainController:getOptionLocalKey()
	return string.format("SummonConfirmView#%s", tostring(PlayerModel.instance:getPlayinfo().userId))
end

function SummonMainController:checkFreeDiamondEnough(params)
	if params.notEnough then
		local costData = SummonMainModel.getCurrencyByCost(params.type, params.id)

		CurrencyController.instance:checkFreeDiamondEnoughDaily(params.cost_quantity, CurrencyEnum.PayDiamondExchangeSource.Summon, true, params.callback, params.callbackObj, nil, nil, params.miss_quantity, costData, params.noCallback, params.noCallbackObj)
	elseif params.callback and params.callbackObj then
		callWithCatch(params.callback, params.callbackObj)
	end
end

function SummonMainController:setDiamondEnoughTipCb(params)
	local oldCb = params.callback
	local oldCallbackObj = params.callbackObj

	function params.callback()
		if oldCb and oldCallbackObj then
			callWithCatch(oldCb, oldCallbackObj)
		end

		GameFacade.showToast(ToastEnum.ExchangeDiamondSummon, params.miss_quantity)
	end
end

SummonMainController.instance = SummonMainController.New()

return SummonMainController
