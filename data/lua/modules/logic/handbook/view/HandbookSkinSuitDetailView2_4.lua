-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_4.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_4", package.seeall)

local HandbookSkinSuitDetailView2_4 = class("HandbookSkinSuitDetailView2_4", HandbookSkinSuitDetailViewBase)
local skinSuitId = 20014

function HandbookSkinSuitDetailView2_4:onInitView()
	HandbookSkinSuitDetailViewBase.onInitView(self)
end

function HandbookSkinSuitDetailView2_4:_editableInitView()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function HandbookSkinSuitDetailView2_4:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)
	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

function HandbookSkinSuitDetailView2_4:refreshUI()
	return
end

function HandbookSkinSuitDetailView2_4:refreshBtnStatus()
	return
end

return HandbookSkinSuitDetailView2_4
