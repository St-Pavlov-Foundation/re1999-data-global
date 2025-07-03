module("modules.logic.achievement.view.AchievementMainViewFocus", package.seeall)

local var_0_0 = class("AchievementMainViewFocus", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchCategory, arg_2_0.onSwitchCategory, arg_2_0)
	arg_2_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchViewType, arg_2_0.onSwitchViewType, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchCategory, arg_3_0.onSwitchCategory, arg_3_0)
	arg_3_0:removeEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchViewType, arg_3_0.onSwitchViewType, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.focus2OriginAchievement, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.triggerAchievementUnLockAduio, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.setHasPlayOpenAnim, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.onFocusNewestUpgradeGroupSucc, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._blockSwtichCategory, arg_5_0)

	if arg_5_0._scrollFocusTweenId then
		ZProj.TweenHelper.KillById(arg_5_0._scrollFocusTweenId)

		arg_5_0._scrollFocusTweenId = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:checkIsNeedFocusAchievement()
end

function var_0_0.onClose(arg_7_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_Focus")
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_FocusOrigin")
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_SwitchCategory")
end

local var_0_1 = 2

function var_0_0.checkIsNeedFocusAchievement(arg_8_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_FocusOrigin")

	local var_8_0 = arg_8_0:checkIsNeedFocusNewest() and var_0_1 or 0

	TaskDispatcher.cancelTask(arg_8_0.focus2OriginAchievement, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0.focus2OriginAchievement, arg_8_0, var_8_0)
end

function var_0_0.checkIsNeedFocusNewest(arg_9_0)
	return arg_9_0:try2FocusNewestUpgradeGroup() or arg_9_0:try2FocusNewestUnlockAchievement()
end

function var_0_0.focus2OriginAchievement(arg_10_0)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_FocusOrigin")

	local var_10_0 = arg_10_0.viewParam and arg_10_0.viewParam.achievementType
	local var_10_1 = arg_10_0.viewParam and arg_10_0.viewParam.focusDataId
	local var_10_2 = false

	if var_10_0 and var_10_1 and var_10_1 ~= 0 then
		var_10_2 = arg_10_0:try2FocusAchievement(var_10_0, var_10_1)
	else
		arg_10_0:setHasPlayOpenAnim()
	end

	return var_10_2
end

function var_0_0.onSwitchCategory(arg_11_0)
	if not arg_11_0:checkIsNeedFocusNewest() then
		arg_11_0:resetViewScrollPixel()
	end

	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_SwitchCategory")
	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.runDelay(arg_11_0._blockSwtichCategory, arg_11_0, 0.5)
end

function var_0_0._blockSwtichCategory(arg_12_0)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_SwitchCategory")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onSwitchViewType(arg_13_0)
	if not arg_13_0:checkIsNeedFocusNewest() then
		arg_13_0:resetViewScrollPixel()
	end
end

function var_0_0.try2FocusAchievement(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = AchievementMainCommonModel.instance:getCurrentViewType()
	local var_14_1, var_14_2, var_14_3 = AchievementMainCommonModel.instance:getViewAchievementIndex(var_14_0, arg_14_1, arg_14_2)
	local var_14_4 = 0

	if var_14_1 then
		var_14_4 = arg_14_0:scrollView2TargetPixel(var_14_0, var_14_3, var_14_2)
	else
		logError(string.format("focus achievement failed, achievementType = %s, dataId = %s", arg_14_1, arg_14_2))
	end

	return var_14_1, var_14_4
end

local var_0_2 = 0.0001
local var_0_3 = 0
local var_0_4 = 1

function var_0_0.scrollView2TargetPixel(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_Focus")
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)

	if arg_15_0._scrollFocusTweenId then
		ZProj.TweenHelper.KillById(arg_15_0._scrollFocusTweenId)
	end

	local var_15_0 = arg_15_0.viewContainer:getScrollView(arg_15_1)
	local var_15_1 = var_15_0 and var_15_0:getCsScroll()

	arg_15_0._curFocusAchievementIndex = arg_15_3

	local var_15_2 = 0

	if var_15_0 and var_15_1 then
		arg_15_0._curFocusCsScroll = var_15_1

		local var_15_3 = var_15_1.VerticalScrollPixel
		local var_15_4 = arg_15_2 or 0
		local var_15_5 = math.abs(var_15_4 - var_15_3)

		var_15_2 = var_15_5 * var_0_2
		var_15_2 = Mathf.Clamp(var_15_2, var_0_3, var_0_4)

		if var_15_5 <= 0 then
			arg_15_0:_onFocusTweenFrameCallback(var_15_4)
			arg_15_0:_onFocusTweenFinishCallback()
		else
			arg_15_0._scrollFocusTweenId = ZProj.TweenHelper.DOTweenFloat(var_15_3, var_15_4, var_15_2, arg_15_0._onFocusTweenFrameCallback, arg_15_0._onFocusTweenFinishCallback, arg_15_0)
		end
	end

	return var_15_2
end

function var_0_0._onFocusTweenFrameCallback(arg_16_0, arg_16_1)
	if arg_16_0._curFocusCsScroll then
		arg_16_0._curFocusCsScroll.VerticalScrollPixel = arg_16_1
	end
end

local var_0_5 = 0.05

function var_0_0._onFocusTweenFinishCallback(arg_17_0)
	local var_17_0 = Mathf.Clamp(arg_17_0._curFocusAchievementIndex - 1, 1, arg_17_0._curFocusAchievementIndex)

	AchievementMainTileModel.instance:markScrollFocusIndex(var_17_0)
	TaskDispatcher.cancelTask(arg_17_0.setHasPlayOpenAnim, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0.setHasPlayOpenAnim, arg_17_0, var_0_5)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_Focus")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.setHasPlayOpenAnim(arg_18_0)
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(false)

	local var_18_0 = AchievementMainCommonModel.instance:getCurrentViewType()

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnFocusAchievementFinished, var_18_0)
	AchievementMainTileModel.instance:setHasPlayOpenAnim(true)
end

function var_0_0.try2FocusNewestUpgradeGroup(arg_19_0)
	local var_19_0 = arg_19_0:getNewestUpgradeGroup()
	local var_19_1 = false
	local var_19_2 = 0

	if var_19_0 and var_19_0 ~= 0 then
		local var_19_3

		var_19_1, var_19_3 = arg_19_0:try2FocusAchievement(AchievementEnum.AchievementType.Group, var_19_0)

		if var_19_1 then
			arg_19_0._focusUpgradeGroupId = var_19_0

			AchievementMainCommonModel.instance:markGroupPlayUpgradeEffect(var_19_0)

			local var_19_4 = var_19_3 + var_0_5 + 0.1

			TaskDispatcher.cancelTask(arg_19_0.onFocusNewestUpgradeGroupSucc, arg_19_0)
			TaskDispatcher.runDelay(arg_19_0.onFocusNewestUpgradeGroupSucc, arg_19_0, var_19_4)
		end
	end

	return var_19_1
end

function var_0_0.onFocusNewestUpgradeGroupSucc(arg_20_0)
	AchievementController.instance:dispatchEvent(AchievementEvent.OnGroupUpGrade, arg_20_0._focusUpgradeGroupId)
	arg_20_0:triggerAchievementUnLockAduio()
end

function var_0_0.getNewestUpgradeGroup(arg_21_0)
	local var_21_0 = AchievementMainCommonModel.instance:getCurrentCategory()
	local var_21_1 = AchievementMainCommonModel.instance:getCurrentFilterType()

	return (AchievementMainCommonModel.instance:getNewestUpgradeGroupId(var_21_0, var_21_1))
end

function var_0_0.try2FocusNewestUnlockAchievement(arg_22_0)
	local var_22_0 = arg_22_0:getNewestUnlockAchievement()
	local var_22_1 = false
	local var_22_2 = 0

	if var_22_0 and var_22_0 ~= 0 then
		local var_22_3 = AchievementConfig.instance:getAchievement(var_22_0)
		local var_22_4 = AchievementMainCommonModel.instance:getCurrentViewType()
		local var_22_5 = AchievementEnum.AchievementType.Single
		local var_22_6 = var_22_0

		if var_22_4 == AchievementEnum.ViewType.Tile and AchievementUtils.isActivityGroup(var_22_0) then
			var_22_5 = AchievementEnum.AchievementType.Group
			var_22_6 = var_22_3.groupId
		end

		local var_22_7

		var_22_1, var_22_7 = arg_22_0:try2FocusAchievement(var_22_5, var_22_6)

		if var_22_1 then
			local var_22_8 = var_22_7 + var_0_5

			TaskDispatcher.cancelTask(arg_22_0.triggerAchievementUnLockAduio, arg_22_0)
			TaskDispatcher.runDelay(arg_22_0.triggerAchievementUnLockAduio, arg_22_0, var_22_8)
		end
	end

	return var_22_1
end

function var_0_0.triggerAchievementUnLockAduio(arg_23_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_medal)
end

function var_0_0.getNewestUnlockAchievement(arg_24_0)
	local var_24_0 = AchievementMainCommonModel.instance:getCurrentCategory()
	local var_24_1 = AchievementMainCommonModel.instance:getCurrentFilterType()

	return (AchievementMainCommonModel.instance:getNewestUnlockAchievementId(var_24_0, var_24_1))
end

function var_0_0.resetViewScrollPixel(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(AchievementEnum.ViewType) do
		local var_25_0 = arg_25_0.viewContainer:getScrollView(iter_25_1)

		;(var_25_0 and var_25_0:getCsScroll()).VerticalScrollPixel = 0

		arg_25_0:scrollView2TargetPixel(iter_25_1, 0, 1)
	end
end

return var_0_0
