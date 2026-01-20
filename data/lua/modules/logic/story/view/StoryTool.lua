-- chunkname: @modules/logic/story/view/StoryTool.lua

module("modules.logic.story.view.StoryTool", package.seeall)

function StoryTool.getFilterDia(txt)
	local txt = string.gsub(txt, "：", ":")

	txt = string.gsub(txt, "【", "[")
	txt = string.gsub(txt, "】", "]")

	return txt
end

function StoryTool.getFilterAlignTxt(txt)
	local result = string.gsub(txt, "<align=\"left\">", "")

	result = string.gsub(result, "<align=\"center\">", "")
	result = string.gsub(result, "<align=\"right\">", "")

	return result
end

function StoryTool.getTxtAlignment(txt, type)
	local align = UnityEngine.TextAnchor.MiddleLeft

	if string.match(txt, "<align=\"left\">") then
		align = type == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions.Left or UnityEngine.TextAnchor.MiddleLeft
	elseif string.match(txt, "<align=\"right\">") then
		align = type == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions.Right or UnityEngine.TextAnchor.MiddleRight
	else
		align = type == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions.Center or UnityEngine.TextAnchor.MiddleCenter
	end

	return align
end

function StoryTool.filterMarkTop(txt)
	local result = ""
	local tops = string.split(txt, "</marktop>")

	for i = 1, #tops do
		local filterTxt = string.gsub(tops[i], "(<marktop=%s>)", "")
		local marks = string.split(filterTxt, "<marktop=")
		local contents = string.split(marks[2], ">")
		local markTag = string.format("<marktop=%s>", contents[1])
		local content = string.gsub(filterTxt, markTag, "<nobr>")

		result = result .. content

		if string.find(filterTxt, markTag) then
			for j = 1, i do
				result = result .. "​"
			end

			result = result .. "</nobr>"
		end
	end

	return result
end

function StoryTool.filterSpTag(txt)
	local result = string.gsub(txt, "<em>", "")

	result = string.gsub(txt, "</em>", "")
	result = string.gsub(result, "<speed=%d[%d.]*>", "")
	result = string.gsub(result, "<brace>", "{")
	result = string.gsub(result, "</brace>", "}")

	return result
end

function StoryTool.getMarkTextIndexs(txt)
	local result = {}
	local diaStrs = string.split(txt, "<em>")

	if #diaStrs < 2 then
		return {}
	end

	local splitLengths = {}
	local length = GameUtil.utf8len(diaStrs[1])

	table.insert(splitLengths, length)

	for i = 2, #diaStrs do
		local splitStr = string.split(diaStrs[i], "</em>")
		local splitLength1 = GameUtil.utf8len(splitStr[1])
		local splitLength2 = GameUtil.utf8len(splitStr[2])

		table.insert(splitLengths, splitLength1 + splitLength2)

		local preLength = 0

		for j = 1, i - 1 do
			preLength = preLength + splitLengths[j]
		end

		for k = 1, splitLength1 do
			table.insert(result, preLength + k - 1)
		end
	end

	return result
end

function StoryTool.getMarkTopTextList(txt)
	local list = {}

	if txt and txt ~= "" then
		local tops = string.split(txt, "</marktop>")

		if #tops > 1 then
			for i = 1, #tops - 1 do
				local marks = string.split(tops[i], "<marktop=")
				local contents = string.split(marks[2], ">")
				local o = contents[1] .. "|" .. contents[2]

				for j = 1, i do
					o = o .. "​"
				end

				table.insert(list, o)
			end
		end
	end

	return list
end

function StoryTool.enablePostProcess(enable)
	if not StoryController.instance._showBlur then
		PostProcessingMgr.instance:setUIPPValue("localMaskActive", enable)
	end

	if StoryController.instance._showBlur then
		return
	end

	if enable then
		TaskDispatcher.runDelay(function()
			PostProcessingMgr.instance:setUIPPValue("bloomActive", true)
		end, nil, 0.1)
	else
		PostProcessingMgr.instance:setUIPPValue("bloomActive", false)
	end

	if StoryController.instance._showBlur then
		return
	end

	StoryModel.instance:setUIActive(enable)
end

StoryTool.spineTbt = {
	{
		heroIcon = "300101",
		path = ResUrl.getRolesCgStory("504301_banshen")
	},
	{
		heroIcon = "507601",
		path = ResUrl.getRolesPrefabStory("507601_zhujue_p")
	},
	{
		heroIcon = "507701",
		path = ResUrl.getRolesPrefabStory("507701_zhujue_p")
	},
	{
		heroIcon = "508701",
		path = ResUrl.getRolesPrefabStory("508701_binghao_p")
	},
	{
		heroIcon = "511201",
		path = ResUrl.getRolesCgStory("511201_heipao", "v1a4_511201_heipao")
	}
}

function StoryTool.FilterStrByPatterns(str, patterns)
	local result = str

	for _, v in pairs(patterns) do
		result = result.gsub(result, v, "")
	end

	return result
end

return StoryTool
