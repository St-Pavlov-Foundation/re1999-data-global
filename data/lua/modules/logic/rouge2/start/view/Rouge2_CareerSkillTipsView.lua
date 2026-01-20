-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerSkillTipsView.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerSkillTipsView", package.seeall)

local Rouge2_CareerSkillTipsView = class("Rouge2_CareerSkillTipsView", BaseView)
local IncludeTypeList1 = {
	Rouge2_Enum.RelicsDescType.NarrativeDesc
}
local IncludeTypeList2 = {
	Rouge2_Enum.RelicsDescType.Desc
}

function Rouge2_CareerSkillTipsView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._simageSkillIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Root/Title/#image_SkillIcon")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_Root/Title/#image_Icon")
	self._txtSkillName = gohelper.findChildText(self.viewGO, "#go_Root/Title/#txt_SkillName")
	self._goCapacity = gohelper.findChild(self.viewGO, "#go_Root/Title/#go_Capacity")
	self._goAssemblyList = gohelper.findChild(self.viewGO, "#go_Root/Title/#go_Capacity/#go_AssemblyList")
	self._goAssemblyItem = gohelper.findChild(self.viewGO, "#go_Root/Title/#go_Capacity/#go_AssemblyList/#go_AssemblyItem")
	self._scrolloverview = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#scroll_overview")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#txt_Descr")
	self._goCareer = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_Career")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_Career/Name/image_NameBG/#txt_Name")
	self._txtCareerDescr = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_Career/#txt_CareerDescr")
	self._goBtnContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_BtnContainer")
	self._btnReplace = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_BtnContainer/#btn_Replace", AudioEnum.Rouge2.RemoveActiveSkill)
	self._btnUse = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_BtnContainer/#btn_Use", AudioEnum.Rouge2.EquipActiveSkill)
	self._btnRemove = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_BtnContainer/#btn_Remove", AudioEnum.Rouge2.RemoveActiveSkill)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerSkillTipsView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnReplace:AddClickListener(self._btnReplaceOnClick, self)
	self._btnUse:AddClickListener(self._btnUseOnClick, self)
	self._btnRemove:AddClickListener(self._btnRemoveOnClick, self)
end

function Rouge2_CareerSkillTipsView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnReplace:RemoveClickListener()
	self._btnUse:RemoveClickListener()
	self._btnRemove:RemoveClickListener()
end

function Rouge2_CareerSkillTipsView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_CareerSkillTipsView:_btnReplaceOnClick()
	if not self._skillUid then
		return
	end

	local selectIndex = Rouge2_BackpackSkillEditListModel.instance:getSelectUseSkillIndex()

	Rouge2_BackpackController.instance:tryReplaceActiveSkill(selectIndex, self._skillUid)
	self:closeThis()
end

function Rouge2_CareerSkillTipsView:_btnUseOnClick()
	if not self._skillUid then
		return
	end

	local selectIndex = Rouge2_BackpackSkillEditListModel.instance:getSelectUseSkillIndex()

	Rouge2_BackpackController.instance:tryReplaceActiveSkill(selectIndex, self._skillUid)
	self:closeThis()
end

function Rouge2_CareerSkillTipsView:_btnRemoveOnClick()
	if not self._skillUid then
		return
	end

	Rouge2_BackpackController.instance:tryRemoveActiveSkillByUid(self._skillUid)
	self:closeThis()
end

function Rouge2_CareerSkillTipsView:_editableInitView()
	return
end

function Rouge2_CareerSkillTipsView:onUpdateParam()
	self:refreshParams()
	self:refreshUI()
	self:updatePosition()
	self:usage2RefreshUI()
end

function Rouge2_CareerSkillTipsView:onOpen()
	self:refreshParams()
	self:refreshUI()
	self:updatePosition()
	self:usage2RefreshUI()
end

