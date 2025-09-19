module("modules.logic.dungeon.view.DungeonMapLevelRewardView", package.seeall)

local var_0_0 = class("DungeonMapLevelRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_rewarditem")
	arg_1_0._gonoreward = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_noreward")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_reward")
	arg_1_0._txtget = gohelper.findChildText(arg_1_0.viewGO, "anim/right/reward_container/#go_reward/#txt_get")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/reward_container/#go_reward/#btn_reward")
	arg_1_0._gonormalrewardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_reward/#go_normalrewardbg")
	arg_1_0._gohardrewardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_reward/#go_hardrewardbg")
	arg_1_0._goTurnBackAddition = gohelper.findChild(arg_1_0.viewGO, "anim/right/turnback_tips")
	arg_1_0._txtTurnBackAdditionTips = gohelper.findChildText(arg_1_0.viewGO, "anim/right/turnback_tips/#txt_des")
	arg_1_0._goactreward = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_act_reward")
	arg_1_0._goactnormalrewardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_act_reward/#go_actnormalrewardbg")
	arg_1_0._goacthardrewardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_act_reward/#go_acthardrewardbg")
	arg_1_0._txtacttime = gohelper.findChildText(arg_1_0.viewGO, "anim/right/reward_container/#go_act_reward/#go_time/#txt_time")
	arg_1_0._btnactreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/reward_container/#go_act_reward/#btn_actreward")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnactreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnactreward:RemoveClickListener()
end

var_0_0.RewardType = {
	Common = 1,
	Act = 5,
	TurnBack = 4,
	OneStar = 2,
	SecondStar = 3
}
var_0_0.TagType = DungeonEnum.TagType

function var_0_0._btnrewardOnClick(arg_4_0)
	DungeonController.instance:openDungeonRewardView(arg_4_0.episodeConfig)
end

function var_0_0.getRewardItem(arg_5_0, arg_5_1)
	if #arg_5_0.rewardItemPool > 0 then
		local var_5_0 = table.remove(arg_5_0.rewardItemPool)

		gohelper.setActive(var_5_0.go, true)
		var_5_0.transform:SetParent(arg_5_1)
		table.insert(arg_5_0.rewardItemList, var_5_0)

		return var_5_0
	end

	local var_5_1 = arg_5_0:getUserDataTb_()

	var_5_1.go = gohelper.cloneInPlace(arg_5_0._gorewarditem)
	var_5_1.transform = var_5_1.go:GetComponent(gohelper.Type_Transform)

	var_5_1.transform:SetParent(arg_5_1)

	var_5_1.txtcount = gohelper.findChildText(var_5_1.go, "countbg/count")
	var_5_1.gofirst = gohelper.findChild(var_5_1.go, "rare/#go_rare2")
	var_5_1.goadvance = gohelper.findChild(var_5_1.go, "rare/#go_rare3")
	var_5_1.gofirsthard = gohelper.findChild(var_5_1.go, "rare/#go_rare4")
	var_5_1.gonormal = gohelper.findChild(var_5_1.go, "rare/#go_rare1")
	var_5_1.txtnormal = gohelper.findChildText(var_5_1.go, "rare/#go_rare1/txt")
	var_5_1.goAddition = gohelper.findChild(var_5_1.go, "turnback")
	var_5_1.gocount = gohelper.findChild(var_5_1.go, "countbg")
	var_5_1.itemIconGO = gohelper.findChild(var_5_1.go, "itemicon")
	var_5_1.finished = gohelper.findChild(var_5_1.go, "finished")
	var_5_1.storyfirst = gohelper.findChild(var_5_1.go, "first")
	var_5_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_5_1.itemIconGO)

	gohelper.setActive(var_5_1.go, true)
	table.insert(arg_5_0.rewardItemList, var_5_1)

	return var_5_1
end

