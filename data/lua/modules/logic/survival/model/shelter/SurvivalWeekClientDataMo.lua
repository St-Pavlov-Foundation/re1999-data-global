module("modules.logic.survival.model.shelter.SurvivalWeekClientDataMo", package.seeall)

local var_0_0 = pureTable("SurvivalWeekClientDataMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}

	if not string.nilorempty(arg_1_1) then
		var_1_0 = cjson.decode(arg_1_1)
	end

	if var_1_0.ver and var_1_0.ver ~= arg_1_0:getCurVersion() then
		var_1_0 = {}
	end

	var_1_0.ver = var_1_0.ver or arg_1_0:getCurVersion()

	local var_1_1 = false

	if not var_1_0.nowUnlockMaps then
		var_1_0.nowUnlockMaps = {}

		for iter_1_0 in pairs(arg_1_2.copyIds) do
			table.insert(var_1_0.nowUnlockMaps, iter_1_0)

			var_1_1 = true
		end
	end

	if not var_1_0.heroCount or var_1_0.heroCount <= 0 then
		var_1_0.heroCount = arg_1_2:getAttr(SurvivalEnum.AttrType.ExploreRoleNum)
	end

	if not var_1_0.npcCount or var_1_0.npcCount <= 0 then
		var_1_0.npcCount = arg_1_2:getAttr(SurvivalEnum.AttrType.ExploreNpcNum)
	end

	arg_1_0.data = var_1_0

	if var_1_1 and arg_1_2.day > 0 then
		arg_1_0:saveDataToServer()
	end
end

function var_0_0.getCurVersion(arg_2_0)
	return 1
end

function var_0_0.saveDataToServer(arg_3_0)
	SurvivalWeekRpc.instance:sendSurvivalSurvivalWeekClientData(cjson.encode(arg_3_0.data))
end

return var_0_0
