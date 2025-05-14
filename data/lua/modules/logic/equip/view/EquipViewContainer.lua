module("modules.logic.equip.view.EquipViewContainer", package.seeall)

local var_0_0 = class("EquipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_category"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = EquipCategoryItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 300
	var_1_0.cellHeight = 120
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_equip"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[4]
	var_1_1.cellClass = EquipChooseItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 3
	var_1_1.cellWidth = 228
	var_1_1.cellHeight = 218
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 2.22
	var_1_1.startSpace = 0

	local var_1_2 = ListScrollParam.New()

	var_1_2.scrollGOPath = "#scroll_refine_equip"
	var_1_2.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_2.prefabUrl = arg_1_0._viewSetting.otherRes[4]
	var_1_2.cellClass = EquipRefineItem
	var_1_2.scrollDir = ScrollEnum.ScrollDirV
	var_1_2.lineCount = 3
	var_1_2.cellWidth = 228
	var_1_2.cellHeight = 218
	var_1_2.cellSpaceH = 1.92
	var_1_2.cellSpaceV = 3
	var_1_2.startSpace = 0

	local var_1_3 = ListScrollParam.New()

	var_1_3.scrollGOPath = "#scroll_costequip"
	var_1_3.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_3.prefabUrl = arg_1_0._viewSetting.otherRes[5]
	var_1_3.cellClass = EquipSelectedItem
	var_1_3.scrollDir = ScrollEnum.ScrollDirH
	var_1_3.lineCount = 1
	var_1_3.cellWidth = 127
	var_1_3.cellHeight = 150
	var_1_3.cellSpaceH = 8
	var_1_3.cellSpaceV = 0
	var_1_3.startSpace = 8
	var_1_3.endSpace = 8
	var_1_3.minUpdateCountInFrame = 5
	arg_1_0.equipView = EquipView.New()
	arg_1_0.tableView = EquipTabViewGroup.New(2, "right")

	return {
		LuaListScrollView.New(EquipCategoryListModel.instance, var_1_0),
		LuaListScrollView.New(EquipChooseListModel.instance, var_1_1),
		LuaListScrollView.New(EquipRefineListModel.instance, var_1_2),
		LuaListScrollView.New(EquipSelectedListModel.instance, var_1_3),
		arg_1_0.equipView,
		TabViewGroup.New(1, "#go_btns"),
		arg_1_0.tableView,
		TabViewGroup.New(3, "#go_righttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
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
		local var_2_0 = ListScrollParam.New()

		var_2_0.scrollGOPath = "#go_effect/#go_cost/#scroll_cost"
		var_2_0.prefabType = ScrollEnum.ScrollPrefabFromView
		var_2_0.prefabUrl = "#go_effect/#go_cost/#scroll_cost/Viewport/#go_cost_item"
		var_2_0.cellClass = EquipRefineSelectedItem
		var_2_0.scrollDir = ScrollEnum.ScrollDirH
		var_2_0.lineCount = 1
		var_2_0.cellWidth = 124
		var_2_0.cellHeight = 127
		var_2_0.cellSpaceH = 18
		var_2_0.cellSpaceV = 0
		var_2_0.startSpace = 0
		var_2_0.endSpace = 0
		arg_2_0.equipInfoView = EquipInfoView.New()
		arg_2_0.equipStrengthenView = EquipStrengthenView.New()
		arg_2_0.equipRefineView = EquipRefineView.New()
		arg_2_0.equipStoryView = EquipStoryView.New()

		return {
			arg_2_0.equipInfoView,
			arg_2_0.equipStrengthenView,
			MultiView.New({
				arg_2_0.equipRefineView,
				LuaListScrollView.New(EquipRefineSelectedListModel.instance, var_2_0)
			}),
			arg_2_0.equipStoryView
		}
	elseif arg_2_1 == 3 then
		local var_2_1 = CurrencyView.New({
			CurrencyEnum.CurrencyType.Gold
		})

		var_2_1:overrideCurrencyClickFunc(arg_2_0.onClickCurrency, arg_2_0)

		return {
			var_2_1
		}
	end
end

function var_0_0.onClickCurrency(arg_3_0, arg_3_1)
	local var_3_0 = JumpController.instance:getCurrentOpenedView()

	for iter_3_0 = #var_3_0, 1, -1 do
		local var_3_1 = var_3_0[iter_3_0]

		if var_3_1.viewName == arg_3_0.viewName then
			var_3_1.viewParam = var_3_1.viewParam or {}
			var_3_1.viewParam.defaultTabIds = {
				[2] = 2
			}
		elseif var_3_1.viewName == ViewName.BackpackView then
			var_3_1.viewParam = var_3_1.viewParam or {}
			var_3_1.viewParam.defaultTabIds = {
				[BackpackController.BackpackViewTabContainerId] = 2
			}
		end
	end

	if type(arg_3_1) == "number" then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, arg_3_1, false, nil, arg_3_0._cantJump, {
			type = MaterialEnum.MaterialType.Currency,
			id = arg_3_1,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = var_3_0
		})
	else
		MaterialTipController.instance:showMaterialInfo(arg_3_1.type, arg_3_1.id, false, nil, arg_3_0._cantJump, {
			type = arg_3_1.type,
			id = arg_3_1.id,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = var_3_0
		})
	end
end

function var_0_0.playCloseTransition(arg_4_0)
	TaskDispatcher.runDelay(arg_4_0.onPlayCloseTransitionFinish, arg_4_0, 0.05)
end

function var_0_0.onContainerOpenFinish(arg_5_0)
	arg_5_0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_checkpoint_story_close)
end

function var_0_0.setIsOpenLeftBackpack(arg_6_0, arg_6_1)
	arg_6_0.isOpenLeftBackpack = arg_6_1
end

function var_0_0.getIsOpenLeftBackpack(arg_7_0)
	return arg_7_0.isOpenLeftBackpack or false
end

function var_0_0.isOpenLeftStrengthenScroll(arg_8_0)
	return arg_8_0.equipView._isShowStrengthenScroll
end

function var_0_0.playCurrencyViewAnimation(arg_9_0, arg_9_1)
	arg_9_0.equipView:playCurrencyViewAnimation(arg_9_1)
end

return var_0_0
