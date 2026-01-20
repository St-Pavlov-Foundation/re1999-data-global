-- chunkname: @modules/logic/rouge2/map/view/skilldrop/Rouge2_ActiveSkillDropView.lua

module("modules.logic.rouge2.map.view.skilldrop.Rouge2_ActiveSkillDropView", package.seeall)

local Rouge2_ActiveSkillDropView = class("Rouge2_ActiveSkillDropView", BaseView)

function Rouge2_ActiveSkillDropView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goSelect = gohelper.findChild(self.viewGO, "Title/#go_Select")
	self._goDrop = gohelper.findChild(self.viewGO, "Title/#go_Drop")
	self._goLoss = gohelper.findChild(self.viewGO, "Title/#go_Loss")
	self._scrollSkill = gohelper.findChildScrollRect(self.viewGO, "#scroll_Skill")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_Skill/Viewport/#go_Content")
	self._goSkillItem = gohelper.findChild(self.viewGO, "#scroll_Skill/Viewport/#go_Content/#go_SkillItem")
	self._btnSelect = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Select", AudioEnum.Rouge2.SelectDropItem)
	self._goToolbar = gohelper.findChild(self.viewGO, "#go_Toolbar")
	self._goTopLeft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goCapacity = gohelper.findChild(self.viewGO, "Capacity")
	self._txtCapacity = gohelper.findChildText(self.viewGO, "Capacity/List/Capacity/#txt_Capacity")
	self._goAssemblyList = gohelper.findChild(self.viewGO, "Capacity/List/#go_AssemblyList")
	self._goAssemblyItem = gohelper.findChild(self.viewGO, "Capacity/List/#go_AssemblyList/#go_AssemblyItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ActiveSkillDropView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnSelect:AddClickListener(self._btnSelectOnClick, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectDropSkillItem, self._onSelectDropSkillItem, self)
end

function Rouge2_ActiveSkillDropView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
end

function Rouge2_ActiveSkillDropView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_ActiveSkillDropView:_btnSelectOnClick()
	if not self._selectIndex then
		return
	end

	self._selectSkillId = self._skillList[self._selectIndex]

	self:_tryStatDrop()

	self._callback = Rouge2_Rpc.instance:sendRouge2SelectDropRequest({
		self._selectIndex
	}, self._rpcReceiveCallback, self)
end

function Rouge2_ActiveSkillDropView:_rpcReceiveCallback(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self._callback = nil

	self:closeThis()
end

function Rouge2_ActiveSkillDropView:_tryStatDrop()
	if self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		return
	end

	local itemNameList = Rouge2_BackpackHelper.getItemNameList(self._dataType, self._skillList)
	local skillCo = Rouge2_BackpackHelper.getItemCofigAndMo(self._dataType, self._selectSkillId)
	local skillId = skillCo and skillCo.id
	local skillName = skillCo and skillCo.name

	Rouge2_StatController.instance:statSelectDrop(Rouge2_MapEnum.DropType.ActiveSkill, skillId, skillName, itemNameList)
end

function Rouge2_ActiveSkillDropView:_editableInitView()
	self._goScrollSkill = self._scrollSkill.gameObject

	Rouge2_AttributeToolBar.Load(self._goToolbar, Rouge2_Enum.AttributeToolType.Default)
end

function Rouge2_ActiveSkillDropView:onOpen()
	self:initViewParam()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.DropActiveSkill)
end

function Rouge2_ActiveSkillDropView:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_ActiveSkillDropView:initViewParam()
	self._viewEnum = self.viewParam and self.viewParam.viewEnum
	self._dataType = self.viewParam and self.viewParam.dataType
	self._skillList = self.viewParam and self.viewParam.itemList or {}

	if self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select then
		NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
	end
end

function Rouge2_ActiveSkillDropView:refreshUI()
	self:refreshTitle()
	self:refreshButton()
	self:refreshAssembly()
	self:refreshActiveSkillList()
end

function Rouge2_ActiveSkillDropView:refreshTitle()
	gohelper.setActive(self._goSelect, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goDrop, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._goLoss, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Loss)
end

function Rouge2_ActiveSkillDropView:refreshButton()
	gohelper.setActive(self._btnSelect.gameObject, self._selectIndex and self._selectIndex > 0)
	gohelper.setActive(self._goTopLeft, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._btnClose.gameObject, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select)
end

function Rouge2_ActiveSkillDropView:refreshActiveSkillList()
	gohelper.CreateObjList(self, self._refreshActiveSkill, self._skillList, self._goContent, self._goSkillItem, Rouge2_ActiveSkillDropItem)
end

function Rouge2_ActiveSkillDropView:_refreshActiveSkill(buffItem, skillId, index)
	buffItem:setParentScroll(self._goScrollSkill)
	buffItem:onUpdateMO(index, self._viewEnum, self._dataType, skillId)
end

function Rouge2_ActiveSkillDropView:_onSelectDropSkillItem(index)
	self._selectIndex = index

	gohelper.setActive(self._btnSelect.gameObject, self._selectIndex and self._selectIndex > 0)
end

function Rouge2_ActiveSkillDropView:refreshAssembly()
	local isUseBXS = Rouge2_Model.instance:isUseBXSCareer()

	gohelper.setActive(self._goCapacity, not isUseBXS)

	if isUseBXS then
		return
	end

	self._maxAssembleCost = Rouge2_Model.instance:getAttrValue(Rouge2_MapEnum.BasicAttrId.ActiveSkillCapacity)
	self._allAssembleCost = Rouge2_BackpackModel.instance:getUseActiveSkillAssembleCost()
	self._txtCapacity.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge2_backpackskillview_capacity"), self._allAssembleCost, self._maxAssembleCost)

	gohelper.CreateNumObjList(self._goAssemblyList, self._goAssemblyItem, self._maxAssembleCost, self._refreshSingleAssembly, self)
end

function Rouge2_ActiveSkillDropView:_refreshSingleAssembly(obj, index)
	local goType1 = gohelper.findChild(obj, "go_Type1")
	local goType2 = gohelper.findChild(obj, "go_Type2")
	local useType1 = index % 2 ~= 0

	gohelper.setActive(goType1, useType1)
	gohelper.setActive(goType2, not useType1)

	local goRoot = useType1 and goType1 or goType2
	local goSelected = gohelper.findChild(goRoot, "#image_Icon")

	gohelper.setActive(goSelected, index <= self._allAssembleCost)
end

function Rouge2_ActiveSkillDropView:onClose()
	if self._callback then
		Rouge2_Rpc.instance:removeCallbackById(self._callback)

		self._callback = nil
	end
end

return Rouge2_ActiveSkillDropView
