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
	arg_2_0:addLabel("L0", "轶事")

	arg_2_0._rolestoryId = arg_2_0:addInputText("L0", nil, "故事id")

	arg_2_0:addButton("L0", "重置", arg_2_0._resetRoleStory, arg_2_0)
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

function var_0_0._resetRoleStory(arg_8_0)
	local var_8_0 = tonumber(arg_8_0._rolestoryId:GetText())

	NecrologistStoryRpc.instance:_sendUpdateNecrologistStoryRequest(tonumber(var_8_0))
	arg_8_0:closeThis()
end

function var_0_0._enterAct178Game(arg_9_0)
	local var_9_0 = tonumber(arg_9_0._act178EpisodeId:GetText())

	if not lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_9_0] then
		GameFacade.showToastString("关卡配置不存在")

		return
	end

	PinballModel.instance.leftEpisodeId = var_9_0

	ViewMgr.instance:openView(ViewName.PinballGameView)
end

function var_0_0.initActivityDrop(arg_10_0)
	local var_10_0 = {
		VersionActivity2_4Enum.ActivityId
	}

	arg_10_0.activityIdList = {}
	arg_10_0.activityShowStrList = {}

	local var_10_1 = {}

	tabletool.addValues(var_10_1, VersionActivity2_4Enum.ActivityId)

	arg_10_0.activityAll = {
		["2_4all"] = var_10_1
	}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			if type(iter_10_3) == "table" then
				for iter_10_4, iter_10_5 in pairs(iter_10_3) do
					table.insert(arg_10_0.activityIdList, iter_10_5)
				end
			else
				table.insert(arg_10_0.activityIdList, iter_10_3)
			end
		end
	end

	for iter_10_6, iter_10_7 in ipairs(arg_10_0.activityIdList) do
		local var_10_2 = lua_activity.configDict[iter_10_7]

		table.insert(arg_10_0.activityShowStrList, (var_10_2 and var_10_2.name or "") .. string.format("(%s)", iter_10_7))
	end

	for iter_10_8, iter_10_9 in pairs(arg_10_0.activityAll) do
		table.insert(arg_10_0.activityIdList, 1, iter_10_8)
		table.insert(arg_10_0.activityShowStrList, 1, iter_10_8)
	end

	arg_10_0.statusList = {
		ActivityEnum.ActivityStatus.Normal,
		ActivityEnum.ActivityStatus.NotOpen,
		ActivityEnum.ActivityStatus.Expired,
		ActivityEnum.ActivityStatus.NotUnlock,
		ActivityEnum.ActivityStatus.NotOnLine
	}
	arg_10_0.statusShowStrList = {
		"正常开启状态",
		"未达到开启时间",
		"活动已结束",
		"活动未解锁",
		"活动已下线"
	}
	arg_10_0.selectActivityIndex = 1
	arg_10_0.selectStatusIndex = 1

	if arg_10_0._dropActivity then
		arg_10_0._dropActivity:ClearOptions()
		arg_10_0._dropActivityStatus:ClearOptions()
		arg_10_0._dropActivity:AddOptions(arg_10_0.activityShowStrList)
		arg_10_0._dropActivityStatus:AddOptions(arg_10_0.statusShowStrList)
	end
end

function var_0_0._onActivityDropValueChange(arg_11_0, arg_11_1)
	arg_11_0.selectActivityIndex = arg_11_1 + 1
end

function var_0_0._onActivityStatusDropValueChange(arg_12_0, arg_12_1)
	arg_12_0.selectStatusIndex = arg_12_1 + 1
end

function var_0_0._onClickChangeActivityBtn(arg_13_0)
	local var_13_0 = arg_13_0.activityIdList[arg_13_0.selectActivityIndex or 1]

	if arg_13_0.activityAll[var_13_0] then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.activityAll[var_13_0]) do
			arg_13_0:_changeActivityInfo(iter_13_1)
		end

		return
	end

	arg_13_0:_changeActivityInfo(var_13_0)
end

