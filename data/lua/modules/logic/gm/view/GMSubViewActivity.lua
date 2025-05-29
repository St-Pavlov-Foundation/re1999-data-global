module("modules.logic.gm.view.GMSubViewActivity", package.seeall)

local var_0_0 = class("GMSubViewActivity", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "活动"
end

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_2_0)
	arg_2_0:addLabel("L0", "2.5春节活动")

	arg_2_0._act186TalkId = arg_2_0:addInputText("L0", nil, "对话id")

	arg_2_0:addButton("L0", "播放对话", arg_2_0._playAct186Talk, arg_2_0)
	arg_2_0:addTitleSplitLine("活动状态")

	arg_2_0._dropActivity = arg_2_0:addDropDown("L1", "活动ID：", nil, arg_2_0._onActivityDropValueChange, arg_2_0)
	arg_2_0._dropActivityStatus = arg_2_0:addDropDown("L1", "活动状态：", nil, arg_2_0._onActivityStatusDropValueChange, arg_2_0)

	arg_2_0:addButton("L1", "修改活动状态", arg_2_0._onClickChangeActivityBtn, arg_2_0, {
		w = 220
	})
	arg_2_0:addButton("L1", "数据复原", arg_2_0._onClickResetActivityBtn, arg_2_0, {
		w = 150
	})
	arg_2_0:addButton("L2", "重置解锁动画", arg_2_0._onClickResetActivityUnlockAim, arg_2_0)
	arg_2_0:addLabel("L3", "2.1外围玩法")
	arg_2_0:addButton("L3", "检查配置表是否正确", arg_2_0._onClickCheckActivity165Config, arg_2_0)
	arg_2_0:addButton("L3", "打印可能通往的结局步骤", arg_2_0._onClickPrintActivity165CanRound, arg_2_0)
	arg_2_0:addLabel("L4", "2.2玩法")

	arg_2_0._txtLevelID = arg_2_0:addInputText("L4", "222101", "输入关卡ID")
	arg_2_0._txtCharacterID = arg_2_0:addInputText("L4", "222002", "输入主战者ID")
	arg_2_0._txtSoliderID = arg_2_0:addInputText("L4", "222001, 222002, 222003, 222004, 22101, 22102", "输入士兵ID")

	arg_2_0:addButton("L4", "直接打开小队玩法（正常流程）", arg_2_0._onClickEditorStartMatch3WarChessInfo_3, arg_2_0)
	arg_2_0:addButton("L5", "斗蛐蛐测试工具", arg_2_0._douQuQuTest, arg_2_0)
	arg_2_0:addLabel("L5", "X场次Y回合开始")

	arg_2_0.douQuQuStartIndex = arg_2_0:addInputText("L5", nil, "场次")

	arg_2_0._setRectTransSize(arg_2_0.douQuQuStartIndex.gameObject, nil, 150, 80)

	arg_2_0.douQuQuStartRound = arg_2_0:addInputText("L5", nil, "回合")

	arg_2_0._setRectTransSize(arg_2_0.douQuQuStartRound.gameObject, nil, 150, 80)
	arg_2_0:addButton("L5", "开始战斗", arg_2_0._douQuQuTestForceIndexRound, arg_2_0)
	arg_2_0:addLabel("L6", "2.4玩法")
	arg_2_0:addButton("L6", "直接打开芭卡洛儿", function()
		VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicChapterView()
	end, arg_2_0)

	local var_2_0 = {
		"无",
		"普通弹珠",
		"分裂弹珠",
		"玻璃弹珠",
		"爆炸弹珠",
		"弹力弹珠"
	}

	arg_2_0._act178Ball = arg_2_0:addDropDown("L7", "弹珠游戏", var_2_0, arg_2_0._onAct178DropChange, arg_2_0)

	arg_2_0._act178Ball:SetValue(PinballModel.instance._gmball)

	arg_2_0._act178Toggle = arg_2_0:addToggle("L7", "解锁所有弹珠科技", arg_2_0._onAct178ToggleChange, arg_2_0)
	arg_2_0._act178Toggle.isOn = PinballModel.instance._gmUnlockAll
	arg_2_0._act178Toggle2 = arg_2_0:addToggle("L7", "GM", arg_2_0._onAct178ToggleChange2, arg_2_0)
	arg_2_0._act178Toggle2.isOn = PinballModel.instance._gmkey

	arg_2_0:addLabel("L8", "弹珠游戏")

	arg_2_0._act178EpisodeId = arg_2_0:addInputText("L8", nil, "关卡ID")

	arg_2_0:addButton("L8", "直接进入弹珠游戏", arg_2_0._enterAct178Game, arg_2_0)
	arg_2_0:addLabel("L9", "2.6 活动")
	arg_2_0:addButton("L9", "虚构集卡牌ID开关", arg_2_0._setXugoujiDebugMode, arg_2_0)
	arg_2_0:initActivityDrop()

	arg_2_0._inited = true
