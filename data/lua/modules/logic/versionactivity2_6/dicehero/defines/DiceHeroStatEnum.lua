module("modules.logic.versionactivity2_6.dicehero.defines.DiceHeroStatEnum", package.seeall)

local var_0_0 = pureTable("DiceHeroStatEnum")

function var_0_0.initEnum(arg_1_0)
	arg_1_0.EventName.DiceHero_FightEnd = "dicehero_fight_end"
	arg_1_0.EventName.DiceHero_StoryEnd = "dicehero_story_end"
	arg_1_0.EventName.DiceHero_Reset = "dicehero_endless_reset"
	arg_1_0.EventProperties.DiceHero_ActId = "activity_id"
	arg_1_0.EventProperties.DiceHero_EpisodeId = "episodeid"
	arg_1_0.EventProperties.DiceHero_OperTpye = "operation_type"
	arg_1_0.EventProperties.DiceHero_UseTime = "usetime"
	arg_1_0.EventProperties.DiceHero_RoundNum = "round_num"
	arg_1_0.EventProperties.DiceHero_Result = "result"
	arg_1_0.EventProperties.DiceHero_IsFirst = "isfirst"
	arg_1_0.EventProperties.DiceHero_FightObj = "dicehero_fight_obj"
	arg_1_0.EventProperties.DiceHero_SkillInfo = "dicehero_skill_info"
	arg_1_0.EventProperties.DiceHero_TalkId = "guideid"
	arg_1_0.EventProperties.DiceHero_StepId = "stepid"
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_ActId] = arg_1_0.Type.String
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_EpisodeId] = arg_1_0.Type.String
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_OperTpye] = arg_1_0.Type.String
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_UseTime] = arg_1_0.Type.Number
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_RoundNum] = arg_1_0.Type.Number
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_Result] = arg_1_0.Type.String
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_IsFirst] = arg_1_0.Type.Boolean
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_FightObj] = arg_1_0.Type.List
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_SkillInfo] = arg_1_0.Type.Array
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_TalkId] = arg_1_0.Type.Number
	arg_1_0.PropertyTypes[arg_1_0.EventProperties.DiceHero_StepId] = arg_1_0.Type.Number
end

return var_0_0
