module("modules.logic.sp01.library.AssassinLibraryListView", package.seeall)

local var_0_0 = class("AssassinLibraryListView", BaseView)
local var_0_1 = 0.06

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_info")
	arg_1_0._goinfoitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")

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
	arg_6_0._scrollView:playOpenAnimation()
end

function var_0_0.addScrollView(arg_7_0)
	local var_7_0 = ListScrollParam.New()

	var_7_0.scrollGOPath = "#scroll_info"
	var_7_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_7_0.prefabUrl = "#scroll_info/Viewport/Content/#go_infoitem"
	var_7_0.cellClass = AssassinLibraryListInfoItem
	var_7_0.scrollDir = ScrollEnum.ScrollDirV
	var_7_0.lineCount = 3
	var_7_0.cellWidth = 450
	var_7_0.cellHeight = 256
	var_7_0.cellSpaceH = 0
	var_7_0.cellSpaceV = 0
	var_7_0.startSpace = 16
	var_7_0.endSpace = 16

	local var_7_1 = {}
	local var_7_2

	for iter_7_0 = 1, 4 do
		var_7_1[iter_7_0] = (iter_7_0 - 1) * var_0_1
	end

	arg_7_0._scrollInst = ListScrollModel.New()
	arg_7_0._scrollView = LuaListScrollViewWithAnimator.New(arg_7_0._scrollInst, var_7_0, var_7_1)

	arg_7_0:addChildView(arg_7_0._scrollView)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
