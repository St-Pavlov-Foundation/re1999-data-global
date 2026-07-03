-- chunkname: @modules/logic/rouge2/record/view/Rouge2_FightRecordDetailItem.lua

module("modules.logic.rouge2.record.view.Rouge2_FightRecordDetailItem", package.seeall)

local Rouge2_FightRecordDetailItem = class("Rouge2_FightRecordDetailItem", LuaCompBase)

function Rouge2_FightRecordDetailItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_FightRecordDetailItem)
end

function Rouge2_FightRecordDetailItem:init(go)
	self.go = go
	self._goBuffContent = gohelper.findChild(self.go, "#go_BuffContent")
	self._goEmptyBuff = gohelper.findChild(self.go, "#go_BuffContent/#go_EmtpyBuff")
	self._scrollBuffList = gohelper.findChildScrollRect(self.go, "#go_BuffContent/#scroll_BuffList")
	self._goBuffListContent = gohelper.findChild(self.go, "#go_BuffContent/#scroll_BuffList/Viewport/Content")
	self._goBuffItem = gohelper.findChild(self.go, "#go_BuffContent/#scroll_BuffList/Viewport/Content/#go_BuffItem")
	self._goDrag = gohelper.findChild(self.go, "#go_Drag")
	self._goHasDrag = gohelper.findChild(self.go, "#go_Drag/#go_HasDrag")
	self._simageDragIcon = gohelper.findChildSingleImage(self.go, "#go_Drag/#go_HasDrag/#simage_DragIcon")
	self._goEmptyDrag = gohelper.findChild(self.go, "#go_Drag/#go_EmptyDrag")
end

function Rouge2_FightRecordDetailItem:addEventListeners()
	return
end

function Rouge2_FightRecordDetailItem:removeEventListeners()
	return
end

function Rouge2_FightRecordDetailItem:onUpdateMO(mo)
	self.mo = mo
	self.reviewInfo = mo.info
	self.hasRecord = self.reviewInfo ~= nil
end

function Rouge2_FightRecordDetailItem:show(isShow)
	self._isShow = isShow

	gohelper.setActive(self.go, self._isShow)

	if not self._isShow then
		return
	end

	self:refreshUI()
end

function Rouge2_FightRecordDetailItem:refreshUI()
	self:refreshBuffList()
	self:refreshDragInfo()
end

function Rouge2_FightRecordDetailItem:refreshBuffList()
	self._buffList = {
		290024,
		220001
	}
	self._hasBuff = self._buffList and #self._buffList > 0

	gohelper.setActive(self._goBuffListContent, self._hasBuff)
	gohelper.setActive(self._goEmptyBuff, not self._hasBuff)

	if not self._hasBuff then
		return
	end

	gohelper.CreateObjList(self, self._refreshBuffItem, self._buffList, self._goBuffListContent, self._goBuffItem, Rouge2_FightRecordBuffItem)
end

function Rouge2_FightRecordDetailItem:_refreshBuffItem(buffItem, buffId, index)
	buffItem:onUpdateMO(buffId, index)
end

function Rouge2_FightRecordDetailItem:refreshDragInfo()
	local haveDrag = self.reviewInfo.drugId ~= nil and self.reviewInfo.drugId ~= 0

	gohelper.setActive(self._goHasDrag, haveDrag)
	gohelper.setActive(self._goEmptyDrag, not haveDrag)

	if not haveDrag then
		return
	end

	Rouge2_IconHelper.setFormulaIcon(self.reviewInfo.drugId, self._simageDragIcon)
end

function Rouge2_FightRecordDetailItem:isShow()
	return self._isShow
end

function Rouge2_FightRecordDetailItem:onDestroy()
	self._simageDragIcon:UnLoadImage()
end

return Rouge2_FightRecordDetailItem
