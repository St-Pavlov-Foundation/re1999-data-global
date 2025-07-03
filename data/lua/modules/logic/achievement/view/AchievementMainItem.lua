module("modules.logic.achievement.view.AchievementMainItem", package.seeall)

local var_0_0 = class("AchievementMainItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosingle = gohelper.findChild(arg_1_0.viewGO, "#go_single")
	arg_1_0._gogroup = gohelper.findChild(arg_1_0.viewGO, "#go_group")
	arg_1_0._gogroup2 = gohelper.findChild(arg_1_0.viewGO, "#go_group2")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_group/#image_bg")
	arg_1_0._gogroupcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_group/#go_groupcontainer")
	arg_1_0._goupgrade = gohelper.findChild(arg_1_0.viewGO, "#go_group/#go_upgrade")
	arg_1_0._goallcollect = gohelper.findChild(arg_1_0.viewGO, "#go_group/#go_allcollect")
	arg_1_0._gotop2 = gohelper.findChild(arg_1_0.viewGO, "#go_group2/go_top2")
	arg_1_0._simageAchievementGroupBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_group2/go_top2/#simage_AchievementGroupBG")
	arg_1_0._txtachievementgroupname = gohelper.findChildText(arg_1_0.viewGO, "#go_group2/go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname")
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "#go_group2/#go_layout")
	arg_1_0._btnpopup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_group2/go_top2/#btn_popup")

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

function var_0_0._btnpopupOnClick(arg_4_0)
	local var_4_0 = arg_4_0._mo:getIsFold()

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnClickGroupFoldBtn, arg_4_0._mo.groupId, not var_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0.viewGO, typeof(UnityEngine.Animator))
	arg_5_0._groupBgImage = gohelper.findChildImage(arg_5_0.viewGO, "#go_group/#image_bg")
	arg_5_0._iconItems = arg_5_0:getUserDataTb_()

	arg_5_0:addEventCb(AchievementController.instance, AchievementEvent.OnGroupUpGrade, arg_5_0._onGroupUpGrade, arg_5_0)
	arg_5_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, arg_5_0._onFocusFinished, arg_5_0)
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0:recycleIcons()
	arg_6_0._simagebg:UnLoadImage()
	arg_6_0._simageAchievementGroupBG:UnLoadImage()
	TaskDispatcher.cancelTask(arg_6_0.playItemOpenAim, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.playAchievementUnlockAnim, arg_6_0)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	if arg_7_0._mo ~= arg_7_1 then
		arg_7_0:recycleIcons()
	end

	arg_7_0._mo = arg_7_1

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = AchievementUtils.isActivityGroup(arg_8_0._mo.firstAchievementCo.id)
	local var_8_1 = AchievementUtils.isGamePlayGroup(arg_8_0._mo.firstAchievementCo.id)
	local var_8_2 = not var_8_0 and not var_8_1

	gohelper.setActive(arg_8_0._gosingle, var_8_2)
	gohelper.setActive(arg_8_0._gogroup, var_8_0)
	gohelper.setActive(arg_8_0._gogroup2, var_8_1)

	if var_8_0 then
		arg_8_0:refreshGroup()
	elseif var_8_1 then
		arg_8_0:refreshGroup2()
	else
		arg_8_0:refreshSingle(arg_8_0._gosingle, 1, arg_8_0._mo.count)
	end

	arg_8_0:playAchievementAnim()
end

var_0_0.LockedIconColor = "#4D4D4D"
var_0_0.UnLockedIconColor = "#FFFFFF"
var_0_0.LockedNameAlpha = 0.5
var_0_0.UnLockedNameAlpha = 1
var_0_0.LockedGroupBgColor = "#808080"
var_0_0.UnLockedGroupBgColor = "#FFFFFF"

