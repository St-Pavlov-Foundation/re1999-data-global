-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailView.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailView", package.seeall)

local Rouge2_AttributeDetailView = class("Rouge2_AttributeDetailView", BaseView)

Rouge2_AttributeDetailView.PassiveSkillType = {
	Rouge2_Enum.PassiveSkillDescType.Career,
	Rouge2_Enum.PassiveSkillDescType.Fight,
	Rouge2_Enum.PassiveSkillDescType.Explore
}
Rouge2_AttributeDetailView.PercentColor = "#F3A055"
Rouge2_AttributeDetailView.BracketColor = "#5E7DD9"

function Rouge2_AttributeDetailView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goTabCotent = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Tab/Viewport/Content")
	self._goAttrTabItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Tab/Viewport/Content/#go_AttrTabItem")
	self._goGroupTabItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Tab/Viewport/Content/#go_GroupTabItem")
	self._goContent = gohelper.findChild(self.viewGO, "#go_Root/Scroll View/Viewport/Content")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close2")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "#go_Root/Scroll View")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AttributeDetailView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnClose2:AddClickListener(self._btnCloseOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSelectAttrTab, self._onSelectAttrTab, self)
end

function Rouge2_AttributeDetailView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function Rouge2_AttributeDetailView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_AttributeDetailView:_editableInitView()
	gohelper.setActive(self._goAttrTabItem, false)
	gohelper.setActive(self._goGroupTabItem, false)

	self._tabItemTab = self:getUserDataTb_()
	self._tabTypeList = {
		Rouge2_Enum.AttrDetailTabGroupType.Overview,
		Rouge2_Enum.AttrDetailTabGroupType.AttrList
	}

	self:initTabList()
end

function Rouge2_AttributeDetailView:onUpdateParam()
	return
end

function Rouge2_AttributeDetailView:onOpen()
	self._careerId = self.viewParam and self.viewParam.careerId
	self._careerCo = Rouge2_CareerConfig.instance:getCareerConfig(self._careerId)

	self:refreshTabItemList()
end

function Rouge2_AttributeDetailView:refreshTabItemList()
	self._attrInfoList = self.viewContainer:getAttrInfoList()

	for i, tabItem in ipairs(self._tabItemTab) do
		tabItem:onUpdateMO(self._careerId, self._attrInfoList, i, self)
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectAttrTab, 1, 1)
end

function Rouge2_AttributeDetailView:initTabList()
	for _, tabType in ipairs(self._tabTypeList) do
		local goItem = gohelper.cloneInPlace(self._goGroupTabItem, "tab_" .. tabType)
		local tabItem = Rouge2_AttrDetailTabGroupBaseItem.Get(goItem, tabType)

		table.insert(self._tabItemTab, tabItem)
	end
end

function Rouge2_AttributeDetailView:_onSelectAttrTab()
	self._scrollView.verticalNormalizedPosition = 1
end

function Rouge2_AttributeDetailView:onClose()
	return
end

function Rouge2_AttributeDetailView:onDestroyView()
	return
end

return Rouge2_AttributeDetailView
