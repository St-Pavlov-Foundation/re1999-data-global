-- chunkname: @modules/logic/handbook/view/HandbookSkinFloorItem.lua

module("modules.logic.handbook.view.HandbookSkinFloorItem", package.seeall)

local HandbookSkinFloorItem = class("HandbookSkinFloorItem", ListScrollCellExtend)

function HandbookSkinFloorItem:onInitView()
	gohelper.setActive(self.viewGO, true)

	self._goSelectedState = gohelper.findChild(self.viewGO, "#select")
	self._goUnSelectedState = gohelper.findChild(self.viewGO, "#unclick")
	self._txtSelectedFloorName = gohelper.findChildText(self._goSelectedState, "#name")
	self._txtUnSelectedFloorName = gohelper.findChildText(self._goUnSelectedState, "#name")
	self._txtSelectedFloorNameEn = gohelper.findChildText(self._goSelectedState, "#name/#name_en")
	self._txtUnSelectedFloorNameEn = gohelper.findChildText(self._goUnSelectedState, "#name/#name_en")
	self._txtSelectedCurSuitIdx = gohelper.findChildText(self._goSelectedState, "#num")
	self._txtUnSelectedCurSuitIdx = gohelper.findChildText(self._goUnSelectedState, "#num")
	self._txtSelectedCurFloorIdx = gohelper.findChildText(self._goSelectedState, "#xulie")
	self._txtUnSelectedCurFloorIdx = gohelper.findChildText(self._goUnSelectedState, "#xulie")
	self._selectTabRedDot = gohelper.findChild(self.viewGO, "#unclick/#goRedDot")
	self._unSelectTabRedDot = gohelper.findChild(self.viewGO, "#select/#goRedDot")
	self._click = gohelper.findChildClickWithAudio(self.viewGO, "#unclick/btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookSkinFloorItem:addEvents()
	self._click:AddClickListener(self.onClick, self)
end

function HandbookSkinFloorItem:removeEvents()
	self._click:RemoveClickListener()
end

function HandbookSkinFloorItem:onClick()
	if self._onClickAction then
		self._onClickAction(self._clickActionObj, self)
	end
end

function HandbookSkinFloorItem:setClickAction(clickAction, clickActionObj)
	self._onClickAction = clickAction
	self._clickActionObj = clickActionObj
end

function HandbookSkinFloorItem:_editableInitView()
	return
end

function HandbookSkinFloorItem:onUpdateData(cfg, index)
	self._suitGroupCfg = cfg
	self._idx = index
	self._suitList = HandbookConfig.instance:getSkinSuitCfgListInGroup(cfg.id) or {}
	self._suitCount = #self._suitList
	self._curSuitIdx = 1
	self._skinIdList = {}

	for i = 1, #self._suitList do
		local suitCfg = self._suitList[i]

		tabletool.addValues(self._skinIdList, HandbookConfig.instance:getSkinIdListBySuitId(suitCfg.id))
	end

	self._skinCount = #self._skinIdList
end

function HandbookSkinFloorItem:getHasSkinCount()
	local skinIdList = self._skinIdList

	if not skinIdList or #skinIdList < 1 then
		return 0
	end

	local hasCount = 0
	local tHeroModel = HeroModel.instance

	for i = 0, #skinIdList do
		if tHeroModel:checkHasSkin(skinIdList[i]) then
			hasCount = hasCount + 1
		end
	end

	return hasCount
end

function HandbookSkinFloorItem:getIdx()
	return self._idx
end

function HandbookSkinFloorItem:refreshFloorView()
	self._txtSelectedFloorName.text = self._suitGroupCfg.name
	self._txtUnSelectedFloorName.text = self._suitGroupCfg.name
	self._txtSelectedFloorNameEn.text = self._suitGroupCfg.nameEn
	self._txtUnSelectedFloorNameEn.text = self._suitGroupCfg.nameEn
	self._txtSelectedCurFloorIdx.text = self._idx
	self._txtUnSelectedCurFloorIdx.text = self._idx
end

function HandbookSkinFloorItem:refreshCurSuitIdx()
	local skinNum = self._skinIdList and #self._skinIdList or 0
	local hasSkinCount = self:getHasSkinCount()
	local str = hasSkinCount .. "/" .. skinNum

	self._txtSelectedCurSuitIdx.text = str
	self._txtUnSelectedCurSuitIdx.text = str
end

function HandbookSkinFloorItem:refreshSelectState(selected)
	self._isSelected = selected

	if self._isSelected then
		if self._showRedDot then
			local groupId = self._suitGroupCfg.id

			HandbookController.instance:markHandbookSkinRedDotShow(groupId)
			self:refreshRedDot()
		end

		gohelper.setActive(self._goSelectedState, true)
		gohelper.setActive(self._goUnSelectedState, false)
	else
		gohelper.setActive(self._goSelectedState, false)
		gohelper.setActive(self._goUnSelectedState, true)
	end
end

function HandbookSkinFloorItem:refreshRedDot()
	local groupId = self._suitGroupCfg.id
	local needRedDot = HandbookEnum.HandbookSkinShowRedDotMap[groupId]

	if not needRedDot then
		gohelper.setActive(self._selectTabRedDot, false)
		gohelper.setActive(self._unSelectTabRedDot, false)

		return
	end

	self._showRedDot = HandbookController.instance:isHandbookSkinRedDotShow(groupId)

	gohelper.setActive(self._selectTabRedDot, self._showRedDot)
	gohelper.setActive(self._unSelectTabRedDot, self._showRedDot)
end

function HandbookSkinFloorItem:hasRedDot()
	return self._showRedDot
end

function HandbookSkinFloorItem:onDestroyView()
	return
end

return HandbookSkinFloorItem
