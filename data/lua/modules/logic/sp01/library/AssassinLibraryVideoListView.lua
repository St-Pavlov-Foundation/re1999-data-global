module("modules.logic.sp01.library.AssassinLibraryVideoListView", package.seeall)

local var_0_0 = class("AssassinLibraryVideoListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollvideo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_video")
	arg_1_0._govideoitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_video/Viewport/Content/#go_videoitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addScrollView()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._actId = AssassinLibraryModel.instance:getCurActId()
	arg_6_0._libType = AssassinLibraryModel.instance:getCurLibType()
	arg_6_0._libraryCoList = AssassinConfig.instance:getLibraryConfigs(arg_6_0._actId, arg_6_0._libType)

	arg_6_0._scrollInst:setList(arg_6_0._libraryCoList)
end

function var_0_0.addScrollView(arg_7_0)
	local var_7_0 = ListScrollParam.New()

	var_7_0.scrollGOPath = "#scroll_video"
	var_7_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_7_0.prefabUrl = "#scroll_video/Viewport/Content/#go_videoitem"
	var_7_0.cellClass = AssassinLibraryVideoListItem
	var_7_0.scrollDir = ScrollEnum.ScrollDirV
	var_7_0.lineCount = 1
	var_7_0.cellWidth = 1300
	var_7_0.cellHeight = 234
	var_7_0.cellSpaceH = 0
	var_7_0.cellSpaceV = 0
	var_7_0.startSpace = 16
	var_7_0.endSpace = 16
	arg_7_0._scrollInst = ListScrollModel.New()
	arg_7_0._scrollView = LuaListScrollView.New(arg_7_0._scrollInst, var_7_0)

	arg_7_0:addChildView(arg_7_0._scrollView)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
