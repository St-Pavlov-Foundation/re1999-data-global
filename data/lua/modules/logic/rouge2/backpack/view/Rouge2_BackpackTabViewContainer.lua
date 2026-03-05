-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTabViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTabViewContainer", package.seeall)

local Rouge2_BackpackTabViewContainer = class("Rouge2_BackpackTabViewContainer", BaseViewContainer)

function Rouge2_BackpackTabViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, TabViewGroup.New(4, "#go_lefttop2"))

	self._containerView = TabViewGroup.New(Rouge2_Enum.BackpackTabContainerId, "#go_Container")

	table.insert(views, self._containerView)
	table.insert(views, Rouge2_BackpackTabView.New())
	table.insert(views, Rouge2_MapCoinView.New())

	return views
end

function Rouge2_BackpackTabViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		self.navigateView:setOverrideHelp(self.overrideHelpBtn, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == Rouge2_Enum.BackpackTabContainerId then
		self:_addTabViewToMap(Rouge2_Enum.BagTabType.Career, Rouge2_BackpackCareerView.New())
		self:_addTabViewToMap(Rouge2_Enum.BagTabType.Buff, Rouge2_BackpackBuffView.New())
		self:_addTabViewToMap(Rouge2_Enum.BagTabType.Relics, Rouge2_BackpackRelicsView.New())
		self:_addTabViewToMap(Rouge2_Enum.BagTabType.ActiveSkill, Rouge2_BackpackSkillView.New())

		return self._bagTabViewList or {}
	elseif tabContainerId == 3 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			}, nil, self._closeSkillEditViewCallback, nil, nil, self)
		}
	elseif tabContainerId == 4 then
		self.editBtnViews = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.editBtnViews:setOverrideClose(self._closeSkillEditViewCallback, self)

		return {
			self.editBtnViews
		}
	end
end

function Rouge2_BackpackTabViewContainer:_addTabViewToMap(tabType, viewInst)
	self._bagTabViewList = self._bagTabViewList or {}
	self._bagTabViewMap = self._bagTabViewMap or {}
	self._bagTabViewMap[tabType] = viewInst

	table.insert(self._bagTabViewList, viewInst)
end

function Rouge2_BackpackTabViewContainer:getCurSelectType()
	return self._containerView:getCurTabId()
end

function Rouge2_BackpackTabViewContainer:switchTab(type)
	local curTabId = self._containerView:getCurTabId()

	if curTabId == type then
		return
	end

	self:dispatchEvent(ViewEvent.ToSwitchTab, Rouge2_Enum.BackpackTabContainerId, type)
	self:refreshHelpBtnVisible()
end

function Rouge2_BackpackTabViewContainer:onContainerOpen()
	self:refreshHelpBtnVisible()
end

function Rouge2_BackpackTabViewContainer:refreshHelpBtnVisible()
	local curTabId = self._containerView:getCurTabId()

	self.navigateView:setHelpVisible(curTabId ~= Rouge2_Enum.BagTabType.Career)
end

function Rouge2_BackpackTabViewContainer:_closeSkillEditViewCallback()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.CloseSkillEditView)
	Rouge2_BackpackController.instance:readAllActiveSkills()
	ViewMgr.instance:closeView(ViewName.Rouge2_CareerSkillTipsView)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchSkillViewType, Rouge2_BackpackSkillView.ViewState.Panel)
end

function Rouge2_BackpackTabViewContainer:overrideHelpBtn()
	local curTabId = self._containerView:getCurTabId()

	if curTabId == Rouge2_Enum.BagTabType.ActiveSkill then
		Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.BackpackActiveSkill)
	elseif curTabId == Rouge2_Enum.BagTabType.Buff then
		Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.BackpackBuff)
	elseif curTabId == Rouge2_Enum.BagTabType.Relics then
		Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.BackpackRelcis)
	else
		logError("肉鸽背包界面帮助按钮未定义页签")
	end
end

function Rouge2_BackpackTabViewContainer:getTabViewByTabType(tabType)
	return self._bagTabViewMap and self._bagTabViewMap[tabType]
end

return Rouge2_BackpackTabViewContainer
