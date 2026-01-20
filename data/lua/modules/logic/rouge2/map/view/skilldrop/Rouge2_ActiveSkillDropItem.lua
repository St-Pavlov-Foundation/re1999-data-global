-- chunkname: @modules/logic/rouge2/map/view/skilldrop/Rouge2_ActiveSkillDropItem.lua

module("modules.logic.rouge2.map.view.skilldrop.Rouge2_ActiveSkillDropItem", package.seeall)

local Rouge2_ActiveSkillDropItem = class("Rouge2_ActiveSkillDropItem", LuaCompBase)

Rouge2_ActiveSkillDropItem.PercentColor = "#F3A055"
Rouge2_ActiveSkillDropItem.BracketColor = "#5E7DD9"

function Rouge2_ActiveSkillDropItem:init(go)
	self.go = go
	self._simageIcon = gohelper.findChildSingleImage(self.go, "go_Info/image_Icon")
	self._imageAttribute = gohelper.findChildImage(self.go, "go_Info/image_Attribute")
	self._goCostList = gohelper.findChild(self.go, "go_Info/go_CostList")
	self._goCostItem = gohelper.findChild(self.go, "go_Info/go_CostList/go_CostItem")
	self._txtName = gohelper.findChildText(self.go, "go_Info/txt_Name")
	self._goSelect = gohelper.findChild(self.go, "go_Info/go_Select")
	self._scrollDesc = gohelper.findChild(self.go, "scroll_Desc"):GetComponent(gohelper.Type_LimitedScrollRect)
	self._goContainer = gohelper.findChild(self.go, "scroll_Desc/Viewport/go_Container")
	self._txtDesc = gohelper.findChildText(self.go, "scroll_Desc/Viewport/go_Container/txt_Desc")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click", AudioEnum.Rouge2.SelectActiveSkill)
	self._btnClick2 = gohelper.findChildClickWithDefaultAudio(self.go, "scroll_Desc/Viewport/go_Container/txt_Desc", AudioEnum.Rouge2.SelectActiveSkill)

	self:onSelect(false)
end

function Rouge2_ActiveSkillDropItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnClick2:AddClickListener(self._btnClickOnClick, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectDropSkillItem, self._onSelectDropSkillItem, self)
end

function Rouge2_ActiveSkillDropItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnClick2:RemoveClickListener()
end

function Rouge2_ActiveSkillDropItem:_btnClickOnClick()
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnSelectDropSkillItem, self._index)
end

function Rouge2_ActiveSkillDropItem:setParentScroll(goParentScroll)
	self._scrollDesc.parentGameObject = goParentScroll
end

function Rouge2_ActiveSkillDropItem:onUpdateMO(index, viewType, dataType, dataId)
	self._index = index
	self._viewType = viewType
	self._dataType = dataType
	self._dataId = dataId
	self._skillCo, self._skillMo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	self._skillId = self._skillCo and self._skillCo.id
	self._attributeId = self._skillCo and self._skillCo.attributeTag
	self._assembleCost = self._skillCo and self._skillCo.assembleCost or 0

	self:refreshUI()
end

function Rouge2_ActiveSkillDropItem:refreshUI()
	self._txtName.text = self._skillCo and self._skillCo.name

	Rouge2_IconHelper.setActiveSkillIcon(self._skillId, self._simageIcon)
	Rouge2_IconHelper.setAttributeIcon(self._attributeId, self._imageAttribute)
	gohelper.setActive(self._goCostList, self._assembleCost > 0)
	gohelper.CreateNumObjList(self._goCostList, self._goCostItem, self._assembleCost)
	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._dataId, self._txtDesc, nil, nil, Rouge2_ActiveSkillDropItem.PercentColor, Rouge2_ActiveSkillDropItem.BracketColor)
	gohelper.setActive(self._btnClick.gameObject, self._viewType == Rouge2_MapEnum.ItemDropViewEnum.Select)
end

function Rouge2_ActiveSkillDropItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)
end

function Rouge2_ActiveSkillDropItem:_onSelectDropSkillItem(index)
	self:onSelect(index == self._index)
end

function Rouge2_ActiveSkillDropItem:onDestroy()
	self._simageIcon:UnLoadImage()
end

return Rouge2_ActiveSkillDropItem
