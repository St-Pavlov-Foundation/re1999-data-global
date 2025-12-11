module("modules.logic.gm.view.GMToolViewContainer", package.seeall)

local var_0_0 = class("GMToolViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "addItem/scroll"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "addItem/scroll/item"
	var_1_0.cellClass = GMAddItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 794
	var_1_0.cellHeight = 100
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "gmcommand/img/scroll"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "gmcommand/img/scroll/item"
	var_1_1.cellClass = GMCommandItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 950
	var_1_1.cellHeight = 100
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 5

	return {
		GMToolView.New(),
		GMToolView2.New(),
		GMAddItemView.New(),
		GMCommandHistoryView.New(),
		GMCommandView.New(),
		GMToolFightView.New(),
		GMAudioTool.New(),
		GMRougeTool.New(),
		LuaListScrollView.New(GMAddItemModel.instance, var_1_0),
		LuaListScrollView.New(GMCommandModel.instance, var_1_1),
		GMSubViewOldView.New(),
		GMSubViewCommon.New(),
		GMSubViewNewFightView.New(),
		GMSubViewBattle.New(),
		GMSubViewAudio.New(),
		GMSubViewGuide.New(),
		GMSubViewActivity.New(),
		GMSubViewSurvival.New(),
		GMSubViewRole.New(),
		GMSubViewCode.New(),
		GMSubViewRouge.New(),
		GMSubViewResource.New(),
		GMSubViewProfiler.New(),
		GMSubViewRoom.New(),
		GMSubViewEliminate.New(),
		GMSubViewEditorFight.New(),
		GMYeShuMeiBtnView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0.viewName)
end

function var_0_0.addSubViewToggle(arg_3_0, arg_3_1)
	arg_3_0.toggleList = arg_3_0.toggleList or arg_3_0:getUserDataTb_()

	table.insert(arg_3_0.toggleList, arg_3_1)
end

function var_0_0.selectToggle(arg_4_0, arg_4_1)
	if arg_4_0.toggleList then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.toggleList) do
			if iter_4_1 == arg_4_1 then
				PlayerPrefsHelper.setNumber("GMLastSelectIndexKey", iter_4_0)
			end
		end
	end
end

function var_0_0.onContainerOpenFinish(arg_5_0)
	local var_5_0 = PlayerPrefsHelper.getNumber("GMLastSelectIndexKey", 1)
	local var_5_1 = arg_5_0.toggleList and arg_5_0.toggleList[var_5_0]

	if var_5_1 then
		var_5_1.isOn = true
	end
end

return var_0_0
