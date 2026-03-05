-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView3_3.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_3", package.seeall)

local HandbookSkinSuitDetailView3_3 = class("HandbookSkinSuitDetailView3_3", HandbookSkinSuitDetailViewBase)
local dragRate = 0.0003
local maxDragProgressPerFrame = 0.1
local animationProcessSplitCount = 5
local loopCardCount = 5
local centerIdxOffset = 2

function HandbookSkinSuitDetailView3_3:onInitView()
	self._skinItemRoot = gohelper.findChild(self.viewGO, "#go_scroll/#go_storyStages")
	self._goStoryStages = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages")
	self._viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._bgTrans = self._goStoryStages.transform
	self._skinItemGo = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#go_handbookskinitem")
	self._festivalItemGo = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/LineItem")
	self._goscroll = gohelper.findChild(self.viewGO, "scroll")
	self._scroll = SLFramework.UGUI.UIDragListener.Get(self._goscroll)
	self._scrollClick = SLFramework.UGUI.UIClickListener.Get(self._goscroll)
	self._scrollRect = gohelper.findChildScrollRect(self.viewGO, "#go_scroll")
	self._goCardStages = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages")
	self._cardGroupAnimator = self._goCardStages:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookSkinSuitDetailView3_3:_editableInitView()
	self._cardAniProgresss = self._cardAniProgresss or 0
	self._curStartIdx = 1
end

function HandbookSkinSuitDetailView3_3:addEvents()
	self:addEventCb(HandbookController.instance, HandbookEvent.OnClickFestivalSkinCard, self._onClickCardItem, self)
	self._scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._scroll:AddDragEndListener(self._onScrollDragEnd, self)
	self._scroll:AddDragListener(self._onScrollDragging, self)
	self._scrollClick:AddClickListener(self._onScrollClick, self)
end

function HandbookSkinSuitDetailView3_3:removeEvents()
	self._scroll:RemoveDragBeginListener()
	self._scroll:RemoveDragEndListener()
	self._scroll:RemoveDragListener()
	self._scrollClick:RemoveClickListener()
end

function HandbookSkinSuitDetailView3_3:_onScrollClick(param, eventData)
	if self._dragging then
		return
	end

	if not self._raycastResults then
		self._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		self._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	local pos = UnityEngine.Input.mousePosition

	self._pointerEventData.position = pos

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(self._pointerEventData, self._raycastResults)

	local current = self._goscroll
	local iter = self._raycastResults:GetEnumerator()

	while iter:MoveNext() do
		local raycastResult = iter.Current
		local go = raycastResult.gameObject

		if go ~= current then
			local btn = go:GetComponent(typeof(UnityEngine.UI.Button))

			if not gohelper.isNil(btn) then
				btn:OnPointerClick(self._pointerEventData)
			end
		end
	end
end

function HandbookSkinSuitDetailView3_3:_onScrollDragBegin(param, eventData)
	self.scrollDragPos = eventData.position
	self._dragging = true
end

function HandbookSkinSuitDetailView3_3:_onScrollDragging(param, eventData)
	if not self.scrollDragPos then
		self.scrollDragPos = eventData.position
	end

	local moveOffset = eventData.position - self.scrollDragPos

	self.scrollDragPos = eventData.position

	if moveOffset.x ~= 0 then
		local progressDiff = dragRate * -moveOffset.x

		progressDiff = Mathf.Clamp(progressDiff, -maxDragProgressPerFrame, maxDragProgressPerFrame)
		self._cardAniProgresss = self._cardAniProgresss + progressDiff

		if self._cardAniProgresss > 1 then
			self._cardAniProgresss = self._cardAniProgresss - 1
		elseif self._cardAniProgresss < 0 then
			self._cardAniProgresss = 1 + self._cardAniProgresss
		end

		self:UpdateAnimProgress(self._cardGroupAnimator, "click", self._cardAniProgresss)
	end
end

function HandbookSkinSuitDetailView3_3:_onScrollDragEnd(param, eventData)
	UIBlockMgr.instance:startBlock(UIBlockKey.WaitItemAnimeDone)

	self._dragging = false

	self:slideToClosestCardPos()
end

function HandbookSkinSuitDetailView3_3:slideToClosestCardPos()
	local progressDiff = 1
	local targetIdx = 0
	local targetProgress = 0

	for idx = 0, animationProcessSplitCount do
		local suitProgress = idx / animationProcessSplitCount
		local diff = math.abs(suitProgress - self._cardAniProgresss)

		if diff < progressDiff then
			progressDiff = diff
			targetIdx = idx + 1
			targetProgress = suitProgress
		end
	end

	local slideSuitAniTweenId = ZProj.TweenHelper.DOTweenFloat(self._cardAniProgresss, targetProgress, 0.2, self.autoSlideAniUpdate, nil, self)

	self._moveToOtherSuitAni = true
	self._cardAniProgresss = targetProgress
	self._curStartIdx = targetIdx
	self._curStartIdx = self._curStartIdx > 5 and self._curStartIdx - 5 or self._curStartIdx

	TaskDispatcher.runDelay(self._onMoveToCardPosSetAniDone, self, 0.2)
end

