module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActProgress", package.seeall)

local var_0_0 = class("SurvivalSummaryActProgress", BaseSceneComp)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	local var_2_0 = arg_2_0.weekInfo.shelterMapId

	arg_2_0.unitComp = SurvivalMapHelper.instance:getScene().unit
	arg_2_0.mapCo = lua_survival_shelter.configDict[var_2_0]
	arg_2_0.npcDataList = {}

	local var_2_1 = SurvivalMapModel.instance.resultData:getFirstNpcMos()

	arg_2_0.buildReputationInfoDic = {}
	arg_2_0.buildReputationInfos = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_2 = SurvivalConfig.instance:getNpcRenown(iter_2_1.id)

		if var_2_2 then
			local var_2_3 = {
				id = iter_2_1.id,
				resource = iter_2_1.co.resource,
				config = iter_2_1.co
			}

			table.insert(arg_2_0.npcDataList, var_2_3)

			local var_2_4 = var_2_2[1]
			local var_2_5 = SurvivalConfig.instance:getNpcReputationValue(iter_2_1.id)

			if arg_2_0.buildReputationInfoDic[var_2_4] == nil then
				local var_2_6 = {
					value = 0,
					reputationId = var_2_4,
					npcs = {}
				}

				arg_2_0.buildReputationInfoDic[var_2_4] = var_2_6

				table.insert(arg_2_0.buildReputationInfos, var_2_6)
			end

			table.insert(arg_2_0.buildReputationInfoDic[var_2_4].npcs, var_2_3)

			arg_2_0.buildReputationInfoDic[var_2_4].value = arg_2_0.buildReputationInfoDic[var_2_4].value + var_2_5
		end
	end

	table.sort(arg_2_0.buildReputationInfos, arg_2_0.reputationSortFunc)

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.buildReputationInfos) do
		local var_2_7 = iter_2_3.reputationId
		local var_2_8 = arg_2_0.weekInfo:getBuildingMoByReputationId(var_2_7)
		local var_2_9 = var_2_8.survivalReputationPropMo.prop.reputationLevel
		local var_2_10 = var_2_8.survivalReputationPropMo.prop.reputationExp

		if var_2_9 > 0 and var_2_10 < iter_2_3.value then
			for iter_2_4, iter_2_5 in ipairs(iter_2_3.npcs) do
				iter_2_5.upInfo = {
					lastLevel = var_2_9 - 1,
					cuLevel = var_2_9
				}
			end
		end
	end
end

function var_0_0.reputationSortFunc(arg_3_0, arg_3_1)
	return arg_3_0.reputationId < arg_3_1.reputationId
end

function var_0_0.onScenePrepared(arg_4_0)
	arg_4_0.sceneGo = GameSceneMgr.instance:getCurScene().level:getSceneGo()
	arg_4_0.npcRoot = gohelper.create3d(arg_4_0.sceneGo, "NpcRoot")

	local var_4_0 = string.splitToNumber(arg_4_0.mapCo.orderPosition, ",")
	local var_4_1 = SurvivalHexNode.New(var_4_0[1], var_4_0[2])

	arg_4_0.playerEntity = SurvivalSummaryActPlayerEntity.Create(var_4_1, arg_4_0.mapCo.toward, arg_4_0.sceneGo)
	arg_4_0.npcList = {}

	local var_4_2 = GameUtil.splitString2(arg_4_0.mapCo.npcPosition, true, "#", ",")

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.npcDataList) do
		local var_4_3 = var_4_2[iter_4_0]

		if var_4_3 then
			local var_4_4 = SurvivalSummaryActNpcEntity.Create(arg_4_0.npcDataList[iter_4_0].resource, arg_4_0.npcRoot, SurvivalHexNode.New(var_4_3[1], var_4_3[2]))

			table.insert(arg_4_0.npcList, var_4_4)
		else
			logError("npc很多，配置位置不够")
		end
	end
end

function var_0_0.onSceneClose(arg_5_0, ...)
	return
end

return var_0_0
