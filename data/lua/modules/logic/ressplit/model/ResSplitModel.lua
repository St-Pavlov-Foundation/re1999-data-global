module("modules.logic.ressplit.model.ResSplitModel", package.seeall)

local var_0_0 = class("ResSplitModel", BaseModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	arg_1_0._excludeDic = {}
	arg_1_0._excludeStoryIdsDic = {}
	arg_1_0.audioDic = arg_1_3
	arg_1_0._includeCharacterIdDic = arg_1_1
	arg_1_0._includeChapterIdDic = arg_1_2
	arg_1_0._includeStoryIdDic = arg_1_4
	arg_1_0._includeGuideIdDic = arg_1_5
	arg_1_0._includeSkinDic = {}
	arg_1_0._includeSkillDic = {}
	arg_1_0._includeTimelineDic = {}
	arg_1_0.includeSeasonDic = arg_1_8
	arg_1_0._innerBGMWenDic = {}

	var_0_0.instance:setExclude(ResSplitEnum.Folder, "effects/prefabs", false)

	for iter_1_0, iter_1_1 in pairs(arg_1_6) do
		var_0_0.instance:setExclude(ResSplitEnum.Video, iter_1_0, false)
	end

	for iter_1_2, iter_1_3 in pairs(arg_1_7) do
		var_0_0.instance:setExclude(ResSplitEnum.Path, iter_1_2, false)
	end
end

function var_0_0.isExcludeCharacter(arg_2_0, arg_2_1)
	return arg_2_0._includeCharacterIdDic[arg_2_1] ~= true
end

function var_0_0.addIncludeChapter(arg_3_0, arg_3_1)
	arg_3_0._includeChapterIdDic[arg_3_1] = true
end

function var_0_0.isExcludeChapter(arg_4_0, arg_4_1)
	return arg_4_0._includeChapterIdDic[arg_4_1] ~= true
end

function var_0_0.isExcludeSkin(arg_5_0, arg_5_1)
	return arg_5_0._includeSkinDic[arg_5_1] ~= true
end

function var_0_0.isExcludeStoryId(arg_6_0, arg_6_1)
	return arg_6_0._includeStoryIdDic[arg_6_1] ~= true
end

function var_0_0.addIncludeStory(arg_7_0, arg_7_1)
	arg_7_0._includeStoryIdDic[arg_7_1] = true
end

function var_0_0.addIncludeSkin(arg_8_0, arg_8_1)
	arg_8_0._includeSkinDic[arg_8_1] = true
end

function var_0_0.addIncludeSkill(arg_9_0, arg_9_1)
	arg_9_0._includeSkillDic[arg_9_1] = true
end

function var_0_0.addInnerBGMWenDic(arg_10_0, arg_10_1)
	arg_10_0._innerBGMWenDic[arg_10_1] = true
end

function var_0_0.getInnerBGMWenDic(arg_11_0)
	return arg_11_0._innerBGMWenDic
end

function var_0_0.addIncludeTimeline(arg_12_0, arg_12_1)
	arg_12_0._includeTimelineDic[arg_12_1] = true
end

function var_0_0.getIncludeSkill(arg_13_0)
	return arg_13_0._includeSkillDic
end

function var_0_0.getIncludeGuide(arg_14_0)
	return arg_14_0._includeGuideIdDic
end

function var_0_0.getIncludeTimelineDic(arg_15_0)
	return arg_15_0._includeTimelineDic
end

function var_0_0.setExclude(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_0._excludeDic[arg_16_1] == nil then
		arg_16_0._excludeDic[arg_16_1] = {}
	end

	local var_16_0 = arg_16_0._excludeDic[arg_16_1]

	if var_16_0[arg_16_2] ~= false then
		var_16_0[arg_16_2] = arg_16_3
	end
end

function var_0_0.getExcludeDic(arg_17_0, arg_17_1)
	return arg_17_0._excludeDic[arg_17_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
