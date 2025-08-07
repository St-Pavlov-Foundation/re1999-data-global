module("modules.logic.sp01.assassin2.outside.model.AssassinStealthGameModel", package.seeall)

local var_0_0 = class("AssassinStealthGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearAll()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
	arg_2_0:setMapPosRecordOnFight()
	arg_2_0:setMapPosRecordOnTurn()
	arg_2_0:setIsShowHeroHighlight(true)
end

function var_0_0.clearAll(arg_3_0)
	arg_3_0:clear()
	arg_3_0:clearData()
end

function var_0_0.clearData(arg_4_0)
	arg_4_0:clearPickHeroData()
	arg_4_0:clearStealthGameData()
	arg_4_0:setIsFightReturn()
end

function var_0_0.clearPickHeroData(arg_5_0)
	arg_5_0._pickHeroList = {}
	arg_5_0._pickHeroDict = {}
end

function var_0_0.clearStealthGameData(arg_6_0)
	arg_6_0._missionData = {}
	arg_6_0._heroDict = {}
	arg_6_0._enemyDict = {}
	arg_6_0._gridDict = {}
	arg_6_0._gridInteractiveDict = {}
	arg_6_0._grid2EntityDict = {}

	arg_6_0:setMapId()
	arg_6_0:setRound()
	arg_6_0:setEvent()
	arg_6_0:setSelectedHero()
	arg_6_0:setSelectedEnemy()
	arg_6_0:setIsPlayerTurn(true)
	arg_6_0:setGameState()
	arg_6_0:setAlertLevel()
	arg_6_0:setSelectedSkillProp()
	arg_6_0:setGameRequestData()
	arg_6_0:setEnemyOperationData()
end

function var_0_0.addHeroPick(arg_7_0, arg_7_1)
	table.insert(arg_7_0._pickHeroList, arg_7_1)
	arg_7_0:_updatePickHeroDict()
end

function var_0_0.removeHeroPick(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getHeroPickIndex(arg_8_1)

	table.remove(arg_8_0._pickHeroList, var_8_0)
	arg_8_0:_updatePickHeroDict()
end

function var_0_0._updatePickHeroDict(arg_9_0)
	arg_9_0._pickHeroDict = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._pickHeroList) do
		arg_9_0._pickHeroDict[iter_9_1] = iter_9_0
	end
end

function var_0_0.initGameSceneData(arg_10_0, arg_10_1)
	arg_10_0:clearStealthGameData()
	arg_10_0:setMapId(arg_10_1.mapId)
	arg_10_0:setRound(arg_10_1.round)
	arg_10_0:setEvent(arg_10_1.currentEventId)
	arg_10_0:setGridDataByList(arg_10_1.grids)
	arg_10_0:addHeroDataByList(arg_10_1.heros)
	arg_10_0:addEnemyDataByList(arg_10_1.monsters)
	arg_10_0:setMissionData(arg_10_1.mission)
	arg_10_0:setInteractiveList(arg_10_1.interactives)

	local var_10_0 = #arg_10_1.battleGridIds

	if arg_10_1.nextRound ~= 0 or var_10_0 > 0 then
		arg_10_0:setIsPlayerTurn(false)
	else
		arg_10_0:setIsPlayerTurn(true)
	end

	arg_10_0:setGameRequestData(arg_10_1.battleGridIds, arg_10_1.nextRound, arg_10_1.changingMapId)
	arg_10_0:setGameState(arg_10_1.state)
	arg_10_0:setAlertLevel(arg_10_1.alertLevel)
	arg_10_0:setEnemyMoveDir(arg_10_1.direction)
end

function var_0_0.updateGameSceneDataOnNewRound(arg_11_0, arg_11_1)
	arg_11_0:setMapId(arg_11_1.mapId)
	arg_11_0:setRound(arg_11_1.round)
	arg_11_0:setEvent(arg_11_1.currentEventId)
	arg_11_0:setGridDataByList(arg_11_1.grids)
	arg_11_0:updateHeroDataByList(arg_11_1.heros)
	arg_11_0:updateEnemyDataByList(arg_11_1.monsters)
	arg_11_0:setMissionData(arg_11_1.mission)
	arg_11_0:setInteractiveList(arg_11_1.interactives)
	arg_11_0:setGameRequestData(arg_11_1.battleGridIds, arg_11_1.nextRound, arg_11_1.changingMapId)
	arg_11_0:setGameState(arg_11_1.state)
	arg_11_0:setAlertLevel(arg_11_1.alertLevel)
	arg_11_0:setEnemyMoveDir(arg_11_1.direction)
end

function var_0_0._addEntity2GridDict(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_2 then
		var_12_0 = arg_12_0:getEnemyMo(arg_12_1, true)
	else
		var_12_0 = arg_12_0:getHeroMo(arg_12_1, true)
	end

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0:getUid()
	local var_12_2, var_12_3 = var_12_0:getPos()
	local var_12_4 = arg_12_0:getGridPointEntity(var_12_2, var_12_3)

	if var_12_4 then
		logWarn(string.format(" AssassinStealthGameModel:_addEntity2GridDict error, pos has entity, gridId:%s, pointIndex:%s, oldUid:%s, newUid:%s", var_12_2, var_12_3, var_12_4, var_12_1))
	end

	local var_12_5 = arg_12_0._grid2EntityDict[var_12_2]

	if not var_12_5 then
		var_12_5 = {}
		arg_12_0._grid2EntityDict[var_12_2] = var_12_5
	end

	var_12_5[var_12_3] = {
		uid = var_12_1,
		isEnemy = arg_12_2 and true or false
	}
end

function var_0_0._removeEntity2GridDict(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getGridPointEntity(arg_13_2, arg_13_3)

	if not var_13_0 or var_13_0 ~= arg_13_1 then
		logWarn(string.format("AssassinStealthGameModel:_removeEntity2GridDict error, uid not same, gridId:%s, pointIndex:%s, posUid:%s, targetUid:%s", arg_13_2, arg_13_3, var_13_0, arg_13_1))

		return
	end

	arg_13_0._grid2EntityDict[arg_13_2][arg_13_3] = nil
end

function var_0_0._changeGrid2EntityDict(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if not arg_14_1 then
		return
	end

	arg_14_0:_removeEntity2GridDict(arg_14_1, arg_14_2, arg_14_3)
	arg_14_0:_addEntity2GridDict(arg_14_1, arg_14_4)
end

function var_0_0.setMapId(arg_15_0, arg_15_1)
	arg_15_0._mapId = arg_15_1
end

function var_0_0.setRound(arg_16_0, arg_16_1)
	arg_16_0._round = arg_16_1
end

function var_0_0.setEvent(arg_17_0, arg_17_1)
	arg_17_0._eventId = arg_17_1
end

function var_0_0.setEnemyMoveDir(arg_18_0, arg_18_1)
	arg_18_0._enemyMoveDir = arg_18_1
end

function var_0_0.setGridDataByList(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		arg_19_0:setGridData(iter_19_1)
	end
end

function var_0_0.setGridData(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.gridId
	local var_20_1 = arg_20_0:getGridMo(var_20_0)

	if not var_20_1 then
		var_20_1 = AssassinStealthGameGridMO.New()
		arg_20_0._gridDict[var_20_0] = var_20_1
	end

	var_20_1:updateData(arg_20_1)
end

function var_0_0.addHeroDataByList(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		arg_21_0:addHeroData(iter_21_1)
	end
end

function var_0_0.addHeroData(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.uid

	if arg_22_0:getHeroMo(var_22_0) then
		return
	end

	local var_22_1 = AssassinStealthGameHeroMO.New()

	var_22_1:updateData(arg_22_1)

	arg_22_0._heroDict[var_22_0] = var_22_1

	arg_22_0:_addEntity2GridDict(var_22_0, false)
end

function var_0_0.updateHeroDataByList(arg_23_0, arg_23_1)
	if not arg_23_1 then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		arg_23_0:updateHeroData(iter_23_1)
	end
end

function var_0_0.updateHeroData(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.uid
	local var_24_1 = arg_24_0:getHeroMo(var_24_0, true)

	if var_24_1 then
		local var_24_2, var_24_3 = var_24_1:getPos()

		var_24_1:updateData(arg_24_1)
		arg_24_0:_changeGrid2EntityDict(var_24_0, var_24_2, var_24_3, false)
	else
		logError(string.format("AssassinStealthGameModel:updateHeroData error, no heroMo, uid:%s", var_24_0))
	end
end

function var_0_0.removeHeroData(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getHeroMo(arg_25_1)

	if var_25_0 then
		local var_25_1, var_25_2 = var_25_0:getPos()

		arg_25_0:_removeEntity2GridDict(arg_25_1, var_25_1, var_25_2)
	end

	arg_25_0._heroDict[arg_25_1] = nil
end

function var_0_0.setSelectedHero(arg_26_0, arg_26_1)
	arg_26_0._selectedHero = arg_26_1
end

function var_0_0.addEnemyDataByList(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		arg_27_0:addEnemyData(iter_27_1)
	end
end

function var_0_0.addEnemyData(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.uid

	if arg_28_0:getEnemyMo(var_28_0) then
		return
	end

	local var_28_1 = AssassinStealthGameEnemyMO.New()

	var_28_1:updateData(arg_28_1)

	arg_28_0._enemyDict[var_28_0] = var_28_1

	arg_28_0:_addEntity2GridDict(var_28_0, true)
end

function var_0_0.updateEnemyDataByList(arg_29_0, arg_29_1)
	if not arg_29_1 then
		return
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		arg_29_0:updateEnemyData(iter_29_1)
	end
end

function var_0_0.updateEnemyData(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1.uid
	local var_30_1 = arg_30_0:getEnemyMo(var_30_0)

	if var_30_1 then
		local var_30_2, var_30_3 = var_30_1:getPos()

		var_30_1:updateData(arg_30_1)
		arg_30_0:_changeGrid2EntityDict(var_30_0, var_30_2, var_30_3, true)
	else
		logError(string.format("AssassinStealthGameModel:updateEnemyData error, no enemyMo, uid:%s", var_30_0))
	end
end

function var_0_0.updateEnemyPos(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_0:getEnemyMo(arg_31_1, true)

	if var_31_0 then
		local var_31_1, var_31_2 = var_31_0:getPos()

		var_31_0:updatePos(arg_31_2, arg_31_3)
		arg_31_0:_changeGrid2EntityDict(arg_31_1, var_31_1, var_31_2, true)
	else
		logError(string.format("AssassinStealthGameModel:updateEnemyPos error, no enemyMo, uid:%s", arg_31_1))
	end
end

function var_0_0.removeEnemyData(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:getEnemyMo(arg_32_1)

	if var_32_0 then
		local var_32_1, var_32_2 = var_32_0:getPos()

		arg_32_0:_removeEntity2GridDict(arg_32_1, var_32_1, var_32_2)
	end

	arg_32_0._enemyDict[arg_32_1] = nil
end

function var_0_0.setSelectedEnemy(arg_33_0, arg_33_1)
	arg_33_0._selectedEnemy = arg_33_1
end

function var_0_0.setMissionData(arg_34_0, arg_34_1)
	arg_34_0._missionData.id = arg_34_1.id
	arg_34_0._missionData.progress = arg_34_1.progress
	arg_34_0._missionData.targetProgress = arg_34_1.targetProgress
end

function var_0_0.setInteractiveList(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		arg_35_0:setInteractiveData(iter_35_1)
	end
end

function var_0_0.setInteractiveData(arg_36_0, arg_36_1)
	local var_36_0 = AssassinConfig.instance:getInteractGridId(arg_36_1)

	arg_36_0._gridInteractiveDict[var_36_0] = arg_36_1
end

function var_0_0.setFinishedInteractive(arg_37_0, arg_37_1)
	local var_37_0 = AssassinConfig.instance:getInteractGridId(arg_37_1)

	arg_37_0._gridInteractiveDict[var_37_0] = nil
end

function var_0_0.setIsPlayerTurn(arg_38_0, arg_38_1)
	arg_38_0._isPlayerTurn = arg_38_1
end

function var_0_0.setGameState(arg_39_0, arg_39_1)
	arg_39_0._gameState = arg_39_1
end

function var_0_0.setAlertLevel(arg_40_0, arg_40_1)
	arg_40_0._alterLevel = arg_40_1
end

function var_0_0.setSelectedSkillProp(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0._selectedSkillProp = arg_41_1
	arg_41_0._isSkill = arg_41_2 and true or false
end

function var_0_0.setGameRequestData(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	arg_42_0._battleGridIds = arg_42_1
	arg_42_0._nextRound = arg_42_2
	arg_42_0._changingMapId = arg_42_3
end

function var_0_0.setIsFightReturn(arg_43_0, arg_43_1)
	arg_43_0._isFightReturn = arg_43_1
end

function var_0_0.setMapPosRecordOnFight(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	arg_44_0._fightRecordMapPosX = arg_44_1
	arg_44_0._fightRecordMapPosY = arg_44_2
	arg_44_0._fightRecordMapScale = arg_44_3
end

function var_0_0.setMapPosRecordOnTurn(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	arg_45_0._turnRecordMapPosX = arg_45_1
	arg_45_0._turnRecordMapPosY = arg_45_2
	arg_45_0._turnRecordMapScale = arg_45_3
end

function var_0_0.setIsShowHeroHighlight(arg_46_0, arg_46_1)
	arg_46_0._isShowHeroHl = arg_46_1
end

function var_0_0.setEnemyOperationData(arg_47_0, arg_47_1)
	arg_47_0._enemyOperationData = arg_47_1
end

function var_0_0.getHeroPickIndex(arg_48_0, arg_48_1)
	return arg_48_0._pickHeroDict[arg_48_1]
end

function var_0_0.getPickHeroCount(arg_49_0)
	return #arg_49_0._pickHeroList
end

function var_0_0.getPickHeroList(arg_50_0)
	return arg_50_0._pickHeroList
end

function var_0_0.getMapId(arg_51_0)
	if not arg_51_0._mapId then
		logError("AssassinStealthGameModel:getMapId error, mapId is nil")
	end

	return arg_51_0._mapId
end

function var_0_0.getMissionId(arg_52_0)
	return arg_52_0._missionData.id
end

function var_0_0.getMissionProgress(arg_53_0)
	return arg_53_0._missionData.progress, arg_53_0._missionData.targetProgress
end

function var_0_0.getHeroMo(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = arg_54_0._heroDict[arg_54_1]

	if not var_54_0 and arg_54_2 then
		logError(string.format("AssassinStealthGameModel:getHeroMo error, heroMo is nil, uid:%s", arg_54_1))
	end

	return var_54_0
end

function var_0_0.getHeroUidByAssassinHeroId(arg_55_0, arg_55_1)
	if arg_55_0._heroDict then
		for iter_55_0, iter_55_1 in pairs(arg_55_0._heroDict) do
			if iter_55_1:getHeroId() == arg_55_1 then
				return iter_55_0
			end
		end
	end
end

function var_0_0.getEnemyMo(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_0._enemyDict[arg_56_1]

	if not var_56_0 and arg_56_2 then
		logError(string.format("AssassinStealthGameModel:getEnemyMo error, enemyMo is nil, uid:%s", arg_56_1))
	end

	return var_56_0
end

function var_0_0.getGridMo(arg_57_0, arg_57_1)
	return arg_57_0._gridDict[arg_57_1]
end

local function var_0_1(arg_58_0, arg_58_1)
	local var_58_0 = var_0_0.instance:isSelectedHero(arg_58_0)
	local var_58_1 = var_0_0.instance:isSelectedHero(arg_58_1)

	if var_58_0 ~= var_58_1 then
		return var_58_1
	end

	return arg_58_0 < arg_58_1
end

function var_0_0.getHeroUidList(arg_59_0)
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in pairs(arg_59_0._heroDict) do
		local var_59_1 = iter_59_1:getUid()

		var_59_0[#var_59_0 + 1] = var_59_1
	end

	table.sort(var_59_0, var_0_1)

	return var_59_0
end

function var_0_0.getEnemyUidList(arg_60_0)
	local var_60_0 = {}

	for iter_60_0, iter_60_1 in pairs(arg_60_0._enemyDict) do
		local var_60_1 = iter_60_1:getUid()

		var_60_0[#var_60_0 + 1] = var_60_1
	end

	return var_60_0
end

function var_0_0.getSelectedHero(arg_61_0)
	return arg_61_0._selectedHero
end

function var_0_0.getSelectedHeroGameMo(arg_62_0)
	local var_62_0 = arg_62_0:getSelectedHero()

	return arg_62_0:getHeroMo(var_62_0)
end

function var_0_0.isSelectedHero(arg_63_0, arg_63_1)
	return arg_63_0._selectedHero == arg_63_1
end

function var_0_0.getSelectedEnemy(arg_64_0)
	return arg_64_0._selectedEnemy
end

function var_0_0.getSelectedEnemyGameMo(arg_65_0)
	local var_65_0 = arg_65_0:getSelectedEnemy()

	return arg_65_0:getEnemyMo(var_65_0)
end

function var_0_0.isSelectedEnemy(arg_66_0, arg_66_1)
	return arg_66_0._selectedEnemy == arg_66_1
end

function var_0_0.getRound(arg_67_0)
	return arg_67_0._round
end

function var_0_0.isPlayerTurn(arg_68_0)
	return arg_68_0._isPlayerTurn
end

function var_0_0.getEventId(arg_69_0)
	return arg_69_0._eventId
end

function var_0_0.getEnemyMoveDir(arg_70_0)
	return arg_70_0._enemyMoveDir
end

function var_0_0.isAlertBellRing(arg_71_0)
	return arg_71_0._alterLevel and arg_71_0._alterLevel > 0
end

function var_0_0.getGridInteractId(arg_72_0, arg_72_1)
	return arg_72_0._gridInteractiveDict and arg_72_0._gridInteractiveDict[arg_72_1]
end

function var_0_0.isQTEInteractGrid(arg_73_0, arg_73_1)
	return arg_73_0:getGridInteractId(arg_73_1) and true or false
end

function var_0_0.getGridAllEntityList(arg_74_0, arg_74_1)
	local var_74_0 = {}
	local var_74_1 = arg_74_0._grid2EntityDict[arg_74_1]

	if var_74_1 then
		for iter_74_0, iter_74_1 in pairs(var_74_1) do
			local var_74_2 = {
				uid = iter_74_1.uid,
				isEnemy = iter_74_1.isEnemy
			}

			var_74_0[#var_74_0 + 1] = var_74_2
		end
	end

	return var_74_0
end

function var_0_0.getGridEntityIdList(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
	local var_75_0 = {}
	local var_75_1 = arg_75_0._grid2EntityDict[arg_75_1]

	if var_75_1 then
		arg_75_2 = arg_75_2 and true or false

		for iter_75_0, iter_75_1 in pairs(var_75_1) do
			local var_75_2 = iter_75_1.uid

			if arg_75_2 == iter_75_1.isEnemy and var_75_2 ~= arg_75_3 then
				var_75_0[#var_75_0 + 1] = var_75_2
			end
		end
	end

	return var_75_0
end

function var_0_0.getGridPointEntity(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0
	local var_76_1
	local var_76_2 = arg_76_0._grid2EntityDict[arg_76_1]
	local var_76_3 = var_76_2 and var_76_2[arg_76_2]

	if var_76_3 then
		var_76_0 = var_76_3.uid
		var_76_1 = var_76_3.isEnemy
	end

	return var_76_0, var_76_1
end

function var_0_0.getGridEmptyPointIndex(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_0:getMapId()
	local var_77_1 = arg_77_0:getGridMo(arg_77_1)
	local var_77_2 = var_77_1 and var_77_1:getTracePointIndex()
	local var_77_3 = AssassinConfig.instance:getGridMaxPointCount()

	for iter_77_0 = 1, var_77_3 do
		local var_77_4 = AssassinConfig.instance:getGridPointType(var_77_0, arg_77_1, iter_77_0)

		if var_77_2 ~= iter_77_0 and var_77_4 == AssassinEnum.StealthGamePointType.Empty and not arg_77_0:getGridPointEntity(arg_77_1, iter_77_0) then
			return iter_77_0
		end
	end
end

function var_0_0.isHasAliveEnemy(arg_78_0, arg_78_1)
	local var_78_0 = false
	local var_78_1 = arg_78_0:getGridEntityIdList(arg_78_1, true)

	for iter_78_0, iter_78_1 in ipairs(var_78_1) do
		if not AssassinStealthGameHelper.isDeadEnemy(iter_78_1) then
			var_78_0 = true

			break
		end
	end

	return var_78_0
end

function var_0_0.getExposeRate(arg_79_0, arg_79_1)
	local var_79_0 = AssassinEnum.StealthConst.MinExposeRate
	local var_79_1 = AssassinEnum.StealthConst.MaxExposeRate
	local var_79_2 = arg_79_0:getEventId()
	local var_79_3 = AssassinConfig.instance:getEventType(var_79_2)
	local var_79_4 = arg_79_0:getGridMo(arg_79_1)
	local var_79_5 = var_79_4 and var_79_4:hasTrapType(AssassinEnum.StealGameTrapType.Smog)

	if var_79_3 == AssassinEnum.EventType.NotExpose or var_79_5 then
		return var_79_0
	end

	local var_79_6 = arg_79_0:getMapId()

	if AssassinConfig.instance:getGridIsEasyExpose(var_79_6, arg_79_1) then
		return var_79_1 * AssassinEnum.StealthConst.ShowExposeRatePoint
	end

	local var_79_7 = var_79_0

	if var_79_3 == AssassinEnum.EventType.ChangExposeRate then
		local var_79_8 = tonumber(AssassinConfig.instance:getEventParam(var_79_2))

		var_79_7 = var_79_8 and var_79_8 / AssassinEnum.StealthConst.ConfigExposeRatePoint or var_79_0
	end

	local var_79_9 = var_79_1
	local var_79_10 = arg_79_0:getGridEntityIdList(arg_79_1, true)

	for iter_79_0, iter_79_1 in ipairs(var_79_10) do
		local var_79_11 = arg_79_0:getEnemyMo(iter_79_1)
		local var_79_12 = var_79_11 and var_79_11:getExposeRate()

		if var_79_12 then
			var_79_9 = var_79_9 * (var_79_1 - Mathf.Clamp(var_79_12 + var_79_7, var_79_0, var_79_1))

			if var_79_9 == var_79_0 then
				break
			end
		end
	end

	return (var_79_1 - var_79_9) * AssassinEnum.StealthConst.ShowExposeRatePoint
end

function var_0_0.getGameState(arg_80_0)
	return arg_80_0._gameState
end

function var_0_0.getHeroSkillPropList(arg_81_0, arg_81_1)
	local var_81_0 = {}
	local var_81_1 = arg_81_0:getHeroMo(arg_81_1, true)

	if var_81_1 then
		local var_81_2 = var_81_1:getActiveSkillId()

		if var_81_2 then
			var_81_0[#var_81_0 + 1] = {
				isSkill = true,
				id = var_81_2
			}
		end

		local var_81_3 = var_81_1:getItemIdList()

		for iter_81_0, iter_81_1 in ipairs(var_81_3) do
			var_81_0[#var_81_0 + 1] = {
				isSkill = false,
				id = iter_81_1
			}
		end
	end

	return var_81_0
end

function var_0_0.getSelectedSkillProp(arg_82_0)
	return arg_82_0._selectedSkillProp, arg_82_0._isSkill
end

function var_0_0.getBattleGridIds(arg_83_0)
	return arg_83_0._battleGridIds
end

function var_0_0.getNeedNextRound(arg_84_0)
	return arg_84_0._nextRound
end

function var_0_0.getNeedChangingMap(arg_85_0)
	return arg_85_0._changingMapId
end

function var_0_0.getIsNeedRequest(arg_86_0)
	local var_86_0, var_86_1 = arg_86_0:getMissionProgress()

	if var_86_1 <= var_86_0 then
		return true
	end

	local var_86_2 = arg_86_0:getNeedChangingMap()

	if var_86_2 and var_86_2 ~= 0 then
		return true
	end

	local var_86_3 = arg_86_0:getBattleGridIds()

	if var_86_3 and var_86_3[1] then
		return true
	end

	local var_86_4 = arg_86_0:getNeedNextRound()

	if var_86_4 and var_86_4 ~= 0 then
		return true
	end
end

function var_0_0.getIsFightReturn(arg_87_0)
	return arg_87_0._isFightReturn
end

function var_0_0.getMapPosRecordOnFight(arg_88_0)
	return arg_88_0._fightRecordMapPosX, arg_88_0._fightRecordMapPosY, arg_88_0._fightRecordMapScale
end

function var_0_0.getMapPosRecordOnTurn(arg_89_0)
	return arg_89_0._turnRecordMapPosX, arg_89_0._turnRecordMapPosY, arg_89_0._turnRecordMapScale
end

function var_0_0.getIsShowHeroHighlight(arg_90_0)
	return arg_90_0._isShowHeroHl
end

function var_0_0.getEnemyOperationData(arg_91_0)
	return arg_91_0._enemyOperationData
end

function var_0_0.getHasEnemyOperation(arg_92_0)
	local var_92_0 = arg_92_0:getEnemyOperationData()

	if var_92_0 then
		local var_92_1 = var_92_0.summons and #var_92_0.summons > 0
		local var_92_2 = var_92_0.attacks and #var_92_0.attacks > 0
		local var_92_3 = var_92_0.moves and #var_92_0.moves > 0
		local var_92_4 = var_92_0.hero and #var_92_0.hero > 0
		local var_92_5 = var_92_0.battleGrids and #var_92_0.battleGrids > 0

		if var_92_1 or var_92_2 or var_92_3 or var_92_4 or var_92_5 then
			return true
		end

		local var_92_6 = arg_92_0:getHeroUidList()

		for iter_92_0, iter_92_1 in ipairs(var_92_6) do
			if AssassinStealthGameHelper.isHeroCanBeScan(iter_92_1) then
				local var_92_7 = arg_92_0:getHeroMo(iter_92_1, true):getPos()

				if AssassinStealthGameHelper.isGridEnemyWillScan(var_92_7) then
					return true
				end
			end
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
