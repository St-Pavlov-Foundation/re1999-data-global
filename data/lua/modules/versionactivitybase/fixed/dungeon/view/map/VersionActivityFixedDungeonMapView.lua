-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/map/VersionActivityFixedDungeonMapView.lua

module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapView", package.seeall)

local VersionActivityFixedDungeonMapView = class("VersionActivityFixedDungeonMapView", BaseView)
local RECT_MASK_PADDING = Vector4(0, 0, 0, 0)
local RECT_MASK_PADDING_OPEN_MAP_LEVEL = Vector4(0, 0, 600, 0)
local ANIMA_TIME = 0.5

function VersionActivityFixedDungeonMapView:onInitView()
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._simagenormalmask = gohelper.findChildSingleImage(self.viewGO, "#simage_normalmask")
	self._simagehardmask = gohelper.findChildSingleImage(self.viewGO, "#simage_hardmask")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._rectmask2D = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._goswitchmodecontainer = gohelper.findChild(self.viewGO, "#go_switchmodecontainer")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._txtstorename = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/normal/txt_shop")
	self._txtstorenum = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	self._imagestoreicon = gohelper.findChildImage(self.viewGO, "#go_topright/#btn_activitystore/normal/#simage_icon")
	self._txtStoreRemainTime = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	self._goTaskReddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._btnactivitystore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitystore")
	self._btnactivitytask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitytask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedDungeonMapView:addEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, self.onClickElement, self)
	self:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnactivitystore:AddClickListener(self._btnactivitystoreOnClick, self)
	self._btnactivitytask:AddClickListener(self._btnactivitytaskOnClick, self)
end

function VersionActivityFixedDungeonMapView:removeEvents()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, self.onClickElement, self)
	self:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self._btncloseview:RemoveClickListener()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
end

function VersionActivityFixedDungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion))
end

function VersionActivityFixedDungeonMapView:_btnactivitystoreOnClick()
	VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance:openStoreView()
end

function VersionActivityFixedDungeonMapView:_btnactivitytaskOnClick()
	VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance:openTaskView()
end

function VersionActivityFixedDungeonMapView:_onEscBtnClick()
	local isShowInteractView = VersionActivityFixedDungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self.viewContainer.interactView:hide()
	else
		self:closeThis()
	end
end

function VersionActivityFixedDungeonMapView:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivityFixedDungeonMapView:endShowRewardView()
	self._showRewardView = false
end

function VersionActivityFixedDungeonMapView:onRemoveElement(elementId)
	return
end

function VersionActivityFixedDungeonMapView:_editableInitView()
	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.DungeonStore]

	self._txtstorename.text = storeActInfoMo and storeActInfoMo.config.name or ""

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	TaskDispatcher.runRepeat(self._everyMinuteCall, self, TimeUtil.OneMinuteSecond)

	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	local reddot = VersionActivityFixedHelper.getVersionActivityDungeonTaskReddotId(self._bigVersion, self._smallVersion)

	RedDotController.instance:addRedDot(self._goTaskReddot, reddot)
end

function VersionActivityFixedDungeonMapView:_everyMinuteCall()
	self:refreshUI()
end

function VersionActivityFixedDungeonMapView:onUpdateParam()
	self:onOpen()
end

function VersionActivityFixedDungeonMapView:onOpen()
	VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance:onVersionActivityDungeonMapViewOpen()
	self:refreshUI()
end

function VersionActivityFixedDungeonMapView:checkLoadingAndRefresh()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function VersionActivityFixedDungeonMapView:refreshUI()
	self:refreshActivityCurrency()
	self:refreshMask()
	self:refreshStoreRemainTime()
end

function VersionActivityFixedDungeonMapView:refreshActivityCurrency()
	local currencyType = VersionActivityFixedHelper.getVersionActivityCurrencyType(self._bigVersion, self._smallVersion)
	local currencyMO = CurrencyModel.instance:getCurrency(currencyType)
	local quantity = currencyMO and currencyMO.quantity or 0

	self._txtstorenum.text = GameUtil.numberDisplay(quantity)
end

function VersionActivityFixedDungeonMapView:onRefreshActivityState(updateActId)
	return
end

function VersionActivityFixedDungeonMapView:_onOpenView(viewName)
	if viewName ~= VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion) then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING_OPEN_MAP_LEVEL

	gohelper.setActive(self._btncloseview, true)
	self:hideBtnUI()
end

function VersionActivityFixedDungeonMapView:hideBtnUI()
	self.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(self.playCloseAnimaDone, self, ANIMA_TIME)
end

function VersionActivityFixedDungeonMapView:playCloseAnimaDone()
	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayCloseAnim)
end

function VersionActivityFixedDungeonMapView:_onCloseView(viewName)
	if viewName ~= VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion) then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING

	gohelper.setActive(self._btncloseview, false)
	self:showBtnUI()
end

function VersionActivityFixedDungeonMapView:showBtnUI()
	self:setNavBtnIsShow(true)
	gohelper.setActive(self._gotopright, true)
	gohelper.setActive(self._goswitchmodecontainer, true)
	self.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(self.playOpenAnimaDone, self, ANIMA_TIME)
end

function VersionActivityFixedDungeonMapView:playOpenAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivityFixedDungeonMapView:setNavBtnIsShow(isShow)
	gohelper.setActive(self._gotopleft, isShow)
end

function VersionActivityFixedDungeonMapView:onClickElement()
	self:hideBtnUI()
	self:setNavBtnIsShow(false)
end

function VersionActivityFixedDungeonMapView:onModeChange()
	self:refreshMask()
end

function VersionActivityFixedDungeonMapView:refreshMask()
	local isHardMode = self.activityDungeonMo:isHardMode()

	gohelper.setActive(self._simagenormalmask.gameObject, not isHardMode)
	gohelper.setActive(self._simagehardmask.gameObject, isHardMode)
end

function VersionActivityFixedDungeonMapView:refreshStoreRemainTime()
	local storeActId = VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.DungeonStore
	local actInfoMo = ActivityModel.instance:getActMO(storeActId)
	local endTime = actInfoMo:getRealEndTimeStamp()
	local offsetSecond = endTime - ServerTime.now()

	if offsetSecond > TimeUtil.OneDaySecond then
		local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
		local timeStr = day .. "d"

		self._txtStoreRemainTime.text = timeStr

		return
	end

	if offsetSecond > TimeUtil.OneHourSecond then
		local hour = Mathf.Floor(offsetSecond / TimeUtil.OneHourSecond)
		local timeStr = hour .. "h"

		self._txtStoreRemainTime.text = timeStr

		return
	end

	self._txtStoreRemainTime.text = "1h"
end

function VersionActivityFixedDungeonMapView:_OnUpdateMapElementState(mapId)
	return
end

function VersionActivityFixedDungeonMapView:onClose()
	self._showRewardView = false

	TaskDispatcher.cancelTask(self._everyMinuteCall, self)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivityFixedDungeonMapView:onDestroyView()
	return
end

return VersionActivityFixedDungeonMapView
