module("modules.logic.achievement.controller.AchievementToastController", package.seeall)

local var_0_0 = class("AchievementToastController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	arg_3_0:registerCallback(AchievementEvent.LoginShowToast, arg_3_0.handleLoginEnterMainScene, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0.checkToastTrigger, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0.checkToastWithOpenView, arg_3_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_3_0.checkToastTrigger, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._isLoginScene = false
	arg_4_0._isToastShowing = false

	if arg_4_0._toastLoader then
		arg_4_0._toastLoader:dispose()

		arg_4_0._toastLoader = nil
	end

	AchievementToastModel.instance:release()
end

function var_0_0.onUpdateAchievements(arg_5_0)
	local var_5_0 = PlayerModel.instance:getPlayinfo()

	if not var_5_0 or var_5_0.userId == 0 then
		return
	end

	if arg_5_0:canPopUpToast() then
		arg_5_0:showNextToast()
	end
end

function var_0_0.handleLoginEnterMainScene(arg_6_0)
	arg_6_0._isLoginScene = true

	if arg_6_0:canPopUpToast() then
		arg_6_0:showNextToast()
	end
end

function var_0_0.checkToastTrigger(arg_7_0)
	if arg_7_0:canPopUpToast() then
		arg_7_0:showNextToast()
	end
end

function var_0_0.checkToastWithOpenView(arg_8_0)
	if arg_8_0:canPopUpToastWithOpenView() then
		arg_8_0:showNextToast()
	end
end

function var_0_0.canPopUpToastWithOpenView(arg_9_0)
	return ViewMgr.instance:isOpen(ViewName.TowerPermanentResultView) or ViewMgr.instance:isOpen(ViewName.TowerDeepResultView) or ViewMgr.instance:isOpen(ViewName.TowerDeepHeroGroupFightView)
end

function var_0_0.canPopUpToast(arg_10_0)
	return arg_10_0._isLoginScene and not ViewMgr.instance:isOpen(ViewName.StoryView) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) and not ViewMgr.instance:isOpen(ViewName.AiZiLaGameView) and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or ViewMgr.instance:isOpen(ViewName.TowerDeepHeroGroupFightView)
end

function var_0_0.showNextToast(arg_11_0)
	local var_11_0 = AchievementToastModel.instance:getWaitToastList()
	local var_11_1 = AchievementToastModel.instance:getWaitNamePlateToastList()

	if var_11_0 and #var_11_0 > 0 then
		arg_11_0:tryShowToast(var_11_0)
		AchievementToastModel.instance:onToastFinished()
	end

	if var_11_1 and #var_11_1 > 0 then
		arg_11_0:tryShowNamePlateToast(var_11_1)
		AchievementToastModel.instance:onToastFinished()
	end
end

