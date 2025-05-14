module("modules.logic.seasonver.act123.model.Season123ShowHeroModel", package.seeall)

local var_0_0 = class("Season123ShowHeroModel", ListScrollModel)

function var_0_0.release(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.activityId = arg_2_1
	arg_2_0.stage = arg_2_2
	arg_2_0.layer = arg_2_3

	arg_2_0:initHeroList()
end

function var_0_0.initHeroList(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = HeroModel.instance:getList()

	arg_3_0:initLayerHeroList(var_3_0, arg_3_0.layer)
	logNormal("hero list count : " .. tostring(#var_3_0))
	arg_3_0:setList(var_3_0)
end

function var_0_0.initLayerHeroList(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Season123Model.instance:getActInfo(arg_4_0.activityId)

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0.stageMap[arg_4_0.stage]

	if not var_4_1 then
		return
	end

	local var_4_2 = var_4_1.episodeMap[arg_4_2]

	if not var_4_2 then
		return
	end

	local var_4_3 = var_4_2.heroes

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		local var_4_4 = HeroModel.instance:getById(iter_4_1.heroUid)

		if not var_4_4 then
			local var_4_5, var_4_6 = Season123Model.instance:getAssistData(arg_4_0.activityId, arg_4_0.stage)

			if var_4_6 and var_4_6.heroUid == iter_4_1.heroUid then
				local var_4_7 = Season123ShowHeroMO.New()

				var_4_7:init(var_4_5, var_4_6.heroUid, var_4_6.heroId, var_4_6.skin, iter_4_1.hpRate, true)
				table.insert(arg_4_1, var_4_7)
			end
		else
			local var_4_8 = Season123ShowHeroMO.New()

			var_4_8:init(var_4_4, var_4_4.uid, var_4_4.heroId, var_4_4.skin, iter_4_1.hpRate, false)
			table.insert(arg_4_1, var_4_8)
		end
	end
end

function var_0_0.isFirstPlayHeroDieAnim(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getPlayHeroDieAnimPrefKey(arg_5_0.stage)
	local var_5_1 = PlayerPrefsHelper.getString(var_5_0, "")
	local var_5_2 = string.split(var_5_1, "|")

	if var_5_2 and not LuaUtil.tableContains(var_5_2, arg_5_1) then
		return true
	end
end

function var_0_0.setPlayedHeroDieAnim(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getPlayHeroDieAnimPrefKey(arg_6_0.stage)
	local var_6_1 = PlayerPrefsHelper.getString(var_6_0, "")

	if string.nilorempty(var_6_1) then
		var_6_1 = arg_6_1
	else
		local var_6_2 = string.split(var_6_1, "|")

		if var_6_2 and not LuaUtil.tableContains(var_6_2, arg_6_1) then
			var_6_1 = var_6_1 .. "|" .. arg_6_1
		end
	end

	PlayerPrefsHelper.setString(var_6_0, var_6_1)
end

function var_0_0.clearPlayHeroDieAnim(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getPlayHeroDieAnimPrefKey(arg_7_1)

	PlayerPrefsHelper.setString(var_7_0, "")
end

function var_0_0.getPlayHeroDieAnimPrefKey(arg_8_0, arg_8_1)
	return "Season123ShowHeroModel_PlayHeroDieAnim_" .. arg_8_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
