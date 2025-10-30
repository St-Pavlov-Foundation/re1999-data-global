module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.MaLiAnNaLaSoliderMoUtil", package.seeall)

local var_0_0 = class("MaLiAnNaLaSoliderMoUtil")

function var_0_0.init(arg_1_0)
	arg_1_0.soliderOnlyId = 0
	arg_1_0._allSoliderMoList = {}
end

function var_0_0.getOnlyId(arg_2_0)
	arg_2_0.soliderOnlyId = arg_2_0.soliderOnlyId + 1

	return arg_2_0.soliderOnlyId
end

function var_0_0.createSoliderMo(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return nil
	end

	local var_3_0 = arg_3_0:getOnlyId()
	local var_3_1 = MaLiAnNaSoldierEntityMo.create()

	var_3_1:init(var_3_0, arg_3_1)

	if var_3_1 ~= nil then
		arg_3_0._allSoliderMoList[var_3_0] = var_3_1
	end

	return var_3_1
end

function var_0_0.recycleSoliderMo(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		return
	end

	local var_4_0 = arg_4_1:getId()

	if not arg_4_1:isHero() then
		arg_4_0._allSoliderMoList[var_4_0] = nil

		Activity201MaLiAnNaGameModel.instance:removeDisPatchSolider(var_4_0)
		arg_4_1:clear()

		arg_4_1 = nil
	end
end

function var_0_0.getSoliderMoByConfigId(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		return nil
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0._allSoliderMoList) do
		if iter_5_1 and iter_5_1:getConfigId() == arg_5_1 then
			return iter_5_1
		end
	end

	return nil
end

function var_0_0.getSoliderMoById(arg_6_0, arg_6_1)
	if arg_6_1 == nil or arg_6_0._allSoliderMoList == nil then
		return nil
	end

	return arg_6_0._allSoliderMoList[arg_6_1]
end

function var_0_0.getAllHeroSolider(arg_7_0, arg_7_1)
	if arg_7_0._allSoliderMoList == nil then
		return nil
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._allSoliderMoList) do
		if iter_7_1 and iter_7_1:isHero() and arg_7_1 == iter_7_1:getCamp() then
			var_7_0[#var_7_0 + 1] = iter_7_1
		end
	end

	return var_7_0
end

function var_0_0.getAllSoliderMoList(arg_8_0)
	return arg_8_0._allSoliderMoList
end

function var_0_0.clear(arg_9_0)
	if arg_9_0._allSoliderMoList ~= nil then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._allSoliderMoList) do
			if iter_9_1 then
				iter_9_1:clear()
			end
		end

		arg_9_0._allSoliderMoList = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
