module("modules.logic.achievement.view.AchievementMainListItem", package.seeall)

local var_0_0 = class("AchievementMainListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotop1 = gohelper.findChild(arg_1_0.viewGO, "go_top")
	arg_1_0._gotop2 = gohelper.findChild(arg_1_0.viewGO, "go_top2")
	arg_1_0._txtachievementname = gohelper.findChildText(arg_1_0.viewGO, "go_top/image_AchievementNameBG/#txt_achievementname")
	arg_1_0._simageAchievementGroupBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_top2/#simage_AchievementGroupBG")
	arg_1_0._txtachievementgroupname = gohelper.findChildText(arg_1_0.viewGO, "go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname")
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "go_layout")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "go_layout/go_taskitem")
	arg_1_0._btnpopup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_top2/#btn_popup")
	arg_1_0._gooff = gohelper.findChild(arg_1_0.viewGO, "go_top2/#btn_popup/#go_off")
	arg_1_0._goon = gohelper.findChild(arg_1_0.viewGO, "go_top2/#btn_popup/#go_on")
	arg_1_0._goallcollect = gohelper.findChild(arg_1_0.viewGO, "go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname/#go_allcollect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnpopup:AddClickListener(arg_2_0._btnpopupOnClick, arg_2_0)
	arg_2_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnPlayGroupFadeAnim, arg_2_0._onPlayGroupFadeAnimation, arg_2_0)
	arg_2_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, arg_2_0._onFocusFinished, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnpopup:RemoveClickListener()
end

function var_0_0._btnpopupOnClick(arg_4_0)
	local var_4_0 = arg_4_0._mo:getIsFold()
	local var_4_1 = AchievementConfig.instance:getAchievement(arg_4_0._mo.id).groupId

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnClickGroupFoldBtn, var_4_1, not var_4_0)
end

