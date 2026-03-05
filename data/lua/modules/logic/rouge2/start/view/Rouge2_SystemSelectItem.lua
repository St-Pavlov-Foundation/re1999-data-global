-- chunkname: @modules/logic/rouge2/start/view/Rouge2_SystemSelectItem.lua

module("modules.logic.rouge2.start.view.Rouge2_SystemSelectItem", package.seeall)

local Rouge2_SystemSelectItem = class("Rouge2_SystemSelectItem", ListScrollCell)

function Rouge2_SystemSelectItem:init(go)
	self.go = go
	self._simageSystemIcon = gohelper.findChildSingleImage(self.go, "simage_SystemIcon")
	self._goSelectSystemName = gohelper.findChild(self.go, "go_SystemName/#go_Select")
	self._txtSelectSystemName = gohelper.findChildText(self.go, "go_SystemName/#go_Select/#txt_Name")
	self._goUnselectSystemName = gohelper.findChild(self.go, "go_SystemName/#go_Unselect")
	self._txtUnselectSystemName = gohelper.findChildText(self.go, "go_SystemName/#go_Unselect/#txt_Name")
	self._txtSystemDesc = gohelper.findChildText(self.go, "txt_SystemDesc")
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.go, "btn_Confirm", AudioEnum.Rouge2.SelectSystem)
	self._btnCancel = gohelper.findChildButtonWithAudio(self.go, "btn_Cancel", AudioEnum.Rouge2.CancelSystem)
	self._goHeroContent = gohelper.findChild(self.go, "scroll_HeroList/Viewport/Content")
	self._goHeroItem = gohelper.findChild(self.go, "scroll_HeroList/Viewport/Content/go_HeroItem")
end

function Rouge2_SystemSelectItem:addEventListeners()
	self._btnConfirm:AddClickListener(self._btnConfirmOnClick, self)
	self._btnCancel:AddClickListener(self._btnCancelOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateTeamSystem, self._onUpdateTeamSystem, self)
end

function Rouge2_SystemSelectItem:removeEventListeners()
	self._btnConfirm:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function Rouge2_SystemSelectItem:_btnConfirmOnClick()
	Rouge2_Rpc.instance:sendRouge2SetSystemIdRequest(self._systemId)
end

function Rouge2_SystemSelectItem:_btnCancelOnClick()
	Rouge2_Rpc.instance:sendRouge2SetSystemIdRequest(Rouge2_Enum.UnselectTeamSystemId)
end

function Rouge2_SystemSelectItem:onUpdateMO(systemCo)
	self._systemCo = systemCo
	self._systemId = systemCo and systemCo.id
	self._tagCo = Rouge2_CareerConfig.instance:getBattleTagConfigBySystemId(self._systemId)
	self._tagId = self._tagCo and self._tagCo.id

	self:initHeroList()
	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_SystemSelectItem:refreshInfo()
	self._curTeamSystemId = Rouge2_Model.instance:getCurTeamSystemId()
	self._isSelectSystem = self._curTeamSystemId == self._systemId
end

function Rouge2_SystemSelectItem:refreshUI()
	local tagName = self._tagCo and self._tagCo.tagName

	self._txtSelectSystemName.text = tagName
	self._txtUnselectSystemName.text = tagName

	gohelper.setActive(self._goSelectSystemName, self._isSelectSystem)
	gohelper.setActive(self._goUnselectSystemName, not self._isSelectSystem)

	self._txtSystemDesc.text = self._systemCo and self._systemCo.desc

	Rouge2_IconHelper.setTeamSystemIcon(self._systemId, self._simageSystemIcon)
	gohelper.CreateObjList(self, self._refreshHeroItem, self._heroList, self._goHeroContent, self._goHeroItem, Rouge2_SystemHeroItem)
	gohelper.setActive(self._btnCancel.gameObject, self._isSelectSystem)
	gohelper.setActive(self._btnConfirm.gameObject, not self._isSelectSystem)
end

function Rouge2_SystemSelectItem:initHeroList()
	self._heroList = Rouge2_SystemController.instance:getHeroListByBattleTag(self._tagId)

	table.sort(self._heroList, self._heroSortFunc)
end

function Rouge2_SystemSelectItem._heroSortFunc(aHeroCo, bHeroCo)
	local aHeroMo = HeroModel.instance:getByHeroId(aHeroCo.id)
	local bHeroMo = HeroModel.instance:getByHeroId(bHeroCo.id)
	local aLevel = aHeroMo and aHeroMo.level or 0
	local bLevel = bHeroMo and bHeroMo.level or 0

	if aLevel ~= bLevel then
		return bLevel < aLevel
	end

	if aHeroCo.rare ~= bHeroCo.rare then
		return aHeroCo.rare > bHeroCo.rare
	end

	local aExSkillLevel = aHeroMo and aHeroMo.exSkillLevel or 0
	local bExSkillLevel = bHeroMo and bHeroMo.exSkillLevel or 0

	if aExSkillLevel ~= bExSkillLevel then
		return bExSkillLevel < aExSkillLevel
	end

	return aHeroCo.id > bHeroCo.id
end

function Rouge2_SystemSelectItem:_refreshHeroItem(heroItem, heroCo, index)
	heroItem:onUpdateMO(heroCo, index)
end

function Rouge2_SystemSelectItem:_onUpdateTeamSystem()
	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_SystemSelectItem:onDestroy()
	self._simageSystemIcon:UnLoadImage()
end

return Rouge2_SystemSelectItem
