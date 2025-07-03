module("modules.logic.scene.fight.preloadwork.FightPreloadCardWork", package.seeall)

local var_0_0 = class("FightPreloadCardWork", BaseWork)
local var_0_1 = {
	[9120110] = {
		"305613"
	},
	[9120111] = {
		"306011"
	},
	[9121002] = {
		"306110"
	},
	[9120103] = {
		"302310"
	}
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = FightDataHelper.roundMgr:getRoundData()

	if var_1_1 and var_1_1.teamACards1 then
		for iter_1_0, iter_1_1 in ipairs(var_1_1.teamACards1) do
			local var_1_2 = lua_skill.configDict[iter_1_1.skillId]
			local var_1_3 = ResUrl.getSkillIcon(var_1_2.icon)

			if not tabletool.indexOf(var_1_0, var_1_3) then
				table.insert(var_1_0, var_1_3)
			end
		end
	end

	local var_1_4 = FightModel.instance:getFightParam().battleId
	local var_1_5 = var_0_1[var_1_4]

	if var_1_5 then
		for iter_1_2, iter_1_3 in ipairs(var_1_5) do
			local var_1_6 = ResUrl.getHeadIconSmall(iter_1_3)

			table.insert(var_1_0, var_1_6)
		end
	end

	arg_1_0._loader = MultiAbLoader.New()

	arg_1_0._loader:setPathList(var_1_0)
	arg_1_0._loader:startLoad(arg_1_0._onLoadFinish, arg_1_0)
end

function var_0_0._onLoadFinish(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getAssetItemDict()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		arg_2_0.context.callback(arg_2_0.context.callbackObj, iter_2_1)
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._loader then
		arg_3_0._loader:dispose()

		arg_3_0._loader = nil
	end
end

return var_0_0
