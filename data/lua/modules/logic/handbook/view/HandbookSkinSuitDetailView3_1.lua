-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView3_1.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_1", package.seeall)

local HandbookSkinSuitDetailView3_1 = class("HandbookSkinSuitDetailView3_1", HandbookSkinSuitDetailViewBase)

function HandbookSkinSuitDetailView3_1:_editableInitView()
	return
end

function HandbookSkinSuitDetailView3_1:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)
	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

return HandbookSkinSuitDetailView3_1
