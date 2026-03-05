-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillPanelView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillPanelView", package.seeall)

local Rouge2_BackpackSkillPanelView = class("Rouge2_BackpackSkillPanelView", BaseView)

function Rouge2_BackpackSkillPanelView:onInitView()
	self._goSkillPanel = gohelper.findChild(self.viewGO, "SkillPanel")
	self._txtCapacity = gohelper.findChildText(self.viewGO, "SkillPanel/Capacity/List/Capacity/#txt_Capacity")
	self._goAssemblyList = gohelper.findChild(self.viewGO, "SkillPanel/Capacity/List/#go_ItemList")
	self._goAssemblyItem = gohelper.findChild(self.viewGO, "SkillPanel/Capacity/List/#go_ItemList/#go_Item")
	self._goAttribute = gohelper.findChild(self.viewGO, "SkillPanel/#go_Attribute")
	self._btnNew = gohelper.findChildButtonWithAudio(self.viewGO, "SkillPanel/#btn_New")
	self._goReddot = gohelper.findChild(self.viewGO, "SkillPanel/#btn_New/#go_Reddot")
	self._goMode = gohelper.findChild(self.viewGO, "SkillPanel/#go_Mode")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackSkillPanelView:addEvents()
	self._btnNew:AddClickListener(self._btnNewOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateActiveSkillInfo, self._onUpdateActiveSkillInfo, self)
end

function Rouge2_BackpackSkillPanelView:removeEvents()
	self._btnNew:RemoveClickListener()
end

function Rouge2_BackpackSkillPanelView:_btnNewOnClick()
	local selectHoleIndex = 1

	for i = 1, Rouge2_Enum.MaxActiveSkillNum do
		local isUse = Rouge2_BackpackModel.instance:isActiveSkillIndexInUse(i)

		if not isUse then
			selectHoleIndex = i

			break
		end
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchSkillViewType, Rouge2_BackpackSkillView.ViewState.Edit, selectHoleIndex)
end

function Rouge2_BackpackSkillPanelView:_editableInitView()
	self._goSkillItem = self:getResInst(Rouge2_Enum.ResPath.BackpackSkillShowItem, self._goSkillPanel, "#go_SkillItem")

	self:addChildView(Rouge2_BackpackSkillBoxView.New())
	self:initSkillEditItems()
	Rouge2_AttributeToolBar.Load(self._goAttribute, Rouge2_Enum.AttributeToolType.Attr_Detail)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.BackpackSkill)
	RedDotController.instance:addRedDot(self._goReddot, Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.ActiveSkill])
end

function Rouge2_BackpackSkillPanelView:onUpdateParam()
	return
end

function Rouge2_BackpackSkillPanelView:onOpen()
	return
end

function Rouge2_BackpackSkillPanelView:onOpenChildView()
	self:refreshUI()
end

function Rouge2_BackpackSkillPanelView:onCloseChildView()
	return
end

function Rouge2_BackpackSkillPanelView:refreshUI()
	self._assembleCost = Rouge2_BackpackModel.instance:getUseActiveSkillAssembleCost()
	self._maxAssembleCost = Rouge2_Model.instance:getAttrValue(Rouge2_MapEnum.BasicAttrId.ActiveSkillCapacity)
	self._txtCapacity.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge2_backpackskillview_capacity"), self._assembleCost, self._maxAssembleCost)

	gohelper.CreateNumObjList(self._goAssemblyList, self._goAssemblyItem, self._maxAssembleCost, self._refreshSingleAssembly, self)
end

function Rouge2_BackpackSkillPanelView:initSkillEditItems()
	self._activeSkillItemTab = self:getUserDataTb_()

	for i = 1, Rouge2_Enum.MaxActiveSkillNum do
		local goSkillPos = gohelper.findChild(self.viewGO, "SkillPanel/#go_SkillPos" .. i)
		local goSkill = gohelper.clone(self._goSkillItem, goSkillPos, i)
		local skillHoleItem = MonoHelper.addNoUpdateLuaComOnceToGo(goSkill, Rouge2_BackpackSkillShowItem, i)

		skillHoleItem:onUpdateMO()
		table.insert(self._activeSkillItemTab, skillHoleItem)
	end

	gohelper.setActive(self._goSkillItem, false)
end

function Rouge2_BackpackSkillPanelView:_refreshSingleAssembly(obj, index)
	local goType1 = gohelper.findChild(obj, "go_Type1")
	local goType2 = gohelper.findChild(obj, "go_Type2")
	local isSelect = index <= self._assembleCost
	local useType1 = index % 2 ~= 0

	gohelper.setActive(goType1, useType1)
	gohelper.setActive(goType2, not useType1)

	local goRoot = useType1 and goType1 or goType2
	local goSelected = gohelper.findChild(goRoot, "#image_Icon")

	gohelper.setActive(goSelected, isSelect)
end

function Rouge2_BackpackSkillPanelView:_onUpdateActiveSkillInfo()
	self:refreshUI()
end

function Rouge2_BackpackSkillPanelView:onClose()
	return
end

function Rouge2_BackpackSkillPanelView:onDestroyView()
	return
end

return Rouge2_BackpackSkillPanelView
