-- chunkname: @modules/logic/scene/survivalsummaryact/comp/SurvivalSummaryActProgress.lua

module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActProgress", package.seeall)

local SurvivalSummaryActProgress = class("SurvivalSummaryActProgress", BaseSceneComp)

function SurvivalSummaryActProgress:ctor()
	return
end

function SurvivalSummaryActProgress:onSceneStart(sceneId, levelId)
	self.weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	local shelterMapId = self.weekInfo.shelterMapId

	self.unitComp = SurvivalMapHelper.instance:getScene().unit
	self.mapCo = lua_survival_shelter.configDict[shelterMapId]
	self.npcDataList = {}

	local npcList = SurvivalMapModel.instance.resultData:getFirstNpcMos()

	self.buildReputationInfoDic = {}
	self.buildReputationInfos = {}

	for k, v in ipairs(npcList) do
		local renown = SurvivalConfig.instance:getNpcRenown(v.id)

		if renown then
			local data = {
				id = v.id,
				resource = v.co.resource,
				config = v.co
			}

			table.insert(self.npcDataList, data)

			local reputationId = renown[1]
			local reputationAdd = SurvivalConfig.instance:getNpcReputationValue(v.id)

			if self.buildReputationInfoDic[reputationId] == nil then
				local info = {
					value = 0,
					reputationId = reputationId,
					npcs = {}
				}

				self.buildReputationInfoDic[reputationId] = info

				table.insert(self.buildReputationInfos, info)
			end

			table.insert(self.buildReputationInfoDic[reputationId].npcs, data)

			self.buildReputationInfoDic[reputationId].value = self.buildReputationInfoDic[reputationId].value + reputationAdd
		end
	end

	table.sort(self.buildReputationInfos, self.reputationSortFunc)

	for i, info in ipairs(self.buildReputationInfos) do
		local reputationId = info.reputationId
		local buildMo = self.weekInfo:getBuildingMoByReputationId(reputationId)
		local level = buildMo.survivalReputationPropMo.prop.reputationLevel
		local reputationExp = buildMo.survivalReputationPropMo.prop.reputationExp

		if level > 0 and reputationExp < info.value then
			for idx, data in ipairs(info.npcs) do
				data.upInfo = {
					lastLevel = level - 1,
					cuLevel = level
				}
			end
		end
	end
end

function SurvivalSummaryActProgress.reputationSortFunc(a, b)
	return a.reputationId < b.reputationId
end

function SurvivalSummaryActProgress:onScenePrepared()
	self.sceneGo = GameSceneMgr.instance:getCurScene().level:getSceneGo()
	self.npcRoot = gohelper.create3d(self.sceneGo, "NpcRoot")

	local playerPos = string.splitToNumber(self.mapCo.orderPosition, ",")
	local pos = SurvivalHexNode.New(playerPos[1], playerPos[2])

	self.playerEntity = SurvivalSummaryActPlayerEntity.Create(pos, self.mapCo.toward, self.sceneGo)
	self.npcList = {}

	local npcPosList = GameUtil.splitString2(self.mapCo.npcPosition, true, "#", ",")

	for i, v in ipairs(self.npcDataList) do
		local pos = npcPosList[i]

		if pos then
			local npc = SurvivalSummaryActNpcEntity.Create(self.npcDataList[i].resource, self.npcRoot, SurvivalHexNode.New(pos[1], pos[2]))

			table.insert(self.npcList, npc)
		else
			logError("npc很多，配置位置不够")
		end
	end
end

function SurvivalSummaryActProgress:onSceneClose(...)
	return
end

return SurvivalSummaryActProgress
