module("modules.logic.survival.util.SurvivalUnitIconHelper", package.seeall)

local var_0_0 = class("SurvivalUnitIconHelper")
local var_0_1 = "survival_map_icon_"
local var_0_2 = "survival_map_bubble_"
local var_0_3 = "survival_map_icon_arrow0"
local var_0_4 = {
	NPC = 2,
	Task = 1,
	Door = 9,
	Search = 3,
	Treasure = 5,
	NPC_High = 25,
	Fight_Skip = 23,
	Fight_Elite_Skip = 24,
	Fight = 6,
	Unknown = 11,
	Fight_Elite = 7,
	Exit = 8,
	Hero = 10,
	Searched = 4,
	Searched_High = 26,
	Search_High = 27
}
local var_0_5 = {
	Gold = {
		"gold",
		"3"
	},
	Green = {
		"green",
		"2"
	},
	Red = {
		"red",
		"1"
	},
	Yellow = {
		"yellow",
		"3"
	}
}
local var_0_6 = {
	[var_0_4.Task] = var_0_5.Green,
	[var_0_4.NPC] = var_0_5.Green,
	[var_0_4.Search] = var_0_5.Green,
	[var_0_4.Searched] = var_0_5.Green,
	[var_0_4.Treasure] = var_0_5.Green,
	[var_0_4.Fight] = var_0_5.Red,
	[var_0_4.Fight_Elite] = var_0_5.Red,
	[var_0_4.Exit] = var_0_5.Yellow,
	[var_0_4.Door] = var_0_5.Yellow,
	[var_0_4.Hero] = var_0_5.Green,
	[var_0_4.Unknown] = var_0_5.Green,
	[var_0_4.NPC_High] = var_0_5.Gold,
	[var_0_4.Fight_Skip] = var_0_5.Green,
	[var_0_4.Fight_Elite_Skip] = var_0_5.Green,
	[var_0_4.Searched_High] = var_0_5.Gold,
	[var_0_4.Search_High] = var_0_5.Gold
}
local var_0_7 = {
	[SurvivalEnum.UnitType.Task] = var_0_4.Task,
	[SurvivalEnum.UnitType.NPC] = var_0_4.NPC,
	[SurvivalEnum.UnitType.Treasure] = var_0_4.Treasure,
	[SurvivalEnum.UnitType.Exit] = var_0_4.Exit,
	[SurvivalEnum.UnitType.Door] = var_0_4.Door
}
local var_0_8 = {
	[53] = var_0_4.NPC_High
}

function var_0_0.getUnitIconAndBg(arg_1_0, arg_1_1)
	local var_1_0 = var_0_4.Unknown

	if arg_1_1.visionVal ~= 8 then
		local var_1_1 = arg_1_1.unitType
		local var_1_2 = arg_1_1.co and arg_1_1.co.subType

		var_1_0 = var_0_7[var_1_1] or var_1_0
		var_1_0 = var_0_8[var_1_2] or var_1_0

		if var_1_1 == SurvivalEnum.UnitType.Search then
			local var_1_3 = arg_1_1.extraParam == "true"

			if var_1_2 == 392 then
				var_1_0 = var_1_3 and var_0_4.Searched_High or var_0_4.Search_High
			else
				var_1_0 = var_1_3 and var_0_4.Searched or var_0_4.Search
			end
		elseif var_1_1 == SurvivalEnum.UnitType.Battle then
			local var_1_4 = var_1_2 == 41 or var_1_2 == 43
			local var_1_5 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroFightLevel)
			local var_1_6 = arg_1_1.co.fightLevel

			if arg_1_1.co.skip == 1 and var_1_6 <= var_1_5 then
				var_1_0 = var_1_4 and var_0_4.Fight_Elite_Skip or var_0_4.Fight_Skip
			else
				var_1_0 = var_1_4 and var_0_4.Fight_Elite or var_0_4.Fight
			end
		end
	end

	return var_0_1 .. var_1_0, var_0_2 .. var_0_6[var_1_0][1], var_0_3 .. var_0_6[var_1_0][2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
