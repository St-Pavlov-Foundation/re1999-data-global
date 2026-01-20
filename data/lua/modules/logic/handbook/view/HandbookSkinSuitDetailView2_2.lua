-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_2.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_2", package.seeall)

local HandbookSkinSuitDetailView2_2 = class("HandbookSkinSuitDetailView2_2", HandbookSkinSuitDetailViewBase)
local skinSuitId = 20012

function HandbookSkinSuitDetailView2_2:onInitView()
	HandbookSkinSuitDetailViewBase.onInitView(self)
end

function HandbookSkinSuitDetailView2_2:_editableInitView()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function HandbookSkinSuitDetailView2_2:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)
	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

return HandbookSkinSuitDetailView2_2
