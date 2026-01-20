-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillShowItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillShowItem", package.seeall)

local Rouge2_BackpackSkillShowItem = class("Rouge2_BackpackSkillShowItem", LuaCompBase)

Rouge2_BackpackSkillShowItem.PercentColor = "#F3A055"
Rouge2_BackpackSkillShowItem.BracketColor = "#60A0FE"

function Rouge2_BackpackSkillShowItem:ctor(index)
	self._index = index
end

function Rouge2_BackpackSkillShowItem:init(go)
	self.go = go
	self._goEmpty = gohelper.findChild(self.go, "#go_Empty")
	self._goEmptyEffect = gohelper.findChild(self.go, "#go_Empty/add_eff")
	self._goTips1 = gohelper.findChild(self.go, "#go_Empty/#go_Tips1")
	self._goTips2 = gohelper.findChild(self.go, "#go_Empty/#go_Tips2")
	self._goUnEmpty = gohelper.findChild(self.go, "#go_UnEmpty")
	self._simageSkillIcon = gohelper.findChildSingleImage(self.go, "#go_UnEmpty/#image_SkillIcon")
	self._goSelected = gohelper.findChild(self.go, "#go_Selected")
	self._txtSkillName = gohelper.findChildText(self.go, "#go_UnEmpty/#go_Skill/#txt_SkillName")
	self._imageAttribute = gohelper.findChildImage(self.go, "#go_UnEmpty/#go_Skill/#txt_SkillName/#image_Icon")
	self._goAssemblyList = gohelper.findChild(self.go, "#go_UnEmpty/Capacity/#go_AssemblyList")
	self._goAssemblyItem = gohelper.findChild(self.go, "#go_UnEmpty/Capacity/#go_AssemblyList/#go_AssemblyItem")
	self._txtDescr = gohelper.findChildText(self.go, "#go_UnEmpty/Scroll View/Viewport/#txt_Descr")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
	self._goBXSAttr = gohelper.findChild(self.go, "#go_BXSAttr")
	self._imageBXSAttrIcon = gohelper.findChildImage(self.go, "#go_BXSAttr/#image_Icon")

	SkillHelper.addHyperLinkClick(self._txtDescr)
end

function Rouge2_BackpackSkillShowItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateActiveSkillInfo, self._onUpdateActiveSkillInfo, self)
end

function Rouge2_BackpackSkillShowItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_BackpackSkillShowItem:_btnClickOnClick()
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchSkillViewType, Rouge2_BackpackSkillView.ViewState.Edit, self._index)
end

function Rouge2_BackpackSkillShowItem:onUpdateMO()
	self:refreshInfo()
	self:refreshUI()
	self:playAnim()
end

function Rouge2_BackpackSkillShowItem:refreshInfo()
	self._preIsEmpty = self._isEmpty
	self._skillMo = Rouge2_BackpackModel.instance:index2UseActiveSkill(self._index)
	self._skillUid = self._skillMo and self._skillMo:getUid()
	self._skillId = self._skillMo and self._skillMo:getItemId()
	self._isEmpty = not self._skillUid or self._skillUid == 0
end

function Rouge2_BackpackSkillShowItem:refreshUI()
	gohelper.setActive(self._goEmpty, self._isEmpty)
	gohelper.setActive(self._goUnEmpty, not self._isEmpty)
	self:refreshBXSAttrIcon()

	if self._isEmpty then
		self:refreshEmptyTips()

		return
	end

	self._skillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(self._skillId)
	self._txtSkillName.text = self._skillCo and self._skillCo.name

	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Server, self._skillUid, self._txtDescr, nil, nil, Rouge2_BackpackSkillShowItem.PercentColor, Rouge2_BackpackSkillShowItem.BracketColor)

	local assemblyNum = self._skillCo and self._skillCo.assembleCost or 0

	gohelper.CreateNumObjList(self._goAssemblyList, self._goAssemblyItem, assemblyNum, self._refreshAssemblyItem, self)
	Rouge2_IconHelper.setActiveSkillIcon(self._skillId, self._simageSkillIcon)
	self:refreshAttrIcon()
end

function Rouge2_BackpackSkillShowItem:refreshAttrIcon()
	local attrId = self._skillCo.attributeTag
	local isUseBXS = Rouge2_Model.instance:isUseBXSCareer()

	gohelper.setActive(self._imageAttribute.gameObject, not isUseBXS)

	if isUseBXS then
		return
	end

	Rouge2_IconHelper.setAttributeIcon(attrId, self._imageAttribute)
end

function Rouge2_BackpackSkillShowItem:refreshBXSAttrIcon()
	local isUseBXS = Rouge2_Model.instance:isUseBXSCareer()

	gohelper.setActive(self._goBXSAttr, isUseBXS)

	if not isUseBXS then
		return
	end

	local attrIdList = Rouge2_MapConfig.instance:getBXSAttrIdList()
	local attrId = attrIdList and attrIdList[self._index]

	Rouge2_IconHelper.setAttributeIcon(attrId, self._imageBXSAttrIcon)
end

function Rouge2_BackpackSkillShowItem:playAnim()
	if self._preIsEmpty == nil or self._preIsEmpty == self._isEmpty then
		return
	end

	if self._isEmpty then
		self._animator:Play("empty", 0, 0)
	else
		self._animator:Play("unempty", 0, 0)
	end
end

function Rouge2_BackpackSkillShowItem:refreshEmptyTips()
	local hasAnySkillEquip = Rouge2_BackpackController.instance:isCanEquipAnySkill(self._index)

	gohelper.setActive(self._goTips1, not hasAnySkillEquip)
	gohelper.setActive(self._goTips2, hasAnySkillEquip)
	gohelper.setActive(self._goEmptyEffect, hasAnySkillEquip)
end

function Rouge2_BackpackSkillShowItem:_refreshAssemblyItem(obj, index)
	local goType1 = gohelper.findChild(obj, "go_Type1")
	local goType2 = gohelper.findChild(obj, "go_Type2")
	local useType1 = index % 2 ~= 0

	gohelper.setActive(goType1, useType1)
	gohelper.setActive(goType2, not useType1)
end

function Rouge2_BackpackSkillShowItem:_onUpdateActiveSkillInfo()
	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_BackpackSkillShowItem:onDestroy()
	self._simageSkillIcon:UnLoadImage()
end

return Rouge2_BackpackSkillShowItem