function var_0_0._onPlayGroupFadeAnimation(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 and arg_5_1.achievementId

	if not var_5_0 or var_5_0 ~= arg_5_0._mo.id then
		return
	end

	arg_5_0._isFold = arg_5_1.isFold

	if not arg_5_0._isFold then
		arg_5_0._mo:setIsFold(arg_5_0._isFold)
	end

	local var_5_1 = arg_5_1.orginLineHeight
	local var_5_2 = arg_5_1.targetLineHeight
	local var_5_3 = arg_5_1.duration

	arg_5_0._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(var_5_1, var_5_2, var_5_3, arg_5_0._onOpenTweenFrameCallback, arg_5_0._onOpenTweenFinishCallback, arg_5_0, nil)
end

function var_0_0._onOpenTweenFrameCallback(arg_6_0, arg_6_1)
	arg_6_0._mo:overrideLineHeight(arg_6_1)
	AchievementMainListModel.instance:onModelUpdate()
end

function var_0_0._onOpenTweenFinishCallback(arg_7_0)
	arg_7_0._mo:clearOverrideLineHeight()
	arg_7_0._mo:setIsFold(arg_7_0._isFold)
	AchievementMainListModel.instance:onModelUpdate()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._taskItemTab = arg_8_0:getUserDataTb_()
	arg_8_0._topAnimator = gohelper.onceAddComponent(arg_8_0._gotop1, gohelper.Type_Animator)
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._simageAchievementGroupBG:UnLoadImage()
	arg_9_0:recycleAchievementMainIcon()
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	if arg_10_0._mo and arg_10_0._mo ~= arg_10_1 and arg_10_0._openAnimTweenId then
		ZProj.TweenHelper.KillById(arg_10_0._openAnimTweenId)

		arg_10_0._openAnimTweenId = nil
	end

	arg_10_0._mo = arg_10_1

	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = AchievementConfig.instance:getAchievement(arg_11_0._mo.id)

	if var_11_0 then
		arg_11_0._groupId = var_11_0.groupId

		local var_11_1 = AchievementMainCommonModel.instance:getCurrentSortType()
		local var_11_2 = AchievementMainCommonModel.instance:getCurrentFilterType()
		local var_11_3 = arg_11_0._mo:getFilterTaskList(var_11_1, var_11_2)

		arg_11_0:refreshTaskList(var_11_3)
		arg_11_0:refreshTopUI(var_11_0)
	end
end

local var_0_1 = 1
local var_0_2 = 0.5
local var_0_3 = 1
local var_0_4 = 0.5
local var_0_5 = "#FFFFFF"
local var_0_6 = "#4D4D4D"

function var_0_0.refreshTaskList(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1 = arg_12_0._mo:getIsFold()

	gohelper.setActive(arg_12_0._golayout, not var_12_1)
	gohelper.setActive(arg_12_0._goon, not var_12_1)
	gohelper.setActive(arg_12_0._gooff, var_12_1)

	arg_12_0._hasTaskFinished = false

	if not var_12_1 and arg_12_1 then
		var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
			local var_12_2 = arg_12_0:getOrCreateTaskItem(iter_12_0)

			var_12_0[var_12_2] = true

			local var_12_3 = AchievementModel.instance:getById(iter_12_1.id)
			local var_12_4 = var_12_3 and var_12_3.hasFinished

			var_12_2.txtTaskDesc2.text = iter_12_1.extraDesc

			var_12_2.taskIcon:setData(iter_12_1)
			var_12_2.taskIcon:setIconColor(var_12_4 and var_0_5 or var_0_6)
			ZProj.UGUIHelper.SetColorAlpha(var_12_2.txtTaskDesc2, var_12_4 and var_0_3 or var_0_4)
			ZProj.UGUIHelper.SetColorAlpha(var_12_2.txtTaskDesc, var_12_4 and var_0_1 or var_0_2)
			gohelper.setActive(var_12_2.goUnLockTime, var_12_4)
			gohelper.setActive(var_12_2.goNormalBG, var_12_4)
			gohelper.setActive(var_12_2.golockedBG, not var_12_4)

			if var_12_4 then
				var_12_2.txtUnLockedTime.text = TimeUtil.localTime2ServerTimeString(var_12_3.finishTime)
				var_12_2.txtTaskDesc.text = iter_12_1.desc
				arg_12_0._hasTaskFinished = true
			else
				local var_12_5 = iter_12_1.maxProgress
				local var_12_6 = var_12_3 and var_12_3.progress or 0
				local var_12_7 = {
					iter_12_1.desc,
					var_12_6,
					var_12_5
				}

				var_12_2.txtTaskDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementmainview_unlockPath"), var_12_7)
			end

			arg_12_0:playTaskAnim(var_12_2)
			arg_12_0:tryPlayUpgradeEffect(var_12_3, var_12_2)
		end
	end

	arg_12_0:recycleUnuseTaskItem(var_12_0)
	arg_12_0:onTasksPlayUpgradeEffectFinished()
end

function var_0_0.tryPlayUpgradeEffect(arg_13_0, arg_13_1, arg_13_2)
	if AchievementMainCommonModel.instance:isCurrentScrollFocusing() or not arg_13_0.viewGO.activeInHierarchy or not arg_13_1 or not arg_13_2 then
		return
	end

	local var_13_0 = AchievementConfig.instance:getTask(arg_13_1.id)

	arg_13_0._achievementId = var_13_0 and var_13_0.achievementId

	local var_13_1 = AchievementMainCommonModel.instance:isAchievementPlayEffect(arg_13_0._achievementId)

	arg_13_0._isNeedPlayEffect = false

	if arg_13_1 and arg_13_1.hasFinished and arg_13_1.isNew and not var_13_1 then
		arg_13_0._isNeedPlayEffect = true
	end

	gohelper.setActive(arg_13_2.goupgrade, arg_13_0._isNeedPlayEffect)

	if arg_13_0._isNeedPlayEffect then
		local var_13_2 = AchievementMainCommonModel.instance:isTaskPlayFinishedEffect(arg_13_1.id)

		arg_13_2.goupgradeAnimator:Play("upgrade2", 0, var_13_2 and 1 or 0)

		if not var_13_2 then
			AchievementMainCommonModel.instance:markTaskPlayFinishedEffect(arg_13_1.id)
		end
	end
end

function var_0_0.onTasksPlayUpgradeEffectFinished(arg_14_0)
	if arg_14_0._isNeedPlayEffect and arg_14_0._achievementId then
		AchievementMainCommonModel.instance:markAchievementPlayEffect(arg_14_0._achievementId)
	end
end

function var_0_0._onFocusFinished(arg_15_0, arg_15_1)
	if arg_15_1 ~= AchievementEnum.ViewType.List then
		return
	end

	if arg_15_0._taskItemTab then
		local var_15_0 = AchievementMainCommonModel.instance:getCurrentSortType()
		local var_15_1 = AchievementMainCommonModel.instance:getCurrentFilterType()
		local var_15_2 = arg_15_0._mo:getFilterTaskList(var_15_0, var_15_1)

		for iter_15_0, iter_15_1 in ipairs(var_15_2) do
			local var_15_3 = arg_15_0:getOrCreateTaskItem(iter_15_0)
			local var_15_4 = AchievementModel.instance:getById(iter_15_1.id)

			arg_15_0:tryPlayUpgradeEffect(var_15_4, var_15_3)
		end

		arg_15_0:onTasksPlayUpgradeEffectFinished()
	end
end

function var_0_0.playTaskAnim(arg_16_0, arg_16_1)
	if not arg_16_1 or not arg_16_1.viewGO.activeInHierarchy then
		return
	end

	if AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim() then
		arg_16_1.animator:Play("idle", 0, 0)
	else
		arg_16_1.animator:Play("open", 0, 0)
	end
end

function var_0_0.getOrCreateTaskItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._taskItemTab[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.viewGO = gohelper.cloneInPlace(arg_17_0._gotaskitem, "task_" .. arg_17_1)
		var_17_0.goNormalBG = gohelper.findChild(var_17_0.viewGO, "#go_NormalBG")
		var_17_0.golockedBG = gohelper.findChild(var_17_0.viewGO, "#go_lockedBG")
		var_17_0.txtTaskDesc = gohelper.findChildText(var_17_0.viewGO, "Descr/txt_taskdesc")
		var_17_0.txtTaskDesc2 = gohelper.findChildText(var_17_0.viewGO, "Descr/txt_taskdesc2")
		var_17_0.goUnLockTime = gohelper.findChild(var_17_0.viewGO, "UnLockedTime")
		var_17_0.txtUnLockedTime = gohelper.findChildText(var_17_0.viewGO, "UnLockedTime/#txt_UnLockedTime")
		var_17_0.goupgrade = gohelper.findChild(var_17_0.viewGO, "#go_upgrade")
		var_17_0.goupgradeAnimator = gohelper.onceAddComponent(var_17_0.goupgrade, gohelper.Type_Animator)
		var_17_0.goIcon = gohelper.findChild(var_17_0.viewGO, "go_icon")
		var_17_0.animator = gohelper.onceAddComponent(var_17_0.viewGO, gohelper.Type_Animator)

		if arg_17_0._view and arg_17_0._view.viewContainer then
			local var_17_1 = arg_17_0._view.viewContainer:getPoolView()

			if var_17_1 then
				var_17_0.taskIcon = var_17_1:getIcon(var_17_0.goIcon)

				var_17_0.taskIcon:setNameTxtVisible(false)
				var_17_0.taskIcon:setClickCall(arg_17_0._iconClickCallBack, arg_17_0)
			end
		end

		arg_17_0._taskItemTab[arg_17_1] = var_17_0
	end

	gohelper.setActive(var_17_0.viewGO, true)

	return var_17_0
end

function var_0_0._iconClickCallBack(arg_18_0)
	return
end

function var_0_0.recycleUnuseTaskItem(arg_19_0, arg_19_1)
	if arg_19_1 and arg_19_0._taskItemTab then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._taskItemTab) do
			if not arg_19_1[iter_19_1] then
				gohelper.setActive(iter_19_1.viewGO, false)
			end
		end
	end
end

function var_0_0.refreshTopUI(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 and arg_20_1.groupId ~= 0 and arg_20_0._mo.isGroupTop

	if var_20_0 then
		local var_20_1 = AchievementConfig.instance:getGroup(arg_20_1.groupId)

		arg_20_0:refreshGroupTopUI(var_20_1)
	end

	local var_20_2 = arg_20_0._mo:getIsFold()

	if not var_20_2 then
		arg_20_0:refreshSingleTopUI(arg_20_1)
	end

	gohelper.setActive(arg_20_0._gotop1, not var_20_2)
	gohelper.setActive(arg_20_0._gotop2, var_20_0)

	if not var_20_2 then
		arg_20_0:playTopAnim()
	end
end

function var_0_0.playTopAnim(arg_21_0)
	if not arg_21_0._gotop1.activeInHierarchy then
		return
	end

	if AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim() then
		arg_21_0._topAnimator:Play("idle", 0, 0)
	else
		arg_21_0._topAnimator:Play("open", 0, 0)
	end
end

local var_0_7 = 1
local var_0_8 = 0.5

function var_0_0.refreshSingleTopUI(arg_22_0, arg_22_1)
	if arg_22_1 then
		arg_22_0._txtachievementname.text = arg_22_1.name

		local var_22_0 = arg_22_0._hasTaskFinished and var_0_7 or var_0_8

		ZProj.UGUIHelper.SetColorAlpha(arg_22_0._txtachievementname, var_22_0)
	end
end

function var_0_0.refreshGroupTopUI(arg_23_0, arg_23_1)
	if arg_23_1 then
		local var_23_0 = AchievementConfig.instance:getGroupTitleColorConfig(arg_23_1.id, AchievementEnum.GroupParamType.Player)

		arg_23_0._txtachievementgroupname.text = arg_23_1.name

		SLFramework.UGUI.GuiHelper.SetColor(arg_23_0._txtachievementgroupname, var_23_0)
		arg_23_0._simageAchievementGroupBG:LoadImage(ResUrl.getAchievementIcon(string.format("grouptitle/%s", arg_23_1.id)))

		local var_23_1 = AchievementModel.instance:isGroupFinished(arg_23_1.id)

		gohelper.setActive(arg_23_0._goallcollect, var_23_1)
	end
end

function var_0_0.recycleAchievementMainIcon(arg_24_0)
	if arg_24_0._taskItemTab then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._taskItemTab) do
			iter_24_1.taskIcon:dispose()
		end
	end
end

return var_0_0
