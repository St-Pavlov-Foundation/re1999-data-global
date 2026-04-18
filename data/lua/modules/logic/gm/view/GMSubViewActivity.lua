-- chunkname: @modules/logic/gm/view/GMSubViewActivity.lua

module("modules.logic.gm.view.GMSubViewActivity", package.seeall)

local GMSubViewActivity = class("GMSubViewActivity", GMSubViewBase)

function GMSubViewActivity:ctor()
	self.tabName = "活动"
end

function GMSubViewActivity:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)
	self:addLabel("L0", "轶事")

	self._rolestoryId = self:addInputText("L0", nil, "故事id")

	self:addButton("L0", "重置", self._resetRoleStory, self)

	self._rolestoryFlagKey = self:addInputText("L0", nil, "条件参数")

	self:addButton("L0", "查询", self._printRoleStoryFlagKey, self)
	self:addTitleSplitLine("活动状态")

	self._dropActivity = self:addDropDown("L1", "活动ID：", nil, self._onActivityDropValueChange, self)
	self._dropActivityStatus = self:addDropDown("L1", "活动状态：", nil, self._onActivityStatusDropValueChange, self)

	self:addButton("L1", "修改活动状态", self._onClickChangeActivityBtn, self, {
		w = 220
	})
	self:addButton("L1", "数据复原", self._onClickResetActivityBtn, self, {
		w = 150
	})
	self:addButton("L2", "重置解锁动画", self._onClickResetActivityUnlockAim, self)
	self:addLabel("L3", "2.1外围玩法")
	self:addButton("L3", "检查配置表是否正确", self._onClickCheckActivity165Config, self)
	self:addButton("L3", "打印可能通往的结局步骤", self._onClickPrintActivity165CanRound, self)
	self:addLabel("L4", "2.2玩法")

	self._txtLevelID = self:addInputText("L4", "222101", "输入关卡ID")
	self._txtCharacterID = self:addInputText("L4", "222002", "输入主战者ID")
	self._txtSoliderID = self:addInputText("L4", "222001, 222002, 222003, 222004, 22101, 22102", "输入士兵ID")

	self:addButton("L4", "直接打开小队玩法（正常流程）", self._onClickEditorStartMatch3WarChessInfo_3, self)
	self:addButton("L5", "斗蛐蛐测试工具", self._douQuQuTest, self)
	self:addLabel("L5", "X场次Y回合开始")

	self.douQuQuStartIndex = self:addInputText("L5", nil, "场次")

	self._setRectTransSize(self.douQuQuStartIndex.gameObject, nil, 150, 80)

	self.douQuQuStartRound = self:addInputText("L5", nil, "回合")

	self._setRectTransSize(self.douQuQuStartRound.gameObject, nil, 150, 80)
	self:addButton("L5", "开始战斗", self._douQuQuTestForceIndexRound, self)
	self:addLabel("L6", "2.4玩法")
	self:addButton("L6", "直接打开芭卡洛儿", function()
		VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicChapterView()
	end, self)

	local list = {
		"无",
		"普通弹珠",
		"分裂弹珠",
		"玻璃弹珠",
		"爆炸弹珠",
		"弹力弹珠"
	}

	self._act178Ball = self:addDropDown("L7", "弹珠游戏", list, self._onAct178DropChange, self)

	self._act178Ball:SetValue(PinballModel.instance._gmball)

	self._act178Toggle = self:addToggle("L7", "解锁所有弹珠科技", self._onAct178ToggleChange, self)
	self._act178Toggle.isOn = PinballModel.instance._gmUnlockAll
	self._act178Toggle2 = self:addToggle("L7", "GM", self._onAct178ToggleChange2, self)
	self._act178Toggle2.isOn = PinballModel.instance._gmkey

	self:addLabel("L8", "弹珠游戏")

	self._act178EpisodeId = self:addInputText("L8", nil, "关卡ID")

	self:addButton("L8", "直接进入弹珠游戏", self._enterAct178Game, self)
	self:addLabel("L9", "2.6 活动")
	self:addButton("L9", "虚构集卡牌ID开关", self._setXugoujiDebugMode, self)
	self:initActivityDrop()

	self._inited = true
