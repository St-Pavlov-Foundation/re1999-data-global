module("modules.logic.player.view.PlayerViewAchievement", package.seeall)

local var_0_0 = class("PlayerViewAchievement", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goachievement = gohelper.findChild(arg_1_0.viewGO, "go_achievement")
	arg_1_0._goshow = gohelper.findChild(arg_1_0.viewGO, "go_achievement/#go_show")
	arg_1_0._btneditachievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_achievement/#go_show/#btn_editachievement")
	arg_1_0._gosinglecontainer = gohelper.findChild(arg_1_0.viewGO, "go_achievement/#go_show/#go_singlecontainer")
	arg_1_0._gogroupcontainer = gohelper.findChild(arg_1_0.viewGO, "go_achievement/#go_show/#go_groupcontainer")
	arg_1_0._gosingleitem = gohelper.findChild(arg_1_0.viewGO, "go_achievement/#go_show/#go_singlecontainer/horizontal/#go_singleitem")
	arg_1_0._goshowempty = gohelper.findChild(arg_1_0.viewGO, "go_achievement/#go_show/#go_showempty")
	arg_1_0._simagegroupbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_achievement/#go_show/#go_groupcontainer/#simage_groupbg")
	arg_1_0._gogrouparea = gohelper.findChild(arg_1_0.viewGO, "go_achievement/#go_show/#go_groupcontainer/#go_grouparea")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "go_achievement/#go_show/#go_groupcontainer/#txt_Title")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btneditachievement:AddClickListener(arg_2_0._btneditachievementOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btneditachievement:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0:_tryDisposeSingleItems()
	arg_5_0:_tryDisposeGroupItems()
	arg_5_0._simagegroupbg:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._playerSelf = arg_6_0.viewParam.playerSelf
	arg_6_0._info = arg_6_0.viewParam.playerInfo
	arg_6_0._singleAchieveTabs = {}

	arg_6_0:addEventCb(AchievementController.instance, AchievementEvent.AchievementSaveSucc, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:removeEventCb(AchievementController.instance, AchievementEvent.AchievementSaveSucc, arg_7_0.refreshUI, arg_7_0)
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:_refreshAchievements()
end

function var_0_0._getOrCreateSingleItem(arg_9_0, arg_9_1)
	if not arg_9_0._singleAchieveTabs[arg_9_1] then
		local var_9_0 = arg_9_0:getUserDataTb_()

		var_9_0.viewGo = gohelper.cloneInPlace(arg_9_0._gosingleitem, "singleitem_" .. arg_9_1)
		var_9_0.goempty = gohelper.findChild(var_9_0.viewGo, "go_empty")
		var_9_0.gohas = gohelper.findChild(var_9_0.viewGo, "go_has")
		var_9_0.simageicon = gohelper.findChildSingleImage(var_9_0.viewGo, "go_has/simage_icon")

		table.insert(arg_9_0._singleAchieveTabs, arg_9_1, var_9_0)
	end

	return arg_9_0._singleAchieveTabs[arg_9_1]
end

function var_0_0._refreshAchievements(arg_10_0)
	local var_10_0 = arg_10_0._playerSelf and PlayerModel.instance:getShowAchievement() or arg_10_0._info.showAchievement
	local var_10_1, var_10_2 = PlayerViewAchievementModel.instance:getShowAchievements(var_10_0)
	local var_10_3 = not var_10_2 or tabletool.len(var_10_2) <= 0

	gohelper.setActive(arg_10_0._goshowempty, var_10_3)
	gohelper.setActive(arg_10_0._gogroupcontainer, var_10_1 and not var_10_3)
	gohelper.setActive(arg_10_0._gosinglecontainer, not var_10_1 and not var_10_3)

	if var_10_3 then
		return
	end

	if not var_10_1 then
		local var_10_4 = 1

		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			local var_10_5 = arg_10_0:_getOrCreateSingleItem(var_10_4)

			gohelper.setActive(var_10_5.viewGo, true)
			gohelper.setActive(var_10_5.goempty, false)
			gohelper.setActive(var_10_5.gohas, true)

			local var_10_6 = AchievementConfig.instance:getTask(iter_10_1)

			if var_10_6 then
				var_10_5.simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. var_10_6.icon))
			end

			var_10_4 = var_10_4 + 1
		end

		for iter_10_2 = var_10_4, AchievementEnum.ShowMaxSingleCount do
			local var_10_7 = arg_10_0:_getOrCreateSingleItem(iter_10_2)

			gohelper.setActive(var_10_7.viewGo, true)
			gohelper.setActive(var_10_7.goempty, true)
			gohelper.setActive(var_10_7.gohas, false)
		end
	else
		for iter_10_3, iter_10_4 in pairs(var_10_2) do
			arg_10_0:_refreshGroupAchievements(iter_10_3, iter_10_4)
		end
	end
end

