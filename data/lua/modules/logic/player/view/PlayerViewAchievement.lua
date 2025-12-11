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
	arg_1_0._gomisihai = gohelper.findChild(arg_1_0.viewGO, "go_achievement/#go_show/#go_misihai")

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
	local var_10_1, var_10_2, var_10_3 = PlayerViewAchievementModel.instance:getShowAchievements(var_10_0)
	local var_10_4 = not var_10_2 or tabletool.len(var_10_2) <= 0

	gohelper.setActive(arg_10_0._goshowempty, var_10_4)
	gohelper.setActive(arg_10_0._gogroupcontainer, var_10_1 and not var_10_4)
	gohelper.setActive(arg_10_0._gosinglecontainer, not var_10_1 and not var_10_4 and not var_10_3)
	gohelper.setActive(arg_10_0._gomisihai, not var_10_1 and not var_10_4 and var_10_3)

	if var_10_4 then
		return
	end

	if not var_10_1 then
		if not var_10_3 then
			local var_10_5 = 1

			for iter_10_0, iter_10_1 in ipairs(var_10_2) do
				local var_10_6 = arg_10_0:_getOrCreateSingleItem(var_10_5)

				gohelper.setActive(var_10_6.viewGo, true)
				gohelper.setActive(var_10_6.goempty, false)
				gohelper.setActive(var_10_6.gohas, true)

				local var_10_7 = AchievementConfig.instance:getTask(iter_10_1)

				if var_10_7 then
					var_10_6.simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. var_10_7.icon))
				end

				var_10_5 = var_10_5 + 1
			end

			for iter_10_2 = var_10_5, AchievementEnum.ShowMaxSingleCount do
				local var_10_8 = arg_10_0:_getOrCreateSingleItem(iter_10_2)

				gohelper.setActive(var_10_8.viewGo, true)
				gohelper.setActive(var_10_8.goempty, true)
				gohelper.setActive(var_10_8.gohas, false)
			end
		else
			arg_10_0:_refreshNamePlate(var_10_2)
		end
	else
		for iter_10_3, iter_10_4 in pairs(var_10_2) do
			arg_10_0:_refreshGroupAchievements(iter_10_3, iter_10_4)
		end
	end
end

function var_0_0._refreshNamePlate(arg_11_0, arg_11_1)
	arg_11_0._gonameplateitem = arg_11_0._gonameplateitem or arg_11_0:_getOrCreateNamePlate()

	local var_11_0 = AchievementConfig.instance:getTask(arg_11_1[1])

	if not var_11_0 then
		return
	end

	local var_11_1 = AchievementConfig.instance:getAchievement(var_11_0.achievementId)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._gonameplateitem.levelItemList) do
		gohelper.setActive(iter_11_1.go, false)
	end

	local var_11_2 = arg_11_0._gonameplateitem.levelItemList[var_11_0.level]
	local var_11_3
	local var_11_4

	if var_11_0.image and not string.nilorempty(var_11_0.image) then
		local var_11_5 = string.split(var_11_0.image, "#")

		var_11_3 = var_11_5[1]
		var_11_4 = var_11_5[2]
	end

	local function var_11_6()
		local var_12_0 = var_11_2._bgLoader:getInstGO()
	end

	if var_11_2._bgLoader then
		var_11_2._bgLoader:dispose()

		var_11_2._bgLoader = nil
	end

	var_11_2._bgLoader = PrefabInstantiate.Create(var_11_2.gobg)

	var_11_2._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(var_11_3), var_11_6, arg_11_0)
	var_11_2.simagetitle:LoadImage(ResUrl.getAchievementLangIcon(var_11_4))

	local var_11_7 = var_11_0.listenerType
	local var_11_8 = AchievementUtils.getAchievementProgressBySourceType(var_11_1.rule)
	local var_11_9

	if var_11_7 and var_11_7 == "TowerPassLayer" then
		if var_11_0.listenerParam and not string.nilorempty(var_11_0.listenerParam) then
			local var_11_10 = string.split(var_11_0.listenerParam, "#")

			var_11_9 = var_11_10 and var_11_10[3]
			var_11_9 = var_11_9 * 10
		end
	else
		var_11_9 = var_11_0 and var_11_0.maxProgress
	end

	var_11_2.txtlevel.text = var_11_9 < var_11_8 and var_11_8 or var_11_9

	gohelper.setActive(var_11_2.go, true)
end

function var_0_0._getOrCreateNamePlate(arg_13_0)
	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.go = gohelper.findChild(arg_13_0._gomisihai, "go_icon")
	var_13_0.levelItemList = {}

	for iter_13_0 = 1, 3 do
		local var_13_1 = {
			go = gohelper.findChild(var_13_0.go, "deep" .. iter_13_0)
		}

		var_13_1.gobg = gohelper.findChild(var_13_1.go, "#simage_bg")
		var_13_1.simagetitle = gohelper.findChildSingleImage(var_13_1.go, "#simage_title")
		var_13_1.txtlevel = gohelper.findChildText(var_13_1.go, "#txt_deep_" .. iter_13_0)

		gohelper.setActive(var_13_1.go, false)
		table.insert(var_13_0.levelItemList, var_13_1)
	end

	return var_13_0