end

function GMSubViewActivity:_onAct178DropChange(index)
	PinballModel.instance._gmball = index
end

function GMSubViewActivity:_onAct178ToggleChange()
	PinballModel.instance._gmUnlockAll = self._act178Toggle.isOn
end

function GMSubViewActivity:_onAct178ToggleChange2()
	PinballModel.instance._gmkey = self._act178Toggle2.isOn
end

function GMSubViewActivity:_playAct186Talk()
	local talkId = tonumber(self._act186TalkId:GetText())

	Activity186Controller.instance:dispatchEvent(Activity186Event.PlayTalk, talkId)
	self:closeThis()
end

function GMSubViewActivity:_resetRoleStory()
	local rolestoryId = tonumber(self._rolestoryId:GetText())

	NecrologistStoryRpc.instance:_sendUpdateNecrologistStoryRequest(tonumber(rolestoryId))
	self:closeThis()
end

function GMSubViewActivity:_printRoleStoryFlagKey()
	local rolestoryId = tonumber(self._rolestoryId:GetText())
	local flagKey = self._rolestoryFlagKey:GetText()
	local mo = NecrologistStoryModel.instance:getById(rolestoryId)
	local dict = mo and mo:getPlotSituationTab() or {}
	local flagVal = dict[flagKey] or 0

	GameFacade.showToastString(string.format("%s:%s", flagKey, flagVal))
end

function GMSubViewActivity:_enterAct178Game()
	local episodeId = tonumber(self._act178EpisodeId:GetText())
	local episodeCo = lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][episodeId]

	if not episodeCo then
		GameFacade.showToastString("关卡配置不存在")

		return
	end

	PinballModel.instance.leftEpisodeId = episodeId

	ViewMgr.instance:openView(ViewName.PinballGameView)
end

function GMSubViewActivity:initActivityDrop()
	local activityEnumList = {
		VersionActivity2_4Enum.ActivityId
	}

	self.activityIdList = {}
	self.activityShowStrList = {}

	local allActList = {}

	tabletool.addValues(allActList, VersionActivity2_4Enum.ActivityId)

	self.activityAll = {
		["2_4all"] = allActList
	}

	for _, activityEnum in ipairs(activityEnumList) do
		for _, actId in pairs(activityEnum) do
			if type(actId) == "table" then
				for _, v in pairs(actId) do
					table.insert(self.activityIdList, v)
				end
			else
				table.insert(self.activityIdList, actId)
			end
		end
	end

	for _, activityId in ipairs(self.activityIdList) do
		local activityConfig = lua_activity.configDict[activityId]

		table.insert(self.activityShowStrList, (activityConfig and activityConfig.name or "") .. string.format("(%s)", activityId))
	end

	for k, v in pairs(self.activityAll) do
		table.insert(self.activityIdList, 1, k)
		table.insert(self.activityShowStrList, 1, k)
	end

	self.statusList = {
		ActivityEnum.ActivityStatus.Normal,
		ActivityEnum.ActivityStatus.NotOpen,
		ActivityEnum.ActivityStatus.Expired,
		ActivityEnum.ActivityStatus.NotUnlock,
		ActivityEnum.ActivityStatus.NotOnLine
	}
	self.statusShowStrList = {
		"正常开启状态",
		"未达到开启时间",
		"活动已结束",
		"活动未解锁",
		"活动已下线"
	}
	self.selectActivityIndex = 1
	self.selectStatusIndex = 1

	if self._dropActivity then
		self._dropActivity:ClearOptions()
		self._dropActivityStatus:ClearOptions()
		self._dropActivity:AddOptions(self.activityShowStrList)
		self._dropActivityStatus:AddOptions(self.statusShowStrList)
	end
end

function GMSubViewActivity:_onActivityDropValueChange(index)
	self.selectActivityIndex = index + 1
end

function GMSubViewActivity:_onActivityStatusDropValueChange(index)
	self.selectStatusIndex = index + 1
end