function var_0_0.recycleRewardItem(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.rewardData

	arg_6_1.rewardData = nil

	if var_6_0.recycleCallback then
		var_6_0.recycleCallback(arg_6_0, arg_6_1)
	end

	gohelper.setActive(arg_6_1.go, false)
	arg_6_1.transform:SetParent(arg_6_0.trRewardPool)
	table.insert(arg_6_0.rewardItemPool, arg_6_1)
end

function var_0_0.recycleAllRewardItem(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.rewardItemList) do
		arg_7_0:recycleRewardItem(iter_7_1)
	end

	tabletool.clear(arg_7_0.rewardItemList)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.trRewardPool = gohelper.findChildComponent(arg_8_0.viewGO, "anim/right/reward_container/#go_rewardpool", gohelper.Type_Transform)
	arg_8_0.trNormalReward = gohelper.findChildComponent(arg_8_0.viewGO, "anim/right/reward_container/#go_reward/rewardList", gohelper.Type_Transform)
	arg_8_0.trActReward = gohelper.findChildComponent(arg_8_0.viewGO, "anim/right/reward_container/#go_act_reward/#go_act_rewardList", gohelper.Type_Transform)
	arg_8_0.trActNormalReward = gohelper.findChildComponent(arg_8_0.viewGO, "anim/right/reward_container/#go_act_reward/#go_normal_rewardList", gohelper.Type_Transform)

	gohelper.setActive(arg_8_0._gorewarditem, false)

	arg_8_0.rewardItemPool = {}
	arg_8_0.rewardItemList = {}
	arg_8_0.rewardList = {}
	arg_8_0.actRewardList = {}

	gohelper.addUIClickAudio(arg_8_0._btnreward.gameObject, AudioEnum.UI.Play_UI_General_OK)
	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_8_0.onRefreshActivityState, arg_8_0)
	arg_8_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_8_0.refreshTurnBack, arg_8_0)
	arg_8_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_8_0.onDailyRefresh, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.SwitchHardMode, arg_8_0.onSwitchHardMode, arg_8_0)
	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_8_0.refreshReward, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0._onCloseView, arg_8_0)
end