end

function var_0_0._onAct178DropChange(arg_4_0, arg_4_1)
	PinballModel.instance._gmball = arg_4_1
end

function var_0_0._onAct178ToggleChange(arg_5_0)
	PinballModel.instance._gmUnlockAll = arg_5_0._act178Toggle.isOn
end

function var_0_0._onAct178ToggleChange2(arg_6_0)
	PinballModel.instance._gmkey = arg_6_0._act178Toggle2.isOn
end

function var_0_0._playAct186Talk(arg_7_0)
	local var_7_0 = tonumber(arg_7_0._act186TalkId:GetText())

	Activity186Controller.instance:dispatchEvent(Activity186Event.PlayTalk, var_7_0)
	arg_7_0:closeThis()
end

function var_0_0._enterAct178Game(arg_8_0)
	local var_8_0 = tonumber(arg_8_0._act178EpisodeId:GetText())

	if not lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_8_0] then
		GameFacade.showToastString("关卡配置不存在")

		return
	end

	PinballModel.instance.leftEpisodeId = var_8_0

	ViewMgr.instance:openView(ViewName.PinballGameView)
end

function var_0_0.initActivityDrop(arg_9_0)
	local var_9_0 = {
		VersionActivity2_4Enum.ActivityId
	}

	arg_9_0.activityIdList = {}
	arg_9_0.activityShowStrList = {}

	local var_9_1 = {}

	tabletool.addValues(var_9_1, VersionActivity2_4Enum.ActivityId)

	arg_9_0.activityAll = {
		["2_4all"] = var_9_1
	}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			if type(iter_9_3) == "table" then
				for iter_9_4, iter_9_5 in pairs(iter_9_3) do
					table.insert(arg_9_0.activityIdList, iter_9_5)
				end
			else
				table.insert(arg_9_0.activityIdList, iter_9_3)
			end
		end
	end

	for iter_9_6, iter_9_7 in ipairs(arg_9_0.activityIdList) do
		local var_9_2 = lua_activity.configDict[iter_9_7]

		table.insert(arg_9_0.activityShowStrList, (var_9_2 and var_9_2.name or "") .. string.format("(%s)", iter_9_7))
	end

	for iter_9_8, iter_9_9 in pairs(arg_9_0.activityAll) do
		table.insert(arg_9_0.activityIdList, 1, iter_9_8)
		table.insert(arg_9_0.activityShowStrList, 1, iter_9_8)
	end

	arg_9_0.statusList = {
		ActivityEnum.ActivityStatus.Normal,
		ActivityEnum.ActivityStatus.NotOpen,
		ActivityEnum.ActivityStatus.Expired,
		ActivityEnum.ActivityStatus.NotUnlock,
		ActivityEnum.ActivityStatus.NotOnLine
	}
	arg_9_0.statusShowStrList = {
		"正常开启状态",
		"未达到开启时间",
		"活动已结束",
		"活动未解锁",
		"活动已下线"
	}
	arg_9_0.selectActivityIndex = 1
	arg_9_0.selectStatusIndex = 1

	if arg_9_0._dropActivity then
		arg_9_0._dropActivity:ClearOptions()
		arg_9_0._dropActivityStatus:ClearOptions()
		arg_9_0._dropActivity:AddOptions(arg_9_0.activityShowStrList)
		arg_9_0._dropActivityStatus:AddOptions(arg_9_0.statusShowStrList)
	end
end

function var_0_0._onActivityDropValueChange(arg_10_0, arg_10_1)
	arg_10_0.selectActivityIndex = arg_10_1 + 1
end

function var_0_0._onActivityStatusDropValueChange(arg_11_0, arg_11_1)
	arg_11_0.selectStatusIndex = arg_11_1 + 1
end

function var_0_0._onClickChangeActivityBtn(arg_12_0)
	local var_12_0 = arg_12_0.activityIdList[arg_12_0.selectActivityIndex or 1]

	if arg_12_0.activityAll[var_12_0] then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.activityAll[var_12_0]) do
			arg_12_0:_changeActivityInfo(iter_12_1)
		end

		return
	end

	arg_12_0:_changeActivityInfo(var_12_0)
end