function GMSubViewActivity:_onClickChangeActivityBtn()
	local activityId = self.activityIdList[self.selectActivityIndex or 1]

	if self.activityAll[activityId] then
		for k, v in pairs(self.activityAll[activityId]) do
			self:_changeActivityInfo(v)
		end

		return
	end

	self:_changeActivityInfo(activityId)
end

function GMSubViewActivity:_changeActivityInfo(activityId)
	local status = self.statusList[self.selectStatusIndex or 1]
	local activityInfo = ActivityModel.instance:getActivityInfo()[activityId]
	local existStatus = ActivityHelper.getActivityStatus(activityId)

	if existStatus == status then
		return
	end

	local now = ServerTime.now() * 1000
	local maxTime = TimeUtil.maxDateTimeStamp * 1000

	activityInfo.config = self:copyConfig(activityInfo.config)

	if status == ActivityEnum.ActivityStatus.Normal then
		activityInfo.startTime = now - 1
		activityInfo.endTime = maxTime
		activityInfo.config.openId = 0
		activityInfo.online = true
	elseif status == ActivityEnum.ActivityStatus.NotOpen then
		activityInfo.startTime = maxTime
	elseif status == ActivityEnum.ActivityStatus.Expired then
		activityInfo.startTime = now - 1
		activityInfo.endTime = activityInfo.startTime
	elseif status == ActivityEnum.ActivityStatus.NotUnlock then
		activityInfo.startTime = now - 1
		activityInfo.endTime = maxTime
		activityInfo.config.openId = activityId
		OpenModel.instance._unlocks[activityId] = false
	elseif status == ActivityEnum.ActivityStatus.NotOnLine then
		activityInfo.startTime = now - 1
		activityInfo.endTime = maxTime
		activityInfo.config.openId = 0
		activityInfo.online = false
	end

	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, activityId)
end

function GMSubViewActivity:_onClickResetActivityBtn()
	ActivityRpc.instance:sendGetActivityInfosRequest()
end

function GMSubViewActivity:_onClickResetActivityUnlockAim()
	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))

	VersionActivityBaseController.instance.playedActUnlockAnimationList = nil
end

function GMSubViewActivity:_onClickCheckActivity165Config()
	Activity165Model.instance:GMCheckConfig()
end

function GMSubViewActivity:_onClickPrintActivity165CanRound()
	Activity165Model.instance:setPrintLog(true)
end

function GMSubViewActivity:_onClickEditorAct165Step()
	ViewMgr.instance:openView(ViewName.GMAct165EditView)
end

function GMSubViewActivity:_onClickEditorStartMatch3WarChessInfo_3()
	local levelId = tonumber(self._txtLevelID:GetText())
	local warChessCharacterId = tonumber(self._txtCharacterID:GetText())
	local pieceIds = string.splitToNumber(self._txtSoliderID:GetText(), ",")

	EliminateLevelController.instance:enterLevel(levelId, warChessCharacterId, pieceIds)
end

function GMSubViewActivity:_douQuQuTest()
	ViewMgr.instance:openView(ViewName.FightGMDouQuQuTest)
	self:closeThis()
end

function GMSubViewActivity:_douQuQuTestForceIndexRound()
	local index = tonumber(self.douQuQuStartIndex:GetText())
	local round = tonumber(self.douQuQuStartRound:GetText())

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.GMDouQuQuSkip2IndexRound, index, round)
	else
		FightPlayMgr._onGMDouQuQuSkip2IndexRound(self, index, round)
	end

	self:closeThis()
end

function GMSubViewActivity:_setXugoujiDebugMode()
	local isDebugMode = XugoujiController.instance:isDebugMode()

	XugoujiController.instance:setDebugMode(not isDebugMode)
	PlayerPrefsHelper.setNumber("XugoujiDebugMode", isDebugMode and 0 or 1)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.TurnChanged)
end

function GMSubViewActivity.copyConfig(co)
	local newCo = {}
	local fields = {
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

	for key, value in pairs(fields) do
		newCo[key] = co[key]
	end

	return newCo
end

return GMSubViewActivity
