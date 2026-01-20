-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeToolBar.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeToolBar", package.seeall)

local Rouge2_AttributeToolBar = class("Rouge2_AttributeToolBar", LuaCompBase)

function Rouge2_AttributeToolBar.Load(go, showType)
	showType = showType or Rouge2_Enum.AttributeToolType.Default

	if gohelper.isNil(go) then
		logError("Rouge2_AttributeToolBar.Load error !!! go is nil")

		return
	end

	local loader = PrefabInstantiate.Create(go)

	loader:startLoad(Rouge2_Enum.ResPath.AttrToolBar, Rouge2_AttributeToolBar._onLoadToolBarDone, showType)
end

function Rouge2_AttributeToolBar._onLoadToolBarDone(showType, loader)
	local goToolBar = loader:getInstGO()

	MonoHelper.addNoUpdateLuaComOnceToGo(goToolBar, Rouge2_AttributeToolBar, showType)
end

function Rouge2_AttributeToolBar:ctor(showType)
	self._showType = showType
end

function Rouge2_AttributeToolBar:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "#go_Root")
	self._goBackpack = gohelper.findChild(self.go, "#go_Root/#go_Backpack")
	self._btnBackpack = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Backpack/#btn_Backpack", AudioEnum.Rouge2.OpenBag)
	self._imageBackpack = gohelper.findChildImage(self.go, "#go_Root/#go_Backpack/#btn_Backpack")
	self._goBackpackReddot = gohelper.findChild(self.go, "#go_Root/#go_Backpack/#go_Reddot")
	self._goBackpackTips = gohelper.findChild(self.go, "#go_Root/#go_Backpack/tips")
	self._btnBackpackTips = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Backpack/tips/bubble/#btn_Tips")
	self._goAttributeContainer = gohelper.findChild(self.go, "#go_Root/#go_AttributeContainer")
	self._goAttributeList = gohelper.findChild(self.go, "#go_Root/#go_AttributeContainer/#go_AttributeList")
	self._goAttributeItem = gohelper.findChild(self.go, "#go_Root/#go_AttributeContainer/#go_AttributeList/#go_AttributeItem")
	self._goSearch = gohelper.findChild(self.go, "#go_Root/#go_Search")
	self._btnSearch = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Search/#btn_Search", AudioEnum.Rouge2.OpenAttrDetail)

	gohelper.setActive(self._goBackpack, false)
	gohelper.setActive(self._goAttributeContainer, false)
	gohelper.setActive(self._goSearch, false)

	local reddotList = {}

	for _, reddotId in pairs(Rouge2_Enum.BagTabType2Reddot) do
		table.insert(reddotList, {
			id = reddotId
		})
	end

	RedDotController.instance:addMultiRedDot(self._goBackpackReddot, reddotList)
	self:showType2RefreshUI()
	self:refreshAttrList()
	self:refreshBackpackTips()
end

function Rouge2_AttributeToolBar:addEventListeners()
	self._btnBackpack:AddClickListener(self._btnBackpackOnClick, self)
	self._btnSearch:AddClickListener(self._btnSearchOnClick, self)
	self._btnBackpackTips:AddClickListener(self._btnBackpackTipsOnClick, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateBagInfo, self._onUpdateBagInfo, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateActiveSkillInfo, self._onUpdateActiveSkillInfo, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateAttrInfo, self._onUpdateAttrInfo, self)
end

function Rouge2_AttributeToolBar:removeEventListeners()
	self._btnBackpack:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnBackpackTips:RemoveClickListener()
end

function Rouge2_AttributeToolBar:_btnBackpackOnClick()
	Rouge2_ViewHelper.openBackpackTabView(Rouge2_Enum.BagTabType.Career)
end

function Rouge2_AttributeToolBar:_btnSearchOnClick()
	Rouge2_ViewHelper.openAttributeDetailView()
end

function Rouge2_AttributeToolBar:_btnBackpackTipsOnClick()
	Rouge2_ViewHelper.openBackpackTabView(Rouge2_Enum.BagTabType.ActiveSkill)
end

function Rouge2_AttributeToolBar:refreshAttrList()
	local attributeList = Rouge2_Model.instance:getHeroAttrInfoList() or {}

	gohelper.CreateObjList(self, self._refreshSingleAttribute, attributeList, self._goAttributeList, self._goAttributeItem, Rouge2_AttributeToolBarItem)
end

function Rouge2_AttributeToolBar:_refreshSingleAttribute(toolBarItem, attributeMo, index)
	local careerId = Rouge2_Model.instance:getCareerId()

	toolBarItem:refresh(index, careerId, attributeMo)
end

function Rouge2_AttributeToolBar:showType2RefreshUI()
	local refreshFunc = self:_showType2RefreshUIFunc(self._showType)

	if refreshFunc then
		refreshFunc(self)
	end
end

function Rouge2_AttributeToolBar:_showType2RefreshUIFunc(showType)
	if not self._showTypeFunc then
		self._showTypeFunc = {}
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Default] = self._refresh_Default
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Enter_Attr] = self._refresh_Enter_Attr
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Enter_Attr_Detail] = self._refresh_Enter_Attr_Detail
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Attr_Detail] = self._refresh_Attr_Detail
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Enter] = self._refresh_Enter
	end

	return self._showTypeFunc[showType]
end

function Rouge2_AttributeToolBar:_refresh_Default()
	gohelper.setActive(self._goAttributeContainer, true)
end

function Rouge2_AttributeToolBar:_refresh_Enter_Attr()
	gohelper.setActive(self._goBackpack, true)
	gohelper.setActive(self._goAttributeContainer, true)
	self:refreshBagEntranceIcon()
end

function Rouge2_AttributeToolBar:_refresh_Enter_Attr_Detail()
	gohelper.setActive(self._goSearch, true)
	gohelper.setActive(self._goBackpack, true)
	gohelper.setActive(self._goAttributeContainer, true)
	self:refreshBagEntranceIcon()
end

function Rouge2_AttributeToolBar:_refresh_Attr_Detail()
	gohelper.setActive(self._goSearch, true)
	gohelper.setActive(self._goAttributeContainer, true)
end

function Rouge2_AttributeToolBar:_refresh_Enter()
	gohelper.setActive(self._goBackpack, true)
	self:refreshBagEntranceIcon()
end

function Rouge2_AttributeToolBar:refreshBagEntranceIcon()
	local careerId = Rouge2_Model.instance:getCareerId()
	local careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)
	local bagEntranceIcon = careerCo and careerCo.bagEntranceIcon

	UISpriteSetMgr.instance:setRouge6Sprite(self._imageBackpack, bagEntranceIcon)
end

function Rouge2_AttributeToolBar:_onUpdateAttrInfo()
	self:refreshAttrList()
end

function Rouge2_AttributeToolBar:_onUpdateActiveSkillInfo()
	self:refreshBackpackTips()
end

function Rouge2_AttributeToolBar:_onUpdateBagInfo()
	self:refreshBackpackTips()
end

function Rouge2_AttributeToolBar:refreshBackpackTips()
	local hasAnyEquipSkill = Rouge2_BackpackController.instance:hasAnyActiveSkillCanEquip()

	gohelper.setActive(self._goBackpackTips, hasAnyEquipSkill)
end

function Rouge2_AttributeToolBar:onDestroy()
	return
end

return Rouge2_AttributeToolBar
