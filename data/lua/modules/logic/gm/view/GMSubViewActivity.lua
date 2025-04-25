module("modules.logic.gm.view.GMSubViewActivity", package.seeall)

slot0 = class("GMSubViewActivity", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "活动"
end

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	GMSubViewBase.initViewContent(slot0)
	slot0:addLabel("L0", "2.5春节活动")

	slot0._act186TalkId = slot0:addInputText("L0", nil, "对话id")

	slot0:addButton("L0", "播放对话", slot0._playAct186Talk, slot0)
	slot0:addTitleSplitLine("活动状态")

	slot0._dropActivity = slot0:addDropDown("L1", "活动ID：", nil, slot0._onActivityDropValueChange, slot0)
	slot0._dropActivityStatus = slot0:addDropDown("L1", "活动状态：", nil, slot0._onActivityStatusDropValueChange, slot0)

	slot0:addButton("L1", "修改活动状态", slot0._onClickChangeActivityBtn, slot0, {
		w = 220
	})
	slot0:addButton("L1", "数据复原", slot0._onClickResetActivityBtn, slot0, {
		w = 150
	})
	slot0:addButton("L2", "重置解锁动画", slot0._onClickResetActivityUnlockAim, slot0)
	slot0:addLabel("L3", "2.1外围玩法")
	slot0:addButton("L3", "检查配置表是否正确", slot0._onClickCheckActivity165Config, slot0)
	slot0:addButton("L3", "打印可能通往的结局步骤", slot0._onClickPrintActivity165CanRound, slot0)
	slot0:addLabel("L4", "2.2玩法")

	slot0._txtLevelID = slot0:addInputText("L4", "222101", "输入关卡ID")
	slot0._txtCharacterID = slot0:addInputText("L4", "222002", "输入主战者ID")
	slot0._txtSoliderID = slot0:addInputText("L4", "222001, 222002, 222003, 222004, 22101, 22102", "输入士兵ID")

	slot0:addButton("L4", "直接打开小队玩法（正常流程）", slot0._onClickEditorStartMatch3WarChessInfo_3, slot0)
	slot0:addButton("L5", "斗蛐蛐测试工具", slot0._douQuQuTest, slot0)
	slot0:addLabel("L5", "X场次Y回合开始")

	slot0.douQuQuStartIndex = slot0:addInputText("L5", nil, "场次")

	slot0._setRectTransSize(slot0.douQuQuStartIndex.gameObject, nil, 150, 80)

	slot0.douQuQuStartRound = slot0:addInputText("L5", nil, "回合")

	slot0._setRectTransSize(slot0.douQuQuStartRound.gameObject, nil, 150, 80)
	slot0:addButton("L5", "开始战斗", slot0._douQuQuTestForceIndexRound, slot0)
	slot0:addLabel("L6", "2.4玩法")
	slot0:addButton("L6", "直接打开芭卡洛儿", function ()
		VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicChapterView()
	end, slot0)

	slot0._act178Ball = slot0:addDropDown("L7", "弹珠游戏", {
		"无",
		"普通弹珠",
		"分裂弹珠",
		"玻璃弹珠",
		"爆炸弹珠",
		"弹力弹珠"
	}, slot0._onAct178DropChange, slot0)

	slot0._act178Ball:SetValue(PinballModel.instance._gmball)

	slot0._act178Toggle = slot0:addToggle("L7", "解锁所有弹珠科技", slot0._onAct178ToggleChange, slot0)
	slot0._act178Toggle.isOn = PinballModel.instance._gmUnlockAll
	slot0._act178Toggle2 = slot0:addToggle("L7", "GM", slot0._onAct178ToggleChange2, slot0)
	slot0._act178Toggle2.isOn = PinballModel.instance._gmkey

	slot0:addLabel("L8", "弹珠游戏")

	slot0._act178EpisodeId = slot0:addInputText("L8", nil, "关卡ID")

	slot0:addButton("L8", "直接进入弹珠游戏", slot0._enterAct178Game, slot0)
	slot0:initActivityDrop()

	slot0._inited = true
end

function slot0._onAct178DropChange(slot0, slot1)
	PinballModel.instance._gmball = slot1
end

function slot0._onAct178ToggleChange(slot0)
	PinballModel.instance._gmUnlockAll = slot0._act178Toggle.isOn
end

function slot0._onAct178ToggleChange2(slot0)
	PinballModel.instance._gmkey = slot0._act178Toggle2.isOn
end

function slot0._playAct186Talk(slot0)
	Activity186Controller.instance:dispatchEvent(Activity186Event.PlayTalk, tonumber(slot0._act186TalkId:GetText()))
	slot0:closeThis()
end

function slot0._enterAct178Game(slot0)
	if not lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][tonumber(slot0._act178EpisodeId:GetText())] then
		GameFacade.showToastString("关卡配置不存在")

		return
	end

	PinballModel.instance.leftEpisodeId = slot1

	ViewMgr.instance:openView(ViewName.PinballGameView)
end

