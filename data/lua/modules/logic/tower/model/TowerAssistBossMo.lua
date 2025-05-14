module("modules.logic.tower.model.TowerAssistBossMo", package.seeall)

local var_0_0 = pureTable("TowerAssistBossMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.level = 0
	arg_1_0.talentPoint = 0
end

function var_0_0.onTowerActiveTalent(arg_2_0, arg_2_1)
	arg_2_0:addTalentId(arg_2_1.talentId)

	arg_2_0.talentPoint = arg_2_1.talentPoint
end

function var_0_0.onTowerResetTalent(arg_3_0, arg_3_1)
	arg_3_0.talentPoint = arg_3_1.talentPoint

	if arg_3_1.talentId == 0 then
		arg_3_0:initTalentIds()
	else
		arg_3_0:removeTalentId(arg_3_1.talentId)
	end
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	arg_4_0.level = arg_4_1.level
	arg_4_0.talentPoint = arg_4_1.talentPoint

	arg_4_0:initTalentIds(arg_4_1.talentIds)
end

function var_0_0.initTalentIds(arg_5_0, arg_5_1)
	arg_5_0.talentIdDict = {}
	arg_5_0.talentIdList = {}
	arg_5_0.talentIdCount = 0

	if arg_5_1 then
		for iter_5_0 = 1, #arg_5_1 do
			arg_5_0:addTalentId(arg_5_1[iter_5_0])
		end
	end
end

function var_0_0.addTalentId(arg_6_0, arg_6_1)
	if not arg_6_1 or arg_6_0:isActiveTalent(arg_6_1) then
		return
	end

	arg_6_0.talentIdCount = arg_6_0.talentIdCount + 1
	arg_6_0.talentIdDict[arg_6_1] = 1
	arg_6_0.talentIdList[arg_6_0.talentIdCount] = arg_6_1
end

function var_0_0.removeTalentId(arg_7_0, arg_7_1)
	if not arg_7_1 or not arg_7_0:isActiveTalent(arg_7_1) then
		return
	end

	arg_7_0.talentIdCount = arg_7_0.talentIdCount - 1
	arg_7_0.talentIdDict[arg_7_1] = nil

	tabletool.removeValue(arg_7_0.talentIdList, arg_7_1)
end

function var_0_0.isActiveTalent(arg_8_0, arg_8_1)
	return arg_8_0.talentIdDict[arg_8_1] ~= nil
end

function var_0_0.getTalentPoint(arg_9_0)
	return arg_9_0.talentPoint
end

function var_0_0.getTalentTree(arg_10_0)
	if not arg_10_0.talentTree then
		arg_10_0.talentTree = TowerTalentTree.New()

		local var_10_0 = TowerConfig.instance:getAssistTalentConfig().configDict[arg_10_0.id]

		arg_10_0.talentTree:initTree(arg_10_0, var_10_0)
	end

	return arg_10_0.talentTree
end

function var_0_0.getTalentActiveCount(arg_11_0)
	return arg_11_0.talentIdCount, arg_11_0.talentPoint
end

function var_0_0.hasTalentCanActive(arg_12_0)
	return arg_12_0:getTalentTree():hasTalentCanActive()
end

return var_0_0
