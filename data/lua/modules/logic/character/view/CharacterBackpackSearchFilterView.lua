-- chunkname: @modules/logic/character/view/CharacterBackpackSearchFilterView.lua

module("modules.logic.character.view.CharacterBackpackSearchFilterView", package.seeall)

local CharacterBackpackSearchFilterView = class("CharacterBackpackSearchFilterView", BaseView)

function CharacterBackpackSearchFilterView:onInitView()
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closefilterview")
	self._godmg1 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg1")
	self._godmg2 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg2")
	self._goattr1 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr1")
	self._goattr2 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr2")
	self._goattr3 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr3")
	self._goattr4 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr4")
	self._goattr5 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr5")
	self._goattr6 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr6")
	self._golocation1 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location1")
	self._golocation2 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location2")
	self._golocation3 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location3")
	self._golocation4 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location4")
	self._golocation5 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location5")
	self._golocation6 = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location6")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_reset")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterBackpackSearchFilterView:addEvents()
	self._btnclosefilterview:AddClickListener(self._btnclosefilterviewOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function CharacterBackpackSearchFilterView:removeEvents()
	self._btnclosefilterview:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function CharacterBackpackSearchFilterView:_btnclosefilterviewOnClick()
	self:closeThis()
end

function CharacterBackpackSearchFilterView:_btnresetOnClick()
	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end

	self:_refreshView()
end

function CharacterBackpackSearchFilterView:_btnconfirmOnClick()
	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, self._filterType)

	local param = {}

	param.dmgs = self._selectDmgs
	param.attrs = self._selectAttrs
	param.locations = self._selectLocations

	CharacterController.instance:dispatchEvent(CharacterEvent.FilterBackpack, param)
	self:closeThis()
end

function CharacterBackpackSearchFilterView:_editableInitView()
	self._dmgSelects = self:getUserDataTb_()
	self._dmgUnselects = self:getUserDataTb_()
	self._dmgBtnClicks = self:getUserDataTb_()
	self._attrSelects = self:getUserDataTb_()
	self._attrUnselects = self:getUserDataTb_()
	self._attrBtnClicks = self:getUserDataTb_()
	self._locationSelects = self:getUserDataTb_()
	self._locationUnselects = self:getUserDataTb_()
	self._locationBtnClicks = self:getUserDataTb_()

	for i = 1, 2 do
		self._dmgUnselects[i] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/unselected")
		self._dmgSelects[i] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/selected")
		self._dmgBtnClicks[i] = gohelper.findChildButtonWithAudio(self.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/click")

		self._dmgBtnClicks[i]:AddClickListener(self._dmgBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._attrUnselects[i] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/unselected")
		self._attrSelects[i] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/selected")
		self._attrBtnClicks[i] = gohelper.findChildButtonWithAudio(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/click")

		self._attrBtnClicks[i]:AddClickListener(self._attrBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._locationUnselects[i] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/unselected")
		self._locationSelects[i] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/selected")
		self._locationBtnClicks[i] = gohelper.findChildButtonWithAudio(self.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/click")

		self._locationBtnClicks[i]:AddClickListener(self._locationBtnOnClick, self, i)
	end
end

function CharacterBackpackSearchFilterView:_attrBtnOnClick(i)
	self._selectAttrs[i] = not self._selectAttrs[i]

	self:_refreshView()
end

function CharacterBackpackSearchFilterView:_dmgBtnOnClick(i)
	if not self._selectDmgs[i] then
		self._selectDmgs[3 - i] = self._selectDmgs[i]
	end

	self._selectDmgs[i] = not self._selectDmgs[i]

	self:_refreshView()
end

function CharacterBackpackSearchFilterView:_locationBtnOnClick(i)
	self._selectLocations[i] = not self._selectLocations[i]

	self:_refreshView()
end

function CharacterBackpackSearchFilterView:onUpdateParam()
	return
end

function CharacterBackpackSearchFilterView:onOpen()
	self._selectDmgs = self.viewParam.dmgs
	self._selectAttrs = self.viewParam.attrs
	self._selectLocations = self.viewParam.locations
	self._filterType = self.viewParam.filterType or CharacterEnum.FilterType.BackpackHero

	self:_refreshView()
end

function CharacterBackpackSearchFilterView:_refreshView()
	for i = 1, 2 do
		gohelper.setActive(self._dmgUnselects[i], not self._selectDmgs[i])
		gohelper.setActive(self._dmgSelects[i], self._selectDmgs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._attrUnselects[i], not self._selectAttrs[i])
		gohelper.setActive(self._attrSelects[i], self._selectAttrs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._locationUnselects[i], not self._selectLocations[i])
		gohelper.setActive(self._locationSelects[i], self._selectLocations[i])
	end
end

function CharacterBackpackSearchFilterView:onClose()
	return
end

function CharacterBackpackSearchFilterView:onDestroyView()
	for i = 1, 2 do
		self._dmgBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._attrBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._locationBtnClicks[i]:RemoveClickListener()
	end
end

return CharacterBackpackSearchFilterView
