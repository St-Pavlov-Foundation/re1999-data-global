module("modules.logic.achievement.view.AchievementMainItem", package.seeall)

local var_0_0 = class("AchievementMainItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosingle = gohelper.findChild(arg_1_0.viewGO, "#go_single")
	arg_1_0._gogroup = gohelper.findChild(arg_1_0.viewGO, "#go_group")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_group/#image_bg")
	arg_1_0._gogroupcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_group/#go_groupcontainer")
	arg_1_0._goupgrade = gohelper.findChild(arg_1_0.viewGO, "#go_group/#go_upgrade")
	arg_1_0._goallcollect = gohelper.findChild(arg_1_0.viewGO, "#go_group/#go_allcollect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._animator = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.Animator))
	arg_4_0._groupBgImage = gohelper.findChildImage(arg_4_0.viewGO, "#go_group/#image_bg")

	arg_4_0:addEventCb(AchievementController.instance, AchievementEvent.OnGroupUpGrade, arg_4_0._onGroupUpGrade, arg_4_0)
	arg_4_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, arg_4_0._onFocusFinished, arg_4_0)
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._iconItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._iconItems) do
			iter_5_1:dispose()
		end

		arg_5_0._iconItems = nil
	end

	arg_5_0._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_5_0.playItemOpenAim, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.playAchievementUnlockAnim, arg_5_0)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	if arg_6_0._mo ~= arg_6_1 then
		arg_6_0:recycleIcons()
	end

	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = arg_7_0._mo.groupId ~= 0

	gohelper.setActive(arg_7_0._gosingle, not var_7_0)
	gohelper.setActive(arg_7_0._gogroup, var_7_0)

	if var_7_0 then
		arg_7_0:refreshGroup()
	else
		arg_7_0:refreshSingle()
	end

	arg_7_0:playAchievementAnim()
end

var_0_0.LockedIconColor = "#4D4D4D"
var_0_0.UnLockedIconColor = "#FFFFFF"
var_0_0.LockedNameAlpha = 0.5
var_0_0.UnLockedNameAlpha = 1
var_0_0.LockedGroupBgColor = "#808080"
var_0_0.UnLockedGroupBgColor = "#FFFFFF"

function var_0_0.refreshSingle(arg_8_0)
	local var_8_0 = AchievementEnum.MainListLineCount

	arg_8_0:checkInitIcon(var_8_0, arg_8_0._gosingle)

	for iter_8_0 = 1, var_8_0 do
		local var_8_1 = arg_8_0._iconItems[iter_8_0]
		local var_8_2 = var_8_1.viewGO.transform

		recthelper.setAnchor(var_8_2, var_0_0.IconStartX + (iter_8_0 - 1) * var_0_0.IconIntervalX, 0)
		var_8_1:setClickCall(arg_8_0.onClickSingleIcon, arg_8_0, iter_8_0)

		local var_8_3 = arg_8_0._mo.achievementCfgs[iter_8_0]

		gohelper.setActive(var_8_1.viewGO, var_8_3 ~= nil)

		if var_8_3 then
			local var_8_4 = var_8_3.id
			local var_8_5 = AchievementController.instance:getMaxLevelFinishTask(var_8_4)

			if var_8_5 then
				var_8_1:setData(var_8_5)

				local var_8_6 = AchievementModel.instance:achievementHasLocked(var_8_4)

				var_8_1:setIsLocked(var_8_6)
				var_8_1:setIconColor(var_8_6 and var_0_0.LockedIconColor or var_0_0.UnLockedIconColor)
				var_8_1:setNameTxtAlpha(var_8_6 and var_0_0.LockedNameAlpha or var_0_0.UnLockedNameAlpha)
				var_8_1:setNameTxtVisible(true)
				var_8_1:setSelectIconVisible(false)
				var_8_1:setBgVisible(true)
			else
				gohelper.setActive(var_8_1.viewGO, false)
			end
		end
	end
end

