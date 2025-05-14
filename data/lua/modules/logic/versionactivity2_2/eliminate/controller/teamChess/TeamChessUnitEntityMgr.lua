module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.TeamChessUnitEntityMgr", package.seeall)

local var_0_0 = class("TeamChessUnitEntityMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._entitys = {}
	arg_1_0.emptyEntity = {}
end

function var_0_0.addEntity(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getUid()

	if arg_2_0._entitys[var_2_0] then
		return arg_2_0._entitys[var_2_0]
	end

	local var_2_1 = gohelper.create3d(arg_2_2, var_2_0)
	local var_2_2

	if arg_2_1.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		var_2_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_1, TeamChessPlayerSoldierUnit)
	end

	if arg_2_1.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		var_2_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_1, TeamChessEnemySoldierUnit)
	end

	if var_2_2 == nil then
		logError("TeamChessUnitEntityMgr:addEntity entity is nil.. type: " .. arg_2_1.teamType)

		var_2_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_1, TeamChessSoldierUnit)
	end

	var_2_2:updateMo(arg_2_1)

	arg_2_0._entitys[var_2_0] = var_2_2

	return var_2_2
end

function var_0_0.getEmptyEntity(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = EliminateConfig.instance:getSoldierChessModelPath(arg_3_2)

	if arg_3_0.emptyEntity[var_3_0] then
		return arg_3_0.emptyEntity[var_3_0]
	end

	if gohelper.isNil(arg_3_1) then
		return nil
	end

	local var_3_1 = gohelper.create3d(arg_3_1, "tempEmpty")
	local var_3_2 = EliminateConfig.instance:getSoldierChessConfig(arg_3_2)
	local var_3_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_1, TeamChessEmptyUnit)

	var_3_3:init(var_3_1)
	var_3_3:setScale(var_3_2.resZoom)
	var_3_3:setPath(var_3_0)

	arg_3_0.emptyEntity[var_3_0] = var_3_3

	return var_3_3
end

function var_0_0.setAllEmptyEntityActive(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.emptyEntity) do
		if iter_4_1 then
			iter_4_1:setActive(arg_4_1)
		end
	end
end

function var_0_0.getEntity(arg_5_0, arg_5_1)
	return arg_5_0._entitys[arg_5_1]
end

function var_0_0.getAllEntity(arg_6_0)
	return arg_6_0._entitys
end

function var_0_0.removeEntity(arg_7_0, arg_7_1)
	if arg_7_0._entitys[arg_7_1] then
		arg_7_0._entitys[arg_7_1]:dispose()

		arg_7_0._entitys[arg_7_1] = nil
	end
end

function var_0_0.setAllEntityActive(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._entitys) do
		if iter_8_1 then
			if arg_8_1 then
				iter_8_1:updatePosByTr()
			end

			iter_8_1:setActive(arg_8_1)
		end
	end
end

function var_0_0.setAllEntityActiveAndPlayAni(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._entitys) do
		if iter_9_1 then
			if arg_9_1 then
				iter_9_1:updatePosByTr()
			end

			iter_9_1:setActiveAndPlayAni(arg_9_1)
		end
	end
end

function var_0_0.setAllEntityCanClick(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._entitys) do
		if iter_10_1 then
			iter_10_1:setCanClick(arg_10_1)
		end
	end
end

function var_0_0.setAllEntityCanDrag(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._entitys) do
		if iter_11_1 then
			iter_11_1:setCanDrag(arg_11_1)
		end
	end
end

function var_0_0.setOutlineActive(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2 and EliminateTeamChessEnum.ModeType.outline or EliminateTeamChessEnum.ModeType.Normal

	if arg_12_0._entitys and arg_12_0._entitys[arg_12_1] then
		arg_12_0._entitys[arg_12_1]:setShowModeType(var_12_0)
	end
end

function var_0_0.setGrayActive(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2 and EliminateTeamChessEnum.ModeType.Gray or EliminateTeamChessEnum.ModeType.Normal

	if arg_13_0._entitys and arg_13_0._entitys[arg_13_1] then
		arg_13_0._entitys[arg_13_1]:setShowModeType(var_13_0)
	end
end

function var_0_0.moveEntityByTeamTypeAndStrongHold(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._entitys) do
		if iter_14_1 and iter_14_1._unitMo.teamType == arg_14_1 and iter_14_1._unitMo.stronghold == arg_14_2 then
			iter_14_1:moveToPosByTargetTr(arg_14_3, arg_14_4, arg_14_5)
		end
	end
end

function var_0_0.resetEntityPosByTeamTypeAndStrongHold(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._entitys) do
		if iter_15_1 and iter_15_1._unitMo.teamType == arg_15_1 and iter_15_1._unitMo.stronghold == arg_15_2 then
			iter_15_1:movePosByTr()
		end
	end
end

function var_0_0.cacheAllEntityShowMode(arg_16_0)
	if arg_16_0.entityCacheMode == nil then
		arg_16_0.entityCacheMode = {}
	end

	for iter_16_0, iter_16_1 in pairs(arg_16_0._entitys) do
		if iter_16_1 then
			arg_16_0.entityCacheMode[iter_16_0] = iter_16_1:getShowModeType()
		end
	end
end

function var_0_0.setAllEntityNormal(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._entitys) do
		if iter_17_1 then
			iter_17_1:setShowModeType(EliminateTeamChessEnum.ModeType.Normal)
		end
	end
end

function var_0_0.cacheEntityShowMode(arg_18_0, arg_18_1)
	if arg_18_0.entityCacheMode == nil then
		arg_18_0.entityCacheMode = {}
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0._entitys) do
		if iter_18_1 and iter_18_1._unitMo.stronghold == arg_18_1 then
			arg_18_0.entityCacheMode[iter_18_0] = iter_18_1:getShowModeType()
		end
	end
end

function var_0_0.restoreEntityShowMode(arg_19_0)
	if arg_19_0.entityCacheMode == nil then
		return
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0.entityCacheMode) do
		local var_19_0 = arg_19_0._entitys[iter_19_0]

		if var_19_0 then
			var_19_0:setShowModeType(iter_19_1)
		end
	end

	tabletool.clear(arg_19_0.entityCacheMode)
end

function var_0_0.setTempShowModeAndCacheByTeamType(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._entitys) do
		if iter_20_1 and iter_20_1._unitMo.teamType == arg_20_1 and iter_20_0 ~= EliminateTeamChessEnum.tempPieceUid then
			iter_20_1:cacheModel()
			iter_20_1:setShowModeType(arg_20_2)
		end
	end
end

function var_0_0.restoreTempShowModeAndCacheByTeamType(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._entitys) do
		if iter_21_1 and iter_21_1._unitMo.teamType == arg_21_1 then
			iter_21_1:restoreModel()
		end
	end
end

function var_0_0.refreshShowModeStateByTeamType(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._entitys) do
		if iter_22_1 and iter_22_1._unitMo.teamType == arg_22_1 then
			iter_22_1:refreshShowModeState()
		end
	end
end

function var_0_0.clear(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._entitys) do
		iter_23_1:dispose()
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.emptyEntity) do
		iter_23_3:dispose()
	end

	arg_23_0._entitys = {}
	arg_23_0.emptyEntity = {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