function var_0_0._changeActivityInfo(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.statusList[arg_14_0.selectStatusIndex or 1]
	local var_14_1 = ActivityModel.instance:getActivityInfo()[arg_14_1]

	if ActivityHelper.getActivityStatus(arg_14_1) == var_14_0 then
		return
	end

	local var_14_2 = ServerTime.now() * 1000
	local var_14_3 = TimeUtil.maxDateTimeStamp * 1000

	var_14_1.config = arg_14_0:copyConfig(var_14_1.config)

	if var_14_0 == ActivityEnum.ActivityStatus.Normal then
		var_14_1.startTime = var_14_2 - 1
		var_14_1.endTime = var_14_3
		var_14_1.config.openId = 0
		var_14_1.online = true
	elseif var_14_0 == ActivityEnum.ActivityStatus.NotOpen then
		var_14_1.startTime = var_14_3
	elseif var_14_0 == ActivityEnum.ActivityStatus.Expired then
		var_14_1.startTime = var_14_2 - 1
		var_14_1.endTime = var_14_1.startTime
	elseif var_14_0 == ActivityEnum.ActivityStatus.NotUnlock then
		var_14_1.startTime = var_14_2 - 1
		var_14_1.endTime = var_14_3
		var_14_1.config.openId = arg_14_1
		OpenModel.instance._unlocks[arg_14_1] = false
	elseif var_14_0 == ActivityEnum.ActivityStatus.NotOnLine then
		var_14_1.startTime = var_14_2 - 1
		var_14_1.endTime = var_14_3
		var_14_1.config.openId = 0
		var_14_1.online = false
	end

	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, arg_14_1)
end

function var_0_0._onClickResetActivityBtn(arg_15_0)
	ActivityRpc.instance:sendGetActivityInfosRequest()
end

function var_0_0._onClickResetActivityUnlockAim(arg_16_0)
	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))

	VersionActivityBaseController.instance.playedActUnlockAnimationList = nil
end

function var_0_0._onClickCheckActivity165Config(arg_17_0)
	Activity165Model.instance:GMCheckConfig()
end

function var_0_0._onClickPrintActivity165CanRound(arg_18_0)
	Activity165Model.instance:setPrintLog(true)
end

function var_0_0._onClickEditorAct165Step(arg_19_0)
	ViewMgr.instance:openView(ViewName.GMAct165EditView)
end

function var_0_0._onClickEditorStartMatch3WarChessInfo_3(arg_20_0)
	local var_20_0 = tonumber(arg_20_0._txtLevelID:GetText())
	local var_20_1 = tonumber(arg_20_0._txtCharacterID:GetText())
	local var_20_2 = string.splitToNumber(arg_20_0._txtSoliderID:GetText(), ",")

	EliminateLevelController.instance:enterLevel(var_20_0, var_20_1, var_20_2)
end

function var_0_0._douQuQuTest(arg_21_0)
	ViewMgr.instance:openView(ViewName.FightGMDouQuQuTest)
	arg_21_0:closeThis()
end

function var_0_0._douQuQuTestForceIndexRound(arg_22_0)
	local var_22_0 = tonumber(arg_22_0.douQuQuStartIndex:GetText())
	local var_22_1 = tonumber(arg_22_0.douQuQuStartRound:GetText())

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.GMDouQuQuSkip2IndexRound, var_22_0, var_22_1)
	else
		FightPlayMgr._onGMDouQuQuSkip2IndexRound(arg_22_0, var_22_0, var_22_1)
	end

	arg_22_0:closeThis()
end

function var_0_0._setXugoujiDebugMode(arg_23_0)
	local var_23_0 = XugoujiController.instance:isDebugMode()

	XugoujiController.instance:setDebugMode(not var_23_0)
	PlayerPrefsHelper.setNumber("XugoujiDebugMode", var_23_0 and 0 or 1)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.TurnChanged)
end

function var_0_0.copyConfig(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = {
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

	for iter_24_0, iter_24_1 in pairs(var_24_1) do
		var_24_0[iter_24_0] = arg_24_0[iter_24_0]
	end

	return var_24_0
end

return var_0_0
