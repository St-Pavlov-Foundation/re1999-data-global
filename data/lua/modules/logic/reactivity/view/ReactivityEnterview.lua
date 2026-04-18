-- chunkname: @modules/logic/reactivity/view/ReactivityEnterview.lua

module("modules.logic.reactivity.view.ReactivityEnterview", package.seeall)

local ReactivityEnterview = class("ReactivityEnterview", VersionActivityEnterBaseSubView)

function ReactivityEnterview:onInitView()
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Replay")
	self._btnAchevement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Achevement")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Store")
	self._txtstoretime = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_Store/#go_taglimit/#txt_limit")
	self._txtNum = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_Store/#txt_Num")
	self._txttime = gohelper.findChildTextMesh(self.viewGO, "Logo/image_LimitTimeBG/#txt_LimitTime")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "Logo/#txt_Descr")
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Exchange")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#image_reddot")
	self._btnEnd = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_End")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtlockedtips = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_Locked/txt_LockedTips")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self.rewardItems = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ReactivityEnterview:addEvents()
	self._btnAchevement:AddClickListener(self._onClickAchevementBtn, self)
	self._btnstore:AddClickListener(self._onClickStoreBtn, self)
	self._btnEnter:AddClickListener(self._onClickEnter, self)
	self._btnreplay:AddClickListener(self._onClickReplay, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnEnd:AddClickListener(self._onClickEnter, self)
	self._btnLock:AddClickListener(self._onClickEnter, self)
end

function ReactivityEnterview:removeEvents()
	self._btnAchevement:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnreplay:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnEnd:RemoveClickListener()
	self._btnLock:RemoveClickListener()
end

function ReactivityEnterview:_editableInitView()
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
end

function ReactivityEnterview:_onClickAchevementBtn()
	if not self.actId then
		return
	end

	local activityCfg = ActivityConfig.instance:getActivityCo(self.actId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function ReactivityEnterview:onOpen()
	self:initRedDot()
	ReactivityEnterview.super.onOpen(self)
	self:refreshUI()
end

function ReactivityEnterview:onClose()
	ReactivityEnterview.super.onClose(self)
end

function ReactivityEnterview:initRedDot()
	if self.actId then
		return
	end

	self.actId = VersionActivity3_4Enum.ActivityId.Reactivity

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	RedDotController.instance:addRedDot(self._goreddot, actCo.redDotId)
end

function ReactivityEnterview:_onRefreshRedDot()
	return
end

function ReactivityEnterview:onUpdateParam()
	return
end

function ReactivityEnterview:onDestroyView()
	if self.rewardItems then
		for k, v in pairs(self.rewardItems) do
			v:onDestroy()
		end

		self.rewardItems = nil
	end
end

function ReactivityEnterview:refreshUI()
	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self._txtdesc.text = actCo.actDesc

	if not string.nilorempty(actCo.activityBonus) then
		local rewards = GameUtil.splitString2(actCo.activityBonus, true) or {}

		for i = 1, math.max(#rewards, #self.rewardItems) do
			local item = self.rewardItems[i]
			local data = rewards[i]

			if not item then
				item = IconMgr.instance:getCommonItemIcon(self._gorewardcontent)
				self.rewardItems[i] = item
			end

			if data then
				gohelper.setActive(item.go, true)
				item:setMOValue(data[1], data[2], data[3] or 1, nil, true)
				item:hideEquipLvAndCount()
				item:isShowCount(false)
			else
				gohelper.setActive(item.go, false)
			end
		end
	end

	self:refreshEnterBtn()
	self:refreshCurrency()
	self:refreshRemainTime()
end

function ReactivityEnterview:everySecondCall()
	self:refreshRemainTime()
end

function ReactivityEnterview:refreshEnterBtn()
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(self.actId)

	gohelper.setActive(self._btnEnter, status == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(self._btnEnd, status ~= ActivityEnum.ActivityStatus.Normal and status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLock, status == ActivityEnum.ActivityStatus.NotUnlock)

	if status == ActivityEnum.ActivityStatus.NotUnlock then
		self._txtlockedtips.text = ToastController.instance:getToastMsgWithTableParam(toastId, toastParamList)
	end

	local define = ReactivityEnum.ActivityDefine[self.actId]
	local storeActId = define and define.storeActId

	self.storeActId = storeActId

	local storeStatus = ActivityHelper.getActivityStatus(storeActId)

	gohelper.setActive(self._btnstore, storeStatus == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(self._btnExchange, storeStatus == ActivityEnum.ActivityStatus.Normal)
end

function ReactivityEnterview:refreshCurrency()
	local currencyId = ReactivityModel.instance:getActivityCurrencyId(self.actId)
	local currencyMO = CurrencyModel.instance:getCurrency(currencyId)
	local quantity = currencyMO and currencyMO.quantity or 0

	self._txtNum.text = GameUtil.numberDisplay(quantity)
end

function ReactivityEnterview:_onClickEnter()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return
	end

	VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView()
end

function ReactivityEnterview:_onClickReplay()
	local activityMo = ActivityModel.instance:getActMO(self.actId)
	local storyId = activityMo and activityMo.config and activityMo.config.storyId

	if not storyId then
		logError(string.format("act id %s dot config story id", storyId))

		return
	end

	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(storyId, param)
end

function ReactivityEnterview:_onClickExchange()
	ViewMgr.instance:openView(ViewName.ReactivityRuleView)
end

function ReactivityEnterview:_onClickStoreBtn()
	ReactivityController.instance:openReactivityStoreView(self.actId)
end

function ReactivityEnterview:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		self._txttime.text = dateStr
	else
		self._txttime.text = luaLang("ended")
	end

	self:refreshStoreTime()
end

function ReactivityEnterview:refreshStoreTime()
	local actId = self.storeActId

	if not actId then
		return
	end

	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo then
		return
	end

	local status = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal and status ~= ActivityEnum.ActivityStatus.NotUnlock then
		self._txtstoretime.text = luaLang("turnback_end")
	else
		self._txtstoretime.text = actInfoMo:getRemainTimeStr2ByEndTime(true)
	end
end

function ReactivityEnterview:_onRefreshActivityState(actId)
	if not actId or actId ~= self.actId then
		return
	end

	if not ActivityHelper.isOpen(actId) then
		self:closeThis()

		return
	end

	self:refreshUI()
end

return ReactivityEnterview
