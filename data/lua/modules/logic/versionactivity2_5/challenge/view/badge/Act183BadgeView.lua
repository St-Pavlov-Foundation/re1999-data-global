module("modules.logic.versionactivity2_5.challenge.view.badge.Act183BadgeView", package.seeall)

local var_0_0 = class("Act183BadgeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._txtbadgecount = gohelper.findChildText(arg_1_0.viewGO, "root/left/#txt_badgecount")
	arg_1_0._scrolldaily = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#scroll_daily")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#scroll_daily/Viewport/Content/#go_heroitem")

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
	arg_4_0._actInfo = Act183Model.instance:getActInfo()
	arg_4_0._activityId = Act183Model.instance:getActivityId()
	arg_4_0._curBadgeNum = Act183Model.instance:getBadgeNum()
	arg_4_0._maxBadgeNum = Act183Helper.getMaxBadgeNum()
	arg_4_0._badgeCos = Act183Config.instance:getActivityBadgeCos(arg_4_0._activityId)
	arg_4_0._heroItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._heroMoList = arg_4_0:getUserDataTb_()
	arg_4_0._needPlayAnimHeroItems = arg_4_0:getUserDataTb_()
	arg_4_0._leftAnim = gohelper.findChildComponent(arg_4_0.viewGO, "root/left", gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenBadgeView)
	arg_6_0:refreshPreBadge()
	arg_6_0:refreshSupportHeros()
	arg_6_0:saveHasReadUnlockSupportHeroIds()
end

function var_0_0.onOpenFinish(arg_7_0)
	arg_7_0:playHeroItemAnim()
	arg_7_0:refreshCurBadge()
end

function var_0_0.refreshPreBadge(arg_8_0)
	arg_8_0._lastSaveBadgeNum = Act183Helper.getLastTotalBadgeNumInLocal(arg_8_0._activityId)
	arg_8_0._txtbadgecount.text = string.format("<size=64>%s</size>/%s", arg_8_0._lastSaveBadgeNum, arg_8_0._maxBadgeNum)
end

function var_0_0.refreshCurBadge(arg_9_0)
	local var_9_0 = arg_9_0._lastSaveBadgeNum ~= arg_9_0._curBadgeNum

	arg_9_0._leftAnim:Play(var_9_0 and "refresh" or "idle", 0, 0)

	arg_9_0._txtbadgecount.text = string.format("<size=64>%s</size>/%s", arg_9_0._curBadgeNum, arg_9_0._maxBadgeNum)

	Act183Helper.saveLastTotalBadgeNumInLocal(arg_9_0._activityId, arg_9_0._curBadgeNum)
end

function var_0_0.refreshSupportHeros(arg_10_0)
	if not arg_10_0._badgeCos then
		return
	end

	local var_10_0 = Act183Helper.getHasReadUnlockSupportHeroIdsInLocal(arg_10_0._activityId)

	arg_10_0._hasReadUnlockHeroIdMap = Act183Helper.listToMap(var_10_0)
	arg_10_0._unlockSupportHeroIndex = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._badgeCos) do
		local var_10_1 = iter_10_1.unlockSupport

		if var_10_1 and var_10_1 ~= 0 then
			arg_10_0:refreshSingleHeroItem(iter_10_1, var_10_1)
		end
	end
end

function var_0_0._getOrCreateHeroItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._heroItemTab[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.viewGO = gohelper.cloneInPlace(arg_11_0._goheroitem, "heroitem_" .. arg_11_1)
		var_11_0.golock = gohelper.findChild(var_11_0.viewGO, "go_lock")
		var_11_0.txtcost = gohelper.findChildText(var_11_0.viewGO, "go_lock/txt_cost")
		var_11_0.goPos = gohelper.findChild(var_11_0.viewGO, "go_pos")
		var_11_0.icon = IconMgr.instance:getCommonHeroItem(var_11_0.goPos)

		var_11_0.icon:setStyle_CharacterBackpack()

		var_11_0.animator = gohelper.onceAddComponent(var_11_0.golock, gohelper.Type_Animator)
		var_11_0.btnclick = gohelper.findChildButtonWithAudio(var_11_0.viewGO, "btn_click")

		var_11_0.btnclick:AddClickListener(arg_11_0._onClickHeroItem, arg_11_0, arg_11_1)

		var_11_0.heroMo = HeroMo.New()
		arg_11_0._heroItemTab[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0._onClickHeroItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._heroItemTab[arg_12_1]

	if not var_12_0 then
		return
	end

	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._heroItemTab) do
		table.insert(var_12_1, iter_12_1.heroMo)
	end

	CharacterController.instance:openCharacterView(var_12_0.heroMo, var_12_1)
end

function var_0_0.refreshSingleHeroItem(arg_13_0, arg_13_1, arg_13_2)
	if lua_hero_trial.configDict[arg_13_2][0] then
		arg_13_0._unlockSupportHeroIndex = arg_13_0._unlockSupportHeroIndex + 1

		local var_13_0 = arg_13_0:_getOrCreateHeroItem(arg_13_0._unlockSupportHeroIndex)

		var_13_0.heroMo:initFromTrial(arg_13_2)
		var_13_0.icon:onUpdateMO(var_13_0.heroMo)

		var_13_0.txtcost.text = arg_13_1.num

		gohelper.setActive(var_13_0.viewGO, true)

		local var_13_1 = arg_13_1.num > arg_13_0._curBadgeNum
		local var_13_2 = not var_13_1 and arg_13_0._hasReadUnlockHeroIdMap[arg_13_2] == nil

		gohelper.setActive(var_13_0.golock, var_13_1 or var_13_2)

		if var_13_1 or var_13_2 then
			arg_13_0._needPlayAnimHeroItems[var_13_0] = var_13_2 and "unlock" or "open"
		end
	else
		logError(string.format("缺少支援角色配置 : badgeNum = %s, supportHeroId = %s", arg_13_1.num, arg_13_1.unlockSupport))
	end
end

function var_0_0.playHeroItemAnim(arg_14_0)
	if arg_14_0._needPlayAnimHeroItems then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._needPlayAnimHeroItems) do
			iter_14_0.animator:Play(iter_14_1, 0, 0)
		end
	end
end

function var_0_0.releaseAllHeroItems(arg_15_0)
	if arg_15_0._heroItemTab then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._heroItemTab) do
			iter_15_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.saveHasReadUnlockSupportHeroIds(arg_16_0)
	local var_16_0 = arg_16_0._actInfo:getUnlockSupportHeroIds()

	Act183Helper.saveHasReadUnlockSupportHeroIdsInLocal(arg_16_0._activityId, var_16_0)
	Act183Controller.instance:dispatchEvent(Act183Event.RefreshMedalReddot)
end

function var_0_0.onClose(arg_17_0)
	arg_17_0:releaseAllHeroItems()
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
