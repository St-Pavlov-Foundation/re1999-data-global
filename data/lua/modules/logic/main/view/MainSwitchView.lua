-- chunkname: @modules/logic/main/view/MainSwitchView.lua

module("modules.logic.main.view.MainSwitchView", package.seeall)

local MainSwitchView = class("MainSwitchView", BaseView)

function MainSwitchView:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "Tab/#scroll_category")
	self._gocategoryitem1 = gohelper.findChild(self.viewGO, "Tab/#scroll_category/categorycontent/#go_categoryitem1")
	self._gocategoryitem2 = gohelper.findChild(self.viewGO, "Tab/#scroll_category/categorycontent/#go_categoryitem2")
	self._gocategoryitem3 = gohelper.findChild(self.viewGO, "Tab/#scroll_category/categorycontent/#go_categoryitem3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSwitchView:addEvents()
	return
end

function MainSwitchView:removeEvents()
	return
end

function MainSwitchView:_editableInitView()
	self._gotab = gohelper.findChild(self.viewGO, "Tab")
	self._goswitchloading = gohelper.findChild(self.viewGO, "loadingmainview")
	self._switchAniamtor = self._goswitchloading:GetComponent("Animator")
	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._tabCanvasGroup = self._gotab:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._btnsCanvasGroup = self._gobtns:GetComponent(typeof(UnityEngine.CanvasGroup))

	local contentcategory = gohelper.findChild(self.viewGO, "Tab/#scroll_category/categorycontent")

	self._gridLayout = contentcategory:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._goreddot2 = gohelper.findChild(self._gocategoryitem2, "reddot")
	self._goreddot3 = gohelper.findChild(self._gocategoryitem3, "reddot")
end

function MainSwitchView:onUpdateParam()
	return
end

function MainSwitchView:onOpen()
	MainSwitchCategoryListModel.instance:initCategoryList()

	self._itemList = self:getUserDataTb_()

	local list = MainSwitchCategoryListModel.instance:getList()

	for i, v in ipairs(list) do
		local go = self["_gocategoryitem" .. i]
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, MainSwitchCategoryItem)

		item:onUpdateMO(v)

		self._itemList[i] = item

		gohelper.setActive(go, true)
	end

	if #list > 2 then
		self._gridLayout.cellSize = Vector2(600, 90)
	else
		self._gridLayout.cellSize = Vector2(780, 90)
	end

	self:refreshReddot()
	self:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchCategoryClick, self._itemClick, self)
	self:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, self._onSceneSwitchUIVisible, self)
	self:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSceneSwitchUIVisible, self)
	self:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, self._onSceneSwitchUIVisible, self)
	self:addEventCb(SummonUISwitchController.instance, SummonUISwitchEvent.SwitchVisible, self._onSceneSwitchUIVisible, self)
	self:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.BeforeStartSwitchScene, self._onStartSwitchScene, self)
	self:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.CloseSwitchSceneLoading, self._onCloseSwitchSceneLoading, self)
	self:addEventCb(FightUISwitchController.instance, FightUISwitchEvent.cancelClassifyReddot, self.checkFightUIReddot, self)
	self:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.CancelReddot, self.checkSceneUIReddot, self)
	self:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshReddot, self)
end

function MainSwitchView:_onStartSwitchScene()
	gohelper.setActive(self._goswitchloading, true)
	self._switchAniamtor:Play("open", 0, 0)
end

function MainSwitchView:_onCloseSwitchSceneLoading()
	self._switchAniamtor:Play("close", 0, 0)
end

function MainSwitchView:_onSceneSwitchUIVisible(visible)
	self._tabCanvasGroup.blocksRaycasts = visible
	self._btnsCanvasGroup.blocksRaycasts = visible

	self._rootAnimator:Play(visible and "open" or "close", 0, 0)
end

function MainSwitchView:_itemClick(id)
	self.viewContainer:playCloseAnim(id)

	for k, v in pairs(self._itemList) do
		v:refreshStatus()
	end
end

function MainSwitchView:checkFightUIReddot()
	local isShow = FightUISwitchModel.instance:isNewUnlockStyle()

	gohelper.setActive(self._goreddot3, isShow)
end

function MainSwitchView:checkSceneUIReddot()
	gohelper.setActive(self._goreddot2, self:_isShowSceneUIReddot())
end

function MainSwitchView:_isShowSceneUIReddot()
	if ClickUISwitchModel.instance:hasReddot() then
		return true
	end
end

function MainSwitchView:refreshReddot()
	self:checkFightUIReddot()
	self:checkSceneUIReddot()
end

function MainSwitchView:onClose()
	return
end

function MainSwitchView:onDestroyView()
	return
end

return MainSwitchView
