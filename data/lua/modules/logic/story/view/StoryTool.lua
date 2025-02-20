module("modules.logic.story.view.StoryTool", package.seeall)

function StoryTool.getFilterDia(slot0)
	return string.gsub(string.gsub(string.gsub(slot0, "：", ":"), "【", "["), "】", "]")
end

function StoryTool.getFilterAlignTxt(slot0)
	return string.gsub(string.gsub(string.gsub(slot0, "<align=\"left\">", ""), "<align=\"center\">", ""), "<align=\"right\">", "")
end

function StoryTool.getTxtAlignment(slot0, slot1)
	slot2 = UnityEngine.TextAnchor.MiddleLeft

	return string.match(slot0, "<align=\"left\">") and (slot1 == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions.Left or UnityEngine.TextAnchor.MiddleLeft) or string.match(slot0, "<align=\"right\">") and (slot1 == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions.Right or UnityEngine.TextAnchor.MiddleRight) or slot1 == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions.Center or UnityEngine.TextAnchor.MiddleCenter
end

function StoryTool.filterMarkTop(slot0)
	for slot6 = 1, #string.split(slot0, "</marktop>") do
		slot7 = string.gsub(slot2[slot6], "(<marktop=%s>)", "")
		slot10 = string.format("<marktop=%s>", string.split(string.split(slot7, "<marktop=")[2], ">")[1])

		if string.find(slot7, slot10) then
			slot1 = "" .. string.gsub(slot7, slot10, "<nobr>") .. "​</nobr>"
		end
	end

	return slot1
end

function StoryTool.filterSpTag(slot0)
	slot1 = string.gsub(slot0, "<em>", "")

	return string.gsub(string.gsub(string.gsub(string.gsub(slot0, "</em>", ""), "<speed=%d[%d.]*>", ""), "<brace>", "{"), "</brace>", "}")
end

function StoryTool.getMarkTextIndexs(slot0)
	slot1 = {}

	if #string.split(slot0, "<em>") < 2 then
		return {}
	end

	slot8 = GameUtil.utf8len(slot2[1])

	table.insert({}, slot8)

	for slot8 = 2, #slot2 do
		slot9 = string.split(slot2[slot8], "</em>")

		table.insert(slot3, GameUtil.utf8len(slot9[1]) + GameUtil.utf8len(slot9[2]))

		for slot16 = 1, slot8 - 1 do
			slot12 = 0 + slot3[slot16]
		end

		for slot16 = 1, slot10 do
			table.insert(slot1, slot12 + slot16 - 1)
		end
	end

	return slot1
end

function StoryTool.getMarkTopTextList(slot0)
	slot1 = {}

	if slot0 and slot0 ~= "" and #string.split(slot0, "</marktop>") > 1 then
		for slot6 = 1, #slot2 - 1 do
			slot8 = string.split(string.split(slot2[slot6], "<marktop=")[2], ">")

			table.insert(slot1, slot8[1] .. "|" .. slot8[2] .. "​")
		end
	end

	return slot1
end

function StoryTool.enablePostProcess(slot0)
	if not StoryController.instance._showBlur then
		PostProcessingMgr.instance:setUIPPValue("localMaskActive", slot0)
	end

	if StoryController.instance._showBlur then
		return
	end

	if slot0 then
		TaskDispatcher.runDelay(function ()
			PostProcessingMgr.instance:setUIPPValue("bloomActive", true)
		end, nil, 0.1)
	else
		PostProcessingMgr.instance:setUIPPValue("bloomActive", false)
	end

	if StoryController.instance._showBlur then
		return
	end

	StoryModel.instance:setUIActive(slot0)
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

function StoryTool.FilterStrByPatterns(slot0, slot1)
	slot2 = slot0

	for slot6, slot7 in pairs(slot1) do
		slot2 = slot2:gsub(slot7, "")
	end

	return slot2
end

return StoryTool