function HandbookSkinSuitDetailView3_3:slideCardToCenter(idx)
	UIBlockMgr.instance:startBlock(UIBlockKey.WaitItemAnimeDone)

	local targetProgress = (idx - 1) / animationProcessSplitCount

	if targetProgress == 0 and self._cardAniProgresss < 0 then
		self._cardAniProgresss = 1 + self._cardAniProgresss
		targetProgress = 1
	end

	local slideSuitAniTweenId = ZProj.TweenHelper.DOTweenFloat(self._cardAniProgresss, targetProgress, 0.2, self.autoSlideAniUpdate, nil, self)

	self._moveCardToCenter = true
	self._cardAniProgresss = targetProgress

	TaskDispatcher.runDelay(self._onMoveToCardPosSetAniDone, self, 0.2)
end

function HandbookSkinSuitDetailView3_3:_onMoveToCardPosSetAniDone()
	self:UpdateSkinItemSelectedState()
	UIBlockMgr.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
end

function HandbookSkinSuitDetailView3_3:_onClickCardItem(idx, skinId)
	local curCenterIdx = self._curStartIdx + centerIdxOffset

	if curCenterIdx == idx or skinId ~= 0 and skinId == self._skinItemList[curCenterIdx]:getSkinId() then
		local skinCfg = SkinConfig.instance:getSkinCo(skinId)

		if not skinCfg then
			return
		end

		local heroId = skinCfg.characterId
		local skinId = skinCfg.id
		local skinViewParams = {
			handbook = true,
			storyMode = true,
			heroId = heroId,
			skin = skinId,
			skinSuitId = self._skinSuitId
		}

		CharacterController.instance:openCharacterSkinView(skinViewParams)
	end

	if curCenterIdx < idx then
		local oriStartIdx = self._curStartIdx

		self._curStartIdx = idx - 2

		if self._curStartIdx > 5 then
			self._curStartIdx = self._curStartIdx - 5
			self._cardAniProgresss = self._cardAniProgresss - 1
		end

		self:slideCardToCenter(self._curStartIdx)

		return
	else
		local oriStartIdx = self._curStartIdx

		self._curStartIdx = idx - 2

		if self._curStartIdx <= 0 then
			self._curStartIdx = self._curStartIdx + 5
			self._cardAniProgresss = self._cardAniProgresss + 1
		end

		self:slideCardToCenter(self._curStartIdx)

		return
	end
end

function HandbookSkinSuitDetailView3_3:onOpen()
	local viewParam = self.viewParam

	self._skinSuitId = viewParam and viewParam.skinThemeGroupId
	self._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(self._skinSuitId)

	local skinIdStr = self._skinSuitCfg.skinContain
	local destivalStr = self._skinSuitCfg.festivalParams

	self._skinIdList = string.splitToNumber(skinIdStr, "|")
	self._destivalDataList = string.split(destivalStr, "|")

	self._viewAnimator:Play(UIAnimationName.Click, 0, 1)
	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()
end

function HandbookSkinSuitDetailView3_3:_refreshSkinItems()
	self._skinItemList = {}

	for i = 1, #self._skinIdList do
		local skinItemGo = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#go_handbookskinitem" .. i)
		local skinItem = MonoHelper.addNoUpdateLuaComOnceToGo(skinItemGo, HandbookSkinItem3_3, self)

		skinItem:setData(i, self._skinSuitId)
		skinItem:refreshItem(self._skinIdList[i])
		skinItem:refreshDestivalData(self._destivalDataList[i])
		table.insert(self._skinItemList, skinItem)
	end

	for i = 1 + loopCardCount, #self._skinIdList + loopCardCount do
		local skinItemGo = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#go_handbookskinitem" .. i)
		local skinItem = MonoHelper.addNoUpdateLuaComOnceToGo(skinItemGo, HandbookSkinItem3_3, self)

		skinItem:setData(i, self._skinSuitId)
		skinItem:refreshItem(self._skinIdList[i - loopCardCount])
		skinItem:refreshDestivalData(self._destivalDataList[i - loopCardCount])
		table.insert(self._skinItemList, skinItem)
	end

	self._curStartIdx = 1

	self:UpdateSkinItemSelectedState()
end

function HandbookSkinSuitDetailView3_3:UpdateSkinItemSelectedState()
	local curSelectedIdx = self._curStartIdx + centerIdxOffset

	for i = 1, #self._skinItemList do
		local skinItem = self._skinItemList[i]

		skinItem:refreshSelectedState(false)
	end

	if curSelectedIdx <= loopCardCount then
		self._skinItemList[curSelectedIdx]:refreshSelectedState(true)
		self._skinItemList[curSelectedIdx + loopCardCount]:refreshSelectedState(true)
	else
		self._skinItemList[curSelectedIdx]:refreshSelectedState(true)
		self._skinItemList[curSelectedIdx - loopCardCount]:refreshSelectedState(true)
	end
end

function HandbookSkinSuitDetailView3_3:onClose()
	HandbookSkinSuitDetailViewBase.onClose(self)
	HandbookController.instance:dispatchEvent(HandbookEvent.OnExitToSuitGroup)
end

function HandbookSkinSuitDetailView3_3:UpdateAnimProgress(animator, aniName, normalizedTime)
	animator:Play(aniName, 0, normalizedTime)
end

function HandbookSkinSuitDetailView3_3:autoSlideAniUpdate(value)
	self:UpdateAnimProgress(self._cardGroupAnimator, "click", value)
end

return HandbookSkinSuitDetailView3_3
