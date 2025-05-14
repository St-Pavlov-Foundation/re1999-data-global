module("modules.logic.tower.model.TowerAssistBossModel", package.seeall)

local var_0_0 = class("TowerAssistBossModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.tempBossDict = {}
end

function var_0_0.updateAssistBossInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.id
	local var_3_1 = arg_3_0:getById(var_3_0)

	if not var_3_1 then
		var_3_1 = TowerAssistBossMo.New()

		var_3_1:init(var_3_0)
		arg_3_0:addAtLast(var_3_1)
	end

	var_3_1:updateInfo(arg_3_1)
end

function var_0_0.onTowerActiveTalent(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.bossId
	local var_4_1 = arg_4_0:getById(var_4_0)

	if var_4_1 then
		var_4_1:onTowerActiveTalent(arg_4_1)
	end
end

function var_0_0.onTowerResetTalent(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.bossId
	local var_5_1 = arg_5_0:getById(var_5_0)

	if var_5_1 then
		var_5_1:onTowerResetTalent(arg_5_1)
	end
end

function var_0_0.getBoss(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getById(arg_6_1) or arg_6_0.tempBossDict[arg_6_1]

	if not var_6_0 then
		var_6_0 = TowerAssistBossMo.New()

		var_6_0:init(arg_6_1)
		var_6_0:initTalentIds()

		arg_6_0.tempBossDict[arg_6_1] = var_6_0
	end

	return var_6_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
