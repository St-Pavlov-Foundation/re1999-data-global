module("modules.logic.gm.view.command.GMCommand", package.seeall)

local var_0_0 = class("GMCommand")

function var_0_0.processCmd(arg_1_0, ...)
	if var_0_0[arg_1_0] then
		var_0_0[arg_1_0](...)
	end
end

function var_0_0.decryptSuccess()
	Role37PuzzleModel.instance:Finish(true)
end

function var_0_0.dungeon(arg_3_0, arg_3_1)
	local var_3_0

	arg_3_0 = tonumber(arg_3_0) or 0
	arg_3_1 = tonumber(arg_3_1)

	local var_3_1 = lua_chapter.configDict[100 + arg_3_0]

	if var_3_1 then
		local var_3_2 = DungeonConfig.instance:getChapterNonSpEpisodeCOList(var_3_1.id)

		var_3_0 = var_3_2 and var_3_2[arg_3_1] and var_3_2[arg_3_1].id
	end

	if var_3_0 then
		GMRpc.instance:sendGMRequest(string.format("set dungeon %d", var_3_0))
	end
end

function var_0_0.weather(arg_4_0)
	arg_4_0 = tonumber(arg_4_0)

	WeatherController.instance:setReportId(arg_4_0)
end

function var_0_0.printreport()
	local var_5_0 = WeatherController.instance._curReport

	if var_5_0 then
		print("report id:", var_5_0.id)
	end
end

function var_0_0.mainheromode(arg_6_0)
	local var_6_0 = tonumber(arg_6_0) == 1
	local var_6_1 = ViewMgr.instance:getContainer(ViewName.MainView)

	if var_6_1 then
		var_6_1:getMainHeroView():debugShowMode(var_6_0)
	end
end

function var_0_0.weekwalksettlement(arg_7_0)
	ViewMgr.instance:closeView(ViewName.GMToolView)

	local var_7_0 = tonumber(arg_7_0)

	if var_7_0 == 1 then
		WeekWalkController.instance:openWeekWalkShallowSettlementView()
	end

	if var_7_0 == 2 then
		WeekWalkController.instance:openWeekWalkDeepLayerNoticeView()
	end

	if var_7_0 == 3 then
		WeekWalkModel.instance:getInfo().isPopDeepSettle = true

		WeekWalkController.instance:openWeekWalkShallowSettlementView()
	end

	if var_7_0 == 4 then
		WeekWalk_2Controller.instance:openWeekWalk_2DeepLayerNoticeView()
	end

	if var_7_0 == 5 then
		WeekWalkModel.instance:getInfo().isPopDeepSettle = true
		WeekWalk_2Model.instance:getInfo().isPopSettle = true

		WeekWalkController.instance:openWeekWalkShallowSettlementView()
	end
end

function var_0_0.finishLayer(arg_8_0, arg_8_1)
	local var_8_0 = {
		"set weekwalkElement 101 10117 3",
		"set weekwalkElement 102 30130 1",
		"set weekwalkElement 103 50117 3",
		"set weekwalkElement 104 201152 1",
		"set weekwalkElement 105 40412 3",
		"set weekwalkElement 201 10129 2",
		"set weekwalkElement 202 30121 3",
		"set weekwalkElement 203 50218 1",
		"set weekwalkElement 204 201151 1",
		"set weekwalkElement 205 40419 1"
	}

	arg_8_0 = tonumber(arg_8_0)
	arg_8_1 = tonumber(arg_8_1)

	if arg_8_0 < 1 or arg_8_0 > #var_8_0 then
		return
	end

	if arg_8_1 < 1 or arg_8_1 > #var_8_0 then
		return
	end

	for iter_8_0 = arg_8_0, arg_8_1 do
		local var_8_1 = var_8_0[iter_8_0]

		GMRpc.instance:sendGMRequest(var_8_1)
	end
end

function var_0_0.clearTrialData(arg_9_0)
	if arg_9_0 then
		local var_9_0 = PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. arg_9_0

		PlayerPrefsHelper.deleteKey(var_9_0)
	else
		for iter_9_0 in pairs(lua_battle.configDict) do
			local var_9_1 = PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. iter_9_0

			PlayerPrefsHelper.deleteKey(var_9_1)
		end
	end
end

return var_0_0
