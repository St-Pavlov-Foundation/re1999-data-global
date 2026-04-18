-- chunkname: @modules/logic/versionactivity2_5/dungeon/view/map/VersionActivity2_5DungeonMapView.lua

module("modules.logic.versionactivity2_5.dungeon.view.map.VersionActivity2_5DungeonMapView", package.seeall)

local VersionActivity2_5DungeonMapView = class("VersionActivity2_5DungeonMapView", BaseView)
local RECT_MASK_PADDING = Vector4(0, 0, 0, 0)
local RECT_MASK_PADDING_OPEN_MAP_LEVEL = Vector4(0, 0, 600, 0)
local ANIMA_TIME = 0.5

function VersionActivity2_5DungeonMapView:onInitView()
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
	self._btnrestaurant = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_restaurant")
	self._goact165Reddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_restaurant/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_5DungeonMapView:addEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self:addEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, self.refreshRestaurantBtn, self)
	self:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnClickElement, self.onClickElement, self)
	self:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self:addEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, self._act165RedDot, self)
	self:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnactivitystore:AddClickListener(self._btnactivitystoreOnClick, self)
	self._btnactivitytask:AddClickListener(self._btnactivitytaskOnClick, self)
	self._btnrestaurant:AddClickListener(self._btnrestaurantOnClick, self)
end

function VersionActivity2_5DungeonMapView:removeEvents()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, self.refreshRestaurantBtn, self)
	self:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnClickElement, self.onClickElement, self)
	self:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self:removeEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, self._act165RedDot, self)
	self:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self._btncloseview:RemoveClickListener()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
	self._btnrestaurant:RemoveClickListener()
end

function VersionActivity2_5DungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity2_5DungeonMapLevelView)
end

function VersionActivity2_5DungeonMapView:_btnactivitystoreOnClick()
	ReactivityController.instance:openReactivityStoreView(VersionActivity3_4Enum.ActivityId.Reactivity)
end

function VersionActivity2_5DungeonMapView:_btnactivitytaskOnClick()
	ReactivityController.instance:openReactivityTaskView(VersionActivity3_4Enum.ActivityId.Reactivity)
end

function VersionActivity2_5DungeonMapView:_btnrestaurantOnClick()
	Activity165Controller.instance:openActivity165EnterView()
end

function VersionActivity2_5DungeonMapView:_onEscBtnClick()
	local isShowInteractView = VersionActivity2_5DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self.viewContainer.interactView:hide()
	else
		self:closeThis()
	end
end

function VersionActivity2_5DungeonMapView:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity2_5DungeonMapView:endShowRewardView()
	self._showRewardView = false
end

function VersionActivity2_5DungeonMapView:onRemoveElement(elementId)
	local storyCo = VersionActivity2_5DungeonModel.instance:checkStoryCanUnlock(elementId)
	local actId = Activity165Model.instance:getActivityId()

	if storyCo then
		GameFacade.showToast(ToastEnum.Act165StoryUnlock, storyCo.name)
		Activity165Model.instance:onInitInfo()
	end
end

function VersionActivity2_5DungeonMapView:_editableInitView()
	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_4Enum.ActivityId.ReactivityStore]

	self._txtstorename.text = storeActInfoMo.config.name

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	TaskDispatcher.runRepeat(self._everyMinuteCall, self, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(self._goTaskReddot, RedDotEnum.DotNode.V2a5DungeonEnter)
	self:_act165RedDot()
end

function VersionActivity2_5DungeonMapView:_everyMinuteCall()
	self:refreshUI()
end

function VersionActivity2_5DungeonMapView:onUpdateParam()
	self:onOpen()
end

function VersionActivity2_5DungeonMapView:onOpen()
	VersionActivity2_5DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	self:refreshUI()
end

function VersionActivity2_5DungeonMapView:checkLoadingAndRefresh()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function VersionActivity2_5DungeonMapView:refreshUI()
	self:refreshRestaurantBtn()
	self:refreshActivityCurrency()
	self:refreshMask()
	self:refreshStoreRemainTime()
end

function VersionActivity2_5DungeonMapView:refreshActivityCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a5Dungeon)
	local quantity = currencyMO and currencyMO.quantity or 0

	self._txtstorenum.text = GameUtil.numberDisplay(quantity)
