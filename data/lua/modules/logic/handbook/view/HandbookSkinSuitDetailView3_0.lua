-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView3_0.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_0", package.seeall)

local HandbookSkinSuitDetailView3_0 = class("HandbookSkinSuitDetailView3_0", HandbookSkinSuitDetailViewBase)

function HandbookSkinSuitDetailView3_0:_editableInitView()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function HandbookSkinSuitDetailView3_0:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)
	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

return HandbookSkinSuitDetailView3_0