function var_0_0._changeActivityInfo(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.statusList[arg_13_0.selectStatusIndex or 1]
	local var_13_1 = ActivityModel.instance:getActivityInfo()[arg_13_1]

	if ActivityHelper.getActivityStatus(arg_13_1) == var_13_0 then
		return
	end

	local var_13_2 = ServerTime.now() * 1000
	local var_13_3 = TimeUtil.maxDateTimeStamp * 1000

	var_13_1.config = arg_13_0:copyConfig(var_13_1.config)

	if var_13_0 == ActivityEnum.ActivityStatus.Normal then
		var_13_1.startTime = var_13_2 - 1
		var_13_1.endTime = var_13_3
		var_13_1.config.openId = 0
		var_13_1.online = true
	elseif var_13_0 == ActivityEnum.ActivityStatus.NotOpen then
		var_13_1.startTime = var_13_3
	elseif var_13_0 == ActivityEnum.ActivityStatus.Expired then
		var_13_1.startTime = var_13_2 - 1
		var_13_1.endTime = var_13_1.startTime
	elseif var_13_0 == ActivityEnum.ActivityStatus.NotUnlock then
		var_13_1.startTime = var_13_2 - 1
		var_13_1.endTime = var_13_3
		var_13_1.config.openId = arg_13_1
		OpenModel.instance._unlocks[arg_13_1] = false
	elseif var_13_0 == ActivityEnum.ActivityStatus.NotOnLine then
		var_13_1.startTime = var_13_2 - 1
		var_13_1.endTime = var_13_3
		var_13_1.config.openId = 0
		var_13_1.online = false
	end

	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, arg_13_1)
end

function var_0_0._onClickResetActivityBtn(arg_14_0)
	ActivityRpc.instance:sendGetActivityInfosRequest()
end

function var_0_0._onClickResetActivityUnlockAim(arg_15_0)
	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))

	VersionActivityBaseController.instance.playedActUnlockAnimationList = nil
end

function var_0_0._onClickCheckActivity165Config(arg_16_0)
	Activity165Model.instance:GMCheckConfig()
end

function var_0_0._onClickPrintActivity165CanRound(arg_17_0)
	Activity165Model.instance:setPrintLog(true)
end

function var_0_0._onClickEditorAct165Step(arg_18_0)
	ViewMgr.instance:openView(ViewName.GMAct165EditView)
end

function var_0_0._onClickEditorStartMatch3WarChessInfo_3(arg_19_0)
	local var_19_0 = tonumber(arg_19_0._txtLevelID:GetText())
	local var_19_1 = tonumber(arg_19_0._txtCharacterID:GetText())
	local var_19_2 = string.splitToNumber(arg_19_0._txtSoliderID:GetText(), ",")

	EliminateLevelController.instance:enterLevel(var_19_0, var_19_1, var_19_2)
end

function var_0_0._douQuQuTest(arg_20_0)
	ViewMgr.instance:openView(ViewName.FightGMDouQuQuTest)
	arg_20_0:closeThis()
end

function var_0_0._douQuQuTestForceIndexRound(arg_21_0)
	local var_21_0 = tonumber(arg_21_0.douQuQuStartIndex:GetText())
	local var_21_1 = tonumber(arg_21_0.douQuQuStartRound:GetText())

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.GMDouQuQuSkip2IndexRound, var_21_0, var_21_1)
	else
		FightPlayMgr._onGMDouQuQuSkip2IndexRound(arg_21_0, var_21_0, var_21_1)
	end

	arg_21_0:closeThis()
end

function var_0_0._setXugoujiDebugMode(arg_22_0)
	local var_22_0 = XugoujiController.instance:isDebugMode()

	XugoujiController.instance:setDebugMode(not var_22_0)
	PlayerPrefsHelper.setNumber("XugoujiDebugMode", var_22_0 and 0 or 1)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.TurnChanged)
end

function var_0_0.copyConfig(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = {
		logoName = 9,
		name = 3,
		banner = 13,
		actDesc = 5,
		desc = 14,
		openId = 17,
		tabButton = 25,
		logoType = 8,
		isRetroAcitivity = 21,
		confirmCondition = 11,
		achievementGroupPath = 22,
		achievementGroup = 19,
		tabBgmId = 26,
		showCenter = 15,
		param = 16,
		redDotId = 18,
		storyId = 20,
		tabBgPath = 24,
		typeId = 7,
		actTip = 6,
		activityBonus = 23,
		tabName = 2,
		id = 1,
		joinCondition = 10,
		displayPriority = 12,
		nameEn = 4
	}

	for iter_23_0, iter_23_1 in pairs(var_23_1) do
		var_23_0[iter_23_0] = arg_23_0[iter_23_0]
	end

	return var_23_0
end

return var_0_0