function var_0_0._onCloseView(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.CommonPropView then
		arg_9_0:delayRefreshReward()
	end
end

function var_0_0.onSwitchHardMode(arg_10_0, arg_10_1)
	if not arg_10_1.episodeConfig then
		return
	end

	arg_10_0.episodeConfig = arg_10_1.episodeConfig

	if arg_10_1.immediately then
		arg_10_0.switchInit = true

		arg_10_0:delayRefreshReward()
	else
		TaskDispatcher.cancelTask(arg_10_0.delayRefreshReward, arg_10_0)
		TaskDispatcher.runDelay(arg_10_0.delayRefreshReward, arg_10_0, 0.3)
	end
end

function var_0_0.delayRefreshReward(arg_11_0)
	arg_11_0:initData()
	arg_11_0:refreshUI()
end

function var_0_0.initData(arg_12_0)
	arg_12_0.episodeId = arg_12_0.episodeConfig.id
	arg_12_0.chapterId = arg_12_0.episodeConfig.chapterId
	arg_12_0.chapterCo = DungeonConfig.instance:getChapterCO(arg_12_0.chapterId)
	arg_12_0.episodeInfo = DungeonModel.instance:getEpisodeInfo(arg_12_0.episodeConfig.id)
	arg_12_0.hardMode = arg_12_0.chapterCo.type == DungeonEnum.ChapterType.Hard
	arg_12_0.isFree = false

	if arg_12_0.chapterCo.enterAfterFreeLimit > 0 then
		arg_12_0.isFree = DungeonModel.instance:getChapterRemainingNum(arg_12_0.chapterCo.type) > 0
	end

	arg_12_0:updateActiveActId()
end

function var_0_0.updateActiveActId(arg_13_0)
	arg_13_0.activityId = 0
	arg_13_0.dropCo = nil

	for iter_13_0, iter_13_1 in ipairs(lua_activity155_drop.configList) do
		if arg_13_0.chapterId == iter_13_1.chapterId then
			local var_13_0 = iter_13_1.activityId

			if ActivityHelper.getActivityStatus(var_13_0, true) == ActivityEnum.ActivityStatus.Normal then
				arg_13_0.activityId = var_13_0
				arg_13_0.dropCo = iter_13_1

				break
			end
		end
	end

	arg_13_0.showActReward = arg_13_0.activityId ~= 0
end

function var_0_0.initEpisodeCo(arg_14_0)
	arg_14_0.episodeConfig = arg_14_0.viewParam[1]

	local var_14_0 = arg_14_0.viewParam[5]
	local var_14_1

	if var_14_0 == nil then
		local var_14_2, var_14_3 = DungeonModel.instance:getLastSelectMode()

		if var_14_3 == arg_14_0.episodeConfig.id then
			local var_14_4 = var_14_2
			local var_14_5 = arg_14_0.episodeConfig.chainEpisode

			if var_14_4 == DungeonEnum.ChapterType.Simple and var_14_5 ~= 0 then
				arg_14_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(var_14_5)
			end
		end
	elseif var_14_0 then
		arg_14_0.episodeConfig = DungeonConfig.instance:getHardEpisode(arg_14_0.episodeConfig.id)
	end
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0:initEpisodeCo()
	arg_15_0:initData()
	arg_15_0:refreshUI()
end

function var_0_0.onOpen(arg_16_0)
	if arg_16_0.switchInit then
		arg_16_0.switchInit = false

		return
	end

	arg_16_0:initEpisodeCo()
	arg_16_0:initData()
	arg_16_0:refreshUI()
end

function var_0_0.refreshUI(arg_17_0)
	arg_17_0:refreshTxt()
	arg_17_0:refreshTurnBackAdditionTips()
	arg_17_0:refreshBG()
	arg_17_0:refreshReward()
end

function var_0_0.refreshBG(arg_18_0)
	gohelper.setActive(arg_18_0._gonormalrewardbg, not arg_18_0.hardMode)
	gohelper.setActive(arg_18_0._gohardrewardbg, arg_18_0.hardMode)
	gohelper.setActive(arg_18_0._goactnormalrewardbg, not arg_18_0.hardMode)
	gohelper.setActive(arg_18_0._goacthardrewardbg, arg_18_0.hardMode)
end

function var_0_0.refreshTxt(arg_19_0)
	arg_19_0._txtget.text = luaLang(arg_19_0.isFree and "p_dungeonmaplevelview_specialdrop" or "p_dungeonmaplevelview_get")
end

function var_0_0.refreshTurnBackAdditionTips(arg_20_0)
	local var_20_0 = TurnbackModel.instance:isShowTurnBackAddition(arg_20_0.episodeConfig.chapterId)

	if var_20_0 then
		local var_20_1, var_20_2 = TurnbackModel.instance:getAdditionCountInfo()
		local var_20_3 = string.format("%s/%s", var_20_1, var_20_2)

		arg_20_0._txtTurnBackAdditionTips.text = formatLuaLang("turnback_addition_times", var_20_3)

		local var_20_4 = gohelper.findChildComponent(arg_20_0.viewGO, "anim/right/#go_operation", gohelper.Type_Transform)

		recthelper.setAnchorY(var_20_4, -20)
	end

	gohelper.setActive(arg_20_0._goTurnBackAddition, var_20_0)
end

function var_0_0.refreshReward(arg_21_0)
	arg_21_0:recycleAllRewardItem()
	tabletool.clear(arg_21_0.rewardList)
	tabletool.clear(arg_21_0.actRewardList)
	gohelper.setActive(arg_21_0._gonoreward, false)
	gohelper.setActive(arg_21_0._goreward, false)
	gohelper.setActive(arg_21_0._goactreward, false)

	if arg_21_0.showActReward and not arg_21_0.isFree and arg_21_0.episodeConfig and arg_21_0.episodeConfig.type ~= DungeonEnum.EpisodeType.Story then
		arg_21_0:refreshActReward()
	else
		arg_21_0:refreshNormalReward()
	end
end

function var_0_0.refreshActReward(arg_22_0)
	arg_22_0:refreshActTime()
	arg_22_0:addFirstReward()
	arg_22_0:addAdvanceReward()
	arg_22_0:addNewReward()
	arg_22_0:addDoubleDropReward()
	arg_22_0:addFreeReward()
	arg_22_0:addCommonRewardList()
	arg_22_0:addActReward()

	local var_22_0 = #arg_22_0.rewardList > 0 or #arg_22_0.actRewardList > 0

	gohelper.setActive(arg_22_0._gonoreward, not var_22_0)
	gohelper.setActive(arg_22_0._goactreward, var_22_0)

	if var_22_0 then
		for iter_22_0 = 1, 3 do
			arg_22_0:refreshOneReward(arg_22_0.rewardList[iter_22_0], arg_22_0.trActNormalReward)
		end

		for iter_22_1 = 1, 3 do
			arg_22_0:refreshOneReward(arg_22_0.actRewardList[iter_22_1], arg_22_0.trActReward)
		end
	end
end

function var_0_0.refreshActTime(arg_23_0)
	local var_23_0 = ActivityModel.instance:getActMO(arg_23_0.activityId)

	if var_23_0 then
		local var_23_1 = var_23_0:getRealEndTimeStamp() - ServerTime.now()
		local var_23_2, var_23_3 = TimeUtil.secondToRoughTime(var_23_1, true)

		arg_23_0._txtacttime.text = string.format(var_23_2 .. var_23_3)
	end
end

function var_0_0.refreshNormalReward(arg_24_0)
	if arg_24_0.chapterCo.type == DungeonEnum.ChapterType.Simple or arg_24_0.episodeConfig.type == DungeonEnum.EpisodeType.Story then
		arg_24_0:addFirstReward(true)
	else
		arg_24_0:addFirstReward()
	end

	arg_24_0:addAdvanceReward()
	arg_24_0:addNewReward()
	arg_24_0:addDoubleDropReward()
	arg_24_0:addFreeReward()
	arg_24_0:addCommonRewardList()

	local var_24_0 = #arg_24_0.rewardList > 0

	gohelper.setActive(arg_24_0._gonoreward, not var_24_0)
	gohelper.setActive(arg_24_0._goreward, var_24_0)

	if var_24_0 then
		for iter_24_0 = 1, 3 do
			arg_24_0:refreshOneReward(arg_24_0.rewardList[iter_24_0], arg_24_0.trNormalReward)
		end

		if arg_24_0.episodeConfig.type == DungeonEnum.EpisodeType.Story or arg_24_0.chapterCo.type == DungeonEnum.ChapterType.Simple then
			for iter_24_1, iter_24_2 in ipairs(arg_24_0.rewardItemList) do
				local var_24_1 = arg_24_0.episodeInfo.star ~= DungeonEnum.StarType.None

				gohelper.setActive(iter_24_2.finished, var_24_1)
			end
		end
	end
end

function var_0_0._addReward(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6)
	local var_25_0 = {
		itemType = arg_25_1,
		id = arg_25_2,
		quantity = arg_25_3,
		tagType = arg_25_4,
		showQuantity = arg_25_5,
		rewardType = arg_25_6
	}

	table.insert(arg_25_0.rewardList, var_25_0)
end

function var_0_0._addActReward(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6, arg_26_7, arg_26_8)
	local var_26_0 = {
		itemType = arg_26_1,
		id = arg_26_2,
		quantity = arg_26_3,
		tagType = arg_26_4,
		showQuantity = arg_26_5,
		rewardType = var_0_0.RewardType.Act,
		customBg = arg_26_6,
		customRefreshCallback = arg_26_7,
		recycleCallback = arg_26_8
	}

	table.insert(arg_26_0.actRewardList, var_26_0)
end

function var_0_0.addActReward(arg_27_0)
	local var_27_0 = arg_27_0.dropCo
	local var_27_1 = var_27_0.itemId1

	if not string.nilorempty(var_27_1) then
		local var_27_2 = string.splitToNumber(var_27_1, "#")
		local var_27_3 = CommonConfig.instance:getAct155CurrencyRatio() * string.splitToNumber(arg_27_0.episodeConfig.cost, "#")[3]

		arg_27_0:_addActReward(var_27_2[1], var_27_2[2], var_27_3, var_27_2[3], true, nil, arg_27_0.onRefreshV1a7Currency, arg_27_0.onRecycleV1a7Currency)
	end

	local var_27_4 = var_27_0.itemId2

	if not string.nilorempty(var_27_4) then
		local var_27_5 = string.splitToNumber(var_27_4, "#")

		arg_27_0:_addActReward(var_27_5[1], var_27_5[2], 0, var_27_5[3], false, nil, arg_27_0.onRefreshV1a7Power, arg_27_0.onRecycleV1a7Currency)
	end

	local var_27_6 = ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle)

	if (var_27_6 == ActivityEnum.ActivityStatus.Normal or var_27_6 == ActivityEnum.ActivityStatus.NotUnlock) and ToughBattleModel.instance:isDropActItem() then
		arg_27_0:_addActReward(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a9ToughEnter, 0, var_0_0.TagType.Act, false, nil, arg_27_0.onRefreshV1a7Power, arg_27_0.onRecycleV1a7Currency)
	end
