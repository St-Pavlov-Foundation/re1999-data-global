-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_9.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_9", package.seeall)

local HandbookSkinSuitDetailView2_9 = class("HandbookSkinSuitDetailView2_9", HandbookSkinSuitDetailViewBase)

function HandbookSkinSuitDetailView2_9:_editableInitView()
	return
end

function HandbookSkinSuitDetailView2_9:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)
	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

return HandbookSkinSuitDetailView2_9