function slot0.initActivityDrop(slot0)
	slot0.activityIdList = {}
	slot0.activityShowStrList = {}
	slot2 = {}

	tabletool.addValues(slot2, VersionActivity2_4Enum.ActivityId)

	slot0.activityAll = {
		["2_4all"] = slot2
	}

	for slot6, slot7 in ipairs({
		VersionActivity2_4Enum.ActivityId
	}) do
		for slot11, slot12 in pairs(slot7) do
			if type(slot12) == "table" then
				for slot16, slot17 in pairs(slot12) do
					table.insert(slot0.activityIdList, slot17)
				end
			else
				table.insert(slot0.activityIdList, slot12)
			end
		end
	end

	for slot6, slot7 in ipairs(slot0.activityIdList) do
		table.insert(slot0.activityShowStrList, (lua_activity.configDict[slot7] and slot8.name or "") .. string.format("(%s)", slot7))
	end

	for slot6, slot7 in pairs(slot0.activityAll) do
		table.insert(slot0.activityIdList, 1, slot6)
		table.insert(slot0.activityShowStrList, 1, slot6)
	end

	slot0.statusList = {
		ActivityEnum.ActivityStatus.Normal,
		ActivityEnum.ActivityStatus.NotOpen,
		ActivityEnum.ActivityStatus.Expired,
		ActivityEnum.ActivityStatus.NotUnlock,
		ActivityEnum.ActivityStatus.NotOnLine
	}
	slot0.statusShowStrList = {
		"正常开启状态",
		"未达到开启时间",
		"活动已结束",
		"活动未解锁",
		"活动已下线"
	}
	slot0.selectActivityIndex = 1
	slot0.selectStatusIndex = 1

	if slot0._dropActivity then
		slot0._dropActivity:ClearOptions()
		slot0._dropActivityStatus:ClearOptions()
		slot0._dropActivity:AddOptions(slot0.activityShowStrList)
		slot0._dropActivityStatus:AddOptions(slot0.statusShowStrList)
	end
end

function slot0._onActivityDropValueChange(slot0, slot1)
	slot0.selectActivityIndex = slot1 + 1
end

function slot0._onActivityStatusDropValueChange(slot0, slot1)
	slot0.selectStatusIndex = slot1 + 1
end

function slot0._onClickChangeActivityBtn(slot0)
	if slot0.activityAll[slot0.activityIdList[slot0.selectActivityIndex or 1]] then
		for slot5, slot6 in pairs(slot0.activityAll[slot1]) do
			slot0:_changeActivityInfo(slot6)
		end

		return
	end

	slot0:_changeActivityInfo(slot1)
end

function slot0._changeActivityInfo(slot0, slot1)
	slot3 = slot0.selectStatusIndex or 1
	slot3 = ActivityModel.instance:getActivityInfo()[slot1]

	if ActivityHelper.getActivityStatus(slot1) == slot0.statusList[slot3] then
		return
	end

	slot3.config = slot0:copyConfig(slot3.config)

	if slot2 == ActivityEnum.ActivityStatus.Normal then
		slot3.startTime = ServerTime.now() * 1000 - 1
		slot3.endTime = TimeUtil.maxDateTimeStamp * 1000
		slot3.config.openId = 0
		slot3.online = true
	elseif slot2 == ActivityEnum.ActivityStatus.NotOpen then
		slot3.startTime = slot6
	elseif slot2 == ActivityEnum.ActivityStatus.Expired then
		slot3.startTime = slot5 - 1
		slot3.endTime = slot3.startTime
	elseif slot2 == ActivityEnum.ActivityStatus.NotUnlock then
		slot3.startTime = slot5 - 1
		slot3.endTime = slot6
		slot3.config.openId = slot1
		OpenModel.instance._unlocks[slot1] = false
	elseif slot2 == ActivityEnum.ActivityStatus.NotOnLine then
		slot3.startTime = slot5 - 1
		slot3.endTime = slot6
		slot3.config.openId = 0
		slot3.online = false
	end

	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, slot1)
end

function slot0._onClickResetActivityBtn(slot0)
	ActivityRpc.instance:sendGetActivityInfosRequest()
end

function slot0._onClickResetActivityUnlockAim(slot0)
	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))

	VersionActivityBaseController.instance.playedActUnlockAnimationList = nil
end

function slot0._onClickCheckActivity165Config(slot0)
	Activity165Model.instance:GMCheckConfig()
end

function slot0._onClickPrintActivity165CanRound(slot0)
	Activity165Model.instance:setPrintLog(true)
end

function slot0._onClickEditorAct165Step(slot0)
	ViewMgr.instance:openView(ViewName.GMAct165EditView)
end

function slot0._onClickEditorStartMatch3WarChessInfo_3(slot0)
	EliminateLevelController.instance:enterLevel(tonumber(slot0._txtLevelID:GetText()), tonumber(slot0._txtCharacterID:GetText()), string.splitToNumber(slot0._txtSoliderID:GetText(), ","))
end

function slot0._douQuQuTest(slot0)
	ViewMgr.instance:openView(ViewName.FightGMDouQuQuTest)
	slot0:closeThis()
end

function slot0._douQuQuTestForceIndexRound(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.GMDouQuQuSkip2IndexRound, tonumber(slot0.douQuQuStartIndex:GetText()), tonumber(slot0.douQuQuStartRound:GetText()))
	else
		FightPlayMgr._onGMDouQuQuSkip2IndexRound(slot0, slot1, slot2)
	end

	slot0:closeThis()
end

function slot0.copyConfig(slot0)
	for slot6, slot7 in pairs({
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
	}) do
		-- Nothing
	end

	return {
		[slot6] = slot0[slot6]
	}
end

return slot0