end

function var_0_0.addAdvanceReward(arg_28_0)
	if arg_28_0.episodeInfo.star < DungeonEnum.StarType.Advanced then
		for iter_28_0, iter_28_1 in ipairs(DungeonModel.instance:getEpisodeAdvancedBonus(arg_28_0.episodeId)) do
			arg_28_0:_addReward(iter_28_1[1], iter_28_1[2], iter_28_1[3], var_0_0.TagType.SecondPass, true, var_0_0.RewardType.SecondStar)
		end
	end
end

function var_0_0.addFirstReward(arg_29_0, arg_29_1)
	if arg_29_0.episodeInfo.star == DungeonEnum.StarType.None or arg_29_1 then
		local var_29_0 = var_0_0.TagType.FirstPass

		if arg_29_1 then
			var_29_0 = var_0_0.TagType.StoryFirst
		end

		for iter_29_0, iter_29_1 in ipairs(DungeonModel.instance:getEpisodeFirstBonus(arg_29_0.episodeId)) do
			local var_29_1 = true

			if tonumber(iter_29_1[1]) == MaterialEnum.MaterialType.Currency and tonumber(iter_29_1[2]) == CurrencyEnum.CurrencyType.V1a9ToughEnter then
				local var_29_2 = ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle)

				if var_29_2 ~= ActivityEnum.ActivityStatus.Normal and var_29_2 ~= ActivityEnum.ActivityStatus.NotUnlock then
					var_29_1 = false
				end
			end

			if var_29_1 then
				arg_29_0:_addReward(iter_29_1[1], iter_29_1[2], iter_29_1[3], var_29_0, true, var_0_0.RewardType.OneStar)
			end
		end
	end
