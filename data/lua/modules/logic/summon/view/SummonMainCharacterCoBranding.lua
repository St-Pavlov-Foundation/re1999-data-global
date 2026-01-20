-- chunkname: @modules/logic/summon/view/SummonMainCharacterCoBranding.lua

module("modules.logic.summon.view.SummonMainCharacterCoBranding", package.seeall)

local SummonMainCharacterCoBranding = class("SummonMainCharacterCoBranding", SummonMainCharacterProbUp)

function SummonMainCharacterCoBranding:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_role1")
	self._simagetitle1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/title/#simage_title1")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/title/#simage_logo")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1")
	self._txtgoto = gohelper.findChildText(self.viewGO, "#go_ui/current/right/#go_characteritem1/btn_goto/#txt_goto")
	self._txttimes = gohelper.findChildText(self.viewGO, "#go_ui/current/first/#txt_times")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	self._btngift = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#btn_gift")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")
	self._txtpreferential = gohelper.findChildText(self.viewGO, "#go_ui/current/first/#txt_times")
	self._gopreferential = gohelper.findChild(self.viewGO, "#go_ui/current/first")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainCharacterCoBranding:addEvents()
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)

	if self._btngift then
		self._btngift:AddClickListener(self._btngiftOnClick, self)
	end
end

function SummonMainCharacterCoBranding:removeEvents()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
	self._btnclaim:RemoveClickListener()
	self._btngoto:RemoveClickListener()

	if self._btngift then
		self._btngift:RemoveClickListener()
	end
end

function SummonMainCharacterCoBranding:_btnsummon1OnClick()
	SummonMainCharacterCoBranding.super._btnsummon1OnClick(self)
end

function SummonMainCharacterCoBranding:_btnsummon10OnClick()
	SummonMainCharacterCoBranding.super._btnsummon10OnClick(self)
end

function SummonMainCharacterCoBranding:_btnclaimOnClick()
	local poolCo = SummonMainModel.instance:getCurPool()

	self._nextRewardsRequestTime = self._nextRewardsRequestTime or 0

	if poolCo and self._nextRewardsRequestTime <= Time.time then
		self._nextRewardsRequestTime = Time.time + 0.3

		SummonRpc.instance:sendGetSummonProgressRewardsRequest(poolCo.id)
	end
end

function SummonMainCharacterCoBranding:_btngotoOnClick()
	local poolCo = SummonMainModel.instance:getCurPool()

	if poolCo then
		SummonMainController.instance:openpPogressRewardView(poolCo.id)
	end
end

function SummonMainCharacterCoBranding:_btngiftOnClick()
	local poolCo = SummonMainModel.instance:getCurPool()

	if poolCo then
		local poolId = poolCo.id
		local viewName = SummonEnum.CharacterCoBrandingGiftView[poolCo.customClz]

		ViewMgr.instance:openView(viewName or ViewName.V2a9_LinkGiftView, {
			poolId = poolId
		})

		if StoreGoodsTaskController.instance:isHasNewRedDotByPoolId(poolId) then
			StoreGoodsTaskController.instance:clearNewRedDotByPoolId(poolId)
			StoreGoodsTaskController.instance:waitUpdateRedDot(poolId)
			self:_refreshGift()
		end
	end
end

function SummonMainCharacterCoBranding:_editableInitView()
	SummonMainCharacterCoBranding.super._editableInitView(self)

	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/current/right/#go_characteritem1/btn_claim")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/current/right/#go_characteritem1/btn_goto")
	self._goallGet = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1/go_allGet")
	self._gogifgReddot = gohelper.findChild(self.viewGO, "#go_ui/#btn_gift/go_reddot")
	self._animcharacter = gohelper.findChildComponent(self.viewGO, "#go_ui/current/right/#go_characteritem1", gohelper.Type_Animator)

	if self._gogifgReddot then
		self._redotComp = RedDotController.instance:addNotEventRedDot(self._gogifgReddot, self._checkRedPointFunc, self, RedDotEnum.Style.NewTag)
	end
end

function SummonMainCharacterCoBranding:onUpdateParam()
	SummonMainCharacterCoBranding.super.onUpdateParam(self)
end

function SummonMainCharacterCoBranding:onOpen()
	self:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshProgressRewards, self)
	self:addEventCb(SummonController.instance, SummonEvent.onSummonProgressRewards, self._refreshProgressRewards, self)
	self:addEventCb(TaskController.instance, TaskEvent.SetTaskList, self._refreshGift, self)
	self:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._refreshGift, self)
	self:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshGift, self)
	self:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._checkCanFinishGiftTask, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewEvent, self)
	SummonMainCharacterCoBranding.super.onOpen(self)
	self:_refreshProgressRewards()
	self:_refreshGift()

	if self:_checkCanFinishGiftTask() then
		StoreGoodsTaskController.instance:autoFinishTaskByPoolId(SummonMainModel.instance:getCurId())
	end

	self:_refreshPreferentialInfo()
end

function SummonMainCharacterCoBranding:_checkCanFinishGiftTask()
	local poolId = SummonMainModel.instance:getCurId()

	if poolId and StoreGoodsTaskController.instance:isHasCanFinishTaskByPoolId(poolId) then
		self._isHasCanFinishTask = true

		return true
	end

	return false
end

