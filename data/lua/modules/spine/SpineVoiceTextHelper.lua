module("modules.spine.SpineVoiceTextHelper", package.seeall)

local var_0_0 = class("SpineVoiceTextHelper")

function var_0_0.getSeparateContent(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}

	table.insert(var_1_0, var_0_0.getSeparateMarks(arg_1_0.content))
	table.insert(var_1_0, var_0_0.getSeparateMarks(arg_1_0.twcontent))
	table.insert(var_1_0, var_0_0.getSeparateMarks(arg_1_0.encontent))
	table.insert(var_1_0, var_0_0.getSeparateMarks(arg_1_0.kocontent))
	table.insert(var_1_0, var_0_0.getSeparateMarks(arg_1_0.jpcontent))
	table.insert(var_1_0, var_0_0.getSeparateMarks(arg_1_0.decontent))
	table.insert(var_1_0, var_0_0.getSeparateMarks(arg_1_0.frcontent))
	table.insert(var_1_0, var_0_0.getSeparateMarks(arg_1_0.thaicontent))

	local var_1_1 = ""

	if arg_1_1 == LanguageEnum.LanguageStoryType.CN then
		var_1_1 = arg_1_0.content
	elseif arg_1_1 == LanguageEnum.LanguageStoryType.TW then
		var_1_1 = arg_1_0.twcontent
	elseif arg_1_1 == LanguageEnum.LanguageStoryType.EN then
		var_1_1 = arg_1_0.encontent
	elseif arg_1_1 == LanguageEnum.LanguageStoryType.KR then
		var_1_1 = arg_1_0.kocontent
	elseif arg_1_1 == LanguageEnum.LanguageStoryType.JP then
		var_1_1 = arg_1_0.jpcontent
	elseif arg_1_1 == LanguageEnum.LanguageStoryType.DE then
		var_1_1 = arg_1_0.decontent
	elseif arg_1_1 == LanguageEnum.LanguageStoryType.FR then
		var_1_1 = arg_1_0.frcontent
	elseif arg_1_1 == LanguageEnum.LanguageStoryType.THAI then
		var_1_1 = arg_1_0.thaicontent
	end

	local var_1_2 = "(#%d+%.?%d?%d?)"

	for iter_1_0, iter_1_1 in ipairs(var_1_0[arg_1_1]) do
		var_1_1 = string.gsub(var_1_1, var_1_2, "<sep>" .. iter_1_0 .. "</sep>", 1)
	end

	local var_1_3 = 0
	local var_1_4 = var_1_0[arg_1_2]

	if (arg_1_0.audio == nil or arg_1_0.audio == 0) and #var_1_4 == 0 then
		var_1_4 = var_1_0[arg_1_1]
	end

	for iter_1_2 in string.gmatch(var_1_1, "<sep>%d+</sep>") do
		var_1_3 = var_1_3 + 1

		local var_1_5 = var_1_4[var_1_3] or "#0"

		var_1_1 = string.gsub(var_1_1, "<sep>" .. var_1_3 .. "</sep>", var_1_5)
	end

	return (StoryModel.instance:getStoryTxtByVoiceType(var_1_1, arg_1_0.audio))
end

function var_0_0.getSeparateMarks(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = "(#%d+%.?%d?)"

	for iter_2_0 in string.gmatch(arg_2_0, var_2_1) do
		table.insert(var_2_0, iter_2_0)
	end

	return var_2_0
end

return var_0_0