function var_0_0.refreshSingle(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0:checkInitIcon(arg_9_3, arg_9_1)

	for iter_9_0 = 1, arg_9_3 do
		local var_9_0 = arg_9_0._iconItems[iter_9_0]
		local var_9_1 = var_9_0.viewGO.transform
		local var_9_2 = arg_9_2 + iter_9_0 - 1

		recthelper.setAnchor(var_9_1, var_0_0.IconStartX + (iter_9_0 - 1) * var_0_0.IconIntervalX, 0)
		var_9_0:setClickCall(arg_9_0.onClickSingleIcon, arg_9_0, var_9_2)

		local var_9_3 = arg_9_0._mo.achievementCfgs[var_9_2]

		gohelper.setActive(var_9_0.viewGO, var_9_3 ~= nil)

		if var_9_3 then
			local var_9_4 = var_9_3.id
			local var_9_5 = AchievementController.instance:getMaxLevelFinishTask(var_9_4)

			if var_9_5 then
				var_9_0:setData(var_9_5)

				local var_9_6 = AchievementModel.instance:achievementHasLocked(var_9_4)

				var_9_0:setIsLocked(var_9_6)
				var_9_0:setIconColor(var_9_6 and var_0_0.LockedIconColor or var_0_0.UnLockedIconColor)
				var_9_0:setNameTxtAlpha(var_9_6 and var_0_0.LockedNameAlpha or var_0_0.UnLockedNameAlpha)
				var_9_0:setNameTxtVisible(true)
				var_9_0:setSelectIconVisible(false)
				var_9_0:setBgVisible(true)
			else
				gohelper.setActive(var_9_0.viewGO, false)
			end
		end
	end
end

function var_0_0.refreshGroup(arg_10_0)
	local var_10_0 = AchievementConfig.instance:getGroup(arg_10_0._mo.groupId)

	if var_10_0 then
		gohelper.setActive(arg_10_0._goupgrade, false)
		arg_10_0:refreshGroupBg(var_10_0)
		arg_10_0:refreshSingleInGroup()
	end
end

function var_0_0.refreshGroup2(arg_11_0)
	arg_11_0._txtachievementgroupname.text = AchievementConfig.instance:getGroupName(arg_11_0._mo.groupId)

	arg_11_0._simageAchievementGroupBG:LoadImage(ResUrl.getAchievementIcon(string.format("grouptitle/%s", arg_11_0._mo.groupId)))
	arg_11_0:refreshSingle(arg_11_0._golayout, 1, arg_11_0._mo.count)
	gohelper.setActive(arg_11_0._gotop2, arg_11_0._mo.isGroupTop)

	arg_11_0._foldAnimComp = AchievementItemFoldAnimComp.Get(arg_11_0._btnpopup.gameObject, arg_11_0._golayout)

	arg_11_0._foldAnimComp:onUpdateMO(arg_11_0._mo)
end

function var_0_0.refreshGroupBg(arg_12_0, arg_12_1)
	if arg_12_1 then
		local var_12_0 = AchievementModel.instance:isAchievementTaskFinished(arg_12_1.unLockAchievement)
		local var_12_1 = AchievementConfig.instance:getGroupBgUrl(arg_12_0._mo.groupId, AchievementEnum.GroupParamType.List, var_12_0)

		arg_12_0._simagebg:LoadImage(var_12_1)

		local var_12_2 = AchievementModel.instance:achievementGroupHasLocked(arg_12_0._mo.groupId)

		SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._groupBgImage, var_12_2 and var_0_0.LockedGroupBgColor or var_0_0.UnLockedGroupBgColor)
	end
end

function var_0_0.refreshSingleInGroup(arg_13_0)
	local var_13_0 = AchievementConfig.instance:getGroupParamIdTab(arg_13_0._mo.groupId, AchievementEnum.GroupParamType.List)
	local var_13_1 = var_13_0 and #var_13_0 or 0

	arg_13_0:checkInitIcon(var_13_1, arg_13_0._gogroupcontainer)

	for iter_13_0 = 1, var_13_1 do
		local var_13_2 = arg_13_0._iconItems[iter_13_0]

		var_13_2:setClickCall(arg_13_0.onClickSingleIcon, arg_13_0, var_13_0[iter_13_0])
		arg_13_0:_setGroupAchievementPosAndScale(var_13_2.viewGO, arg_13_0._mo.groupId, iter_13_0)

		local var_13_3 = arg_13_0._mo.achievementCfgs[var_13_0[iter_13_0]]

		gohelper.setActive(var_13_2.viewGO, var_13_3 ~= nil)

		if var_13_3 then
			local var_13_4 = var_13_3.id
			local var_13_5 = AchievementController.instance:getMaxLevelFinishTask(var_13_4)

			if var_13_5 then
				var_13_2:setData(var_13_5)

				local var_13_6 = AchievementModel.instance:achievementHasLocked(var_13_4)

				var_13_2:setIsLocked(var_13_6)
				var_13_2:setIconColor(var_13_6 and var_0_0.LockedIconColor or var_0_0.UnLockedIconColor)
				var_13_2:setSelectIconVisible(false)
				var_13_2:setNameTxtVisible(false)
				var_13_2:setBgVisible(false)
			else
				gohelper.setActive(var_13_2.viewGO, false)
			end
		end
	end

	local var_13_7 = AchievementModel.instance:isGroupFinished(arg_13_0._mo.groupId)

	gohelper.setActive(arg_13_0._goallcollect, var_13_7)
end

