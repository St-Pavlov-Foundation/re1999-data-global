-- chunkname: @modules/logic/bossrush/view/v1a6/taskachievement/V1a6_BossRush_BonusView.lua

module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusView", package.seeall)

local V1a6_BossRush_BonusView = class("V1a6_BossRush_BonusView", BaseView)

function V1a6_BossRush_BonusView:_setActive_text(isActive)
	gohelper.setActive(self._textGo, isActive)
end

function V1a6_BossRush_BonusView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gobonus = gohelper.findChild(self.viewGO, "#go_bonus")
	self._goTab1 = gohelper.findChild(self.viewGO, "Tab/#go_Tab1")
	self._goTab2 = gohelper.findChild(self.viewGO, "Tab/#go_Tab2")
	self._goTab3 = gohelper.findChild(self.viewGO, "Tab/#go_Tab3")
	self._goBlock = gohelper.findChild(self.viewGO, "#go_Block")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_BossRush_BonusView:addEvents()
	self:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._refreshRedDot, self)
	self:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, self._refreshRedDot, self)
	self:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._refreshRedDot, self)
	self:addEventCb(TaskController.instance, TaskEvent.SetTaskList, self._refreshRedDot, self)
end

function V1a6_BossRush_BonusView:removeEvents()
	self:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._refreshRedDot, self)
	self:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, self._refreshRedDot, self)
	self:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._refreshRedDot, self)
	self:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, self._refreshRedDot, self)
end

function V1a6_BossRush_BonusView:_btnOnClick(index)
	self:cutTab(index)
end

function V1a6_BossRush_BonusView:_editableInitView()
	self._textGo = gohelper.findChild(self.viewGO, "text")
	self._tabs = self:getUserDataTb_()

	for i = 1, 3 do
		local item = self:getUserDataTb_()
		local go = self["_goTab" .. i]
		local goUnSelected = gohelper.findChild(go, "#go_UnSelect")
		local goSelected = gohelper.findChild(go, "#go_Selected")
		local goRedDot = gohelper.findChild(go, "#go_RedDot")

		item.go = go
		item.goUnSelected = goUnSelected
		item.txtUnSelected = gohelper.findChildText(goUnSelected, "txt_Tab")
		item.goSelected = goSelected
		item.txtSelected = gohelper.findChildText(goSelected, "txt_Tab")
		item.goRedDot = goRedDot
		item.btn = gohelper.findChildButtonWithAudio(go, "#btn")

		item.btn:AddClickListener(self._btnOnClick, self, i)

		self._tabs[i] = item
	end
end

function V1a6_BossRush_BonusView:onUpdateParam()
	return
end

function V1a6_BossRush_BonusView:onOpen()
	self._stage = self.viewParam.stage
	self._selectTab = self.viewParam.defaultTab or V1a6_BossRush_BonusModel.instance:getTab()

	self:_refreshRedDot()
	self:activeTab()
	self:_refreshTab()
	self:_addRedDot()

	if self._selectTab == BossRushEnum.BonusViewTab.AchievementTab then
		V1a6_BossRush_BonusModel.instance:selecAchievementTab(self._stage)
	end
end

function V1a6_BossRush_BonusView:onClose()
	for i, item in ipairs(self._tabs) do
		item.btn:RemoveClickListener()
	end
end

function V1a6_BossRush_BonusView:onDestroyView()
	return
end

function V1a6_BossRush_BonusView:openDefaultTab()
	self:selectTab(self._selectTab)
	self:_refreshRedDot()
end

function V1a6_BossRush_BonusView:cutTab(tab)
	if self._selectTab and self._selectTab == tab then
		return
	end

	self._selectTab = tab

	self:activeTab()
	self:selectTab(self._selectTab)
end

function V1a6_BossRush_BonusView:selectTab(tab, callback)
	self:_setActive_text(tab == BossRushEnum.BonusViewTab.AchievementTab)
	self.viewContainer:selectTabView(tab, callback)
end

function V1a6_BossRush_BonusView:activeTab()
	for i, item in ipairs(self._tabs) do
		gohelper.setActive(item.goUnSelected, i ~= self._selectTab)
		gohelper.setActive(item.goSelected, i == self._selectTab)
	end
end

function V1a6_BossRush_BonusView:_addRedDot()
	local tabViewEnum = BossRushModel.instance:getActivityBonus()

	if tabViewEnum then
		for i, tab in ipairs(tabViewEnum) do
			local reddotId = tab.Reddot
			local goRedDot = self._tabs[i].goRedDot

			if reddotId and goRedDot then
				local uid = BossRushRedModel.instance:getUId(reddotId, self._stage)

				RedDotController.instance:addRedDot(goRedDot, reddotId, uid)
			end
		end
	end
end

function V1a6_BossRush_BonusView:_refreshRedDot()
	local tabViewEnum = BossRushModel.instance:getActivityBonus()

	if tabViewEnum then
		for i, tab in ipairs(tabViewEnum) do
			local goRedDot = self._tabs[i].goRedDot

			if goRedDot and tab.ListModel and tab.ListModel.instance.isReddot then
				local isShow = tab.ListModel.instance:isReddot(self._stage, i)

				gohelper.setActive(goRedDot, isShow)
			end
		end
	end
end

function V1a6_BossRush_BonusView:_refreshTab()
	local tabViewEnum = BossRushModel.instance:getActivityBonus()
	local isTab3 = #tabViewEnum > 2
	local width = isTab3 and 326 or 489

	for i, item in ipairs(self._tabs) do
		recthelper.setWidth(item.go.transform, width)
		gohelper.setActive(item.go, i <= #tabViewEnum)

		local txt = tabViewEnum[i] and tabViewEnum[i].TabTitle

		if not string.nilorempty(txt) then
			item.txtUnSelected.text = luaLang(txt)
			item.txtSelected.text = luaLang(txt)
		end
	end
end

return V1a6_BossRush_BonusView
