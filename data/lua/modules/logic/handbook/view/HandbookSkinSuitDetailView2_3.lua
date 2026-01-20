-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_3.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_3", package.seeall)

local HandbookSkinSuitDetailView2_3 = class("HandbookSkinSuitDetailView2_3", HandbookSkinSuitDetailViewBase)
local skinSuitId = 20010

function HandbookSkinSuitDetailView2_3:onInitView()
	HandbookSkinSuitDetailViewBase.onInitView(self)
end

function HandbookSkinSuitDetailView2_3:_editableInitView()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._viewMatCtrl = self.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
end

function HandbookSkinSuitDetailView2_3:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)

	if not self._isSuitSwitch and self._viewMatCtrl then
		self._viewMatCtrl.vector_02 = Vector4.New(1, 1, 0.18, 0)
	end

	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

function HandbookSkinSuitDetailView2_3:refreshUI()
	return
end

function HandbookSkinSuitDetailView2_3:refreshBtnStatus()
	return
end

function HandbookSkinSuitDetailView2_3:_refreshBg()
	return
end

function HandbookSkinSuitDetailView2_3:onDestroyView()
	return
end

return HandbookSkinSuitDetailView2_3
