-- chunkname: @modules/logic/versionactivity2_7/towergift/view/DestinyStoneGiftPickChoiceListItem.lua

module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceListItem", package.seeall)

local DestinyStoneGiftPickChoiceListItem = class("DestinyStoneGiftPickChoiceListItem", ListScrollCellExtend)

function DestinyStoneGiftPickChoiceListItem:onInitView()
	self._gorole = gohelper.findChild(self.viewGO, "role")
	self._godestiny = gohelper.findChild(self.viewGO, "#go_destiny")
	self._golocked = gohelper.findChild(self.viewGO, "#go_destiny/locked")
	self._simagelockStone = gohelper.findChildSingleImage(self.viewGO, "#go_destiny/locked/#image_stone")
	self._gounlocked = gohelper.findChild(self.viewGO, "#go_destiny/unlock")
	self._simageunlockStone = gohelper.findChildSingleImage(self.viewGO, "#go_destiny/unlock/#image_stone")
	self._txtlevel = gohelper.findChildText(self.viewGO, "#go_destiny/unlock/#txt_level")
	self._goselect = gohelper.findChild(self.viewGO, "select")
	self._btnclick = gohelper.findChildButton(self.viewGO, "go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DestinyStoneGiftPickChoiceListItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, self.updateSelect, self)
end

function DestinyStoneGiftPickChoiceListItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, self.updateSelect, self)
end

function DestinyStoneGiftPickChoiceListItem:_btnclickOnClick()
	DestinyStoneGiftPickChoiceListModel.instance:setCurrentSelectMo(self._mo)
end

function DestinyStoneGiftPickChoiceListItem:updateSelect()
	local isSelect = DestinyStoneGiftPickChoiceListModel.instance:isSelectedMo(self._mo.stoneId)

	gohelper.setActive(self._goselect, isSelect)
end

function DestinyStoneGiftPickChoiceListItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
	self:updateSelect()
end

function DestinyStoneGiftPickChoiceListItem:refreshUI()
	if not self._mo then
		return
	end

	self:_refreshHeroItem()
	self:_refreshStone()
end

function DestinyStoneGiftPickChoiceListItem:_refreshHeroItem()
	if not self.herocomponent then
		self.herocomponent = MonoHelper.addNoUpdateLuaComOnceToGo(self._gorole, DestinyStoneGiftPickChoiceListHeroItem)

		self.herocomponent:init(self._gorole)
	end

	local mo = SummonCustomPickChoiceMO.New()

	mo:init(tonumber(self._mo.heroId))
	self.herocomponent:onUpdateMO(mo)
end

function DestinyStoneGiftPickChoiceListItem:_refreshStone()
	local isUnLock = self._mo.isUnLock

	gohelper.setActive(self._golocked, not isUnLock)
	gohelper.setActive(self._gounlocked, isUnLock)

	if isUnLock then
		self._txtlevel.text = GameUtil.getRomanNums(self._mo.stonelevel)
	else
		self._txtlevel.text = ""
	end

	local name, icon = self._mo.stoneMo:getNameAndIcon()

	self._simagelockStone:LoadImage(icon)
	self._simageunlockStone:LoadImage(icon)
end

return DestinyStoneGiftPickChoiceListItem
