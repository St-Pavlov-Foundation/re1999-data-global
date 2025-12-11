module("modules.logic.tower.model.TowerAssistBossListModel", package.seeall)

local var_0_0 = class("TowerAssistBossListModel", ListScrollModel)

function var_0_0.initList(arg_1_0)
	arg_1_0.isFirstRefresh = true
end

function var_0_0.refreshList(arg_2_0, arg_2_1)
	arg_2_0.isFromHeroGroup = arg_2_1 and arg_2_1.isFromHeroGroup
	arg_2_0.bossId = arg_2_1 and arg_2_1.bossId
	arg_2_0.towerType = arg_2_1 and arg_2_1.towerType
	arg_2_0.towerId = arg_2_1 and arg_2_1.towerId

	local var_2_0 = arg_2_1.otherParam and arg_2_1.otherParam.heroGroupMO

	if arg_2_0.isFromHeroGroup then
		arg_2_0.bossId = (var_2_0 or HeroGroupModel.instance:getCurGroupMO()):getAssistBossId()

		if TowerModel.instance:isBossBan(arg_2_0.bossId) or TowerModel.instance:isLimitTowerBossBan(arg_2_0.towerType, arg_2_0.towerId, arg_2_0.bossId) then
			arg_2_0.bossId = 0
		end
	end

	if arg_2_0.isFirstRefresh then
		local var_2_1 = TowerConfig.instance:getAssistBossList()
		local var_2_2 = {}

		if var_2_1 then
			for iter_2_0, iter_2_1 in ipairs(var_2_1) do
				if arg_2_0:checkBossCanShow(iter_2_1.bossId) then
					table.insert(var_2_2, arg_2_0:buildBossData(iter_2_1))
				end
			end
		end

		if #var_2_2 > 1 then
			if arg_2_0.isFromHeroGroup then
				table.sort(var_2_2, SortUtil.tableKeyLower({
					"isBanOrder",
					"isSelectOrder",
					"isLock",
					"bossId"
				}))
			else
				table.sort(var_2_2, SortUtil.tableKeyLower({
					"isLock",
					"bossId"
				}))
			end
		end

		arg_2_0:setList(var_2_2)
	else
		local var_2_3 = arg_2_0:getList()

		for iter_2_2, iter_2_3 in ipairs(var_2_3) do
			arg_2_0:buildBossData(iter_2_3.config, iter_2_3)
		end

		local var_2_4 = {}

		for iter_2_4, iter_2_5 in ipairs(var_2_3) do
			if arg_2_0:checkBossCanShow(iter_2_5.bossId) then
				table.insert(var_2_4, iter_2_5)
			end
		end

		arg_2_0:setList(var_2_4)
	end

	arg_2_0.isFirstRefresh = false
end

function var_0_0.checkBossCanShow(arg_3_0, arg_3_1)
	if not TowerModel.instance:isBossOpen(arg_3_1) then
		return false
	end

	if arg_3_0.towerType and arg_3_0.towerType == TowerEnum.TowerType.Limited then
		local var_3_0 = TowerConfig.instance:getTowerLimitedTimeCo(arg_3_0.towerId)

		if var_3_0 then
			local var_3_1 = string.splitToNumber(var_3_0.bossPool, "#")

			for iter_3_0, iter_3_1 in ipairs(var_3_1) do
				if iter_3_1 == arg_3_1 then
					return true
				end
			end
		end

		return false
	end

	return true
end

function var_0_0.buildBossData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or {}
	arg_4_2.id = arg_4_1.bossId
	arg_4_2.config = arg_4_1
	arg_4_2.bossId = arg_4_1.bossId
	arg_4_2.bossInfo = TowerAssistBossModel.instance:getById(arg_4_1.bossId)
	arg_4_2.isLock = (arg_4_2.bossInfo == nil or arg_4_2.bossInfo:getTempState()) and 1 or 0
	arg_4_2.isFromHeroGroup = arg_4_0.isFromHeroGroup

	if arg_4_0.isFromHeroGroup then
		arg_4_2.isSelect = arg_4_0.bossId == arg_4_1.bossId

		if arg_4_0.isFirstRefresh then
			arg_4_2.isSelectOrder = arg_4_2.isSelect and 0 or 1
		end

		arg_4_2.isBanOrder = TowerModel.instance:isBossBan(arg_4_1.bossId) and 1 or 0
	end

	arg_4_2.isTowerOpen = TowerModel.instance:getTowerOpenInfo(TowerEnum.TowerType.Boss, arg_4_1.towerId, TowerEnum.TowerStatus.Open) ~= nil

	return arg_4_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
