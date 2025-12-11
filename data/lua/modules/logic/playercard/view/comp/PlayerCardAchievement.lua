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
	arg_2_0.goMisihai = gohelper.findChild(arg_2_0.go, "#go_misihai")
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
	local var_7_1 = arg_7_0.viewContainer:getSetting().otherRes.misihaiitem

	arg_7_0.achieveitemRes = arg_7_0.viewContainer:getRes(var_7_0)
	arg_7_0.misihaiitemRes = arg_7_0.viewContainer:getRes(var_7_1)

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
	local var_13_3, var_13_4, var_13_5 = PlayerViewAchievementModel.instance:getShowAchievements(var_13_2)
	local var_13_6 = not var_13_4 or tabletool.len(var_13_4) <= 0

	gohelper.setActive(arg_13_0.goEmpty, var_13_6)
	gohelper.setActive(arg_13_0.goGroup, var_13_3 and not var_13_6)
	gohelper.setActive(arg_13_0.goSingle, not var_13_3 and not var_13_6 and not var_13_5)
	gohelper.setActive(arg_13_0.goMisihai, not var_13_3 and not var_13_6 and var_13_5)

	if arg_13_0.notIsFirst and arg_13_0.showStr ~= var_13_2 then
		arg_13_0:playSelelctEffect()
	end

	arg_13_0.showStr = var_13_2
	arg_13_0.notIsFirst = true

	if var_13_6 then
		return
	end

	if not var_13_3 then
		if not var_13_5 then
			arg_13_0:_refreshSingle(var_13_4)
		else
			arg_13_0:_refreshNamePlate(var_13_4)
		end
	else
		for iter_13_0, iter_13_1 in pairs(var_13_4) do
			arg_13_0:_refreshGroup(iter_13_0, iter_13_1)

			break
		end
	end
end

function var_0_0._refreshNamePlate(arg_14_0, arg_14_1)
	arg_14_0._gonameplateitem = arg_14_0._gonameplateitem or arg_14_0:_getOrCreateNamePlate()

	local var_14_0 = AchievementConfig.instance:getTask(arg_14_1[1])

	if not var_14_0 then
		return
	end

	local var_14_1 = AchievementConfig.instance:getAchievement(var_14_0.achievementId)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._gonameplateitem.levelItemList) do
		gohelper.setActive(iter_14_1.go, false)
	end

	local var_14_2 = arg_14_0._gonameplateitem.levelItemList[var_14_0.level]
	local var_14_3
	local var_14_4

	if var_14_0.image and not string.nilorempty(var_14_0.image) then
		local var_14_5 = string.split(var_14_0.image, "#")

		var_14_3 = var_14_5[1]
		var_14_4 = var_14_5[2]
	end

	local function var_14_6()
		local var_15_0 = var_14_2._bgLoader:getInstGO()
	end

	if var_14_2._bgLoader then
		var_14_2._bgLoader:dispose()

		var_14_2._bgLoader = nil
	end

	var_14_2._bgLoader = PrefabInstantiate.Create(var_14_2.gobg)

	var_14_2._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(var_14_3, true), var_14_6, arg_14_0)
	var_14_2.simagetitle:LoadImage(ResUrl.getAchievementLangIcon(var_14_4))

	local var_14_7 = var_14_0.listenerType
	local var_14_8 = AchievementUtils.getAchievementProgressBySourceType(var_14_1.rule)
	local var_14_9

	if var_14_7 and var_14_7 == "TowerPassLayer" then
		if var_14_0.listenerParam and not string.nilorempty(var_14_0.listenerParam) then
			local var_14_10 = string.split(var_14_0.listenerParam, "#")

			var_14_9 = var_14_10 and var_14_10[3]
			var_14_9 = var_14_9 * 10
		end
	else
		var_14_9 = var_14_0 and var_14_0.maxProgress
	end

	var_14_2.txtlevel.text = var_14_9 < var_14_8 and var_14_8 or var_14_9

	gohelper.setActive(var_14_2.go, true)
end

function var_0_0._getOrCreateNamePlate(arg_16_0)
	local var_16_0 = arg_16_0:getUserDataTb_()

	var_16_0.go = gohelper.clone(arg_16_0.misihaiitemRes, arg_16_0.goMisihai, "nameplate")
	var_16_0.levelItemList = {}

	for iter_16_0 = 1, 3 do
		local var_16_1 = {
			go = gohelper.findChild(var_16_0.go, "go_icon/level" .. iter_16_0)
		}

		var_16_1.gobg = gohelper.findChild(var_16_1.go, "#simage_bg")
		var_16_1.simagetitle = gohelper.findChildSingleImage(var_16_1.go, "#simage_title")
		var_16_1.txtlevel = gohelper.findChildText(var_16_1.go, "#txt_level")

		gohelper.setActive(var_16_1.go, false)
		table.insert(var_16_0.levelItemList, var_16_1)
	end

	return var_16_0
end

function var_0_0._refreshSingle(arg_17_0, arg_17_1)
	local var_17_0 = 1

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_1 = arg_17_0:_getOrCreateSingleItem(var_17_0)

		gohelper.setActive(var_17_1.viewGo, true)
		gohelper.setActive(var_17_1.goempty, false)
		gohelper.setActive(var_17_1.gohas, true)

		local var_17_2 = AchievementConfig.instance:getTask(iter_17_1)

		if var_17_2 then
			var_17_1.simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. var_17_2.icon))
		end

		var_17_0 = var_17_0 + 1
	end

	for iter_17_2 = var_17_0, AchievementEnum.ShowMaxSingleCount do
		local var_17_3 = arg_17_0:_getOrCreateSingleItem(iter_17_2)

		gohelper.setActive(var_17_3.viewGo, true)
		gohelper.setActive(var_17_3.goempty, true)
		gohelper.setActive(var_17_3.gohas, false)
	end
