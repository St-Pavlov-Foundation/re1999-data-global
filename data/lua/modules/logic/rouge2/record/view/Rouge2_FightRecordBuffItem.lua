-- chunkname: @modules/logic/rouge2/record/view/Rouge2_FightRecordBuffItem.lua

module("modules.logic.rouge2.record.view.Rouge2_FightRecordBuffItem", package.seeall)

local Rouge2_FightRecordBuffItem = class("Rouge2_FightRecordBuffItem", LuaCompBase)

function Rouge2_FightRecordBuffItem:init(go)
	self.go = go
	self._simageBuffIcon = gohelper.findChildSingleImage(self.go, "simage_BuffIcon")
	self._imageBuffRare = gohelper.findChildImage(self.go, "image_BuffRare")
end

function Rouge2_FightRecordBuffItem:addEventListeners()
	return
end

function Rouge2_FightRecordBuffItem:removeEventListeners()
	return
end

function Rouge2_FightRecordBuffItem:onUpdateMO(buffId, index)
	self._buffId = buffId
	self._index = index

	self:refreshUI()
end

function Rouge2_FightRecordBuffItem:refreshUI()
	Rouge2_IconHelper.setItemIconAndRare(self._buffId, self._simageBuffIcon, self._imageBuffRare)
end

return Rouge2_FightRecordBuffItem
