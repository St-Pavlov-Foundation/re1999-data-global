module("modules.logic.playercard.view.comp.PlayerCardAchievement", package.seeall)

local var_0_0 = class("PlayerCardAchievement", BaseView)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1

	arg_1_0:onInitView()
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.go = gohelper.findChild(arg_2_0.viewGO, "root/main/achieve")
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_0.go, "#btn_click")
	arg_2_0.txtDec = gohelper.findChildTextMesh(arg_2_0.go, "#txt_dec")
	arg_2_0.goAchievement = gohelper.findChild(arg_2_0.go, "#go_achievement")
	arg_2_0.goSingle = gohelper.findChild(arg_2_0.goAchievement, "#go_singlecontainer")
	arg_2_0.goSingleItem = gohelper.findChild(arg_2_0.goAchievement, "#go_singlecontainer/horizontal/#go_singleitem")
	arg_2_0.goSingleSelectedEffect = gohelper.findChild(arg_2_0.goAchievement, "#go_singlecontainer/selected_eff")
	arg_2_0.goGroup = gohelper.findChild(arg_2_0.goAchievement, "#go_group")
	arg_2_0.groupSimageBg = gohelper.findChildSingleImage(arg_2_0.goAchievement, "#go_group/#image_bg")
	arg_2_0.goGroupContainer = gohelper.findChild(arg_2_0.goAchievement, "#go_group/#go_groupcontainer")
	arg_2_0.goGroupSelectedEffect = gohelper.findChild(arg_2_0.goAchievement, "#go_group/selected_eff")
	arg_2_0.goEmpty = gohelper.findChild(arg_2_0.goAchievement, "#go_showempty")
	arg_2_0._singleAchieveTabs = {}
	arg_2_0._iconItems = {}
end

function var_0_0.playSelelctEffect(arg_3_0)
	gohelper.setActive(arg_3_0.goGroupSelectedEffect, false)
	gohelper.setActive(arg_3_0.goGroupSelectedEffect, true)
	gohelper.setActive(arg_3_0.goSingleSelectedEffect, false)
	gohelper.setActive(arg_3_0.goSingleSelectedEffect, true)
	PlayerCardController.instance:playChangeEffectAudio()
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0.btnClick:AddClickListener(arg_4_0.btnClickOnClick, arg_4_0)
	arg_4_0:addEventCb(AchievementController.instance, AchievementEvent.AchievementSaveSucc, arg_4_0.onRefreshView, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0.btnClick:RemoveClickListener()
	arg_5_0:removeEventCb(AchievementController.instance, AchievementEvent.AchievementSaveSucc, arg_5_0.onRefreshView, arg_5_0)
end

function var_0_0.canOpen(arg_6_0)
	arg_6_0:onOpen()
	arg_6_0:addEvents()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.userId = arg_7_0.viewParam.userId

	local var_7_0 = arg_7_0.viewContainer:getSetting().otherRes.achieveitem

	arg_7_0.itemRes = arg_7_0.viewContainer:getRes(var_7_0)

	arg_7_0:onRefreshView()
end

function var_0_0.getCardInfo(arg_8_0)
	return PlayerCardModel.instance:getCardInfo(arg_8_0.userId)
end

function var_0_0.isPlayerSelf(arg_9_0)
	local var_9_0 = arg_9_0:getCardInfo()

	return var_9_0 and var_9_0:isSelf()
end

function var_0_0.getPlayerInfo(arg_10_0)
	local var_10_0 = arg_10_0:getCardInfo()

	return var_10_0 and var_10_0:getPlayerInfo()
end

function var_0_0.btnClickOnClick(arg_11_0)
	if arg_11_0:isPlayerSelf() then
		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
			ViewMgr.instance:openView(ViewName.PlayerCardAchievementSelectView)
		else
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
		end
	end
end

function var_0_0.onRefreshView(arg_12_0)
	local var_12_0 = arg_12_0:getCardInfo()

	if not var_12_0 then
		return
	end

	if var_12_0.achievementCount == -1 then
		arg_12_0.txtDec.text = PlayerCardEnum.EmptyString2
	else
		arg_12_0.txtDec.text = tostring(var_12_0.achievementCount)
	end

	arg_12_0:_refreshAchievements()
end

function var_0_0._refreshAchievements(arg_13_0)
	local var_13_0 = arg_13_0:getCardInfo()
	local var_13_1 = arg_13_0:getPlayerInfo()
	local var_13_2 = var_13_0:getShowAchievement() or var_13_1.showAchievement
	local var_13_3, var_13_4 = PlayerViewAchievementModel.instance:getShowAchievements(var_13_2)
	local var_13_5 = not var_13_4 or tabletool.len(var_13_4) <= 0

	gohelper.setActive(arg_13_0.goEmpty, var_13_5)
	gohelper.setActive(arg_13_0.goGroup, var_13_3 and not var_13_5)
	gohelper.setActive(arg_13_0.goSingle, not var_13_3 and not var_13_5)

	if arg_13_0.notIsFirst and arg_13_0.showStr ~= var_13_2 then
		arg_13_0:playSelelctEffect()
	end

	arg_13_0.showStr = var_13_2
	arg_13_0.notIsFirst = true

	if var_13_5 then
		return
	end

	if not var_13_3 then
		arg_13_0:_refreshSingle(var_13_4)
	else
		for iter_13_0, iter_13_1 in pairs(var_13_4) do
			arg_13_0:_refreshGroup(iter_13_0, iter_13_1)

			break
		end
	end
end

function var_0_0._refreshSingle(arg_14_0, arg_14_1)
	local var_14_0 = 1

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_1 = arg_14_0:_getOrCreateSingleItem(var_14_0)

		gohelper.setActive(var_14_1.viewGo, true)
		gohelper.setActive(var_14_1.goempty, false)
		gohelper.setActive(var_14_1.gohas, true)

		local var_14_2 = AchievementConfig.instance:getTask(iter_14_1)

		if var_14_2 then
			var_14_1.simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. var_14_2.icon))
		end

		var_14_0 = var_14_0 + 1
	end

	for iter_14_2 = var_14_0, AchievementEnum.ShowMaxSingleCount do
		local var_14_3 = arg_14_0:_getOrCreateSingleItem(iter_14_2)

		gohelper.setActive(var_14_3.viewGo, true)
		gohelper.setActive(var_14_3.goempty, true)
		gohelper.setActive(var_14_3.gohas, false)
	end
