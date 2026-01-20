-- chunkname: @modules/logic/mainswitchclassify/view/MainSwitchClassifyView.lua

module("modules.logic.mainswitchclassify.view.MainSwitchClassifyView", package.seeall)

local MainSwitchClassifyView = class("MainSwitchClassifyView", BaseView)

function MainSwitchClassifyView:onInitView()
	self._gobg2 = gohelper.findChild(self.viewGO, "#go_bg2")
	self._gobg1 = gohelper.findChild(self.viewGO, "#go_bg1")
	self._goleft = gohelper.findChild(self.viewGO, "left/#go_left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSwitchClassifyView:addEvents()
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, self._onSwitchUIVisible, self)
	self:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
	self:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ForceShowSceneTab, self._onForceShowSceneTab, self)
	self:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshReddot, self)
end

function MainSwitchClassifyView:removeEvents()
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, self._onSwitchUIVisible, self)
	self:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self:removeEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
	self:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ForceShowSceneTab, self._onForceShowSceneTab, self)
	self:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshReddot, self)
end

function MainSwitchClassifyView:_onForceShowSceneTab()
	self.viewContainer:switchClassifyTab(MainSwitchClassifyEnum.Classify.Scene)
end

function MainSwitchClassifyView:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == self._tabContainerId then
		self._tabId = tabId
	end
end

function MainSwitchClassifyView:_editableInitView()
	self._rootAnimator = self.viewGO:GetComponent("Animator")
end

function MainSwitchClassifyView:onUpdateParam()
	return
end

function MainSwitchClassifyView:_onSwitchUIVisible(showUI)
	gohelper.setActive(self._goleft, showUI)
	self._rootAnimator:Play(showUI and "open" or "close", 0, 0)
end

function MainSwitchClassifyView:onOpen()
	MainSwitchClassifyListModel.instance:initMoList()

	self._tabContainerId = 3
	self._tabId = self.viewParam.defaultTabIds[1]
end

function MainSwitchClassifyView:onClose()
	self:_clearScene()
end

function MainSwitchClassifyView:onDestroyView()
	return
end

function MainSwitchClassifyView:onTabSwitchOpen()
	MainHeroView.resetPostProcessBlur()
	self._rootAnimator:Play("open", 0, 0)
end

function MainSwitchClassifyView:onTabSwitchClose(isClosing)
	self:_clearScene()
end

function MainSwitchClassifyView:_clearScene()
	WeatherController.instance:FakeShowScene(true)
	MainHeroView.setPostProcessBlur()
end

function MainSwitchClassifyView:refreshReddot()
	MainSwitchClassifyListModel.instance:onModelUpdate()
end

return MainSwitchClassifyView