function SummonMainCharacterCoBranding:onClose()
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshProgressRewards, self)
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonProgressRewards, self._refreshProgressRewards, self)
	self:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, self._refreshGift, self)
	self:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._refreshGift, self)
	self:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshGift, self)
	self:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._checkCanFinishGiftTask, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewEvent, self)
	TaskDispatcher.cancelTask(self._onRunTaskOpenGiftView, self)
	SummonMainCharacterCoBranding.super.onClose(self)
	StoreGoodsTaskController.instance:waitUpdateRedDot()
end

function SummonMainCharacterCoBranding:onDestroyView()
	SummonMainCharacterCoBranding.super.onDestroyView(self)
end

function SummonMainCharacterCoBranding:_adLoaded()
	return
end

function SummonMainCharacterCoBranding:_onCloseViewEvent(viewName)
	if self._isHasCanFinishTask then
		TaskDispatcher.cancelTask(self._onRunTaskOpenGiftView, self)
		TaskDispatcher.runDelay(self._onRunTaskOpenGiftView, self, 0.1)
	end
end

function SummonMainCharacterCoBranding:_onRunTaskOpenGiftView()
	if self._isHasCanFinishTask and ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self._isHasCanFinishTask = false

		self:_btngiftOnClick()
	end
end

function SummonMainCharacterCoBranding:_refreshProgressRewards()
	local poolCo = SummonMainModel.instance:getCurPool()

	if not poolCo or string.nilorempty(poolCo.progressRewards) then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(poolCo.id)

	if not poolMO then
		return
	end

	local isRewardFinish = false
	local hasReward = false
	local rewardCount = poolMO.customPickMO:getRewardCount() or 0
	local summonCount = poolMO.summonCount or 0
	local maxRewardCount = 0
	local canRewardCount = 0
	local nextRwardCount
	local numsList = SummonConfig.instance:getProgressRewardsByPoolId(poolCo.id)

	if numsList and #numsList > 0 then
		maxRewardCount = #numsList

		for i, nums in ipairs(numsList) do
			local count = nums[1]
			local heroId = nums[2]

			if count <= summonCount then
				canRewardCount = canRewardCount + 1
			elseif not nextRwardCount or count < nextRwardCount then
				nextRwardCount = count
			end
		end
	end

	gohelper.setActive(self._goallGet, maxRewardCount <= rewardCount)
	gohelper.setActive(self._txtgoto, rewardCount < maxRewardCount)
	gohelper.setActive(self._btnclaim, rewardCount < canRewardCount)

	if rewardCount < maxRewardCount then
		if nextRwardCount and summonCount < nextRwardCount then
			self._txtgoto.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("summonmaincharacter_progress_rewards"), nextRwardCount - summonCount)

			local key = "summonmaincharacter_progress_rewards" .. poolCo.id

			self:_playNumAninByKey(key, summonCount)
		elseif rewardCount < canRewardCount then
			self._txtgoto.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("summonmaincharacter_progress_rewards_full"), canRewardCount - rewardCount)

			local key2 = "summonmaincharacter_progress_rewards_full" .. poolCo.id

			self:_playNumAninByKey(key2, 1)
		else
			self._txtgoto.text = ""
		end
	end

	self:_refreshPreferentialInfo()
	self:_refreshGift()
end

function SummonMainCharacterCoBranding:_playNumAninByKey(key, summonCount)
	local playerKey = PlayerModel.instance:getPlayerPrefsKey(key)
	local tempCount = PlayerPrefsHelper.getNumber(playerKey, -1)

	PlayerPrefsHelper.setNumber(playerKey, summonCount)

	if tempCount ~= -1 and tempCount ~= summonCount and self._animcharacter then
		self._animcharacter:Play("num", 0, 0)
	end
end

function SummonMainCharacterCoBranding:_refreshGift()
	local poolId = SummonMainModel.instance:getCurId()
	local goodsCfgList = StoreConfig.instance:getCharageGoodsCfgListByPoolId(poolId)
	local isShow = false

	if goodsCfgList then
		for _, goodsCfg in ipairs(goodsCfgList) do
			local storePackageGoodsMO = StoreModel.instance:getGoodsMO(goodsCfg.id)

			if storePackageGoodsMO and (not storePackageGoodsMO:isSoldOut() or StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsCfg.id)) then
				isShow = true

				break
			end
		end
	end

	if isShow and SummonModel.instance:getSummonFullExSkillHero(poolId) then
		isShow = false
	end

	if self._redotComp then
		self._redotComp:refreshRedDot()

		if not isShow and self._redotComp.isShowRedDot then
			isShow = true
		end
	end

	gohelper.setActive(self._btngift, isShow)
end

function SummonMainCharacterCoBranding:_checkRedPointFunc()
	return StoreGoodsTaskController.instance:isHasNewRedDotByPoolId(SummonMainModel.instance:getCurId())
end

function SummonMainCharacterCoBranding:_refreshPreferentialInfo()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)
	local preferentialLimitCount = poolMO.canGetGuaranteeSRCount

	if self._gopreferential then
		gohelper.setActive(self._gopreferential, preferentialLimitCount > 0)

		if self._txtpreferential and preferentialLimitCount > 0 then
			local preferential = poolMO.guaranteeSRCountDown

			self._txtpreferential.text = preferential
		end
	end
end

return SummonMainCharacterCoBranding
