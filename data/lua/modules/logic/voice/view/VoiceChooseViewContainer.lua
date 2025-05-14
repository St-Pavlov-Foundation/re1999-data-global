module("modules.logic.voice.view.VoiceChooseViewContainer", package.seeall)

local var_0_0 = class("VoiceChooseViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "view/#scroll_content"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = VoiceChooseItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 1400
	var_1_0.cellHeight = 124
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 10
	var_1_0.startSpace = 0

	local var_1_1 = {}

	table.insert(var_1_1, LuaListScrollView.New(VoiceChooseModel.instance, var_1_0))
	table.insert(var_1_1, VoiceChooseView.New())

	return var_1_1
end

return var_0_0