function var_0_0._setGroupAchievementPosAndScale(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0, var_14_1, var_14_2, var_14_3 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(arg_14_2, arg_14_3, AchievementEnum.GroupParamType.List)

	if arg_14_1 then
		recthelper.setAnchor(arg_14_1.transform, var_14_0 or 0, var_14_1 or 0)
		transformhelper.setLocalScale(arg_14_1.transform, var_14_2 or 1, var_14_3 or 1, 1)
	end
end

var_0_0.IconStartX = -535
var_0_0.IconIntervalX = 262

function var_0_0.checkInitIcon(arg_15_0, arg_15_1, arg_15_2)
	if #arg_15_0._iconItems == arg_15_1 then
		return
	end

	local var_15_0

	if arg_15_0._view and arg_15_0._view.viewContainer then
		var_15_0 = arg_15_0._view.viewContainer:getPoolView()

		if not var_15_0 then
			return
		end
	end

	for iter_15_0 = 1, arg_15_1 do
		local var_15_1 = var_15_0:getIcon(arg_15_2)

		gohelper.setActive(var_15_1.viewGO, true)

		arg_15_0._iconItems[iter_15_0] = var_15_1
	end
end

function var_0_0.recycleIcons(arg_16_0)
	local var_16_0

	if arg_16_0._view and arg_16_0._view.viewContainer then
		var_16_0 = arg_16_0._view.viewContainer:getPoolView()

		if not var_16_0 then
			return
		end
	end

	if arg_16_0._iconItems then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._iconItems) do
			var_16_0:recycleIcon(arg_16_0._iconItems[iter_16_0])

			arg_16_0._iconItems[iter_16_0] = nil
		end
	end
end

function var_0_0.onClickSingleIcon(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._mo.achievementCfgs[arg_17_1]

	if var_17_0 then
		local var_17_1 = {
			achievementId = var_17_0.id,
			achievementIds = AchievementMainTileModel.instance:getCurrentAchievementIds()
		}

		ViewMgr.instance:openView(ViewName.AchievementLevelView, var_17_1)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
	end
end

var_0_0.AnimDelayDelta = 0.06

function var_0_0.playAchievementAnim(arg_18_0)
	arg_18_0:playAchievementOpenAnim()
	TaskDispatcher.cancelTask(arg_18_0.playAchievementUnlockAnim, arg_18_0)
	TaskDispatcher.runDelay(arg_18_0.playAchievementUnlockAnim, arg_18_0, 0.5)
end

function var_0_0.playAchievementOpenAnim(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.playItemOpenAim, arg_19_0)

	if not arg_19_0.viewGO.activeInHierarchy then
		return
	end

	local var_19_0 = AchievementMainTileModel.instance:getScrollFocusIndex()
	local var_19_1 = AchievementMainTileModel.instance:hasPlayOpenAnim()

	if var_19_0 then
		if not var_19_1 then
			arg_19_0._animator:Play("close", 0, 0)

			local var_19_2 = var_0_0.AnimDelayDelta * Mathf.Clamp(arg_19_0._index - var_19_0, 0, arg_19_0._index)

			TaskDispatcher.runDelay(arg_19_0.playItemOpenAim, arg_19_0, var_19_2)
		else
			arg_19_0._animator:Play("idle", 0, 0)
		end
	else
		arg_19_0._animator:Play("close", 0, 0)
	end
end

function var_0_0.playItemOpenAim(arg_20_0)
	arg_20_0._animator:Play("open", 0, 0)
end

function var_0_0._onFocusFinished(arg_21_0, arg_21_1)
	if arg_21_1 ~= AchievementEnum.ViewType.Tile then
		return
	end

	arg_21_0:playAchievementAnim()
end

function var_0_0.playAchievementUnlockAnim(arg_22_0)
	if arg_22_0._iconItems then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._iconItems) do
			arg_22_0:playSingleAchievementUnlockAnim(iter_22_1)
		end
	end
end

function var_0_0.playSingleAchievementUnlockAnim(arg_23_0, arg_23_1)
	if not arg_23_1 or not arg_23_1.viewGO or not arg_23_1.viewGO.activeInHierarchy then
		return
	end

	local var_23_0 = arg_23_1:getTaskCO()
	local var_23_1 = var_23_0 and var_23_0.achievementId
	local var_23_2 = AchievementModel.instance:achievementHasNew(var_23_1)
	local var_23_3 = AchievementMainCommonModel.instance:isAchievementPlayEffect(var_23_1)

	if var_23_2 then
		arg_23_1:playAnim(var_23_3 and AchievementMainIcon.AnimClip.Loop or AchievementMainIcon.AnimClip.New)
	else
		arg_23_1:playAnim(AchievementMainIcon.AnimClip.Idle)
	end

	AchievementMainCommonModel.instance:markAchievementPlayEffect(var_23_1)
end

function var_0_0._onGroupUpGrade(arg_24_0, arg_24_1)
	if arg_24_0._mo.groupId == arg_24_1 then
		gohelper.setActive(arg_24_0._goupgrade, true)
	end
end

return var_0_0