function Rouge2_CareerSkillTipsView:refreshParams()
	self._dataType = self.viewParam and self.viewParam.dataType
	self._dataId = self.viewParam and self.viewParam.dataId
	self._skillCo, self._skillMo = Rouge2_BackpackHelper.getItemCofigAndMo(self._dataType, self._dataId)
	self._skillUid = self._skillMo and self._skillMo:getUid()
	self._skillId = self._skillCo and self._skillCo.id
	self._tipPos = self.viewParam and self.viewParam.tipPos
	self._attributeId = self._skillCo and self._skillCo.attributeTag
	self._usage = self.viewParam and self.viewParam.usage
	self._usage = self._usage or Rouge2_Enum.SkillTipsUsage.Default
end

function Rouge2_CareerSkillTipsView:refreshUI()
	self._txtSkillName.text = self._skillCo and self._skillCo.name
	self._txtDescr.text = self._skillCo and self._skillCo.desc
	self._txtName.text = self._skillCo and self._skillCo.keyWord

	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._dataId, self._txtDescr, Rouge2_Enum.ItemDescMode.Full, IncludeTypeList1)
	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._dataId, self._txtCareerDescr, Rouge2_Enum.ItemDescMode.Full, IncludeTypeList2)

	local assemblyNum = self._skillCo and self._skillCo.assembleCost or 0

	gohelper.setActive(self._goCapacity, assemblyNum > 0)
	gohelper.CreateNumObjList(self._goAssemblyList, self._goAssemblyItem, assemblyNum)
	Rouge2_IconHelper.setActiveSkillIcon(self._skillId, self._simageSkillIcon)
	Rouge2_IconHelper.setAttributeIcon(self._attributeId, self._imageIcon)
end

function Rouge2_CareerSkillTipsView:updatePosition()
	local posX = self._tipPos and self._tipPos.x or 0
	local posY = self._tipPos and self._tipPos.y or 0

	recthelper.setAnchor(self._goRoot.transform, posX, posY)
end

function Rouge2_CareerSkillTipsView:usage2RefreshUI()
	local usageFunc = self:_getUsageRefreshUIFunc(self._usage)

	if usageFunc then
		usageFunc(self)
	end
end

function Rouge2_CareerSkillTipsView:_getUsageRefreshUIFunc(usage)
	if not self._usageRefreshFuncTab then
		self._usageRefreshFuncTab = {}
		self._usageRefreshFuncTab[Rouge2_Enum.SkillTipsUsage.Default] = self._refreshUI_Default
		self._usageRefreshFuncTab[Rouge2_Enum.SkillTipsUsage.BackpackEditView_Left] = self._refreshUI_BackpackEditView
		self._usageRefreshFuncTab[Rouge2_Enum.SkillTipsUsage.BackpackEditView_Right] = self._refreshUI_BackpackEditView
	end

	local func = self._usageRefreshFuncTab and self._usageRefreshFuncTab[usage]

	if not func then
		logError(string.format("Rouge2_CareerSkillTipsView:_getUsageRefreshUIFunc error ! usage = %s", usage))
	end

	return func
end

function Rouge2_CareerSkillTipsView:_refreshUI_Default()
	gohelper.setActive(self._goBtnContainer, false)
	gohelper.setActive(self._btnClose.gameObject, true)
end

function Rouge2_CareerSkillTipsView:_refreshUI_BackpackEditView()
	local selectIndex = Rouge2_BackpackSkillEditListModel.instance:getSelectUseSkillIndex()
	local isUse = Rouge2_BackpackModel.instance:isActiveSkillIndexInUse(selectIndex)
	local curShowSkillIndex = Rouge2_BackpackModel.instance:uid2UseActiveSkillIndex(self._skillUid)

	gohelper.setActive(self._goBtnContainer, true)
	gohelper.setActive(self._btnClose.gameObject, false)
	gohelper.setActive(self._btnReplace.gameObject, isUse and selectIndex ~= curShowSkillIndex)
	gohelper.setActive(self._btnRemove.gameObject, isUse and selectIndex == curShowSkillIndex)
	gohelper.setActive(self._btnUse.gameObject, not isUse and selectIndex)
end

function Rouge2_CareerSkillTipsView:onClose()
	return
end

function Rouge2_CareerSkillTipsView:onDestroyView()
	self._simageSkillIcon:UnLoadImage()
end

return Rouge2_CareerSkillTipsView
