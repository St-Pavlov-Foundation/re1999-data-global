module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaModel", package.seeall)

local var_0_0 = class("TianShiNaNaModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.nowMapId = nil
	arg_1_0._curState = TianShiNaNaEnum.CurState.None
	arg_1_0.unitMos = {}
	arg_1_0.nowScenePos = nil
	arg_1_0.currEpisodeId = 0
	arg_1_0._episodeStars = {}
	arg_1_0.sceneLevelLoadFinish = false
	arg_1_0.waitStartFlow = false
	arg_1_0.waitClickJump = false
	arg_1_0.statMo = nil
	arg_1_0.curSelectIndex = 1
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.initInfo(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if iter_3_1.passChessGame then
			var_3_0[iter_3_1.episodeId] = iter_3_1.star
		end
	end

	local var_3_1 = TianShiNaNaConfig.instance:getEpisodeCoList(VersionActivity2_2Enum.ActivityId.TianShiNaNa)

	for iter_3_2 = 1, #var_3_1 do
		if var_3_1[iter_3_2].episodeType == 1 then
			local var_3_2 = true

			if var_3_1[iter_3_2].storyBefore > 0 then
				var_3_2 = StoryModel.instance:isStoryFinished(var_3_1[iter_3_2].storyBefore)
			end

			arg_3_0._episodeStars[iter_3_2] = var_3_2 and 1 or 0
		else
			arg_3_0._episodeStars[iter_3_2] = var_3_0[var_3_1[iter_3_2].id] or 0
		end
	end
end

function var_0_0.markEpisodeFinish(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.currEpisodeId = 0

	if arg_4_0._episodeStars[arg_4_1] ~= arg_4_2 then
		local var_4_0 = arg_4_0._episodeStars[arg_4_1]

		arg_4_0._episodeStars[arg_4_1] = arg_4_2

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EpisodeStarChange, arg_4_1, var_4_0, arg_4_2)
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EpisodeFinish)
end

function var_0_0.getEpisodeStar(arg_5_0, arg_5_1)
	return arg_5_0._episodeStars[arg_5_1] or 0
end

function var_0_0.getUnLockMaxIndex(arg_6_0)
	local var_6_0 = 0

	while arg_6_0:getEpisodeStar(var_6_0 + 1) > 0 do
		var_6_0 = var_6_0 + 1
	end

	return var_6_0
end

function var_0_0.initDatas(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.statMo = TianShiNaNaStatMo.New()
	arg_7_0._curState = TianShiNaNaEnum.CurState.None
	arg_7_0.episodeCo = lua_activity167_episode.configDict[VersionActivity2_2Enum.ActivityId.TianShiNaNa][arg_7_1]
	arg_7_0.nowMapId = arg_7_0.episodeCo.mapId

	local var_7_0 = TianShiNaNaConfig.instance:getMapCo(arg_7_0.episodeCo.mapId)

	arg_7_0.unitMos = {}
	arg_7_0.mapCo = var_7_0
	arg_7_0.heroMo = nil
	arg_7_0.nowRound = arg_7_2.currentRound
	arg_7_0.stepCount = arg_7_2.stepCount

	for iter_7_0, iter_7_1 in ipairs(arg_7_2.interact) do
		local var_7_1 = iter_7_1.id
		local var_7_2 = var_7_0:getUnitCo(var_7_1)

		if var_7_2 then
			local var_7_3 = TianShiNaNaMapUnitMo.New()

			var_7_3:init(var_7_2)
			var_7_3:updatePos(iter_7_1.x, iter_7_1.y, iter_7_1.direction)
			var_7_3:setActive(iter_7_1.active)

			arg_7_0.unitMos[var_7_2.id] = var_7_3

			if var_7_2.unitType == TianShiNaNaEnum.UnitType.Player then
				arg_7_0.heroMo = var_7_3
			end
		else
			logError(string.format("天使娜娜地图 %d 元件 %d 不存在", arg_7_0.nowMapId, var_7_1))
		end
	end

	arg_7_0.remainCubeList = string.splitToNumber(arg_7_0.episodeCo.cubeList, "#")
	arg_7_0.totalRound = #arg_7_0.remainCubeList

	if not arg_7_0.heroMo then
		logError(string.format("天使娜娜地图 %d 角色元件不存在", arg_7_0.nowMapId))
	end

	arg_7_0.curOperList = {}
	arg_7_0.curPointList = {}
	arg_7_0.waitClickJump = false
end

function var_0_0.sendStat(arg_8_0, arg_8_1)
	if arg_8_0.statMo then
		arg_8_0.statMo:sendStatData(arg_8_1)

		arg_8_0.statMo = nil
	end
end

function var_0_0.isWaitClick(arg_9_0)
	return arg_9_0._curState == TianShiNaNaEnum.CurState.DoStep and arg_9_0.waitClickJump
end

function var_0_0.resetScene(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.statMo then
		if arg_10_2 then
			arg_10_0.statMo:sendStatData("重置")
			arg_10_0.statMo:reset()
		else
			arg_10_0.statMo:addBackNum()
		end
	else
		arg_10_0.statMo = TianShiNaNaStatMo.New()
	end

	TianShiNaNaController.instance:clearFlow()

	arg_10_0.waitClickJump = false
	arg_10_0.nowRound = arg_10_1.currentRound
	arg_10_0.stepCount = arg_10_1.stepCount

	local var_10_0 = {}

	for iter_10_0 in pairs(arg_10_0.unitMos) do
		var_10_0[iter_10_0] = true
	end

	local var_10_1 = arg_10_0.mapCo

	for iter_10_1, iter_10_2 in ipairs(arg_10_1.interact) do
		local var_10_2 = iter_10_2.id

		if var_10_0[var_10_2] then
			var_10_0[var_10_2] = nil
		end

		local var_10_3 = arg_10_0.unitMos[var_10_2]

		if var_10_3 then
			var_10_3:updatePos(iter_10_2.x, iter_10_2.y, iter_10_2.direction)
			var_10_3:setActive(iter_10_2.active)

			local var_10_4 = TianShiNaNaEntityMgr.instance:getEntity(var_10_2)

			if var_10_4 then
				var_10_4:updatePosAndDir()
			end
		else
			local var_10_5 = var_10_1:getUnitCo(var_10_2)

			if var_10_5 then
				local var_10_6 = TianShiNaNaMapUnitMo.New()

				var_10_6:init(var_10_5)
				var_10_6:updatePos(iter_10_2.x, iter_10_2.y, iter_10_2.direction)

				arg_10_0.unitMos[var_10_5.id] = var_10_6

				if var_10_5.unitType == TianShiNaNaEnum.UnitType.Player then
					arg_10_0.heroMo = var_10_6
				end
			else
				logError(string.format("天使娜娜地图 %d 元件 %d 不存在", arg_10_0.nowMapId, var_10_2))
			end
		end
	end

	for iter_10_3 in pairs(var_10_0) do
		arg_10_0:removeUnit(iter_10_3)
	end

	arg_10_0.curOperList = arg_10_1.operations
	arg_10_0.curPointList = {}

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CubePointUpdate)
end

function var_0_0.removeUnit(arg_11_0, arg_11_1)
	if arg_11_0.unitMos[arg_11_1] then
		TianShiNaNaEntityMgr.instance:removeEntity(arg_11_1)

		arg_11_0.unitMos[arg_11_1] = nil
	end
end

function var_0_0.getNextCubeType(arg_12_0)
	if not arg_12_0.remainCubeList then
		return
	end

	return arg_12_0.remainCubeList[arg_12_0.nowRound + 1]
end

function var_0_0.setState(arg_13_0, arg_13_1)
	if arg_13_1 ~= arg_13_0._curState then
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.StatuChange, arg_13_0._curState, arg_13_1)

		arg_13_0._curState = arg_13_1
	end
end

function var_0_0.getState(arg_14_0)
	return arg_14_0._curState
end

function var_0_0.getHeroMo(arg_15_0)
	return arg_15_0.heroMo
end

function var_0_0.isNodeCanPlace(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_0.nowMapId then
		return false
	end

	for iter_16_0, iter_16_1 in pairs(arg_16_0.unitMos) do
		if iter_16_1:isPosEqual(arg_16_1, arg_16_2) and not iter_16_1:canWalk() then
			return false
		end
	end

	local var_16_0 = arg_16_0.mapCo:getNodeCo(arg_16_1, arg_16_2)

	if not var_16_0 or arg_16_3 and var_16_0 and var_16_0.nodeType == TianShiNaNaEnum.NodeType.Swamp then
		return false
	end

	if not var_16_0.walkable then
		return false
	end

	if var_16_0:isCollapse() then
		return false
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