end

function var_0_0._refreshGroupAchievements(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = AchievementConfig.instance:getGroup(arg_14_1)

	if var_14_0 then
		arg_14_0:_refreshGroupTitle(var_14_0)
		arg_14_0:_refreshGroupBg(var_14_0, arg_14_2)
		arg_14_0:_buildAchievementIconInGroup(arg_14_1, arg_14_2)
	end
end

function var_0_0._refreshGroupBg(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = false

	if arg_15_1 and arg_15_1.unLockAchievement ~= 0 and arg_15_2 then
		var_15_0 = tabletool.indexOf(arg_15_2, arg_15_1.unLockAchievement) ~= nil
	end

	local var_15_1 = AchievementConfig.instance:getGroupBgUrl(arg_15_1.id, AchievementEnum.GroupParamType.Player, var_15_0)

	arg_15_0._simagegroupbg:LoadImage(var_15_1)
end

function var_0_0._refreshGroupTitle(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0._txtTitle.text = tostring(arg_16_1.name)

		local var_16_0 = AchievementConfig.instance:getGroupTitleColorConfig(arg_16_1.id, AchievementEnum.GroupParamType.Player)

		SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtTitle, var_16_0)
	end
end

function var_0_0._buildAchievementIconInGroup(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_17_1)
	local var_17_1 = arg_17_0:buildAchievementAndTaskMap(arg_17_2)
	local var_17_2 = {}
	local var_17_3 = AchievementConfig.instance:getGroupParamIdTab(arg_17_1, AchievementEnum.GroupParamType.Player)

	if var_17_3 then
		for iter_17_0, iter_17_1 in ipairs(var_17_3) do
			local var_17_4 = arg_17_0:getOrCreateSingleItemInGroup(iter_17_0)

			arg_17_0:_setGroupAchievementPosAndScale(var_17_4.viewGO, arg_17_1, iter_17_0)

			var_17_2[var_17_4] = true

			local var_17_5 = var_17_0 and var_17_0[iter_17_1]

			gohelper.setActive(var_17_4.viewGO, var_17_5 ~= nil)

			if var_17_5 then
				local var_17_6 = arg_17_0:getExistTaskCo(var_17_1, var_17_5)

				var_17_4:setSelectIconVisible(false)
				var_17_4:setNameTxtVisible(false)

				if var_17_6 then
					var_17_4:setData(var_17_6)
					var_17_4:setIconVisible(true)
					var_17_4:setBgVisible(false)
				else
					gohelper.setActive(var_17_4.viewGO, false)
				end
			end
		end
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0._groupItems) do
		if not var_17_2[iter_17_3] then
			gohelper.setActive(iter_17_3.viewGO, false)
		end
	end
end

function var_0_0.buildAchievementAndTaskMap(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if arg_18_1 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			local var_18_1 = AchievementConfig.instance:getTask(iter_18_1)
			local var_18_2 = var_18_1.achievementId

			if not var_18_0[var_18_2] then
				var_18_0[var_18_2] = var_18_1
			end
		end
	end

	return var_18_0
end

function var_0_0.getExistTaskCo(arg_19_0, arg_19_1, arg_19_2)
	return arg_19_1[arg_19_2.id]
end

function var_0_0.getOrCreateSingleItemInGroup(arg_20_0, arg_20_1)
	arg_20_0._groupItems = arg_20_0._groupItems or arg_20_0:getUserDataTb_()

	local var_20_0 = arg_20_0._groupItems[arg_20_1]

	if not var_20_0 then
		var_20_0 = AchievementMainIcon.New()

		local var_20_1 = arg_20_0:getResInst(AchievementEnum.MainIconPath, arg_20_0._gogrouparea, "#go_icon" .. arg_20_1)

		var_20_0:init(var_20_1)

		arg_20_0._groupItems[arg_20_1] = var_20_0
	end

	return var_20_0
end

function var_0_0._setGroupAchievementPosAndScale(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0, var_21_1, var_21_2, var_21_3 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(arg_21_2, arg_21_3, AchievementEnum.GroupParamType.Player)

	if arg_21_1 then
		recthelper.setAnchor(arg_21_1.transform, var_21_0 or 0, var_21_1 or 0)
		transformhelper.setLocalScale(arg_21_1.transform, var_21_2 or 1, var_21_3 or 1, 1)
	end
end

function var_0_0._btneditachievementOnClick(arg_22_0)
	if arg_22_0._playerSelf then
		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
			ViewMgr.instance:openView(ViewName.AchievementSelectView)
		else
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
		end
	end
end

function var_0_0._tryDisposeSingleItems(arg_23_0)
	if arg_23_0._singleAchieveTabs then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._singleAchieveTabs) do
			if iter_23_1.simageicon then
				iter_23_1.simageicon:UnLoadImage()
			end
		end

		arg_23_0._singleAchieveTabs = nil
	end
end

function var_0_0._tryDisposeGroupItems(arg_24_0)
	if arg_24_0._groupItems then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._groupItems) do
			iter_24_1:dispose()
		end

		arg_24_0._groupItems = nil
	end
end

return var_0_0
