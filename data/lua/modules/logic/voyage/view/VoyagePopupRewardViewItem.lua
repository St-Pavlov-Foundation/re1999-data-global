-- chunkname: @modules/logic/voyage/view/VoyagePopupRewardViewItem.lua

module("modules.logic.voyage.view.VoyagePopupRewardViewItem", package.seeall)

local VoyagePopupRewardViewItem = class("VoyagePopupRewardViewItem", ActivityGiftForTheVoyageItemBase)

function VoyagePopupRewardViewItem:onInitView()
	self._imagenum = gohelper.findChildImage(self.viewGO, "#image_num")
	self._gonum = gohelper.findChild(self.viewGO, "#go_num")
	self._goimgall = gohelper.findChild(self.viewGO, "#go_imgall")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "#txt_taskdesc")
	self._scrollRewards = gohelper.findChildScrollRect(self.viewGO, "#scroll_Rewards")
	self._goRewards = gohelper.findChild(self.viewGO, "#scroll_Rewards/Viewport/#go_Rewards")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VoyagePopupRewardViewItem:addEvents()
	return
end

function VoyagePopupRewardViewItem:removeEvents()
	return
end

function VoyagePopupRewardViewItem:_editableInitView()
	self._gonumTrans = self._gonum.transform
	self._bg = gohelper.findChild(self.viewGO, "bg")
end

local kIgnoreChildCount = 1

function VoyagePopupRewardViewItem:onUpdateMO(mo)
	local childCount = self._gonumTrans.childCount
	local n = math.max(self._index, childCount)

	for i = 1 + kIgnoreChildCount, n do
		if childCount <= i - 1 then
			break
		end

		local t = self._gonumTrans:GetChild(i - 1)

		GameUtil.setActive01(t, self._index == i - kIgnoreChildCount)
	end

	ZProj.UGUIHelper.SetColorAlpha(self._bg:GetComponent(gohelper.Type_Image), mo.id > 0 and 0.7 or 1)
	VoyagePopupRewardViewItem.super.onUpdateMO(self, mo)
end

function VoyagePopupRewardViewItem:onRefresh()
	local mo = self._mo

	self._txttaskdesc.text = mo.desc

	gohelper.setActive(self._goimgall, mo.id == -1)
	self:_refreshRewardList(self._goRewards)

	self._scrollRewards.horizontalNormalizedPosition = 0
end

return VoyagePopupRewardViewItem