end

function var_0_0.addFreeReward(arg_30_0)
	if arg_30_0.isFree then
		for iter_30_0, iter_30_1 in ipairs(DungeonModel.instance:getEpisodeFreeDisplayList(arg_30_0.episodeId)) do
			arg_30_0:_addReward(iter_30_1[1], iter_30_1[2], 0, iter_30_1[3], false, var_0_0.RewardType.Common)
		end
	end
end

function var_0_0.addDoubleDropReward(arg_31_0)
	if not DoubleDropModel.instance:isShowDoubleByEpisode(arg_31_0.episodeId, true) then
		return
	end

	local var_31_0

	if arg_31_0.chapterCo.type == DungeonEnum.ChapterType.Gold or arg_31_0.chapterCo.type == DungeonEnum.ChapterType.Exp then
		local var_31_1 = DungeonModel.instance:getEpisodeBonus(arg_31_0.episodeId)

		for iter_31_0, iter_31_1 in ipairs(var_31_1) do
			arg_31_0:_addReward(iter_31_1[1], iter_31_1[2], iter_31_1[3], var_0_0.TagType.TurnBack, false, var_0_0.RewardType.TurnBack)
		end
	else
		local var_31_2 = DungeonModel.instance:getEpisodeRewardDisplayList(arg_31_0.episodeId)

		for iter_31_2, iter_31_3 in ipairs(var_31_2) do
			arg_31_0:_addReward(iter_31_3[1], iter_31_3[2], 0, var_0_0.TagType.TurnBack, false, var_0_0.RewardType.TurnBack)
		end
	end

	local var_31_3 = DoubleDropModel.instance:getActId()
	local var_31_4 = DoubleDropConfig.instance:getAct153ExtraBonus(var_31_3, arg_31_0.episodeId)
	local var_31_5 = GameUtil.splitString2(var_31_4, true)

	if var_31_5 then
		for iter_31_4, iter_31_5 in ipairs(var_31_5) do
			arg_31_0:_addReward(iter_31_5[1], iter_31_5[2], iter_31_5[3], var_0_0.TagType.TurnBack, false, var_0_0.RewardType.TurnBack)
		end
	end