function var_0_0.refreshGroup(arg_9_0)
	local var_9_0 = AchievementConfig.instance:getGroup(arg_9_0._mo.groupId)

	if var_9_0 then
		gohelper.setActive(arg_9_0._goupgrade, false)
		arg_9_0:refreshGroupBg(var_9_0)
		arg_9_0:refreshSingleInGroup()
	end
end

function var_0_0.refreshGroupBg(arg_10_0, arg_10_1)
	if arg_10_1 then
		local var_10_0 = AchievementModel.instance:isAchievementTaskFinished(arg_10_1.unLockAchievement)
		local var_10_1 = AchievementConfig.instance:getGroupBgUrl(arg_10_0._mo.groupId, AchievementEnum.GroupParamType.List, var_10_0)

		arg_10_0._simagebg:LoadImage(var_10_1)

		local var_10_2 = AchievementModel.instance:achievementGroupHasLocked(arg_10_0._mo.groupId)

		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._groupBgImage, var_10_2 and var_0_0.LockedGroupBgColor or var_0_0.UnLockedGroupBgColor)
	end
end

function var_0_0.refreshSingleInGroup(arg_11_0)
	local var_11_0 = AchievementConfig.instance:getGroupParamIdTab(arg_11_0._mo.groupId, AchievementEnum.GroupParamType.List)
	local var_11_1 = var_11_0 and #var_11_0 or 0

	arg_11_0:checkInitIcon(var_11_1, arg_11_0._gogroupcontainer)

	for iter_11_0 = 1, var_11_1 do
		local var_11_2 = arg_11_0._iconItems[iter_11_0]

		var_11_2:setClickCall(arg_11_0.onClickSingleIcon, arg_11_0, var_11_0[iter_11_0])
		arg_11_0:_setGroupAchievementPosAndScale(var_11_2.viewGO, arg_11_0._mo.groupId, iter_11_0)

		local var_11_3 = arg_11_0._mo.achievementCfgs[var_11_0[iter_11_0]]

		gohelper.setActive(var_11_2.viewGO, var_11_3 ~= nil)

		if var_11_3 then
			local var_11_4 = var_11_3.id
			local var_11_5 = AchievementController.instance:getMaxLevelFinishTask(var_11_4)

			if var_11_5 then
				var_11_2:setData(var_11_5)

				local var_11_6 = AchievementModel.instance:achievementHasLocked(var_11_4)

				var_11_2:setIsLocked(var_11_6)
				var_11_2:setIconColor(var_11_6 and var_0_0.LockedIconColor or var_0_0.UnLockedIconColor)
				var_11_2:setSelectIconVisible(false)
				var_11_2:setNameTxtVisible(false)
				var_11_2:setBgVisible(false)
			else
				gohelper.setActive(var_11_2.viewGO, false)
			end
		end
	end

	local var_11_7 = AchievementModel.instance:isGroupFinished(arg_11_0._mo.groupId)

	gohelper.setActive(arg_11_0._goallcollect, var_11_7)
end

