module("modules.logic.survival.util.SurvivalStatHelper", package.seeall)

local var_0_0 = class("SurvivalStatHelper")

function var_0_0.statBtnClick(arg_1_0, arg_1_1, arg_1_2)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ButtonName] = arg_1_1,
		[StatEnum.EventProperties.ViewName] = arg_1_2
	})
end

function var_0_0.statSurvivalMapUnit(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = SurvivalMapModel.instance:getSceneMo()
	local var_2_1 = var_2_0.player.pos
	local var_2_2 = var_2_0.unitsById[arg_2_2]

	StatController.instance:track(StatEnum.EventName.SurvivalMapUnit, {
		[StatEnum.EventProperties.SurvivalBaseObj] = arg_2_0:getWeekData(),
		[StatEnum.EventProperties.SurvivalMapBaseObj] = arg_2_0:getMapData(),
		[StatEnum.EventProperties.OperationType] = arg_2_1,
		[StatEnum.EventProperties.EventId] = var_2_2 and var_2_2.cfgId,
		[StatEnum.EventProperties.TreeId] = arg_2_4 or 0,
		[StatEnum.EventProperties.OptionId] = arg_2_3,
		[StatEnum.EventProperties.Position] = {
			x = var_2_1.q,
			y = var_2_1.r,
			z = var_2_1.s
		}
	})
end

function var_0_0.statWeekClose(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = SurvivalModel.instance:getOutSideInfo()

	StatController.instance:track(StatEnum.EventName.SurvivalWeekClose, {
		[StatEnum.EventProperties.Season] = var_3_0.season,
		[StatEnum.EventProperties.SurvivalBaseObj] = arg_3_0:getWeekData(),
		[StatEnum.EventProperties.UseTime] = arg_3_1,
		[StatEnum.EventProperties.From] = arg_3_2
	})
end

function var_0_0.statMapClose(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = SurvivalModel.instance:getOutSideInfo()

	StatController.instance:track(StatEnum.EventName.SurvivalMapClose, {
		[StatEnum.EventProperties.Season] = var_4_0.season,
		[StatEnum.EventProperties.SurvivalBaseObj] = arg_4_0:getWeekData(),
		[StatEnum.EventProperties.SurvivalMapBaseObj] = arg_4_0:getMapData(),
		[StatEnum.EventProperties.UseTime] = arg_4_1,
		[StatEnum.EventProperties.From] = arg_4_2
	})
end

function var_0_0.getWeekData(arg_5_0)
	local var_5_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_5_0 then
		return
	end

	return {
		world_lv = var_5_0:getAttr(SurvivalEnum.AttrType.WorldLevel),
		difficulty = var_5_0.difficulty,
		day = var_5_0.day
	}
end

function var_0_0.getMapData(arg_6_0)
	local var_6_0 = SurvivalMapModel.instance:getSceneMo()

	if not var_6_0 then
		return
	end

	local var_6_1 = lua_survival_map_group_mapping.configDict[var_6_0.mapId].id
	local var_6_2 = SurvivalConfig.instance:getCopyCo(var_6_1)
	local var_6_3 = var_6_0.currMaxGameTime - var_6_0.gameTime
	local var_6_4 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0.units) do
		table.insert(var_6_4, iter_6_1.cfgId)
	end

	return {
		map_type = var_6_2.id,
		map_id = var_6_0.mapId,
		countdown = var_6_3,
		alive_events = var_6_4
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
