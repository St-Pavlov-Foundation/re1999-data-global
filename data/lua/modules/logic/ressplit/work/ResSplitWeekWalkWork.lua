module("modules.logic.ressplit.work.ResSplitWeekWalkWork", package.seeall)

local var_0_0 = class("ResSplitWeekWalkWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = ResSplitConfig.instance:getAppIncludeConfig()
	local var_1_1 = 0

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		var_1_1 = math.max(var_1_1, iter_1_1.maxWeekWalk)
	end

	for iter_1_2, iter_1_3 in pairs(lua_weekwalk.configDict) do
		if var_1_1 >= iter_1_3.layer then
			local var_1_2 = lua_weekwalk_scene.configDict[iter_1_3.sceneId].mapId
			local var_1_3 = string.format("Assets/ZProj/Editor/WeekWalk/Map/%s.txt", var_1_2)
			local var_1_4 = SLFramework.FileHelper.ReadText(var_1_3)
			local var_1_5 = cjson.decode(var_1_4).nodeList

			for iter_1_4, iter_1_5 in ipairs(var_1_5) do
				local var_1_6 = WeekwalkElementInfoMO.New()

				var_1_6:init({
					elementId = iter_1_5.configId
				})

				if var_1_6.config then
					local var_1_7 = var_1_6:getConfigBattleId()

					if var_1_7 then
						local var_1_8 = lua_battle.configDict[var_1_7]

						ResSplitHelper.addBattleMonsterSkins(var_1_8)
					end
				end
			end
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