end

function var_0_0._getOrCreateSingleItem(arg_15_0, arg_15_1)
	if not arg_15_0._singleAchieveTabs[arg_15_1] then
		local var_15_0 = arg_15_0:getUserDataTb_()

		var_15_0.viewGo = gohelper.cloneInPlace(arg_15_0.goSingleItem, "singleitem_" .. arg_15_1)
		var_15_0.goempty = gohelper.findChild(var_15_0.viewGo, "go_empty")
		var_15_0.gohas = gohelper.findChild(var_15_0.viewGo, "go_has")
		var_15_0.simageicon = gohelper.findChildSingleImage(var_15_0.viewGo, "go_has/simage_icon")

		table.insert(arg_15_0._singleAchieveTabs, arg_15_1, var_15_0)
	end

	return arg_15_0._singleAchieveTabs[arg_15_1]
end

function var_0_0._refreshGroup(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = AchievementConfig.instance:getGroup(arg_16_1)

	if var_16_0 then
		local var_16_1 = AchievementModel.instance:isAchievementTaskFinished(var_16_0.unLockAchievement)
		local var_16_2 = AchievementConfig.instance:getGroupBgUrl(arg_16_1, AchievementEnum.GroupParamType.List, var_16_1)

		arg_16_0.groupSimageBg:LoadImage(var_16_2)
		arg_16_0:refreshSingleInGroup(arg_16_1, arg_16_2)
	end
end

function var_0_0.refreshSingleInGroup(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_17_1)
	local var_17_1 = arg_17_0:buildAchievementAndTaskMap(arg_17_2)
	local var_17_2 = {}
	local var_17_3 = AchievementConfig.instance:getGroupParamIdTab(arg_17_1, AchievementEnum.GroupParamType.List)
	local var_17_4 = var_17_3 and #var_17_3 or 0

	for iter_17_0 = 1, math.max(#arg_17_0._iconItems, var_17_4) do
		local var_17_5 = arg_17_0:_getOrCreateGroupItem(iter_17_0)
		local var_17_6 = var_17_0 and var_17_0[var_17_3[iter_17_0]]

		arg_17_0:_setGroupAchievementPosAndScale(var_17_5.viewGO, arg_17_1, iter_17_0)
		gohelper.setActive(var_17_5.viewGO, var_17_6 ~= nil)

		if var_17_6 then
			local var_17_7 = var_17_6.id
			local var_17_8 = arg_17_0:getExistTaskCo(var_17_1, var_17_6)

			if var_17_8 then
				var_17_5:setData(var_17_8)
				var_17_5:setIconVisible(true)
				var_17_5:setBgVisible(false)
				var_17_5:setNameTxtVisible(false)
			else
				gohelper.setActive(var_17_5.viewGO, false)
			end
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

function var_0_0._setGroupAchievementPosAndScale(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0, var_19_1, var_19_2, var_19_3 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(arg_19_2, arg_19_3, AchievementEnum.GroupParamType.List)

	if arg_19_1 then
		recthelper.setAnchor(arg_19_1.transform, var_19_0 or 0, var_19_1 or 0)
		transformhelper.setLocalScale(arg_19_1.transform, var_19_2 or 1, var_19_3 or 1, 1)
	end
end

function var_0_0.getExistTaskCo(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_1[arg_20_2.id]
end

function var_0_0._getOrCreateGroupItem(arg_21_0, arg_21_1)
	if not arg_21_0._iconItems[arg_21_1] then
		local var_21_0 = AchievementMainIcon.New()
		local var_21_1 = gohelper.clone(arg_21_0.itemRes, arg_21_0.goGroupContainer, tostring(arg_21_1))

		var_21_0:init(var_21_1)

		arg_21_0._iconItems[arg_21_1] = var_21_0
	end

	return arg_21_0._iconItems[arg_21_1]
end

function var_0_0._tryDisposeSingleItems(arg_22_0)
	if arg_22_0._singleAchieveTabs then
		for iter_22_0, iter_22_1 in pairs(arg_22_0._singleAchieveTabs) do
			if iter_22_1.simageicon then
				iter_22_1.simageicon:UnLoadImage()
			end
		end

		arg_22_0._singleAchieveTabs = nil
	end

	if arg_22_0._iconItems then
		for iter_22_2, iter_22_3 in pairs(arg_22_0._iconItems) do
			iter_22_3:dispose()
		end

		arg_22_0._iconItems = nil
	end
end

function var_0_0.onDestroy(arg_23_0)
	arg_23_0:_tryDisposeSingleItems()
	arg_23_0.groupSimageBg:UnLoadImage()
	arg_23_0:removeEvents()
end

return var_0_0
