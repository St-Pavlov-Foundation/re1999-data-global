module("modules.logic.bossrush.controller.BossRushController_Test", package.seeall)

local var_0_0 = class("BossRushController_Test", BaseController)
local var_0_1 = getGlobal("ddd") or SLFramework.SLLogger.Log

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0._test(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = "bossrush"

	if arg_2_1 == "bossrush demo" then
		arg_2_0:_test_demo()

		return
	end

	if arg_2_1 == "bossrush red" then
		arg_2_0:_test_red()

		return
	end

	if arg_2_1 == "bossrush red reset" then
		arg_2_0:_test_red_reset()

		return
	end

	if arg_2_1 == "bossrush" then
		BossRushController.instance:openMainView()

		return
	end

	local var_2_1 = tonumber(arg_2_1:sub(#var_2_0 + 1))

	if var_2_1 then
		arg_2_0:_test_battle_demo(var_2_1)
	end
end

function var_0_0._test_demo(arg_3_0)
	local var_3_0 = BossRushConfig.instance:getStages()
	local var_3_1 = BossRushConfig.instance:InfiniteDoubleMaxTimes()
	local var_3_2 = BossRushModel.instance:getActivityId()
	local var_3_3 = 800000

	local function var_3_4(arg_4_0)
		local var_4_0 = BossRushConfig.instance:getStageRewardList(arg_4_0)
		local var_4_1 = {
			bossId = arg_4_0,
			totalPoint = var_3_3 or math.random(0, 99999),
			hasGetBonusIds = {},
			highestPoint = math.random(0, 99999),
			doubleNum = math.random(0, var_3_1)
		}
		local var_4_2 = 0
		local var_4_3 = {}

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			if var_4_1.totalPoint >= iter_4_1.rewardPointNum then
				var_4_2 = iter_4_0
				var_4_3[#var_4_3 + 1] = iter_4_1.id
			end
		end

		local var_4_4 = var_4_2 or math.random(0, var_4_2)

		for iter_4_2 = 1, var_4_4 do
			local var_4_5 = var_4_3[iter_4_2]

			var_4_1.hasGetBonusIds[var_4_5] = true
		end

		return var_4_1
	end

	local function var_3_5(arg_5_0)
		local var_5_0 = BossRushConfig.instance:getTaskCO(arg_5_0)
		local var_5_1 = var_5_0.maxFinishCount
		local var_5_2 = var_5_0.maxProgress
		local var_5_3 = math.random(0, var_5_1)
		local var_5_4 = math.random(0, 100) % 2 == 0 and true or false

		if var_5_1 <= var_5_3 then
			var_5_4 = false
		end

		local var_5_5 = var_5_4 and var_5_2 or math.random(0, var_5_2)

		return {
			id = arg_5_0,
			finishCount = var_5_3,
			progress = var_5_5,
			hasFinished = var_5_4,
			expiryTime = math.random(1000, 2000),
			type = math.random(1, 2)
		}
	end

	local var_3_6 = {
		[var_3_2] = {}
	}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_7 = iter_3_1.stage

		var_3_6[var_3_2][var_3_7] = var_3_4(var_3_7)
	end

	local function var_3_8(arg_6_0)
		return tabletool.copy(var_3_6[var_3_2][arg_6_0])
	end

	local function var_3_9(arg_7_0)
		local var_7_0 = var_3_6[var_3_2][arg_7_0]
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			var_7_1[#var_7_1 + 1] = iter_7_0
		end

		return var_7_1
	end

	local function var_3_10(arg_8_0)
		local var_8_0 = HeroMo.New()
		local var_8_1 = HeroConfig.instance:getHeroCO(arg_8_0)
		local var_8_2 = {
			heroId = arg_8_0,
			skin = var_8_1.skinId
		}

		var_8_0:init(var_8_2, var_8_1)

		return var_8_0
	end

	local function var_3_11(arg_9_0)
		local var_9_0 = EquipMO.New()
		local var_9_1 = {
			count = 1,
			isLock = false,
			exp = 0,
			uid = math.random(1, 9999999),
			equipId = arg_9_0,
			level = math.random(1, 10),
			breakLv = math.random(1, 2),
			refineLv = math.random(1, 2)
		}

		var_9_0:init(var_9_1)

		return var_9_0
	end

	local function var_3_12(arg_10_0)
		local var_10_0 = arg_10_0.configList

		return var_10_0[math.random(1, #var_10_0)].id
	end

	local var_3_13 = 0
	local var_3_14 = FightParam.New()
	local var_3_15 = BossRushController
	local var_3_16 = BossRushRpc
	local var_3_17 = BossRushModel

	function var_3_16.sendGet128InfosRequest(arg_11_0, arg_11_1)
		local var_11_0 = {
			activityId = var_3_2,
			bossDetail = {}
		}

		for iter_11_0, iter_11_1 in pairs(var_3_0) do
			local var_11_1 = iter_11_1.stage

			table.insert(var_11_0.bossDetail, var_3_8(var_11_1))
		end

		BossRushRpc.instance:onReceiveGet128InfosReply(var_3_13, var_11_0)

		if arg_11_1 then
			arg_11_1()
		end
	end

	function var_3_16.sendAct128GetTotalRewardsRequest(arg_12_0, arg_12_1)
		local var_12_0 = var_3_6[var_3_2][arg_12_1]
		local var_12_1 = BossRushConfig.instance:getStageRewardList(arg_12_1)

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			if not var_12_0.hasGetBonusIds[iter_12_1.id] and var_12_0.totalPoint >= iter_12_1.rewardPointNum then
				var_12_0.hasGetBonusIds[iter_12_1.id] = true
			end
		end

		local var_12_2 = {
			activityId = var_3_2,
			bossId = arg_12_1,
			hasGetBonusIds = var_3_9(arg_12_1)
		}

		BossRushRpc.instance:onReceiveAct128GetTotalRewardsReply(var_3_13, var_12_2)
	end

	function var_3_16.sendAct128DoublePointRequest(arg_13_0, arg_13_1)
		local var_13_0 = var_3_6[var_3_2][arg_13_1]
		local var_13_1 = math.random(10000, 200000)

		var_13_0.totalPoint = var_13_0.totalPoint + var_13_1

		local var_13_2 = var_13_0.doubleNum + 1

		var_13_0.doubleNum = var_13_2

		local var_13_3 = {
			activityId = var_3_2,
			bossId = arg_13_1,
			doublePoint = var_13_1,
			totalPoint = var_13_0.totalPoint,
			doubleNum = var_13_2
		}

		BossRushRpc.instance:onReceiveAct128DoublePointReply(var_3_13, var_13_3)
	end

	function var_3_17.getRealStartTimeStamp(arg_14_0)
		return os.time()
	end

	function var_3_17.getRealEndTimeStamp(arg_15_0)
		return os.time() + 2000
	end

	function var_3_17.getRemainTimeStr(arg_16_0)
		return "xxxx"
	end

	function var_3_17.isBossLayerOpen(arg_17_0, arg_17_1, arg_17_2)
		return true
	end

	function var_3_17.isActOnLine(arg_18_0)
		return true
	end

	function var_3_15.sendGetTaskInfoRequest(arg_19_0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function var_3_15.enterFightScene(arg_20_0, arg_20_1, arg_20_2)
		function var_3_17.getBattleStageAndLayer(arg_21_0)
			return arg_20_1, arg_20_2
		end

		BossRushController.instance:openResultPanel()
	end

	function var_3_15.isInBossRushInfiniteFight(arg_22_0)
		return true
	end

	function TaskModel.getTaskMoList(arg_23_0)
		local var_23_0 = BossRushConfig.instance:getAllTaskList()
		local var_23_1 = {}

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			local var_23_2 = iter_23_1.id
			local var_23_3 = var_3_5(var_23_2)

			var_23_1[#var_23_1 + 1] = {
				id = var_23_3.id,
				progress = var_23_3.progress,
				hasFinished = var_23_3.hasFinished,
				finishCount = var_23_3.finishCount,
				config = iter_23_1
			}
		end

		return var_23_1
	end

	function var_3_17.getBattleStageAndLayer(arg_24_0)
		return 1, 3
	end

	local var_3_18 = 1000000

	function var_3_17.getFightScore(arg_25_0)
		local var_25_0, var_25_1 = BossRushModel.instance:getBattleStageAndLayer()
		local var_25_2 = BossRushConfig.instance:getBattleMaxPoints(var_25_0, var_25_1)

		if var_25_2 == 0 then
			var_25_2 = math.max(0, 99999999999)
		end

		return var_3_18 or math.random(0, var_25_2)
	end

	function FightModel.getFightParam(arg_26_0)
		return var_3_14
	end

	function var_3_17.getStageScore(arg_27_0)
		local var_27_0 = {}
		local var_27_1 = math.random(3, 5)

		for iter_27_0 = 1, var_27_1 do
			var_27_0[#var_27_0 + 1] = math.random(1000, 999999)
		end

		return var_27_0
	end

	function var_3_17.setStageLastTotalPoint(arg_28_0, arg_28_1, arg_28_2)
		return
	end

	local var_3_19 = 0
	local var_3_20 = 4

	function FightParam.getAllHeroMoList(arg_29_0)
		local var_29_0 = {}
		local var_29_1 = var_3_19

		var_3_19 = (var_3_19 + 1) % var_3_20

		for iter_29_0 = 0, var_29_1 do
			local var_29_2 = var_3_12(_G.lua_character)

			table.insert(var_29_0, var_3_10(var_29_2))
		end

		return var_29_0
	end

	function FightParam.getEquipMoList(arg_30_0)
		local var_30_0 = {}
		local var_30_1 = math.random(1, 4)

		for iter_30_0 = 1, var_30_1 do
			local var_30_2 = var_3_12(_G.lua_equip)

			var_30_0[iter_30_0] = var_3_11(var_30_2)
		end

		return var_30_0
	end

	function PlayerModel.getPlayinfo(arg_31_0)
		return {
			portrait = 0,
			name = "123456"
		}
	end

	function ResUrl.getPlayerHeadIcon()
		local var_32_0 = 170000 + math.random(1, 5)

		return string.format("singlebg/playerheadicon/%s.png", var_32_0)
	end

	function var_3_17.isBossOnline()
		return true
	end

	function var_3_17.getLastPointInfo(arg_34_0)
		return {
			cur = 0,
			max = 2500000
		}
	end

	function V1a4_BossRushMainViewContainer.onContainerInit(arg_35_0)
		return
	end

	BossRushController.instance:openMainView(nil, true)
end

function var_0_0._test_battle_demo(arg_36_0, arg_36_1)
	if not lua_battle.configDict[arg_36_1] then
		logError("battleId not exist" .. tostring(arg_36_1))

		return
	end

	HeroGroupModel.instance:setParam(arg_36_1, nil, nil)

	local var_36_0 = HeroGroupModel.instance:getCurGroupMO()

	if not var_36_0 then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local var_36_1, var_36_2 = var_36_0:getMainList()
	local var_36_3, var_36_4 = var_36_0:getSubList()
	local var_36_5 = var_36_0:getAllHeroEquips()
	local var_36_6 = FightController.instance:setFightParamByBattleId(arg_36_1)
	local var_36_7 = DungeonEnum.ChapterType

	for iter_36_0, iter_36_1 in ipairs(lua_episode.configList) do
		if iter_36_1.battleId == arg_36_1 then
			local var_36_8 = iter_36_1.id
			local var_36_9 = iter_36_1.chapterId
			local var_36_10 = DungeonConfig.instance:getChapterCO(var_36_9).type

			if var_36_10 == var_36_7.BossRushNormal or var_36_10 == var_36_7.BossRushInfinite then
				var_36_6.chapterId = var_36_9
				var_36_6.episodeId = var_36_8
				FightResultModel.instance.episodeId = var_36_8

				DungeonModel.instance:SetSendChapterEpisodeId(var_36_9, var_36_8)

				break
			end
		end
	end

	if not var_36_6.chapterId then
		logError("invalid battleid: " .. tostring(arg_36_1))

		return
	end

	var_36_6:setMySide(var_36_0.clothId, var_36_1, var_36_3, var_36_5)
	FightController.instance:sendTestFightId(var_36_6)
end

function var_0_0._test_red(arg_37_0)
	local var_37_0 = RedDotEnum.DotNode
	local var_37_1 = {
		[var_37_0.BossRushEnter] = "BossRushEnter(活动入口Root)",
		[var_37_0.BossRushOpen] = "BossRushOpen(新功能开启)",
		[var_37_0.BossRushBoss] = "BossRushBoss(Boss Root)",
		[var_37_0.BossRushNewBoss] = "BossRushNewBoss(新boss解锁)",
		[var_37_0.BossRushNewLayer] = "BossRushNewLayer(新难度解锁)",
		[var_37_0.BossRushBossReward] = "BossRushBossReward(奖励可领取Root)",
		[var_37_0.BossRushBossSchedule] = "BossRushBossSchedule(累计奖励可领)",
		[var_37_0.BossRushBossAchievement] = "BossRushBossAchievement(成就奖励可领)"
	}
	local var_37_2 = ""
	local var_37_3 = {}

	for iter_37_0, iter_37_1 in pairs(RedDotModel.instance._dotInfos or {}) do
		if var_37_1[iter_37_0] then
			var_37_3[iter_37_0] = iter_37_1
		end
	end

	for iter_37_2, iter_37_3 in pairs(var_37_3) do
		local var_37_4 = var_37_1[iter_37_2]
		local var_37_5 = iter_37_2
		local var_37_6 = "(" .. tostring(iter_37_2) .. ")" .. var_37_4 .. ":"
		local var_37_7 = iter_37_3.infos

		for iter_37_4, iter_37_5 in pairs(var_37_7) do
			local var_37_8 = iter_37_5.value
			local var_37_9 = ""
			local var_37_10 = ""
			local var_37_11 = ""
			local var_37_12

			if iter_37_2 == var_37_0.BossRushBossSchedule or iter_37_2 == var_37_0.BossRushBossAchievement then
				var_37_12 = " <color=#FF00FF>(tingjie)</color>"
			else
				local var_37_13 = BossRushRedModel.instance:getDefaultValue(var_37_5)
				local var_37_14 = BossRushRedModel.instance:_get(var_37_5, iter_37_4, var_37_13)

				var_37_12 = "(<color=#FFFF00>" .. tostring(var_37_14) .. "</color>)"
			end

			if var_37_8 > 0 then
				var_37_9 = " (<color=#00FF00>" .. tostring(var_37_8) .. "</color>)"
			else
				var_37_9 = " (" .. tostring(var_37_8) .. ")"
			end

			if iter_37_2 == var_37_0.BossRushNewLayer then
				local var_37_15 = math.modf(iter_37_4 / 1000)
				local var_37_16 = math.modf(iter_37_4 % 1000)

				var_37_10 = "uid" .. var_37_12 .. ": " .. tostring(iter_37_4) .. string.format("[%s-%s]", var_37_15, var_37_16)
			else
				var_37_10 = "uid" .. var_37_12 .. ": " .. tostring(iter_37_4)
			end

			var_37_6 = var_37_6 .. "\n\t" .. var_37_10 .. var_37_9
		end

		if var_37_2 ~= "" then
			var_37_2 = var_37_2 .. "\n"
		end

		var_37_2 = var_37_2 .. var_37_6
	end

	if var_37_2 == "" then
		var_37_2 = "BossRush red data is NULL!!"
	end

	var_0_1("\n" .. var_37_2)
end

function var_0_0._test_red_reset(arg_38_0)
	local var_38_0 = RedDotEnum.DotNode
	local var_38_1 = BossRushConfig.instance:getStages()

	for iter_38_0, iter_38_1 in pairs(var_38_1) do
		local var_38_2 = iter_38_1.stage

		BossRushRedModel.instance:_deleteByDSL(var_38_0.BossRushOpen, var_38_2)
		BossRushRedModel.instance:_deleteByDSL(var_38_0.BossRushNewBoss, var_38_2)

		local var_38_3 = BossRushConfig.instance:getEpisodeStages(var_38_2)

		for iter_38_2, iter_38_3 in pairs(var_38_3) do
			local var_38_4 = iter_38_3.layer

			BossRushRedModel.instance:_deleteByDSL(var_38_0.BossRushNewLayer, var_38_2, var_38_4)
		end
	end

	UnityEngine.PlayerPrefs.Save()
	BossRushRedModel.instance:_reload()
end

function var_0_0._v1a6Enter(arg_39_0)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_EnterView)

	local var_39_0 = V1a6_BossRush_EnterView
	local var_39_1 = V1a6_BossRush_StoreModel
	local var_39_2 = BossRushRpc
	local var_39_3 = BossRushConfig
	local var_39_4 = BossRushModel
	local var_39_5 = FightParam

	function var_39_0._btnUnOpenOnClick(arg_40_0)
		var_0_0.instance:_test_demo()
	end

	function var_39_0._btnNormalOnClick(arg_41_0)
		var_0_0.instance:_test_demo()
	end

	function var_39_4.getEvaluateList(arg_42_0)
		local var_42_0 = {}

		for iter_42_0 = 1, 10 do
			table.insert(var_42_0, iter_42_0)
		end

		return var_42_0
	end

	function var_39_3.getEvaluateInfo(arg_43_0, arg_43_1)
		local var_43_0 = "测试标题—" .. arg_43_1
		local var_43_1 = "测试评价—" .. arg_43_1

		return var_43_0, var_43_1
	end

	function var_39_1.checkStoreNewGoods(arg_44_0)
		return true
	end

	function var_39_5.getHeroEquipMoList(arg_45_0)
		local var_45_0 = {}
		local var_45_1 = var_39_5.getEquipMoList()
		local var_45_2 = var_39_5.getAllHeroMoList()

		for iter_45_0, iter_45_1 in pairs(var_45_2) do
			table.insert(var_45_0, {
				heroMo = iter_45_1,
				equipMo = var_45_1[iter_45_0]
			})
		end

		return var_45_0
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
