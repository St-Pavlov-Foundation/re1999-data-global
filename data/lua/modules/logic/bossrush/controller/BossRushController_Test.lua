module("modules.logic.bossrush.controller.BossRushController_Test", package.seeall)

slot0 = class("BossRushController_Test", BaseController)
slot1 = getGlobal("ddd") or SLFramework.SLLogger.Log

function slot0.onInit(slot0)
end

function slot0._test(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = "bossrush"

	if slot1 == "bossrush demo" then
		slot0:_test_demo()

		return
	end

	if slot1 == "bossrush red" then
		slot0:_test_red()

		return
	end

	if slot1 == "bossrush red reset" then
		slot0:_test_red_reset()

		return
	end

	if slot1 == "bossrush" then
		BossRushController.instance:openMainView()

		return
	end

	if tonumber(slot1:sub(#slot2 + 1)) then
		slot0:_test_battle_demo(slot3)
	end
end

function slot0._test_demo(slot0)
	slot2 = BossRushConfig.instance:InfiniteDoubleMaxTimes()
	slot4 = 800000

	function slot6(slot0)
		slot1 = BossRushConfig.instance:getTaskCO(slot0)
		slot3 = slot1.maxProgress
		slot5 = math.random(0, 100) % 2 == 0 and true or false

		if slot2 <= math.random(0, slot1.maxFinishCount) then
			slot5 = false
		end

		return {
			id = slot0,
			finishCount = slot4,
			progress = slot5 and slot3 or math.random(0, slot3),
			hasFinished = slot5,
			expiryTime = math.random(1000, 2000),
			type = math.random(1, 2)
		}
	end

	for slot11, slot12 in pairs(BossRushConfig.instance:getStages()) do
		slot13 = slot12.stage
		({
			[BossRushModel.instance:getActivityId()] = {}
		})[slot3][slot13] = function (slot0)
			slot3 = 0
			slot4 = {}

			for slot8, slot9 in ipairs(BossRushConfig.instance:getStageRewardList(slot0)) do
				if slot9.rewardPointNum <= ({
					bossId = slot0,
					totalPoint = uv0 or math.random(0, 99999),
					hasGetBonusIds = {},
					highestPoint = math.random(0, 99999),
					doubleNum = math.random(0, uv1)
				}).totalPoint then
					slot3 = slot8
					slot4[#slot4 + 1] = slot9.id
				end
			end

			for slot9 = 1, slot3 or math.random(0, slot3) do
				slot2.hasGetBonusIds[slot4[slot9]] = true
			end

			return slot2
		end(slot13)
	end

	function slot8(slot0)
		return tabletool.copy(uv0[uv1][slot0])
	end

	function slot9(slot0)
		slot2 = {}

		for slot6, slot7 in pairs(uv0[uv1][slot0]) do
			slot2[#slot2 + 1] = slot6
		end

		return slot2
	end

	function slot10(slot0)
		slot1 = HeroMo.New()
		slot2 = HeroConfig.instance:getHeroCO(slot0)

		slot1:init({
			heroId = slot0,
			skin = slot2.skinId
		}, slot2)

		return slot1
	end

	function slot11(slot0)
		slot1 = EquipMO.New()

		slot1:init({
			count = 1,
			isLock = false,
			exp = 0,
			uid = math.random(1, 9999999),
			equipId = slot0,
			level = math.random(1, 10),
			breakLv = math.random(1, 2),
			refineLv = math.random(1, 2)
		})

		return slot1
	end

	function slot12(slot0)
		slot1 = slot0.configList

		return slot1[math.random(1, #slot1)].id
	end

	slot13 = 0
	slot14 = FightParam.New()
	slot15 = BossRushController
	slot16 = BossRushRpc
	slot17 = BossRushModel

	function slot16.sendGet128InfosRequest(slot0, slot1)
		slot2 = {
			activityId = uv0,
			bossDetail = {}
		}

		for slot6, slot7 in pairs(uv1) do
			table.insert(slot2.bossDetail, uv2(slot7.stage))
		end

		BossRushRpc.instance:onReceiveGet128InfosReply(uv3, slot2)

		if slot1 then
			slot1()
		end
	end

	function slot16.sendAct128GetTotalRewardsRequest(slot0, slot1)
		slot2 = uv0[uv1][slot1]

		for slot7, slot8 in ipairs(BossRushConfig.instance:getStageRewardList(slot1)) do
			if not slot2.hasGetBonusIds[slot8.id] and slot8.rewardPointNum <= slot2.totalPoint then
				slot2.hasGetBonusIds[slot8.id] = true
			end
		end

		BossRushRpc.instance:onReceiveAct128GetTotalRewardsReply(uv3, {
			activityId = uv1,
			bossId = slot1,
			hasGetBonusIds = uv2(slot1)
		})
	end

	function slot16.sendAct128DoublePointRequest(slot0, slot1)
		slot2 = uv0[uv1][slot1]
		slot3 = math.random(10000, 200000)
		slot2.totalPoint = slot2.totalPoint + slot3
		slot4 = slot2.doubleNum + 1
		slot2.doubleNum = slot4

		BossRushRpc.instance:onReceiveAct128DoublePointReply(uv2, {
			activityId = uv1,
			bossId = slot1,
			doublePoint = slot3,
			totalPoint = slot2.totalPoint,
			doubleNum = slot4
		})
	end

	function slot17.getRealStartTimeStamp(slot0)
		return os.time()
	end

	function slot17.getRealEndTimeStamp(slot0)
		return os.time() + 2000
	end

	function slot17.getRemainTimeStr(slot0)
		return "xxxx"
	end

	function slot17.isBossLayerOpen(slot0, slot1, slot2)
		return true
	end

	function slot17.isActOnLine(slot0)
		return true
	end

	function slot15.sendGetTaskInfoRequest(slot0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function slot15.enterFightScene(slot0, slot1, slot2)
		function uv0.getBattleStageAndLayer(slot0)
			return uv0, uv1
		end

		BossRushController.instance:openResultPanel()
	end

	function slot15.isInBossRushInfiniteFight(slot0)
		return true
	end

	function TaskModel.getTaskMoList(slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(BossRushConfig.instance:getAllTaskList()) do
			slot9 = uv0(slot7.id)
			slot2[#slot2 + 1] = {
				id = slot9.id,
				progress = slot9.progress,
				hasFinished = slot9.hasFinished,
				finishCount = slot9.finishCount,
				config = slot7
			}
		end

		return slot2
	end

	function slot17.getBattleStageAndLayer(slot0)
		return 1, 3
	end

	slot18 = 1000000

	function slot17.getFightScore(slot0)
		slot1, slot2 = BossRushModel.instance:getBattleStageAndLayer()

		if BossRushConfig.instance:getBattleMaxPoints(slot1, slot2) == 0 then
			slot3 = math.max(0, 99999999999.0)
		end

		return uv0 or math.random(0, slot3)
	end

	function FightModel.getFightParam(slot0)
		return uv0
	end

	function slot17.getStageScore(slot0)
		slot1 = {}

		for slot6 = 1, math.random(3, 5) do
			slot1[#slot1 + 1] = math.random(1000, 999999)
		end

		return slot1
	end

	function slot17.setStageLastTotalPoint(slot0, slot1, slot2)
	end

	slot19 = 0
	slot20 = 4

	function FightParam.getAllHeroMoList(slot0)
		slot1 = {}
		uv0 = (uv0 + 1) % uv1

		for slot6 = 0, uv0 do
			table.insert(slot1, uv3(uv2(_G.lua_character)))
		end

		return slot1
	end

	function FightParam.getEquipMoList(slot0)
		for slot6 = 1, math.random(1, 4) do
		end

		return {
			[slot6] = uv1(uv0(_G.lua_equip))
		}
	end

	function PlayerModel.getPlayinfo(slot0)
		return {
			portrait = 0,
			name = "123456"
		}
	end

	function ResUrl.getPlayerHeadIcon()
		return string.format("singlebg/playerheadicon/%s.png", 170000 + math.random(1, 5))
	end

	function slot17.isBossOnline()
		return true
	end

	function slot17.getLastPointInfo(slot0)
		return {
			cur = 0,
			max = 2500000
		}
	end

	function V1a4_BossRushMainViewContainer.onContainerInit(slot0)
	end

	BossRushController.instance:openMainView(nil, true)
end

function slot0._test_battle_demo(slot0, slot1)
	if not lua_battle.configDict[slot1] then
		logError("battleId not exist" .. tostring(slot1))

		return
	end

	HeroGroupModel.instance:setParam(slot1, nil, )

	if not HeroGroupModel.instance:getCurGroupMO() then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	slot4, slot5 = slot3:getMainList()
	slot6, slot7 = slot3:getSubList()
	slot8 = slot3:getAllHeroEquips()
	slot9 = FightController.instance:setFightParamByBattleId(slot1)
	slot10 = DungeonEnum.ChapterType

	for slot14, slot15 in ipairs(lua_episode.configList) do
		if slot15.battleId == slot1 then
			slot16 = slot15.id

			if DungeonConfig.instance:getChapterCO(slot15.chapterId).type == slot10.BossRushNormal or slot19 == slot10.BossRushInfinite then
				slot9.chapterId = slot17
				slot9.episodeId = slot16
				FightResultModel.instance.episodeId = slot16

				DungeonModel.instance:SetSendChapterEpisodeId(slot17, slot16)

				break
			end
		end
	end

	if not slot9.chapterId then
		logError("invalid battleid: " .. tostring(slot1))

		return
	end

	slot9:setMySide(slot3.clothId, slot4, slot6, slot8)
	FightController.instance:sendTestFightId(slot9)
end

function slot0._test_red(slot0)
	slot1 = RedDotEnum.DotNode
	slot3 = ""

	for slot8, slot9 in pairs(RedDotModel.instance._dotInfos or {}) do
		if ({
			[slot1.BossRushEnter] = "BossRushEnter(活动入口Root)",
			[slot1.BossRushOpen] = "BossRushOpen(新功能开启)",
			[slot1.BossRushBoss] = "BossRushBoss(Boss Root)",
			[slot1.BossRushNewBoss] = "BossRushNewBoss(新boss解锁)",
			[slot1.BossRushNewLayer] = "BossRushNewLayer(新难度解锁)",
			[slot1.BossRushBossReward] = "BossRushBossReward(奖励可领取Root)",
			[slot1.BossRushBossSchedule] = "BossRushBossSchedule(累计奖励可领)",
			[slot1.BossRushBossAchievement] = "BossRushBossAchievement(成就奖励可领)"
		})[slot8] then
			-- Nothing
		end
	end

	for slot8, slot9 in pairs({
		[slot8] = slot9
	}) do
		slot11 = slot8

		for slot17, slot18 in pairs(slot9.infos) do
			slot19 = slot18.value
			slot20 = ""
			slot21 = ""
			slot22 = ""
			slot22 = (slot8 == slot1.BossRushBossSchedule or slot8 == slot1.BossRushBossAchievement) and " <color=#FF00FF>(tingjie)</color>" or "(<color=#FFFF00>" .. tostring(BossRushRedModel.instance:_get(slot11, slot17, BossRushRedModel.instance:getDefaultValue(slot11))) .. "</color>)"
			slot12 = "(" .. tostring(slot8) .. ")" .. slot2[slot8] .. ":" .. "\n\t" .. (slot8 == slot1.BossRushNewLayer and "uid" .. slot22 .. ": " .. tostring(slot17) .. string.format("[%s-%s]", math.modf(slot17 / 1000), math.modf(slot17 % 1000)) or "uid" .. slot22 .. ": " .. tostring(slot17)) .. (slot19 > 0 and " (<color=#00FF00>" .. tostring(slot19) .. "</color>)" or " (" .. tostring(slot19) .. ")")
		end

		if slot3 ~= "" then
			slot3 = slot3 .. "\n"
		end

		slot3 = slot3 .. slot12
	end

	if slot3 == "" then
		slot3 = "BossRush red data is NULL!!"
	end

	uv0("\n" .. slot3)
end

function slot0._test_red_reset(slot0)
	slot1 = RedDotEnum.DotNode

	for slot6, slot7 in pairs(BossRushConfig.instance:getStages()) do
		slot8 = slot7.stage

		BossRushRedModel.instance:_deleteByDSL(slot1.BossRushOpen, slot8)

		slot13 = slot8

		BossRushRedModel.instance:_deleteByDSL(slot1.BossRushNewBoss, slot13)

		for slot13, slot14 in pairs(BossRushConfig.instance:getEpisodeStages(slot8)) do
			BossRushRedModel.instance:_deleteByDSL(slot1.BossRushNewLayer, slot8, slot14.layer)
		end
	end

	UnityEngine.PlayerPrefs.Save()
	BossRushRedModel.instance:_reload()
end

function slot0._v1a6Enter(slot0)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_EnterView)

	slot1 = V1a6_BossRush_EnterView
	slot3 = BossRushRpc

	function slot1._btnUnOpenOnClick(slot0)
		uv0.instance:_test_demo()
	end

	function slot1._btnNormalOnClick(slot0)
		uv0.instance:_test_demo()
	end

	function BossRushModel.getEvaluateList(slot0)
		slot1 = {}

		for slot5 = 1, 10 do
			table.insert(slot1, slot5)
		end

		return slot1
	end

	function BossRushConfig.getEvaluateInfo(slot0, slot1)
		return "测试标题—" .. slot1, "测试评价—" .. slot1
	end

	function V1a6_BossRush_StoreModel.checkStoreNewGoods(slot0)
		return true
	end

	function FightParam.getHeroEquipMoList(slot0)
		slot1 = {}

		for slot7, slot8 in pairs(uv0.getAllHeroMoList()) do
			table.insert(slot1, {
				heroMo = slot8,
				equipMo = uv0.getEquipMoList()[slot7]
			})
		end

		return slot1
	end
end

slot0.instance = slot0.New()

return slot0