end

function var_0_0.addCommonRewardList(arg_32_0)
	local var_32_0

	if arg_32_0.chapterCo.type == DungeonEnum.ChapterType.Gold or arg_32_0.chapterCo.type == DungeonEnum.ChapterType.Exp then
		var_32_0 = DungeonModel.instance:getEpisodeBonus(arg_32_0.episodeId)

		for iter_32_0, iter_32_1 in ipairs(var_32_0) do
			arg_32_0:_addReward(iter_32_1[1], iter_32_1[2], iter_32_1[3], var_0_0.TagType.None, true, var_0_0.RewardType.Common)
		end
	else
		var_32_0 = DungeonModel.instance:getEpisodeRewardDisplayList(arg_32_0.episodeId)

		for iter_32_2, iter_32_3 in ipairs(var_32_0) do
			arg_32_0:_addReward(iter_32_3[1], iter_32_3[2], 0, iter_32_3[3], false, var_0_0.RewardType.Common)
		end
	end

	if TurnbackModel.instance:isShowTurnBackAddition(arg_32_0.chapterId) then
		local var_32_1 = TurnbackModel.instance:getAdditionRewardList(var_32_0)

		for iter_32_4, iter_32_5 in ipairs(var_32_1) do
			arg_32_0:_addReward(iter_32_5[1], iter_32_5[2], iter_32_5[3], var_0_0.TagType.TurnBack, true, var_0_0.RewardType.TurnBack)
		end
	end
end

function var_0_0.addNewReward(arg_33_0)
	local var_33_0 = DungeonModel.instance:getEpisodeReward(arg_33_0.episodeId)

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		arg_33_0:_addReward(iter_33_1[1], iter_33_1[2], 0, iter_33_1.tagType, false, var_0_0.RewardType.Common)
	end
end

function var_0_0.setItemIcon(arg_34_0, arg_34_1)
	arg_34_1:isShowAddition(false)
	arg_34_1:isShowEquipAndItemCount(false)
	arg_34_1:setHideLvAndBreakFlag(true)
	arg_34_1:setShowCountFlag(false)
	arg_34_1:hideEquipLvAndBreak(true)
end

