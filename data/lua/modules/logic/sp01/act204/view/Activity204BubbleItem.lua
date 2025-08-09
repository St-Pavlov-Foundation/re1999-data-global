module("modules.logic.sp01.act204.view.Activity204BubbleItem", package.seeall)

local var_0_0 = class("Activity204BubbleItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.go, "root/Reward/#go_reddot")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.go, "root/Reward/rewardList/#go_rewardItem")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.go, "root/Reward/go_hasget")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.go, "root/Reward/go_canget")
	arg_1_0._gonotget = gohelper.findChild(arg_1_0.go, "root/Reward/go_notget")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.go, "root/Reward/go_notget/txt_remainTime")
	arg_1_0._gorewardbg = gohelper.findChild(arg_1_0.go, "root/image_RewardBG")
	arg_1_0._rewardItemTab = arg_1_0:getUserDataTb_()

	gohelper.setActive(arg_1_0._gorewardItem, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_2_0._refreshBonus, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._refreshActivityState, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0:_initActivity101Configs(arg_4_1)
	arg_4_0:_initRedDot(arg_4_1)
	arg_4_0:_refreshBonus()
end

function var_0_0._initActivity101Configs(arg_5_0, arg_5_1)
	arg_5_0._bubbleActIds = arg_5_1
	arg_5_0._activity101List = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._bubbleActIds) do
		local var_5_0 = lua_activity101.configDict[iter_5_1]

		tabletool.addValues(arg_5_0._activity101List, var_5_0)
	end

	table.sort(arg_5_0._activity101List, arg_5_0.activity101SortFunc)
end

function var_0_0._initRedDot(arg_6_0)
	RedDotController.instance:addRedDot(arg_6_0._goreddot, RedDotEnum.DotNode.V2a9_Act204Bubble)
end

function var_0_0.activity101SortFunc(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.activityId
	local var_7_1 = arg_7_1.activityId
	local var_7_2 = ActivityModel.instance:getActStartTime(var_7_0)
	local var_7_3 = ActivityModel.instance:getActStartTime(var_7_1)

	if var_7_2 ~= var_7_3 then
		return var_7_2 < var_7_3
	end

	if var_7_0 ~= var_7_1 then
		return var_7_0 < var_7_1
	end

	return arg_7_0.id < arg_7_1.id
end

function var_0_0._refreshBonus(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._activity101List) do
		local var_8_2 = iter_8_1.activityId
		local var_8_3 = ActivityHelper.getActivityStatusAndToast(var_8_2)

		if var_8_3 == ActivityEnum.ActivityStatus.Normal then
			if ActivityType101Model.instance:isType101RewardCouldGet(var_8_2, iter_8_1.id) then
				table.insert(var_8_0, iter_8_1)
			end
		elseif var_8_3 == ActivityEnum.ActivityStatus.NotOpen and var_8_2 ~= 130525 then
			table.insert(var_8_1, iter_8_1)

			break
		end
	end

	arg_8_0:findNeedShowRewardList(var_8_0, var_8_1)
	arg_8_0:refreshBonusItemList()
end

function var_0_0.findNeedShowRewardList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1 = arg_9_1 and #arg_9_1 or 0
	local var_9_2 = arg_9_2 and #arg_9_2 or 0

	if var_9_1 > 0 then
		var_9_0 = arg_9_1
	elseif var_9_2 > 0 then
		var_9_0 = arg_9_2
	end

	arg_9_0._rewardCfgList = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_3 = GameUtil.splitString2(iter_9_1.bonus, true)

		for iter_9_2, iter_9_3 in ipairs(var_9_3) do
			local var_9_4 = {
				materilType = iter_9_3[1],
				materilId = iter_9_3[2],
				quantity = iter_9_3[3],
				activity101Cfg = iter_9_1
			}

			table.insert(arg_9_0._rewardCfgList, var_9_4)
		end
	end

	gohelper.setActive(arg_9_0._gohasget, var_9_1 <= 0 and var_9_2 <= 0)
	gohelper.setActive(arg_9_0._gocanget, var_9_1 > 0)
	gohelper.setActive(arg_9_0._gonotget, var_9_1 <= 0 and var_9_2 > 0)
	gohelper.setActive(arg_9_0._gorewardbg, #arg_9_0._rewardCfgList > 1)
	TaskDispatcher.cancelTask(arg_9_0.refreshRemainTime, arg_9_0)

	if var_9_1 <= 0 and var_9_2 > 0 then
		arg_9_0._nextCouldGetActCo = arg_9_2[1]

		arg_9_0:refreshRemainTime()
		TaskDispatcher.runRepeat(arg_9_0.refreshRemainTime, arg_9_0, 1)
	end
end

function var_0_0.refreshRemainTime(arg_10_0)
	if not arg_10_0._nextCouldGetActCo then
		TaskDispatcher.cancelTask(arg_10_0.refreshRemainTime, arg_10_0)

		return
	end

	local var_10_0 = arg_10_0._nextCouldGetActCo and arg_10_0._nextCouldGetActCo.activityId
	local var_10_1 = ActivityModel.instance:getActStartTime(var_10_0) / 1000 - ServerTime.now()

	if var_10_1 <= 0 then
		arg_10_0._txtremainTime = ActivityHelper.getActivityRemainTimeStr(var_10_0)

		TaskDispatcher.cancelTask(arg_10_0.refreshRemainTime, arg_10_0)
		Activity101Rpc.instance:sendGet101InfosRequest(var_10_0)

		return
	end

	arg_10_0._txtremainTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_bubble"), TimeUtil.SecondToActivityTimeFormat(var_10_1))
end

function var_0_0.refreshBonusItemList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._rewardCfgList) do
		local var_11_1 = arg_11_0:_getOrCreateRewardItem(iter_11_0)

		arg_11_0:_refreshRewardItem(var_11_1, iter_11_1)

		var_11_0[var_11_1] = true
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0._rewardItemTab) do
		if not var_11_0[iter_11_3] then
			gohelper.setActive(iter_11_3.go, false)
		end
	end