function var_0_0.tryShowNamePlateToast(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[1]

	ViewMgr.instance:openView(ViewName.AchievementNamePlateUnlockView, var_12_0)
end

function var_0_0.tryShowToast(arg_13_0, arg_13_1)
	if arg_13_1 then
		local var_13_0 = #arg_13_1
		local var_13_1 = var_13_0 - AchievementEnum.ShowMaxToastCount + 1

		for iter_13_0 = Mathf.Clamp(var_13_1, 1, var_13_0), var_13_0 do
			local var_13_2 = arg_13_1[iter_13_0]
			local var_13_3 = var_13_2.taskId
			local var_13_4 = var_13_2.toastType

			arg_13_0:showToastByTaskId(var_13_3, var_13_4)
		end
	end
end

function var_0_0.showToastByTaskId(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = AchievementConfig.instance:getTask(arg_14_1)
	local var_14_1 = AchievementConfig.instance:getAchievement(var_14_0.achievementId)
	local var_14_2 = arg_14_0:getToastShowFunction(arg_14_2)
	local var_14_3 = false

	if var_14_2 then
		var_14_3 = var_14_2(arg_14_0, var_14_0, var_14_1)
	end

	return var_14_3
end

function var_0_0.getToastShowFunction(arg_15_0, arg_15_1)
	return var_0_0.AchievementToastShowFuncTab[arg_15_1]
end

function var_0_0.onShowTaskFinishedToast(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = false

	if arg_16_1 then
		local var_16_1 = formatLuaLang("achievementtoastitem_achievementcompleted", arg_16_0:getToastName(arg_16_2, arg_16_1.level))
		local var_16_2 = ResUrl.getAchievementIcon("badgeicon/" .. arg_16_1.icon)
		local var_16_3 = {
			toastTip = var_16_1,
			icon = var_16_2
		}

		ToastController.instance:showToastWithCustomData(ToastEnum.AchievementCompleted, arg_16_0.fillToastObj, arg_16_0, var_16_3, var_16_1)

		var_16_0 = true
	end

	return var_16_0
end

function var_0_0.onShowGroupUnlockedToast(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = false

	if arg_17_1 and arg_17_2 then
		local var_17_1 = AchievementConfig.instance:getAchievement(arg_17_1.achievementId)
		local var_17_2 = var_17_1 and var_17_1.groupId

		var_17_0 = arg_17_0:showToastByGroupId(var_17_2, ToastEnum.AchievementUnLockGroup)
	end

	return var_17_0
end

function var_0_0.onShowGroupUpgrade(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = AchievementConfig.instance:getGroup(arg_18_2.groupId)
	local var_18_1 = false

	if var_18_0 then
		local var_18_2 = formatLuaLang("achievementtoastitem_upgradegroup", var_18_0.name)
		local var_18_3 = ResUrl.getAchievementIcon("badgeicon/achievementgroupicon")
		local var_18_4 = {
			toastTip = var_18_2,
			icon = var_18_3
		}

		ToastController.instance:showToastWithCustomData(ToastEnum.AchievementGroupUpGrade, arg_18_0.fillToastObj, arg_18_0, var_18_4, var_18_0.name)

		var_18_1 = true
	end

	return var_18_1
end

function var_0_0.onShowGroupFinishedToast(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2 and arg_19_2.groupId
	local var_19_1 = false

	if var_19_0 ~= 0 then
		var_19_1 = arg_19_0:showToastByGroupId(var_19_0, ToastEnum.AchievementGroupCollect)
	end

	return var_19_1
end

function var_0_0.getToastName(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = AchievementModel.instance:getAchievementTaskCoList(arg_20_1.id)

	if var_20_0 and #var_20_0 == 1 then
		return arg_20_1.name
	end

	if LangSettings.instance:isEn() then
		return string.format("%s %s", arg_20_1.name, GameUtil.getRomanNums(arg_20_2))
	else
		return string.format("%s%s", arg_20_1.name, GameUtil.getRomanNums(arg_20_2))
	end
end

function var_0_0.fillToastObj(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = ToastCallbackGroup.New()

	var_21_0.onClose = arg_21_0.onCloseWhenToastRemove
	var_21_0.onCloseObj = arg_21_0
	var_21_0.onCloseParam = arg_21_2
	var_21_0.onOpen = arg_21_0.onOpenToast
	var_21_0.onOpenObj = arg_21_0
	var_21_0.onOpenParam = arg_21_2
	arg_21_1.callbackGroup = var_21_0
end

function var_0_0.onOpenToast(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1.item = AchievementToastItem.New()

	arg_22_1.item:init(arg_22_2, arg_22_1)
end

function var_0_0.onCloseWhenToastRemove(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1.item then
		arg_23_1.item:dispose()

		arg_23_1.item = nil
	end
end

function var_0_0.showToastByGroupId(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = AchievementConfig.instance:getGroup(arg_24_1)

	if var_24_0 then
		ToastController.instance:showToast(arg_24_2, var_24_0.name)

		return true
	end
end

function var_0_0.tryGetToastAsset(arg_25_0)
	if arg_25_0._toastLoader and not arg_25_0._toastLoader.isLoading then
		return (arg_25_0._toastLoader:getAssetItem(AchievementEnum.AchievementToastPath):GetResource(AchievementEnum.AchievementToastPath))
	end

	if not arg_25_0._toastLoader then
		arg_25_0._toastLoader = arg_25_0._toastLoader or MultiAbLoader.New()

		arg_25_0._toastLoader:addPath(AchievementEnum.AchievementToastPath)
		arg_25_0._toastLoader:startLoad()
	end

	return nil
end

var_0_0.AchievementToastShowFuncTab = {
	[AchievementEnum.ToastType.TaskFinished] = var_0_0.onShowTaskFinishedToast,
	[AchievementEnum.ToastType.GroupUnlocked] = var_0_0.onShowGroupUnlockedToast,
	[AchievementEnum.ToastType.GroupUpgrade] = var_0_0.onShowGroupUpgrade,
	[AchievementEnum.ToastType.GroupFinished] = var_0_0.onShowGroupFinishedToast
}
var_0_0.instance = var_0_0.New()

return var_0_0
