-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_8.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_8", package.seeall)

local HandbookSkinSuitDetailView2_8 = class("HandbookSkinSuitDetailView2_8", HandbookSkinSuitDetailViewBase)
local skinSuitId = 20018

function HandbookSkinSuitDetailView2_8:onInitView()
	HandbookSkinSuitDetailViewBase.onInitView(self)
end

function HandbookSkinSuitDetailView2_8:_editableInitView()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._viewMatCtrl = self.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
end

function HandbookSkinSuitDetailView2_8:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)

	if self._viewMatCtrl then
		self._viewMatCtrl.vector_02 = Vector4.New(1, 1, 0.18, 0)

		if self._isSuitSwitch then
			-- block empty
		end
	end

	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

function HandbookSkinSuitDetailView2_8:refreshUI()
	return
end

function HandbookSkinSuitDetailView2_8:refreshBtnStatus()
	return
end

function HandbookSkinSuitDetailView2_8:_refreshBg()
	return
end

function HandbookSkinSuitDetailView2_8:onDestroyView()
	return
end

return HandbookSkinSuitDetailView2_8