end

function var_0_0._getOrCreateRewardItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._rewardItemTab[arg_12_1]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()
		var_12_0.go = gohelper.cloneInPlace(arg_12_0._gorewardItem, "rewardItem_" .. arg_12_1)
		var_12_0.gopos = gohelper.findChild(var_12_0.go, "go_rewardPos")
		var_12_0.icon = IconMgr.instance:getCommonPropItemIcon(var_12_0.gopos)
		var_12_0.gocanget = gohelper.findChild(var_12_0.go, "go_rewardGet")
		var_12_0.golock = gohelper.findChild(var_12_0.go, "go_rewardLock")
		var_12_0.txtnum = gohelper.findChildText(var_12_0.go, "Num/#txt_Num")
		arg_12_0._rewardItemTab[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0._refreshRewardItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1.icon:setMOValue(arg_13_2.materilType, arg_13_2.materilId, arg_13_2.quantity, nil, true)
	arg_13_1.icon:setConsume(true)
	arg_13_1.icon:isShowEffect(true)
	arg_13_1.icon:isShowCount(false)
	arg_13_1.icon:isShowQuality(false)
	arg_13_1.icon:setCanShowDeadLine(false)
	arg_13_1.icon:setHideLvAndBreakFlag(true)
	arg_13_1.icon:hideEquipLvAndBreak(true)
	arg_13_1.icon:setCountFontSize(48)

	local var_13_0 = arg_13_0:_isCouldGetReward(arg_13_2.activity101Cfg)

	gohelper.setActive(arg_13_1.gocanget, var_13_0)
	gohelper.setActive(arg_13_1.golock, not var_13_0)
	gohelper.setActive(arg_13_1.go, true)

	arg_13_1.txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), arg_13_2.quantity)

	arg_13_1.icon:customOnClickCallback(function()
		if not arg_13_2 then
			return
		end

		local var_14_0 = arg_13_2 and arg_13_2.activity101Cfg

		if arg_13_0:_isCouldGetReward(var_14_0) then
			arg_13_0:_claimAll()

			return
		end

		MaterialTipController.instance:showMaterialInfo(tonumber(arg_13_2.materilType), arg_13_2.materilId)
	end)
end

function var_0_0._claimAll(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._rewardCfgList) do
		local var_15_1 = iter_15_1.activity101Cfg

		if arg_15_0:_isCouldGetReward(var_15_1) then
			table.insert(var_15_0, var_15_1)
		end
	end

	for iter_15_2, iter_15_3 in ipairs(var_15_0) do
		local var_15_2 = iter_15_3.activityId
		local var_15_3 = iter_15_3.id

		Activity101Rpc.instance:sendGet101BonusRequest(var_15_2, var_15_3)
	end
end

function var_0_0._isCouldGetReward(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return
	end

	local var_16_0 = arg_16_1.activityId
	local var_16_1 = arg_16_1.id

	return ActivityType101Model.instance:isType101RewardCouldGet(var_16_0, var_16_1)
end

function var_0_0._refreshActivityState(arg_17_0, arg_17_1)
	if not arg_17_0._bubbleActIds or not tabletool.indexOf(arg_17_0._bubbleActIds, arg_17_1) then
		return
	end

	arg_17_0:_refreshBonus()
end

function var_0_0.onDestroy(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.refreshRemainTime, arg_18_0)
end

return var_0_0