end

function var_0_0._getOrCreateSingleItem(arg_18_0, arg_18_1)
	if not arg_18_0._singleAchieveTabs[arg_18_1] then
		local var_18_0 = arg_18_0:getUserDataTb_()

		var_18_0.viewGo = gohelper.cloneInPlace(arg_18_0.goSingleItem, "singleitem_" .. arg_18_1)
		var_18_0.goempty = gohelper.findChild(var_18_0.viewGo, "go_empty")
		var_18_0.gohas = gohelper.findChild(var_18_0.viewGo, "go_has")
		var_18_0.simageicon = gohelper.findChildSingleImage(var_18_0.viewGo, "go_has/simage_icon")

		table.insert(arg_18_0._singleAchieveTabs, arg_18_1, var_18_0)
	end

	return arg_18_0._singleAchieveTabs[arg_18_1]
end

function var_0_0._refreshGroup(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = AchievementConfig.instance:getGroup(arg_19_1)

	if var_19_0 then
		local var_19_1 = AchievementModel.instance:isAchievementTaskFinished(var_19_0.unLockAchievement)
		local var_19_2 = AchievementConfig.instance:getGroupBgUrl(arg_19_1, AchievementEnum.GroupParamType.List, var_19_1)

		arg_19_0.groupSimageBg:LoadImage(var_19_2)
		arg_19_0:refreshSingleInGroup(arg_19_1, arg_19_2)
	end
end

function var_0_0.refreshSingleInGroup(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_20_1)
	local var_20_1 = arg_20_0:buildAchievementAndTaskMap(arg_20_2)
	local var_20_2 = {}
	local var_20_3 = AchievementConfig.instance:getGroupParamIdTab(arg_20_1, AchievementEnum.GroupParamType.List)
	local var_20_4 = var_20_3 and #var_20_3 or 0

	for iter_20_0 = 1, math.max(#arg_20_0._iconItems, var_20_4) do
		local var_20_5 = arg_20_0:_getOrCreateGroupItem(iter_20_0)
		local var_20_6 = var_20_0 and var_20_0[var_20_3[iter_20_0]]

		arg_20_0:_setGroupAchievementPosAndScale(var_20_5.viewGO, arg_20_1, iter_20_0)
		gohelper.setActive(var_20_5.viewGO, var_20_6 ~= nil)

		if var_20_6 then
			local var_20_7 = var_20_6.id
			local var_20_8 = arg_20_0:getExistTaskCo(var_20_1, var_20_6)

			if var_20_8 then
				var_20_5:setData(var_20_8)
				var_20_5:setIconVisible(true)
				var_20_5:setBgVisible(false)
				var_20_5:setNameTxtVisible(false)
			else
				gohelper.setActive(var_20_5.viewGO, false)
			end
		end
	end
end

function var_0_0.buildAchievementAndTaskMap(arg_21_0, arg_21_1)
	local var_21_0 = {}

	if arg_21_1 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
			local var_21_1 = AchievementConfig.instance:getTask(iter_21_1)
			local var_21_2 = var_21_1.achievementId

			if not var_21_0[var_21_2] then
				var_21_0[var_21_2] = var_21_1
			end
		end
	end

	return var_21_0
end

function var_0_0._setGroupAchievementPosAndScale(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0, var_22_1, var_22_2, var_22_3 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(arg_22_2, arg_22_3, AchievementEnum.GroupParamType.List)

	if arg_22_1 then
		recthelper.setAnchor(arg_22_1.transform, var_22_0 or 0, var_22_1 or 0)
		transformhelper.setLocalScale(arg_22_1.transform, var_22_2 or 1, var_22_3 or 1, 1)
	end
end

function var_0_0.getExistTaskCo(arg_23_0, arg_23_1, arg_23_2)
	return arg_23_1[arg_23_2.id]
end

function var_0_0._getOrCreateGroupItem(arg_24_0, arg_24_1)
	if not arg_24_0._iconItems[arg_24_1] then
		local var_24_0 = AchievementMainIcon.New()
		local var_24_1 = gohelper.clone(arg_24_0.achieveitemRes, arg_24_0.goGroupContainer, tostring(arg_24_1))

		var_24_0:init(var_24_1)

		arg_24_0._iconItems[arg_24_1] = var_24_0
	end

	return arg_24_0._iconItems[arg_24_1]
end

function var_0_0._tryDisposeSingleItems(arg_25_0)
	if arg_25_0._singleAchieveTabs then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._singleAchieveTabs) do
			if iter_25_1.simageicon then
				iter_25_1.simageicon:UnLoadImage()
			end
		end

		arg_25_0._singleAchieveTabs = nil
	end

	if arg_25_0._iconItems then
		for iter_25_2, iter_25_3 in pairs(arg_25_0._iconItems) do
			iter_25_3:dispose()
		end

		arg_25_0._iconItems = nil
	end
end

function var_0_0.onDestroy(arg_26_0)
	arg_26_0:_tryDisposeSingleItems()
	arg_26_0.groupSimageBg:UnLoadImage()
	arg_26_0:removeEvents()
end

return var_0_0
