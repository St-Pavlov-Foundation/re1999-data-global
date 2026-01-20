-- chunkname: @modules/logic/activitywelfare/view/ActivityWelfareView.lua

module("modules.logic.activitywelfare.view.ActivityWelfareView", package.seeall)

local ActivityWelfareView = class("ActivityWelfareView", BaseView)

function ActivityWelfareView:onInitView()
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "#go_category/#scroll_categoryitem")
	self._gosubview = gohelper.findChild(self.viewGO, "#go_subview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWelfareView:addEvents()
	return
end

function ActivityWelfareView:removeEvents()
	return
end

function ActivityWelfareView:_editableInitView()
	return
end

local activitySubViewDict = {
	[ActivityEnum.Activity.NewWelfare] = ViewName.NewWelfareView,
	[ActivityEnum.Activity.NoviceSign] = ViewName.ActivityNoviceSignView,
	[ActivityEnum.Activity.StoryShow] = ViewName.ActivityStoryShowView,
	[ActivityEnum.Activity.ClassShow] = ViewName.ActivityClassShowView,
	[ActivityEnum.Activity.V2a7_NewInsight] = ViewName.ActivityInsightShowView_2_7,
	[ActivityEnum.Activity.V2a7_SelfSelectSix2] = ViewName.V2a7_SelfSelectSix_FullView
}

function ActivityWelfareView:onUpdateParam()
	return
end

function ActivityWelfareView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, self.setCategoryListInteractable, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.SwitchWelfareActivity, self._openSubView, self)
	self:_refreshView()
end

function ActivityWelfareView:_refreshView()
	local actCo = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)

	if not actCo or not next(actCo) then
		self:closeThis()
	end

	ActivityModel.instance:removeFinishedWelfare(actCo)

	local lastdata = self.data and tabletool.copy(self.data) or nil
	local id2data = {}

	self.data = {}

	for _, v in pairs(actCo) do
		local o = {}

		o.id = v
		o.co = ActivityConfig.instance:getActivityCo(v)
		o.type = ActivityEnum.ActivityType.Welfare

		table.insert(self.data, o)

		id2data[v] = o
	end

	ActivityWelfareListModel.instance:setOpenViewTime()

	local isNeedCallOpenSubView = lastdata == nil

	if lastdata ~= nil then
		if #lastdata ~= #self.data then
			isNeedCallOpenSubView = true
		else
			for _, v in ipairs(lastdata) do
				local id = v.id

				if not id2data[id] then
					isNeedCallOpenSubView = true

					break
				end
			end
		end
	end

	if not isNeedCallOpenSubView and self._viewName then
		local c = ViewMgr.instance:getContainer(self._viewName)

		if c then
			ViewMgr.instance:openView(self._viewName, c.viewParam, true)

			return
		end
	end

	ActivityWelfareListModel.instance:setCategoryList(self.data)
	self:_openSubView()
end

function ActivityWelfareView:_openSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)
	end

	local actId = ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Welfare)

	self._viewName = activitySubViewDict[actId]

	if not self._viewName then
		return
	end

	if actId == ActivityEnum.Activity.StoryShow or actId == ActivityEnum.Activity.ClassShow then
		self:setCategoryRedDotData(actId)
	end

	self.viewContainer:hideHelp()

	local viewParam = {
		parent = self._gosubview,
		actId = actId,
		root = self.viewGO
	}

	ViewMgr.instance:openView(self._viewName, viewParam, true)
end

function ActivityWelfareView:setCategoryRedDotData(actId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, "hasEnter")

	return key
end

function ActivityWelfareView:closeSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)

		self._viewName = nil
	end
end

function ActivityWelfareView:onClose()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	self:removeEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, self.setCategoryListInteractable, self)
	self:closeSubView()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	ActivityWelfareListModel.instance:clear()
end

function ActivityWelfareView:setCategoryListInteractable(isInteractable)
	if not self._categoryListCanvasGroup then
		self._categoryListCanvasGroup = gohelper.onceAddComponent(self._gocategory, typeof(UnityEngine.CanvasGroup))
	end

	self._categoryListCanvasGroup.interactable = isInteractable
	self._categoryListCanvasGroup.blocksRaycasts = isInteractable
	self._categoryListCanvasGroup.blocksRaycasts = isInteractable
end

function ActivityWelfareView:onDestroyView()
	return
end

return ActivityWelfareView
