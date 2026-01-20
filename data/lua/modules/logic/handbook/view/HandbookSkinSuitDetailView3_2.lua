-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView3_2.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_2", package.seeall)

local HandbookSkinSuitDetailView3_2 = class("HandbookSkinSuitDetailView3_2", HandbookSkinSuitDetailViewBase)

function HandbookSkinSuitDetailView3_2:_editableInitView()
	return
end

function HandbookSkinSuitDetailView3_2:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)
	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

return HandbookSkinSuitDetailView3_2
