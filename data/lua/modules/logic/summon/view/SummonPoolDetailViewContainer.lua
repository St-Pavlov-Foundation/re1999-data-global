module("modules.logic.summon.view.SummonPoolDetailViewContainer", package.seeall)

local var_0_0 = class("SummonPoolDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "category/#scroll_category"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = SummonPoolDetailCategoryItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 380
	var_1_1.cellHeight = 116
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 4

	table.insert(var_1_0, LuaListScrollView.New(SummonPoolDetailCategoryListModel.instance, var_1_1))
	table.insert(var_1_0, SummonPoolDetailView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "info"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			MultiView.New({
				SummonPoolDetailDescView.New(),
				SummonPoolDetailDescProbUpView.New()
			}),
			SummonPoolDetailProbabilityView.New()
		}
	end
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	arg_3_0:closeThis()
end

return var_0_0
