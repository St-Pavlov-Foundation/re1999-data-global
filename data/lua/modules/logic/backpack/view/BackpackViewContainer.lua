module("modules.logic.backpack.view.BackpackViewContainer", package.seeall)

local var_0_0 = class("BackpackViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_category"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[2]
	var_1_0.cellClass = BackpackCategoryListItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 370
	var_1_0.cellHeight = 110
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 4

	return {
		LuaListScrollView.New(BackpackCategoryListModel.instance, var_1_0),
		BackpackView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(BackpackController.BackpackViewTabContainerId, "#go_container"),
		CommonRainEffectView.New("rainEffect")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = 0

	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigationView
		}
	elseif arg_2_1 == 2 then
		local var_2_1 = ListScrollParam.New()

		var_2_1.scrollGOPath = "#scroll_prop"
		var_2_1.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_1.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_1.cellClass = BackpackPropListItem
		var_2_1.scrollDir = ScrollEnum.ScrollDirV
		var_2_1.lineCount = 6
		var_2_1.cellWidth = 254
		var_2_1.cellHeight = 200
		var_2_1.cellSpaceH = var_2_0
		var_2_1.cellSpaceV = 25
		var_2_1.startSpace = 28
		var_2_1.endSpace = 0
		var_2_1.minUpdateCountInFrame = 100

		local var_2_2 = ListScrollParam.New()

		var_2_2.scrollGOPath = "#scroll_equip"
		var_2_2.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_2.prefabUrl = arg_2_0._viewSetting.otherRes[3]
		var_2_2.cellClass = CharacterEquipItem
		var_2_2.scrollDir = ScrollEnum.ScrollDirV
		var_2_2.lineCount = 6
		var_2_2.cellWidth = 220
		var_2_2.cellHeight = 210
		var_2_2.cellSpaceH = 33.8 + var_2_0
		var_2_2.cellSpaceV = 13
		var_2_2.startSpace = 16
		var_2_2.minUpdateCountInFrame = 100

		local var_2_3 = {}
		local var_2_4

		for iter_2_0 = 1, 24 do
			var_2_3[iter_2_0] = (math.ceil(iter_2_0 / 6) - 1) * 0.03
		end

		local var_2_5 = ListScrollParam.New()

		var_2_5.scrollGOPath = "#scroll_antique"
		var_2_5.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_5.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_5.cellClass = AntiqueBackpackItem
		var_2_5.scrollDir = ScrollEnum.ScrollDirV
		var_2_5.lineCount = 6
		var_2_5.cellWidth = 250
		var_2_5.cellHeight = 250
		var_2_5.cellSpaceH = 0
		var_2_5.cellSpaceV = 0
		var_2_5.startSpace = 20
		var_2_5.endSpace = 10
		var_2_5.minUpdateCountInFrame = 100
		arg_2_0.notPlayAnimation = true

		return {
			MultiView.New({
				BackpackPropView.New(),
				LuaListScrollView.New(BackpackPropListModel.instance, var_2_1)
			}),
			MultiView.New({
				CharacterBackpackEquipView.New(),
				LuaListScrollViewWithAnimator.New(CharacterBackpackEquipListModel.instance, var_2_2, var_2_3)
			}),
			MultiView.New({
				AntiqueBackpackView.New(),
				LuaListScrollViewWithAnimator.New(AntiqueBackpackListModel.instance, var_2_5)
			})
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_Rolesclose)
end

function var_0_0.setCurrentSelectCategoryId(arg_4_0, arg_4_1)
	arg_4_0.currentSelectCategoryId = arg_4_1 or ItemEnum.CategoryType.All
end

function var_0_0.getCurrentSelectCategoryId(arg_5_0)
	return arg_5_0.currentSelectCategoryId
end

return var_0_0