function var_0_0._setGroupAchievementPosAndScale(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0, var_12_1, var_12_2, var_12_3 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(arg_12_2, arg_12_3, AchievementEnum.GroupParamType.List)

	if arg_12_1 then
		recthelper.setAnchor(arg_12_1.transform, var_12_0 or 0, var_12_1 or 0)
		transformhelper.setLocalScale(arg_12_1.transform, var_12_2 or 1, var_12_3 or 1, 1)
	end
end

var_0_0.IconStartX = -535
var_0_0.IconIntervalX = 262

function var_0_0.checkInitIcon(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._iconItems and #arg_13_0._iconItems == arg_13_1 then
		return
	end

	local var_13_0

	if arg_13_0._view and arg_13_0._view.viewContainer then
		var_13_0 = arg_13_0._view.viewContainer:getPoolView()

		if not var_13_0 then
			return
		end
	end

	arg_13_0._iconItems = arg_13_0._iconItems or {}

	for iter_13_0 = 1, arg_13_1 do
		local var_13_1 = var_13_0:getIcon(arg_13_2)

		gohelper.setActive(var_13_1.viewGO, true)

		arg_13_0._iconItems[iter_13_0] = var_13_1
	end
end

function var_0_0.recycleIcons(arg_14_0)
	local var_14_0

	if arg_14_0._view and arg_14_0._view.viewContainer then
		var_14_0 = arg_14_0._view.viewContainer:getPoolView()

		if not var_14_0 then
			return
		end
	end

	if arg_14_0._iconItems then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._iconItems) do
			var_14_0:recycleIcon(arg_14_0._iconItems[iter_14_0])

			arg_14_0._iconItems[iter_14_0] = nil
		end
	end
end

function var_0_0.onClickSingleIcon(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._mo.achievementCfgs[arg_15_1]

	if var_15_0 then
		local var_15_1 = {
			achievementId = var_15_0.id,
			achievementIds = AchievementMainTileModel.instance:getCurrentAchievementIds()
		}

		ViewMgr.instance:openView(ViewName.AchievementLevelView, var_15_1)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
	end
end

var_0_0.AnimDelayDelta = 0.06

function var_0_0.playAchievementAnim(arg_16_0)
	arg_16_0:playAchievementOpenAnim()
	TaskDispatcher.cancelTask(arg_16_0.playAchievementUnlockAnim, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0.playAchievementUnlockAnim, arg_16_0, 0.5)
end

function var_0_0.playAchievementOpenAnim(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.playItemOpenAim, arg_17_0)

	if not arg_17_0.viewGO.activeInHierarchy then
		return
	end

	local var_17_0 = AchievementMainTileModel.instance:getScrollFocusIndex()
	local var_17_1 = AchievementMainTileModel.instance:hasPlayOpenAnim()

	if var_17_0 then
		if not var_17_1 then
			arg_17_0._animator:Play("close", 0, 0)

			local var_17_2 = var_0_0.AnimDelayDelta * Mathf.Clamp(arg_17_0._index - var_17_0, 0, arg_17_0._index)

			TaskDispatcher.runDelay(arg_17_0.playItemOpenAim, arg_17_0, var_17_2)
		else
			arg_17_0._animator:Play("idle", 0, 0)
		end
	else
		arg_17_0._animator:Play("close", 0, 0)
	end
end

function var_0_0.playItemOpenAim(arg_18_0)
	arg_18_0._animator:Play("open", 0, 0)
end

function var_0_0._onFocusFinished(arg_19_0, arg_19_1)
	if arg_19_1 ~= AchievementEnum.ViewType.Tile then
		return
	end

	arg_19_0:playAchievementAnim()
end

function var_0_0.playAchievementUnlockAnim(arg_20_0)
	if arg_20_0._iconItems then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._iconItems) do
			arg_20_0:playSingleAchievementUnlockAnim(iter_20_1)
		end
	end
end

function var_0_0.playSingleAchievementUnlockAnim(arg_21_0, arg_21_1)
	if not arg_21_1 or not arg_21_1.viewGO or not arg_21_1.viewGO.activeInHierarchy then
		return
	end

	local var_21_0 = arg_21_1:getTaskCO()
	local var_21_1 = var_21_0 and var_21_0.achievementId
	local var_21_2 = AchievementModel.instance:achievementHasNew(var_21_1)
	local var_21_3 = AchievementMainCommonModel.instance:isAchievementPlayEffect(var_21_1)

	if var_21_2 then
		arg_21_1:playAnim(var_21_3 and AchievementMainIcon.AnimClip.Loop or AchievementMainIcon.AnimClip.New)
	else
		arg_21_1:playAnim(AchievementMainIcon.AnimClip.Idle)
	end

	AchievementMainCommonModel.instance:markAchievementPlayEffect(var_21_1)
end

function var_0_0._onGroupUpGrade(arg_22_0, arg_22_1)
	if arg_22_0._mo.groupId == arg_22_1 then
		gohelper.setActive(arg_22_0._goupgrade, true)
	end
end

return var_0_0