function var_0_0._refreshGroupAchievements(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = AchievementConfig.instance:getGroup(arg_11_1)

	if var_11_0 then
		arg_11_0:_refreshGroupTitle(var_11_0)
		arg_11_0:_refreshGroupBg(var_11_0, arg_11_2)
		arg_11_0:_buildAchievementIconInGroup(arg_11_1, arg_11_2)
	end
end

function var_0_0._refreshGroupBg(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = false

	if arg_12_1 and arg_12_1.unLockAchievement ~= 0 and arg_12_2 then
		var_12_0 = tabletool.indexOf(arg_12_2, arg_12_1.unLockAchievement) ~= nil
	end

	local var_12_1 = AchievementConfig.instance:getGroupBgUrl(arg_12_1.id, AchievementEnum.GroupParamType.Player, var_12_0)

	arg_12_0._simagegroupbg:LoadImage(var_12_1)
end

function var_0_0._refreshGroupTitle(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0._txtTitle.text = tostring(arg_13_1.name)

		local var_13_0 = AchievementConfig.instance:getGroupTitleColorConfig(arg_13_1.id, AchievementEnum.GroupParamType.Player)

		SLFramework.UGUI.GuiHelper.SetColor(arg_13_0._txtTitle, var_13_0)
	end
end

function var_0_0._buildAchievementIconInGroup(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_14_1)
	local var_14_1 = arg_14_0:buildAchievementAndTaskMap(arg_14_2)
	local var_14_2 = {}
	local var_14_3 = AchievementConfig.instance:getGroupParamIdTab(arg_14_1, AchievementEnum.GroupParamType.Player)

	if var_14_3 then
		for iter_14_0, iter_14_1 in ipairs(var_14_3) do
			local var_14_4 = arg_14_0:getOrCreateSingleItemInGroup(iter_14_0)

			arg_14_0:_setGroupAchievementPosAndScale(var_14_4.viewGO, arg_14_1, iter_14_0)

			var_14_2[var_14_4] = true

			local var_14_5 = var_14_0 and var_14_0[iter_14_1]

			gohelper.setActive(var_14_4.viewGO, var_14_5 ~= nil)

			if var_14_5 then
				local var_14_6 = arg_14_0:getExistTaskCo(var_14_1, var_14_5)

				var_14_4:setSelectIconVisible(false)
				var_14_4:setNameTxtVisible(false)

				if var_14_6 then
					var_14_4:setData(var_14_6)
					var_14_4:setIconVisible(true)
					var_14_4:setBgVisible(false)
				else
					gohelper.setActive(var_14_4.viewGO, false)
				end
			end
		end
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0._groupItems) do
		if not var_14_2[iter_14_3] then
			gohelper.setActive(iter_14_3.viewGO, false)
		end
	end
end

function var_0_0.buildAchievementAndTaskMap(arg_15_0, arg_15_1)
	local var_15_0 = {}

	if arg_15_1 then
		for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
			local var_15_1 = AchievementConfig.instance:getTask(iter_15_1)
			local var_15_2 = var_15_1.achievementId

			if not var_15_0[var_15_2] then
				var_15_0[var_15_2] = var_15_1
			end
		end
	end

	return var_15_0
end

function var_0_0.getExistTaskCo(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_1[arg_16_2.id]
end

function var_0_0.getOrCreateSingleItemInGroup(arg_17_0, arg_17_1)
	arg_17_0._groupItems = arg_17_0._groupItems or arg_17_0:getUserDataTb_()

	local var_17_0 = arg_17_0._groupItems[arg_17_1]

	if not var_17_0 then
		var_17_0 = AchievementMainIcon.New()

		local var_17_1 = arg_17_0:getResInst(AchievementEnum.MainIconPath, arg_17_0._gogrouparea, "#go_icon" .. arg_17_1)

		var_17_0:init(var_17_1)

		arg_17_0._groupItems[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0._setGroupAchievementPosAndScale(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0, var_18_1, var_18_2, var_18_3 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(arg_18_2, arg_18_3, AchievementEnum.GroupParamType.Player)

	if arg_18_1 then
		recthelper.setAnchor(arg_18_1.transform, var_18_0 or 0, var_18_1 or 0)
		transformhelper.setLocalScale(arg_18_1.transform, var_18_2 or 1, var_18_3 or 1, 1)
	end
end

function var_0_0._btneditachievementOnClick(arg_19_0)
	if arg_19_0._playerSelf then
		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
			ViewMgr.instance:openView(ViewName.AchievementSelectView)
		else
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
		end
	end
end

function var_0_0._tryDisposeSingleItems(arg_20_0)
	if arg_20_0._singleAchieveTabs then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._singleAchieveTabs) do
			if iter_20_1.simageicon then
				iter_20_1.simageicon:UnLoadImage()
			end
		end

		arg_20_0._singleAchieveTabs = nil
	end
end

function var_0_0._tryDisposeGroupItems(arg_21_0)
	if arg_21_0._groupItems then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._groupItems) do
			iter_21_1:dispose()
		end

		arg_21_0._groupItems = nil
	end
end

return var_0_0
