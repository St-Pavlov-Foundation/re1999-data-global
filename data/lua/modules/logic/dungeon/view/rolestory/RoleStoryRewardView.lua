-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryRewardView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryRewardView", package.seeall)

local RoleStoryRewardView = class("RoleStoryRewardView", BaseView)

function RoleStoryRewardView:onInitView()
	self._txtScore = gohelper.findChildTextMesh(self.viewGO, "Left/title/scorebg/#txt_score")
	self._goMask = gohelper.findChild(self.viewGO, "Left/progress")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "Left/progress/#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content")
	self._gonormalline = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._rectnormalline = self._gonormalline.transform
	self._gotarget = gohelper.findChild(self.viewGO, "Left/rightbg")
	self._gotargetrewardpos = gohelper.findChild(self.viewGO, "Left/rightbg/rightprogressbg/#go_progressitem")
	self._normalDelta = Vector2.New(-420, 600)
	self._fullDelta = Vector2.New(-200, 600)
	self.startSpace = 2
	self.cellWidth = 268
	self.space = 0
	self.targetId = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryRewardView:addEvents()
	self:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, self._onGetScoreBonus, self)
end

function RoleStoryRewardView:removeEvents()
	self:removeEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, self._onGetScoreBonus, self)
end

function RoleStoryRewardView:_editableInitView()
	self._scrollreward:AddOnValueChanged(self._onScrollChange, self)
end

function RoleStoryRewardView:_onScrollChange(value)
	self:refreshTarget()
end

function RoleStoryRewardView:_onGetScoreBonus()
	self:refreshView()
end

function RoleStoryRewardView:onOpen()
	self:refreshView()
	TaskDispatcher.runDelay(self.checkGetReward, self, 0.6)
end

function RoleStoryRewardView:refreshView()
	self:refreshReward()
	self:refreshProgress()
	TaskDispatcher.cancelTask(self.refreshTarget, self)
	TaskDispatcher.runDelay(self.refreshTarget, self, 0.02)
end

function RoleStoryRewardView:refreshProgress()
	self.storyId = RoleStoryModel.instance:getCurActStoryId()
	self.storyMo = RoleStoryModel.instance:getById(self.storyId)

	if not self.storyMo then
		return
	end

	local score = self.storyMo:getScore()

	self._txtScore.text = score

	local list = RoleStoryConfig.instance:getRewardList(self.storyId) or {}
	local curIndex = #list

	for i, v in ipairs(list) do
		if score < v.score then
			curIndex = i - 1

			break
		end
	end

	local curScore = list[curIndex] and list[curIndex].score or 0
	local nextScore = list[curIndex + 1] and list[curIndex + 1].score or curScore
	local beginPos = 0
	local nodeWidth = self:getNodeWidth(curIndex, beginPos)
	local offsetWidth = self:getNodeWidth(curIndex + 1, beginPos) - nodeWidth
	local perWidth = 0

	if curScore < nextScore then
		perWidth = (score - curScore) / (nextScore - curScore) * offsetWidth
	end

	recthelper.setWidth(self._rectnormalline, nodeWidth + perWidth)

	if not self.isPlayMove then
		self.isPlayMove = true

		local scrollView = self.viewContainer:getScrollView()

		scrollView:moveToByCheckFunc(function(mo)
			return mo.index == curIndex
		end)
	end
end

function RoleStoryRewardView:getNodeWidth(index, beginPos)
	beginPos = beginPos or 0

	local nodeWidth = beginPos

	if index > 0 then
		nodeWidth = (index - 1) * (self.cellWidth + self.space) + (self.startSpace + self.cellWidth * 0.5) + beginPos
	end

	return nodeWidth
end

function RoleStoryRewardView:refreshReward()
	RoleStoryRewardListModel.instance:refreshList()
end

function RoleStoryRewardView:refreshTarget()
	TaskDispatcher.cancelTask(self.refreshTarget, self)

	local rewardData = self:getTargetReward()
	local targetId = rewardData and rewardData.config and rewardData.config.id

	if targetId == self.targetId then
		return
	end

	self.targetId = targetId

	local data

	if targetId then
		if not self.targetItem then
			local path = self.viewContainer:getSetting().otherRes.itemRes
			local child = self:getResInst(path, self._gotargetrewardpos, "targetItem")

			self.targetItem = MonoHelper.addLuaComOnceToGo(child, RoleStoryRewardItem)
		end

		data = {
			config = rewardData.config,
			index = rewardData.index
		}
		data.isTarget = true
	end

	if self.targetItem then
		self.targetItem:refresh(data)
	end

	if data then
		gohelper.setActive(self._gotarget, true)

		self._goMask.transform.sizeDelta = self._normalDelta
	else
		gohelper.setActive(self._gotarget, false)

		self._goMask.transform.sizeDelta = self._fullDelta
	end
end

function RoleStoryRewardView:getTargetReward()
	if not self.importantRewards then
		self.importantRewards = {}

		local list = RoleStoryConfig.instance:getRewardList(self.storyId) or {}

		for i, v in ipairs(list) do
			if v.keyReward == 1 then
				table.insert(self.importantRewards, {
					score = v.score,
					index = i,
					config = v
				})
			end
		end

		table.sort(self.importantRewards, SortUtil.keyLower("score"))
	end

	local contentPosX = recthelper.getAnchorX(self._gocontent.transform)
	local viewWidth = recthelper.getWidth(self._scrollreward.transform)
	local targetCo = {}
	local lastCo = {}

	for i, v in ipairs(self.importantRewards) do
		if RoleStoryModel.instance:getRewardState(v.config.storyId, v.config.id, v.config.score) == 0 then
			lastCo = v

			local pos = (v.index - 1) * (self.cellWidth + self.space) + self.startSpace
			local posX = pos + contentPosX

			if viewWidth < posX then
				targetCo = v

				break
			end
		end
	end

	if not targetCo.config then
		targetCo = lastCo
	end

	return targetCo
end

function RoleStoryRewardView:checkGetReward()
	local list = {}
	local rewardList = RoleStoryConfig.instance:getRewardList(self.storyId)

	if rewardList then
		for i, v in ipairs(rewardList) do
			if RoleStoryModel.instance:getRewardState(v.storyId, v.id, v.score) == 1 then
				table.insert(list, v.id)
			end
		end
	end

	if #list > 0 then
		HeroStoryRpc.instance:sendGetScoreBonusRequest(list)
	end
end

function RoleStoryRewardView:onClose()
	self._scrollreward:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self.checkGetReward, self)
	TaskDispatcher.cancelTask(self.refreshTarget, self)
end

function RoleStoryRewardView:onDestroyView()
	return
end

return RoleStoryRewardView