function var_0_0.refreshOneReward(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_1 then
		return
	end

	local var_35_0 = arg_35_0:getRewardItem(arg_35_2)

	var_35_0.rewardData = arg_35_1

	var_35_0.itemIcon:setMOValue(arg_35_1.itemType, arg_35_1.id, arg_35_1.quantity, nil, true)

	if arg_35_1.customRefreshCallback then
		arg_35_1.customRefreshCallback(arg_35_0, var_35_0)
	end

	arg_35_0:setItemIcon(var_35_0.itemIcon)
	arg_35_0:refreshTag(var_35_0)
	arg_35_0:refreshCount(var_35_0)
	arg_35_0:refreshCustomBg(var_35_0)

	return var_35_0
end

function var_0_0.refreshTag(arg_36_0, arg_36_1)
	arg_36_0:clearRewardTag(arg_36_1)

	local var_36_0 = arg_36_1.rewardData.tagType

	if var_36_0 == var_0_0.TagType.None then
		return
	end

	if var_36_0 == var_0_0.TagType.SecondPass then
		gohelper.setActive(arg_36_1.goadvance, true)
	elseif var_36_0 == var_0_0.TagType.FirstPass then
		gohelper.setActive(arg_36_1.gofirst, not arg_36_0.hardMode)
		gohelper.setActive(arg_36_1.gofirsthard, arg_36_0.hardMode)
	elseif var_36_0 == var_0_0.TagType.TurnBack then
		gohelper.setActive(arg_36_1.goAddition, true)
	elseif var_36_0 == var_0_0.TagType.StoryFirst then
		gohelper.setActive(arg_36_1.storyfirst, true)
	else
		gohelper.setActive(arg_36_1.gonormal, true)

		arg_36_1.txtnormal.text = luaLang("dungeon_prob_flag" .. var_36_0)
	end
end

function var_0_0.clearRewardTag(arg_37_0, arg_37_1)
	gohelper.setActive(arg_37_1.gofirst, false)
	gohelper.setActive(arg_37_1.goadvance, false)
	gohelper.setActive(arg_37_1.gofirsthard, false)
	gohelper.setActive(arg_37_1.gonormal, false)
	gohelper.setActive(arg_37_1.goAddition, false)
	gohelper.setActive(arg_37_1.finished, false)
	gohelper.setActive(arg_37_1.storyfirst, false)
end

function var_0_0.refreshCount(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1.rewardData.showQuantity

	gohelper.setActive(arg_38_1.gocount, var_38_0)

	if var_38_0 then
		if arg_38_1.itemIcon:isEquipIcon() then
			arg_38_1.itemIcon:ShowEquipCount(arg_38_1.gocount, arg_38_1.txtcount)
		else
			arg_38_1.itemIcon:showStackableNum2(arg_38_1.gocount, arg_38_1.txtcount)
		end
	end
end

function var_0_0.refreshCustomBg(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1.rewardData.customBg

	if string.nilorempty(var_39_0) then
		return
	end

	arg_39_1.itemIcon:setIconBg(var_39_0)
end

function var_0_0.onRefreshV1a7Power(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1.itemIcon._itemIcon

	var_40_0:setCanShowDeadLine(false)

	var_40_0._gov1a7act = var_40_0._gov1a7act or gohelper.findChild(var_40_0.go, "act")

	gohelper.setActive(var_40_0._gov1a7act, true)
end

function var_0_0.onRefreshV1a7Currency(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1.itemIcon._itemIcon

	var_41_0._gov1a7act = var_41_0._gov1a7act or gohelper.findChild(var_41_0.go, "act")

	gohelper.setActive(var_41_0._gov1a7act, true)
end

function var_0_0.onRecycleV1a7Currency(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1.itemIcon._itemIcon

	gohelper.setActive(var_42_0._gov1a7act, false)
end

function var_0_0.onClose(arg_43_0)
	arg_43_0.switchInit = false

	TaskDispatcher.cancelTask(arg_43_0.delayRefreshReward, arg_43_0)
end

function var_0_0.onDestroyView(arg_44_0)
	return
end

function var_0_0.onRefreshActivityState(arg_45_0, arg_45_1)
	if arg_45_1 ~= arg_45_0.activityId then
		return
	end

	arg_45_0:updateActiveActId()
	arg_45_0:refreshReward()
end

function var_0_0.onDailyRefresh(arg_46_0)
	arg_46_0:refreshTurnBack()
end

function var_0_0.refreshTurnBack(arg_47_0)
	arg_47_0:refreshTurnBackAdditionTips()
	arg_47_0:refreshReward()
end

return var_0_0