end

function VersionActivity2_5DungeonMapView:onRefreshActivityState(updateActId)
	if updateActId == VersionActivity2_5Enum.ActivityId.Dungeon then
		local status = ActivityHelper.getActivityStatusAndToast(updateActId)
		local isNormal = status == ActivityEnum.ActivityStatus.Normal

		if not isNormal then
			self:closeThis()
			GameFacade.showToast(ToastEnum.ActivityEnd)

			return
		end
	end

	local actId = Activity165Model.instance:getActivityId()

	if updateActId and updateActId ~= actId then
		return
	end

	local isOnline = ActivityModel.instance:isActOnLine(actId)

	if isOnline then
		Activity165Model.instance:onInitInfo()
	end

	gohelper.setActive(self._btnrestaurant.gameObject, false)
end

function VersionActivity2_5DungeonMapView:_onOpenView(viewName)
	if viewName ~= ViewName.VersionActivity2_5DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING_OPEN_MAP_LEVEL

	gohelper.setActive(self._btncloseview, true)
	self:hideBtnUI()
end

function VersionActivity2_5DungeonMapView:hideBtnUI()
	self.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(self.playCloseAnimaDone, self, ANIMA_TIME)
end

function VersionActivity2_5DungeonMapView:playCloseAnimaDone()
	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function VersionActivity2_5DungeonMapView:_onCloseView(viewName)
	if viewName ~= ViewName.VersionActivity2_5DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING

	gohelper.setActive(self._btncloseview, false)
	self:showBtnUI()
end

function VersionActivity2_5DungeonMapView:showBtnUI()
	self:setNavBtnIsShow(true)
	gohelper.setActive(self._gotopright, true)
	gohelper.setActive(self._goswitchmodecontainer, true)
	self:refreshRestaurantBtn()
	self.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(self.playOpenAnimaDone, self, ANIMA_TIME)
end

function VersionActivity2_5DungeonMapView:refreshRestaurantBtn()
	local isUnlockAct165Btn = VersionActivity2_5DungeonModel.instance:isUnlockAct165Btn()

	gohelper.setActive(self._btnrestaurant.gameObject, false)
end

function VersionActivity2_5DungeonMapView:playOpenAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity2_5DungeonMapView:setNavBtnIsShow(isShow)
	gohelper.setActive(self._gotopleft, isShow)
end

function VersionActivity2_5DungeonMapView:onClickElement()
	self:hideBtnUI()
	self:setNavBtnIsShow(false)
end

function VersionActivity2_5DungeonMapView:onModeChange()
	self:refreshMask()
end

function VersionActivity2_5DungeonMapView:refreshMask()
	local isHardMode = self.activityDungeonMo:isHardMode()

	gohelper.setActive(self._simagenormalmask.gameObject, not isHardMode)
	gohelper.setActive(self._simagehardmask.gameObject, isHardMode)
end

function VersionActivity2_5DungeonMapView:refreshStoreRemainTime()
	local storeActId = VersionActivity3_4Enum.ActivityId.ReactivityStore
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

function VersionActivity2_5DungeonMapView:_act165RedDot()
	local isShow = Activity165Model.instance:isShowAct165Reddot()

	gohelper.setActive(self._goact165Reddot.gameObject, isShow)
end

function VersionActivity2_5DungeonMapView:_OnUpdateMapElementState(mapId)
	local elements = Activity165Model.instance:getAllElements()

	if elements then
		for _, element in pairs(elements) do
			local co = DungeonConfig.instance:getChapterMapElement(element)

			if co and co.mapId == mapId then
				Activity165Model.instance:onInitInfo()

				return
			end
		end
	end
end

function VersionActivity2_5DungeonMapView:onClose()
	self._showRewardView = false

	TaskDispatcher.cancelTask(self._everyMinuteCall, self)
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity2_5DungeonMapView:onDestroyView()
	return
end

return VersionActivity2_5DungeonMapView
