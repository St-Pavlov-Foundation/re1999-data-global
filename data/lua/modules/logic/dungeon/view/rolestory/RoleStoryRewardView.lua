module("modules.logic.dungeon.view.rolestory.RoleStoryRewardView", package.seeall)

local var_0_0 = class("RoleStoryRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/title/scorebg/#txt_score")
	arg_1_0._goMask = gohelper.findChild(arg_1_0.viewGO, "Left/progress")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/progress/#scroll_view")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "Left/progress/#scroll_view/Viewport/Content")
	arg_1_0._gonormalline = gohelper.findChild(arg_1_0.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	arg_1_0._rectnormalline = arg_1_0._gonormalline.transform
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "Left/rightbg")
	arg_1_0._gotargetrewardpos = gohelper.findChild(arg_1_0.viewGO, "Left/rightbg/rightprogressbg/#go_progressitem")
	arg_1_0._normalDelta = Vector2.New(-420, 600)
	arg_1_0._fullDelta = Vector2.New(-200, 600)
	arg_1_0.startSpace = 2
	arg_1_0.cellWidth = 268
	arg_1_0.space = 0
	arg_1_0.targetId = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, arg_2_0._onGetScoreBonus, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, arg_3_0._onGetScoreBonus, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._scrollreward:AddOnValueChanged(arg_4_0._onScrollChange, arg_4_0)
end

function var_0_0._onScrollChange(arg_5_0, arg_5_1)
	arg_5_0:refreshTarget()
end

function var_0_0._onGetScoreBonus(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshView()
	TaskDispatcher.runDelay(arg_7_0.checkGetReward, arg_7_0, 0.6)
end

function var_0_0.refreshView(arg_8_0)
	arg_8_0:refreshReward()
	arg_8_0:refreshProgress()
	TaskDispatcher.cancelTask(arg_8_0.refreshTarget, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0.refreshTarget, arg_8_0, 0.02)
end

function var_0_0.refreshProgress(arg_9_0)
	arg_9_0.storyId = RoleStoryModel.instance:getCurActStoryId()
	arg_9_0.storyMo = RoleStoryModel.instance:getById(arg_9_0.storyId)

	if not arg_9_0.storyMo then
		return
	end

	local var_9_0 = arg_9_0.storyMo:getScore()

	arg_9_0._txtScore.text = var_9_0

	local var_9_1 = RoleStoryConfig.instance:getRewardList(arg_9_0.storyId) or {}
	local var_9_2 = #var_9_1

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if var_9_0 < iter_9_1.score then
			var_9_2 = iter_9_0 - 1

			break
		end
	end

	local var_9_3 = var_9_1[var_9_2] and var_9_1[var_9_2].score or 0
	local var_9_4 = var_9_1[var_9_2 + 1] and var_9_1[var_9_2 + 1].score or var_9_3
	local var_9_5 = 0
	local var_9_6 = arg_9_0:getNodeWidth(var_9_2, var_9_5)
	local var_9_7 = arg_9_0:getNodeWidth(var_9_2 + 1, var_9_5) - var_9_6
	local var_9_8 = 0

	if var_9_3 < var_9_4 then
		var_9_8 = (var_9_0 - var_9_3) / (var_9_4 - var_9_3) * var_9_7
	end

	recthelper.setWidth(arg_9_0._rectnormalline, var_9_6 + var_9_8)

	if not arg_9_0.isPlayMove then
		arg_9_0.isPlayMove = true

		arg_9_0.viewContainer:getScrollView():moveToByCheckFunc(function(arg_10_0)
			return arg_10_0.index == var_9_2
		end)
	end
end

function var_0_0.getNodeWidth(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or 0

	local var_11_0 = arg_11_2

	if arg_11_1 > 0 then
		var_11_0 = (arg_11_1 - 1) * (arg_11_0.cellWidth + arg_11_0.space) + (arg_11_0.startSpace + arg_11_0.cellWidth * 0.5) + arg_11_2
	end

	return var_11_0
end

function var_0_0.refreshReward(arg_12_0)
	RoleStoryRewardListModel.instance:refreshList()
end

function var_0_0.refreshTarget(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.refreshTarget, arg_13_0)

	local var_13_0 = arg_13_0:getTargetReward()
	local var_13_1 = var_13_0 and var_13_0.config and var_13_0.config.id

	if var_13_1 == arg_13_0.targetId then
		return
	end

	arg_13_0.targetId = var_13_1

	local var_13_2

	if var_13_1 then
		if not arg_13_0.targetItem then
			local var_13_3 = arg_13_0.viewContainer:getSetting().otherRes.itemRes
			local var_13_4 = arg_13_0:getResInst(var_13_3, arg_13_0._gotargetrewardpos, "targetItem")

			arg_13_0.targetItem = MonoHelper.addLuaComOnceToGo(var_13_4, RoleStoryRewardItem)
		end

		var_13_2 = {
			config = var_13_0.config,
			index = var_13_0.index
		}
		var_13_2.isTarget = true
	end

	if arg_13_0.targetItem then
		arg_13_0.targetItem:refresh(var_13_2)
	end

	if var_13_2 then
		gohelper.setActive(arg_13_0._gotarget, true)

		arg_13_0._goMask.transform.sizeDelta = arg_13_0._normalDelta
	else
		gohelper.setActive(arg_13_0._gotarget, false)

		arg_13_0._goMask.transform.sizeDelta = arg_13_0._fullDelta
	end
end

function var_0_0.getTargetReward(arg_14_0)
	if not arg_14_0.importantRewards then
		arg_14_0.importantRewards = {}

		local var_14_0 = RoleStoryConfig.instance:getRewardList(arg_14_0.storyId) or {}

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if iter_14_1.keyReward == 1 then
				table.insert(arg_14_0.importantRewards, {
					score = iter_14_1.score,
					index = iter_14_0,
					config = iter_14_1
				})
			end
		end

		table.sort(arg_14_0.importantRewards, SortUtil.keyLower("score"))
	end

	local var_14_1 = recthelper.getAnchorX(arg_14_0._gocontent.transform)
	local var_14_2 = recthelper.getWidth(arg_14_0._scrollreward.transform)
	local var_14_3 = {}
	local var_14_4 = {}

	for iter_14_2, iter_14_3 in ipairs(arg_14_0.importantRewards) do
		if RoleStoryModel.instance:getRewardState(iter_14_3.config.storyId, iter_14_3.config.id, iter_14_3.config.score) == 0 then
			var_14_4 = iter_14_3

			if var_14_2 < (iter_14_3.index - 1) * (arg_14_0.cellWidth + arg_14_0.space) + arg_14_0.startSpace + var_14_1 then
				var_14_3 = iter_14_3

				break
			end
		end
	end

	if not var_14_3.config then
		var_14_3 = var_14_4
	end

	return var_14_3
end

function var_0_0.checkGetReward(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = RoleStoryConfig.instance:getRewardList(arg_15_0.storyId)

	if var_15_1 then
		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			if RoleStoryModel.instance:getRewardState(iter_15_1.storyId, iter_15_1.id, iter_15_1.score) == 1 then
				table.insert(var_15_0, iter_15_1.id)
			end
		end
	end

	if #var_15_0 > 0 then
		HeroStoryRpc.instance:sendGetScoreBonusRequest(var_15_0)
	end
end

function var_0_0.onClose(arg_16_0)
	arg_16_0._scrollreward:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_16_0.checkGetReward, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.refreshTarget, arg_16_0)
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
