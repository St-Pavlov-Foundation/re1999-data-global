module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6GameModel", package.seeall)

local var_0_0 = class("LengZhou6GameModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0._round = 0
	arg_1_0._enemySettleCount = 1
	arg_1_0._battleModel = LengZhou6Enum.BattleModel.normal
	arg_1_0._recordServerData = nil
	arg_1_0._endlessBattleProgress = nil
	arg_1_0._isFirstEnterLayer = true
end

function var_0_0.enterLevel(arg_2_0, arg_2_1)
	arg_2_0._isFirstEnterLayer = true
	arg_2_0._episodeConfig = arg_2_1
	arg_2_0._levelId = arg_2_1.episodeId

	arg_2_0:setBattleModel(arg_2_1.type)

	if arg_2_1.type == LengZhou6Enum.BattleModel.infinite then
		arg_2_0:initSelectSkillId()

		if arg_2_0._recordServerData == nil then
			arg_2_0._recordServerData = RecordServerDataMO.New()
		end
	end

	local var_2_0 = LengZhou6Model.instance:getEpisodeInfoMo(arg_2_1.episodeId)

	if var_2_0 ~= nil and not string.nilorempty(var_2_0.progress) then
		arg_2_0._recordServerData:initFormJson(var_2_0.progress)
		arg_2_0:initByServerData()
	else
		arg_2_0:initByConfig(arg_2_1)

		if arg_2_1.type == LengZhou6Enum.BattleModel.infinite then
			arg_2_0:setEndLessBattleProgress(LengZhou6Enum.BattleProgress.selectSkill)
		end
	end

	arg_2_0._lineEliminateRate = 0

	arg_2_0:setCurGameStep(LengZhou6Enum.BattleStep.gameBegin)
end

function var_0_0.initByConfig(arg_3_0, arg_3_1)
	arg_3_0._playerEntity = PlayerEntity.New()

	local var_3_0 = arg_3_1.masterId

	if var_3_0 then
		arg_3_0:initPlayer(var_3_0)
	end

	arg_3_0:_initEnemyByConfig(arg_3_1)

	arg_3_0._round = arg_3_1.maxRound

	if arg_3_0:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		arg_3_0._round = arg_3_0:calRound()
	end
end

function var_0_0._initEnemyByConfig(arg_4_0, arg_4_1)
	arg_4_0._enemyEntity = EnemyEntity.New()

	local var_4_0 = string.splitToNumber(arg_4_1.enemyId, "#")
	local var_4_1 = var_4_0[1] == 1 and var_4_0[2] or arg_4_0:calEnemyId()

	if var_4_1 then
		arg_4_0:initEnemy(var_4_1)

		local var_4_2 = arg_4_0:calEnemyHpUp()

		arg_4_0._enemyEntity:setHp(var_4_2 + arg_4_0._enemyEntity:getHp())
	end
end

function var_0_0.initByServerData(arg_5_0)
	if arg_5_0._recordServerData ~= nil then
		local var_5_0 = arg_5_0._recordServerData:getData()

		arg_5_0._round = var_5_0.round
		arg_5_0._playerEntity = PlayerEntity.New()

		local var_5_1 = var_5_0.playerId

		if var_5_1 then
			arg_5_0:initPlayer(var_5_1, var_5_0.playerSkillList)

			if var_5_0.playerSkillList ~= nil then
				for iter_5_0 = 1, #var_5_0.playerSkillList do
					arg_5_0:setPlayerSelectSkillId(iter_5_0, var_5_0.playerSkillList[iter_5_0])
				end
			end

			arg_5_0._playerEntity:setHp(var_5_0.playerHp)
		end

		local var_5_2 = var_5_0.enemyConfigId

		if var_5_2 then
			LengZhou6Config.instance:recordEnemyLastRandomId(var_5_0.endLessLayer)
			LengZhou6Config.instance:setSelectEnemyRandomId(var_5_0.endLessLayer, var_5_2)

			arg_5_0._enemyEntity = EnemyEntity.New()

			arg_5_0:initEnemy(var_5_2)
			arg_5_0._enemyEntity:setHp(var_5_0.enemyHp)
			arg_5_0._enemyEntity:setActionStepIndexAndRound(var_5_0.curActionStepIndex, var_5_0.skillRound)
		end

		arg_5_0._round = var_5_0.round

		arg_5_0:setEndLessModelLayer(var_5_0.endLessLayer)
		arg_5_0:setEndLessBattleProgress(var_5_0.endLessBattleProgress)

		if var_5_0.endLessLayer ~= LengZhou6Enum.DefaultEndLessBeginRound or var_5_0.endLessBattleProgress ~= LengZhou6Enum.BattleProgress.selectSkill then
			arg_5_0._isFirstEnterLayer = false
		end
	end
end

function var_0_0.getRecordServerData(arg_6_0)
	return arg_6_0._recordServerData
end

function var_0_0.initPlayer(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._playerEntity:init(arg_7_1)

	if arg_7_2 ~= nil then
		arg_7_0._playerEntity:resetData(arg_7_2)
	end
end

function var_0_0.initEnemy(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._enemyEntity:init(arg_8_1)
end

function var_0_0.getBattleModel(arg_9_0)
	return arg_9_0._battleModel
end

function var_0_0.setBattleModel(arg_10_0, arg_10_1)
	arg_10_0._battleModel = arg_10_1
end

function var_0_0.getEpisodeConfig(arg_11_0)
	return arg_11_0._episodeConfig
end

function var_0_0.getPlayer(arg_12_0)
	return arg_12_0._playerEntity
end

function var_0_0.getEnemy(arg_13_0)
	return arg_13_0._enemyEntity
end

function var_0_0.changeRound(arg_14_0, arg_14_1)
	arg_14_0._round = math.max(arg_14_0._round + arg_14_1, 0)

	LengZhou6StatHelper.instance:updateRound()
end

function var_0_0.getCurRound(arg_15_0)
	return arg_15_0._round
end

function var_0_0.gameIsOver(arg_16_0)
	if arg_16_0._enemyEntity == nil or arg_16_0._playerEntity == nil then
		return false
	end

	return arg_16_0._round == 0 or arg_16_0._enemyEntity:getHp() <= 0 or arg_16_0._playerEntity:getHp() <= 0
end

function var_0_0.playerIsWin(arg_17_0)
	if arg_17_0._enemyEntity == nil then
		return false
	end

	return arg_17_0._enemyEntity:getHp() <= 0 and arg_17_0._playerEntity:getHp() > 0 and arg_17_0._round > 0
end

function var_0_0.enemySettle(arg_18_0)
	return
end

local var_0_1 = "\n"

function var_0_0.getTotalPlayerSettle(arg_19_0)
	local var_19_0 = 0
	local var_19_1 = 0

	if arg_19_0._playerTempDamages ~= nil then
		for iter_19_0 = 1, #arg_19_0._playerTempDamages do
			local var_19_2 = 1 + arg_19_0._lineEliminateRate * (iter_19_0 - 1)
			local var_19_3 = arg_19_0._playerTempDamages[iter_19_0] * var_19_2

			var_19_0 = var_19_0 + var_19_3

			if isDebugBuild then
				var_0_1 = var_0_1 .. "消除第 " .. iter_19_0 .. " 次 连消伤害：" .. var_19_3 .. " = " .. arg_19_0._playerTempDamages[iter_19_0] .. " * " .. var_19_2 .. "\n"
			end
		end
	end

	if arg_19_0._playerTempHps ~= nil then
		for iter_19_1 = 1, #arg_19_0._playerTempHps do
			var_19_1 = var_19_1 + arg_19_0._playerTempHps[iter_19_1]
		end
	end

	if isDebugBuild then
		var_0_1 = var_0_1 .. "消除伤害总值：" .. math.floor(var_19_0) .. "\n"

		logNormal(var_0_1)

		var_0_1 = "\n"

		logNormal("消除治疗总值：" .. math.floor(var_19_1))
	end

	return math.floor(var_19_0), math.floor(var_19_1)
end

function var_0_0.setLineEliminateRate(arg_20_0, arg_20_1)
	arg_20_0._lineEliminateRate = arg_20_1
end

function var_0_0.clearTempData(arg_21_0)
	if arg_21_0._playerTempDamages == nil or arg_21_0._playerTempHps == nil then
		return
	end

	tabletool.clear(arg_21_0._playerTempDamages)
	tabletool.clear(arg_21_0._playerTempHps)
end

function var_0_0._playerSettle(arg_22_0)
	local var_22_0 = LocalEliminateChessModel.instance:getCurEliminateRecordData()
	local var_22_1 = arg_22_0._playerEntity:calDamage(var_22_0)
	local var_22_2 = arg_22_0._playerEntity:calTreatment(var_22_0)

	return var_22_1, var_22_2
end

function var_0_0.playerSettle(arg_23_0)
	var_0_0.instance:setCurGameStep(LengZhou6Enum.BattleStep.calHpBefore)

	local var_23_0, var_23_1 = arg_23_0:_playerSettle()

	var_0_0.instance:setCurGameStep(LengZhou6Enum.BattleStep.calHpAfter)

	if arg_23_0._playerTempDamages == nil then
		arg_23_0._playerTempDamages = {}
	end

	table.insert(arg_23_0._playerTempDamages, var_23_0)

	if arg_23_0._playerTempHps == nil then
		arg_23_0._playerTempHps = {}
	end

	table.insert(arg_23_0._playerTempHps, var_23_1)
end

function var_0_0.addBuffIdToEntity(arg_24_0)
	return
end

function var_0_0.setEnemySettleCount(arg_25_0, arg_25_1)
	arg_25_0._enemySettleCount = arg_25_1
end

function var_0_0.getEnemySettleCount(arg_26_0)
	return arg_26_0._enemySettleCount
end

function var_0_0.resetEnemySettleCount(arg_27_0)
	arg_27_0:setEnemySettleCount(1)
end

function var_0_0.triggerPlayerBuffOrSkill(arg_28_0)
	if arg_28_0._playerEntity then
		arg_28_0._playerEntity:triggerBuffAndSkill()
	end

	if arg_28_0._enemyEntity then
		arg_28_0._enemyEntity:triggerBuffAndSkill()
	end
end

function var_0_0.setCurGameStep(arg_29_0, arg_29_1)
	arg_29_0._curGameStep = arg_29_1

	arg_29_0:triggerPlayerBuffOrSkill()
end

function var_0_0.getCurGameStep(arg_30_0)
	return arg_30_0._curGameStep
end

function var_0_0.getCurEliminateSpEliminateCount(arg_31_0, arg_31_1)
	local var_31_0 = LocalEliminateChessModel.instance:getCurEliminateRecordData():getEliminateTypeMap()
	local var_31_1 = 0

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		if iter_31_0 == arg_31_1 then
			for iter_31_2 = 1, #iter_31_1 do
				local var_31_2 = iter_31_1[iter_31_2].spEliminateCount

				if var_31_2 ~= nil then
					var_31_1 = var_31_1 + var_31_2
				end
			end
		end
	end

	return var_31_1
end

function var_0_0.clear(arg_32_0)
	arg_32_0._endLessModelLayer = nil
	arg_32_0._isFirstEnterLayer = true
	arg_32_0._episodeConfig = nil
	arg_32_0._playerEntity = nil
	arg_32_0._enemyEntity = nil
	arg_32_0._round = 0
	arg_32_0._enemySettleCount = 1
	arg_32_0._playerTempDamages = nil
	arg_32_0._playerTempHps = nil
	arg_32_0._recordServerData = nil
	arg_32_0._recordLayerId = nil
	arg_32_0._playerSelectSkillIds = nil

	LengZhou6Config.instance:clearLevelCache()
end

function var_0_0.setEndLessModelLayer(arg_33_0, arg_33_1)
	arg_33_0._endLessModelLayer = arg_33_1
end

function var_0_0.getEndLessModelLayer(arg_34_0)
	return arg_34_0._endLessModelLayer or 1
end

function var_0_0.setEndLessBattleProgress(arg_35_0, arg_35_1)
	arg_35_0._endlessBattleProgress = arg_35_1

	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.OnEndlessChangeSelectState)
end

function var_0_0.getEndLessBattleProgress(arg_36_0)
	return arg_36_0._endlessBattleProgress
end

function var_0_0.calEnemyId(arg_37_0)
	local var_37_0 = arg_37_0:getEndLessModelLayer() or 1
	local var_37_1 = LengZhou6Config.instance:getEliminateBattleCost(9)

	if var_37_0 <= var_37_1 then
		local var_37_2 = LengZhou6Config.instance:getEnemyRandomIdsConfig(var_37_0)

		if var_37_2 then
			local var_37_3 = var_37_2[math.random(1, #var_37_2)]

			LengZhou6Config.instance:setSelectEnemyRandomId(var_37_0, var_37_3)

			return var_37_3
		else
			return LengZhou6Enum.defaultEnemy
		end
	end

	local var_37_4 = var_37_0 - var_37_1

	if arg_37_0._recordLayerId == nil then
		arg_37_0._recordLayerId = {}
	end

	local var_37_5 = math.ceil(var_37_4 / 5)

	if arg_37_0._recordLayerId[var_37_5] == nil then
		local var_37_6 = LengZhou6Config.instance:getEliminateBattleCostStr(16)
		local var_37_7 = string.splitToNumber(var_37_6, "#")

		if var_37_7 then
			arg_37_0._recordLayerId[var_37_5] = var_37_7[math.random(1, #var_37_7)]
		end
	end

	return arg_37_0._recordLayerId[var_37_5]
end

function var_0_0.initSelectSkillId(arg_38_0)
	if arg_38_0._playerSelectSkillIds == nil then
		arg_38_0._playerSelectSkillIds = {}
	end
end

function var_0_0.getSelectSkillIdList(arg_39_0)
	local var_39_0 = {}

	if arg_39_0._playerSelectSkillIds ~= nil then
		for iter_39_0, iter_39_1 in pairs(arg_39_0._playerSelectSkillIds) do
			table.insert(var_39_0, iter_39_1)
		end
	end

	return var_39_0
end

function var_0_0.getSelectSkillId(arg_40_0)
	return arg_40_0._playerSelectSkillIds
end

function var_0_0.isSelectSkill(arg_41_0, arg_41_1)
	if arg_41_0._playerSelectSkillIds == nil then
		return false
	end

	for iter_41_0, iter_41_1 in pairs(arg_41_0._playerSelectSkillIds) do
		if iter_41_1 == arg_41_1 then
			return true
		end
	end

	return false
end

function var_0_0.resetSelectSkillId(arg_42_0)
	if arg_42_0._playerSelectSkillIds then
		tabletool.clear(arg_42_0._playerSelectSkillIds)
	end
end

function var_0_0.setPlayerSelectSkillId(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_0._playerSelectSkillIds == nil then
		arg_43_0._playerSelectSkillIds = {}
	end

	arg_43_0._playerSelectSkillIds[arg_43_1] = arg_43_2
end

function var_0_0.calRound(arg_44_0)
	local var_44_0 = arg_44_0:getBattleModel()
	local var_44_1 = arg_44_0:getEndLessModelLayer() or 1

	if var_44_0 == LengZhou6Enum.BattleModel.normal or var_44_1 == 0 then
		return arg_44_0._round
	end

	local var_44_2 = arg_44_0._round or 0
	local var_44_3 = LengZhou6Config.instance:getEliminateBattleCost(6)
	local var_44_4 = LengZhou6Config.instance:getEliminateBattleCost(7)
	local var_44_5 = LengZhou6Config.instance:getEliminateBattleCost(8)
	local var_44_6 = var_44_1 - 1

	if var_44_6 ~= 0 then
		var_44_2 = var_44_2 + (var_44_6 % var_44_5 == 0 and var_44_4 or var_44_3)
	end

	return var_44_2
end

function var_0_0.getSkillEffectUp(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0:getBattleModel()
	local var_45_1 = arg_45_0:getEndLessModelLayer() or 1

	if var_45_0 == LengZhou6Enum.BattleModel.normal or var_45_1 == 0 then
		return 0
	end

	local var_45_2 = math.min(arg_45_0:getEndLessModelLayer() or 1, LengZhou6Config.instance:getEliminateBattleCost(9))
	local var_45_3 = LengZhou6Config.instance:getEliminateBattleEndlessMode(var_45_2)

	return var_45_3 and var_45_3[arg_45_1] or 0
end

function var_0_0.calEnemyHpUp(arg_46_0)
	local var_46_0 = arg_46_0:getBattleModel()
	local var_46_1 = arg_46_0:getEndLessModelLayer() or 1

	if var_46_0 == LengZhou6Enum.BattleModel.normal or var_46_1 == 0 then
		return 0
	end

	local var_46_2 = LengZhou6Config.instance:getEliminateBattleCost(9)

	if var_46_1 > 0 and var_46_1 <= var_46_2 then
		return LengZhou6Config.instance:getEliminateBattleEndlessMode(var_46_1).hp
	end

	local var_46_3 = LengZhou6Config.instance:getEliminateBattleEndlessMode(var_46_2).hp
	local var_46_4 = LengZhou6Config.instance:getEliminateBattleCost(10)
	local var_46_5 = LengZhou6Config.instance:getEliminateBattleCost(11)

	for iter_46_0 = 1, var_46_1 - var_46_2 do
		var_46_3 = var_46_3 + (iter_46_0 % 5 == 0 and var_46_5 or var_46_4)
	end

	return var_46_3
end

function var_0_0.enterNextLayer(arg_47_0)
	if arg_47_0._playerEntity then
		local var_47_0 = var_0_0.instance:getSelectSkillIdList()

		arg_47_0._playerEntity:resetData(var_47_0)
	end

	local var_47_1 = arg_47_0:getEndLessModelLayer()

	if arg_47_0._isFirstEnterLayer then
		arg_47_0:setEndLessModelLayer(LengZhou6Enum.DefaultEndLessBeginRound)

		arg_47_0._isFirstEnterLayer = false
	else
		LocalEliminateChessModel.instance:createInitMoveState()
		arg_47_0:setEndLessModelLayer(var_47_1 + 1)
		arg_47_0:_initEnemyByConfig(arg_47_0._episodeConfig)
	end

	if arg_47_0:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		arg_47_0._round = arg_47_0:calRound()
	end

	arg_47_0:setCurGameStep(LengZhou6Enum.BattleStep.gameBegin)
	var_0_0.instance:setEndLessBattleProgress(LengZhou6Enum.BattleProgress.selectFinish)
end

function var_0_0.recordChessData(arg_48_0)
	local var_48_0 = LocalEliminateChessModel.instance:getInitData()

	if arg_48_0._recordServerData and var_48_0 ~= nil then
		arg_48_0._recordServerData:record(var_48_0)
	end
end

function var_0_0.canSelectSkill(arg_49_0)
	if var_0_0.instance:getEndLessModelLayer() % LengZhou6Enum.EndLessChangeSkillLayer == 0 then
		return true
	end

	return false
end

function var_0_0.isFirstEnterLayer(arg_50_0)
	return arg_50_0._isFirstEnterLayer
end

var_0_0.instance = var_0_0.New()

return var_0_0
