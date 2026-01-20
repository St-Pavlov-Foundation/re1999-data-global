-- chunkname: @modules/versionactivitybase/fixed/enterview/view/subview/VersionActivityFixedDungeonEnterView.lua

module("modules.versionactivitybase.fixed.enterview.view.subview.VersionActivityFixedDungeonEnterView", package.seeall)

local VersionActivityFixedDungeonEnterView = class("VersionActivityFixedDungeonEnterView", BaseView)

function VersionActivityFixedDungeonEnterView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._gotime = gohelper.findChild(self.viewGO, "logo/actbg")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/time/#txt_time")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtStoreNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._txtStoreTime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._gohardModeUnLock = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_hardModeUnLock")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedDungeonEnterView:addEvents()
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
end

function VersionActivityFixedDungeonEnterView:removeEvents()
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
	self._btnstore:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function VersionActivityFixedDungeonEnterView:onRefreshActivity(actId)
	if actId ~= self.actId then
		return
	end

	self:refreshActivityState()
end

function VersionActivityFixedDungeonEnterView:_btnstoreOnClick()
	VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance:openStoreView()
end

function VersionActivityFixedDungeonEnterView:_btnenterOnClick()
	VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance:openVersionActivityDungeonMapView()
end

function VersionActivityFixedDungeonEnterView:_btnFinishedOnClick()
	GameFacade.showToast(ToastEnum.ActivityEnd)
end

function VersionActivityFixedDungeonEnterView:_btnLockedOnClick()
	GameFacade.showToast(ToastEnum.ActivityNotOpen)
end

function VersionActivityFixedDungeonEnterView:_editableInitView()
	self._txtstorename = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	self.actId = VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon
	self.animComp = VersionActivityFixedHelper.getVersionActivitySubAnimatorComp().get(self.viewGO, self)
	self.goEnter = self._btnenter.gameObject
	self.goFinish = self._btnFinished.gameObject
	self.goStore = self._btnstore.gameObject
	self.goLock = self._btnLocked.gameObject
	self.actId = VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self:_setDesc()
	RedDotController.instance:addRedDot(self._goreddot, VersionActivityFixedHelper.getVersionActivityDungeonEnterReddotId(self._bigVersion, self._smallVersion))
end

function VersionActivityFixedDungeonEnterView:_setDesc()
	if not self.actCo or not self._txtdesc then
		return
	end

	self._txtdesc.text = self.actCo.actDesc
end

function VersionActivityFixedDungeonEnterView:onUpdateParam()
	self:refreshUI()
end

function VersionActivityFixedDungeonEnterView:onOpen()
	self:refreshUI()
	self.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
	self:refreshRedDot()
end

function VersionActivityFixedDungeonEnterView:everyMinuteCall()
	self:refreshUI()
end

function VersionActivityFixedDungeonEnterView:refreshUI()
	self:refreshRemainTime()
	self:refreshActivityState()
	self:refreshStoreCurrency()
end

function VersionActivityFixedDungeonEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		self._txttime.text = dateStr

		gohelper.setActive(self._txttime, true)
	else
		gohelper.setActive(self._txttime, false)
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.DungeonStore]

	self._txtstorename.text = storeActInfoMo.config.name
	self._txtStoreTime.text = storeActInfoMo:getRemainTimeStr2ByEndTime(true)
end

function VersionActivityFixedDungeonEnterView:refreshActivityState()
	local status = ActivityHelper.getActivityStatusAndToast(self.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal
	local isNotOpen = status == ActivityEnum.ActivityStatus.NotOpen

	gohelper.setActive(self.goEnter, isNormal)
	gohelper.setActive(self.goFinish, not isNotOpen and not isNormal)
	gohelper.setActive(self.goLock, isNotOpen)

	local isExpired = status == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(self._gotime, not isExpired)

	local storeStatus = ActivityHelper.getActivityStatusAndToast(VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.DungeonStore)
	local isStoreNormal = storeStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goStore, isStoreNormal)
end

function VersionActivityFixedDungeonEnterView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(VersionActivityFixedHelper.getVersionActivityCurrencyType(self._bigVersion, self._smallVersion))
	local quantity = currencyMO and currencyMO.quantity or 0

	self._txtStoreNum.text = GameUtil.numberDisplay(quantity)
end

function VersionActivityFixedDungeonEnterView:refreshRedDot()
	local dungeonActId = VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon
	local isOpen = VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(dungeonActId)
	local isNormalStatus = ActivityHelper.getActivityStatus(dungeonActId) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self._gohardModeUnLock, isOpen and isNormalStatus)
end

function VersionActivityFixedDungeonEnterView:onClose()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
end

function VersionActivityFixedDungeonEnterView:onDestroyView()
	self.animComp:destroy()
end

return VersionActivityFixedDungeonEnterView
