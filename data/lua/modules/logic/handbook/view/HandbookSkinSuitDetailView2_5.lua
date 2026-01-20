-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_5.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_5", package.seeall)

local HandbookSkinSuitDetailView2_5 = class("HandbookSkinSuitDetailView2_5", HandbookSkinSuitDetailViewBase)

function HandbookSkinSuitDetailView2_5:_editableInitView()
	return
end

function HandbookSkinSuitDetailView2_5:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)
	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

return HandbookSkinSuitDetailView2_5
