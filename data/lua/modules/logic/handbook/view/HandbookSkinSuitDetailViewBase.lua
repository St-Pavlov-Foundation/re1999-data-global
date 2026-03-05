-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailViewBase.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailViewBase", package.seeall)

local HandbookSkinSuitDetailViewBase = class("HandbookSkinSuitDetailViewBase", BaseView)

HandbookSkinSuitDetailViewBase.scrollableDiff = 50

function HandbookSkinSuitDetailViewBase:onInitView()
	self._skinItemRoot = gohelper.findChild(self.viewGO, "#go_scroll/#go_storyStages")
	self._imageBg = gohelper.findChildSingleImage(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#simage_FullBG")
	self._goscroll = gohelper.findChild(self.viewGO, "#go_scroll")
	self._scroll = self._goscroll:GetComponent(gohelper.Type_ScrollRect)
	self._textSkinThemeDescr = gohelper.findChildText(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#txt_Descr")
	self._viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._bgTrans = self._imageBg.transform

	local bgWidth = recthelper.getWidth(self._bgTrans)

	for i = 1, self._bgTrans.childCount do
		local child = self._bgTrans:GetChild(i - 1)

		if child then
			bgWidth = bgWidth + recthelper.getWidth(child)
		end
	end

	local uiRoot = ViewMgr.instance:getUIRoot()
	local uiRootWidth = recthelper.getWidth(uiRoot.transform)

	if bgWidth - uiRootWidth < HandbookSkinSuitDetailViewBase.scrollableDiff then
		self._scroll.horizontal = false
		self._scroll.vertical = false
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookSkinSuitDetailViewBase:addEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenedFinish, self)
end

function HandbookSkinSuitDetailViewBase:removeEvents()
	return
end

function HandbookSkinSuitDetailViewBase:_editableInitView()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function HandbookSkinSuitDetailViewBase:_getPhotoRootGo(photoCount)
	self._skinItemGoList = self:getUserDataTb_()

	for i = 1, photoCount do
		self._skinItemGoList[i] = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/handbookskinitem/photo" .. i)
	end
end

function HandbookSkinSuitDetailViewBase:onOpen()
	local viewParam = self.viewParam

	self._skinSuitId = viewParam and viewParam.skinThemeGroupId
	self._isSuitSwitch = viewParam and viewParam.suitSwitch
	self._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(self._skinSuitId)
	self._skinSuitGroupId = self._skinSuitCfg.highId

	local skinIdStr = self._skinSuitCfg.skinContain

	self._skinIdList = string.splitToNumber(skinIdStr, "|")

	self:addSwitchSuitBtns()

	if self._isSuitSwitch and self._viewAnimator then
		if self._viewAnimator:HasState(0, UnityEngine.Animator.StringToHash(UIAnimationName.Open)) then
			self._viewAnimator:Play(UIAnimationName.Open, 0, 1)
		elseif self._viewAnimator:HasState(0, UnityEngine.Animator.StringToHash("skinsuitdetailview_open")) then
			self._viewAnimator:Play("skinsuitdetailview_open", 0, 1)
		end
	end

	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
	self:_refreshDesc()
	self:_refreshBg()
end

function HandbookSkinSuitDetailViewBase:refreshUI()
	return
end

function HandbookSkinSuitDetailViewBase:refreshBtnStatus()
	return
end

function HandbookSkinSuitDetailViewBase:_refreshDesc()
	self._textSkinThemeDescr.text = self._skinSuitCfg.des
end

function HandbookSkinSuitDetailViewBase:_refreshBg()
	return
end

function HandbookSkinSuitDetailViewBase:_refreshSkinItems()
	self._skinItemList = {}

	for i = 1, #self._skinIdList do
		local skinItemGo = self._skinItemGoList[i]

		if skinItemGo then
			local skinItem = MonoHelper.addNoUpdateLuaComOnceToGo(skinItemGo, HandbookSkinItem, self)

			skinItem:setData(self._skinSuitId)
			skinItem:refreshItem(self._skinIdList[i])
			table.insert(self._skinItemList, skinItem)
		end
	end
end

function HandbookSkinSuitDetailViewBase:addSwitchSuitBtns()
	local btnAsset = self.viewContainer:getSetting().otherRes[1]

	self.goBtns = self.viewContainer:getResInst(btnAsset, self.viewGO)
	self._btnLeftSuit = gohelper.findChildButton(self.goBtns, "#btn_Left")
	self._btnRightSuit = gohelper.findChildButton(self.goBtns, "#btn_Right")

	local suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(self._skinSuitGroupId, true)

	self._suitCount = #suitCfgList

	table.sort(suitCfgList, HandbookSkinSuitDetailViewBase._suitCfgSort)

	for idx, suitCfg in ipairs(suitCfgList) do
		if suitCfg.id == self._skinSuitId then
			self._preSuitIdx = idx - 1
			self._curSuitIdx = idx
			self._nextSuitIdx = idx + 1

			break
		end
	end

	local hasPreSuit = self._preSuitIdx and self._preSuitIdx >= 1
	local hasNextSuit = self._nextSuitIdx and self._nextSuitIdx <= self._suitCount

	if hasPreSuit then
		local preSuitId = suitCfgList[self._preSuitIdx].id

		self._btnLeftSuit:AddClickListener(self.OpenOtherSuitView, self, preSuitId)
	else
		gohelper.setActive(self._btnLeftSuit.gameObject, false)

		self._btnLeftSuit = nil
	end

	if hasNextSuit then
		local nextSuitId = suitCfgList[self._nextSuitIdx].id

		self._btnRightSuit:AddClickListener(self.OpenOtherSuitView, self, nextSuitId)
	else
		gohelper.setActive(self._btnRightSuit.gameObject, false)

		self._btnRightSuit = nil
	end
end

function HandbookSkinSuitDetailViewBase:OpenOtherSuitView(suitId)
	local viewName = HandbookSkinScene.SkinSuitId2SuitView[suitId]

	if viewName then
		local viewParam = {
			suitSwitch = true,
			skinThemeGroupId = suitId
		}

		self._openOtherSuitView = viewName

		ViewMgr.instance:openView(viewName, viewParam, true)
	end
end

function HandbookSkinSuitDetailViewBase:onViewOpenedFinish(viewName)
	if self._openOtherSuitView == viewName then
		self:closeThis()
	end
end

function HandbookSkinSuitDetailViewBase._suitCfgSort(cfg1, cfg2)
	if cfg1.show == 1 and cfg2.show == 0 then
		return true
	elseif cfg1.show == 0 and cfg2.show == 1 then
		return false
	else
		return cfg1.id > cfg2.id
	end
end

function HandbookSkinSuitDetailViewBase:onClose()
	if self._btnRightSuit then
		self._btnRightSuit:RemoveClickListener()

		self._btnRightSuit = nil
	end

	if self._btnLeftSuit then
		self._btnLeftSuit:RemoveClickListener()

		self._btnLeftSuit = nil
	end
end

function HandbookSkinSuitDetailViewBase:onDestroyView()
	return
end

return HandbookSkinSuitDetailViewBase
