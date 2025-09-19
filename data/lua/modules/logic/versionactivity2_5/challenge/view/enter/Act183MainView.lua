module("modules.logic.versionactivity2_5.challenge.view.enter.Act183MainView", package.seeall)

local var_0_0 = class("Act183MainView", BaseView)
local var_0_1 = 1
local var_0_2 = 30

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/left/#txt_time")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/#btn_reward")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "root/left/#btn_reward/#go_taskreddot")
	arg_1_0._btnrecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/#btn_record")
	arg_1_0._btnmedal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/#btn_medal")
	arg_1_0._gomedalreddot = gohelper.findChild(arg_1_0.viewGO, "root/left/#btn_medal/#go_medalreddot")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_main")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_main/#go_normal")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_main/#go_hard")
	arg_1_0._btnentermain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/middle/#btn_entermain")
	arg_1_0._scrolldaily = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#scroll_daily")
	arg_1_0._godailyitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#scroll_daily/Viewport/Content/#go_dailyitem")
	arg_1_0._simagelevelpic = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/middle/#simage_LevelPic")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnrecord:AddClickListener(arg_2_0._btnrecordOnClick, arg_2_0)
	arg_2_0._btnmedal:AddClickListener(arg_2_0._btnmedalOnClick, arg_2_0)
	arg_2_0._btnentermain:AddClickListener(arg_2_0._btnentermainOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnrecord:RemoveClickListener()
	arg_3_0._btnmedal:RemoveClickListener()
	arg_3_0._btnentermain:RemoveClickListener()
end

function var_0_0._btnrewardOnClick(arg_4_0)
	Act183Controller.instance:openAct183TaskView()
end

function var_0_0._btnrecordOnClick(arg_5_0)
	Act183Controller.instance:openAct183ReportView()
end

function var_0_0._btnmedalOnClick(arg_6_0)
	Act183Controller.instance:openAct183BadgeView()
end

function var_0_0._btnentermainOnClick(arg_7_0)
	local var_7_0 = Act183Helper.getLastEnterMainGroupTypeInLocal(arg_7_0._actId, Act183Enum.GroupType.NormalMain)
	local var_7_1 = arg_7_0._mainGroupEpisodeTab[var_7_0]

	if not var_7_1 then
		return
	end

	local var_7_2 = var_7_1:getStatus()

	if var_7_2 == Act183Enum.GroupStatus.Locked and var_7_0 ~= Act183Enum.GroupType.NormalMain then
		logError(string.format("本地标记的上一次进入关卡组未解锁!!!, 保底进入普通日常关卡。lastEnterGroupType = %s, status = %s", var_7_0, var_7_2))

		local var_7_3 = Act183Enum.GroupType.NormalMain

		var_7_1 = arg_7_0._mainGroupEpisodeTab[var_7_3]
	end

	local var_7_4 = var_7_1 and var_7_1:getGroupId()
	local var_7_5 = var_7_1 and var_7_1:getGroupType()
	local var_7_6 = Act183Helper.generateDungeonViewParams(var_7_5, var_7_4)

	Act183Controller.instance:openAct183DungeonView(var_7_6)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._actId = Act183Model.instance:getActivityId()
	arg_8_0._info = Act183Model.instance:getActInfo()

	Act183Model.instance:initTaskStatusMap()

	arg_8_0._rewardReddotAnim = gohelper.findChildComponent(arg_8_0._btnreward.gameObject, "ani", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(arg_8_0._gotaskreddot, RedDotEnum.DotNode.V2a5_Act183Task, nil, arg_8_0._taskReddotFunc, arg_8_0)
	arg_8_0:addEventCb(Act183Controller.instance, Act183Event.RefreshMedalReddot, arg_8_0.initOrRefreshMedalReddot, arg_8_0)

	local var_8_0 = lua_challenge_const.configDict[Act183Enum.Const.MainBannerUrl]
	local var_8_1 = var_8_0 and var_8_0.value2 or ""

	arg_8_0._simagelevelpic:LoadImage(ResUrl.getChallengeIcon(var_8_1))
end

function var_0_0._taskReddotFunc(arg_9_0, arg_9_1)
	arg_9_1:defaultRefreshDot()
	arg_9_0._rewardReddotAnim:Play(arg_9_1.show and "loop" or "idle", 0, 0)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:initRemainTime()
	arg_10_0:initMainGroupEntranceList()
	arg_10_0:initDailyGroupEntranceList()
	arg_10_0:initOrRefreshMedalReddot()
end

function var_0_0.initRemainTime(arg_11_0)
	arg_11_0:showLeftTime()
	TaskDispatcher.runRepeat(arg_11_0.showLeftTime, arg_11_0, var_0_1)
end

function var_0_0.showLeftTime(arg_12_0)
	arg_12_0._txttime.text = ActivityHelper.getActivityRemainTimeStr(arg_12_0._actId)
end

function var_0_0.initMainGroupEntranceList(arg_13_0)
	local var_13_0 = arg_13_0._info:getGroupEpisodeMos(Act183Enum.GroupType.NormalMain)
	local var_13_1 = arg_13_0._info:getGroupEpisodeMos(Act183Enum.GroupType.HardMain)
	local var_13_2 = var_13_0 and var_13_0[1]
	local var_13_3 = var_13_1 and var_13_1[1]

	if not var_13_2 or not var_13_3 then
		return
	end

	arg_13_0._mainGroupEpisodeTab = {
		[Act183Enum.GroupType.NormalMain] = var_13_2,
		[Act183Enum.GroupType.HardMain] = var_13_3
	}

	for iter_13_0, iter_13_1 in pairs(arg_13_0._mainGroupEpisodeTab) do
		Act183MainGroupEntranceItem.Get(arg_13_0.viewGO, iter_13_0):onUpdateMO(iter_13_1)
	end
end

function var_0_0.initDailyGroupEntranceList(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.initDailyGroupEntranceList, arg_14_0)

	arg_14_0._dailyGroupEpisodeMos = arg_14_0._info:getGroupEpisodeMos(Act183Enum.GroupType.Daily)
	arg_14_0._dailyGroupEpisodeCount = arg_14_0._dailyGroupEpisodeMos and #arg_14_0._dailyGroupEpisodeMos or 0

	if not arg_14_0._dailyGroupEpisodeMos then
		return
	end

	local var_14_0 = false

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._dailyGroupEpisodeMos) do
		local var_14_1 = Act183DailyGroupEntranceItem.Get(arg_14_0.viewGO, arg_14_0._godailyitem, iter_14_1, iter_14_0)
		local var_14_2 = iter_14_1:getStatus()

		var_14_1:onUpdateMO(iter_14_1)

		if var_14_2 == Act183Enum.GroupStatus.Locked and not var_14_0 then
			var_14_1:showUnlockCountDown()

			var_14_0 = true
		end
	end

	if var_14_0 then
		TaskDispatcher.runDelay(arg_14_0.initDailyGroupEntranceList, arg_14_0, var_0_2)
	end
end

function var_0_0.initOrRefreshMedalReddot(arg_15_0)
	if not arg_15_0._medatReddot then
		arg_15_0._medatReddot = RedDotController.instance:addNotEventRedDot(arg_15_0._gomedalreddot, arg_15_0._checkMedalReddot, arg_15_0, RedDotEnum.Style.Normal)
	end

	arg_15_0._medatReddot:refreshRedDot()
end

function var_0_0._checkMedalReddot(arg_16_0)
	local var_16_0 = Act183Helper.getHasReadUnlockSupportHeroIdsInLocal(arg_16_0._actId)
	local var_16_1 = Act183Helper.listToMap(var_16_0)
	local var_16_2 = arg_16_0._info:getUnlockSupportHeroIds()

	if var_16_2 then
		for iter_16_0, iter_16_1 in ipairs(var_16_2) do
			if not var_16_1[iter_16_1] then
				return true
			end
		end
	end
end

function var_0_0.onClose(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.showLeftTime, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.initDailyGroupEntranceList, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simagelevelpic:UnLoadImage()
end

return var_0_0
