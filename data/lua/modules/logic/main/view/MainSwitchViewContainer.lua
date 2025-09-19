module("modules.logic.main.view.MainSwitchViewContainer", package.seeall)

local var_0_0 = class("MainSwitchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MainSwitchView.New())
	table.insert(var_1_0, TabViewGroupFit.New(1, "#go_container"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 2 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0.overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end

	if arg_2_1 == 1 then
		local var_2_0 = {}

		arg_2_0:_addCharacterSwitch(var_2_0)
		arg_2_0:_addSceneClassify(var_2_0)
		arg_2_0:_addFightUISwitch(var_2_0)

		return var_2_0
	end

	if arg_2_1 == 3 then
		local var_2_1 = {}

		arg_2_0:_addSceneSwitch(var_2_1)
		arg_2_0:_addUISwitch(var_2_1)

		return var_2_1
	end

	if arg_2_1 == 4 then
		local var_2_2 = {}

		arg_2_0:_addMainUI(var_2_2)

		return var_2_2
	end
end

function var_0_0.getMainHeroView(arg_3_0)
	return arg_3_0._mainUIHeroView
end

function var_0_0.switchMainUI(arg_4_0, arg_4_1)
	arg_4_0._mainUISwitchView:refreshMainUI(arg_4_1)
end

function var_0_0._addCharacterSwitch(arg_5_0, arg_5_1)
	local var_5_0 = {}

	arg_5_0._characterSwitchView = CharacterSwitchView.New()

	table.insert(var_5_0, arg_5_0._characterSwitchView)

	local var_5_1 = ListScrollParam.New()

	var_5_1.scrollGOPath = "right/mask/#scroll_card"
	var_5_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_5_1.prefabUrl = arg_5_0._viewSetting.tabRes[1][1][2]
	var_5_1.cellClass = CharacterSwitchItem
	var_5_1.scrollDir = ScrollEnum.ScrollDirV
	var_5_1.lineCount = 3
	var_5_1.cellWidth = 170
	var_5_1.cellHeight = 208
	var_5_1.cellSpaceH = 5
	var_5_1.cellSpaceV = 0
	var_5_1.startSpace = 5
	var_5_1.endSpace = 0
	arg_5_0._characterScrollView = LuaListScrollView.New(CharacterSwitchListModel.instance, var_5_1)

	table.insert(var_5_0, arg_5_0._characterScrollView)

	arg_5_1[MainEnum.SwitchType.Character] = MultiView.New(var_5_0)
end

function var_0_0.getCharacterScrollView(arg_6_0)
	return arg_6_0._characterScrollView
end

function var_0_0._addSceneClassify(arg_7_0, arg_7_1)
	local var_7_0 = {}

	arg_7_0._classifyView = MainSwitchClassifyView.New()

	table.insert(var_7_0, arg_7_0._classifyView)
	table.insert(var_7_0, TabViewGroupFit.New(3, "root"))

	local var_7_1 = ListScrollParam.New()

	var_7_1.scrollGOPath = "left/#go_left"
	var_7_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_7_1.prefabUrl = arg_7_0._viewSetting.otherRes[3]
	var_7_1.cellClass = MainSwitchClassifyInfoItem
	var_7_1.scrollDir = ScrollEnum.ScrollDirV
	var_7_1.cellWidth = 400
	var_7_1.cellHeight = 160

	table.insert(var_7_0, LuaListScrollView.New(MainSwitchClassifyListModel.instance, var_7_1))

	arg_7_1[MainEnum.SwitchType.Scene] = MultiView.New(var_7_0)
end

function var_0_0._addMainSceneSwitchList(arg_8_0, arg_8_1)
	local var_8_0 = MixScrollParam.New()

	var_8_0.scrollGOPath = "right/mask/#scroll_card"
	var_8_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_8_0.prefabUrl = arg_8_0._viewSetting.tabRes[1][2][2]
	var_8_0.cellClass = MainSceneSwitchItem
	var_8_0.scrollDir = ScrollEnum.ScrollDirV
	var_8_0.lineCount = 1

	table.insert(arg_8_1, LuaMixScrollView.New(MainSceneSwitchListModel.instance, var_8_0))
end

function var_0_0._addSceneSwitch(arg_9_0, arg_9_1)
	local var_9_0 = {}

	arg_9_0._displayView = MainSceneSwitchDisplayView.New()

	table.insert(var_9_0, arg_9_0._displayView)
	table.insert(var_9_0, MainSceneSwitchNewView.New())
	arg_9_0:_addMainSceneSwitchList(var_9_0)

	arg_9_1[MainSwitchClassifyEnum.Classify.Scene] = MultiView.New(var_9_0)
end

function var_0_0._addMainUISwitchList(arg_10_0, arg_10_1)
	local var_10_0 = MixScrollParam.New()

	var_10_0.scrollGOPath = "right/mask/#scroll_card"
	var_10_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_10_0.prefabUrl = arg_10_0._viewSetting.tabRes[1][2][2]
	var_10_0.cellClass = MainUISwitchItem
	var_10_0.scrollDir = ScrollEnum.ScrollDirV
	var_10_0.lineCount = 1

	table.insert(arg_10_1, LuaMixScrollView.New(MainUISwitchListModel.instance, var_10_0))
end

function var_0_0._addUISwitch(arg_11_0, arg_11_1)
	local var_11_0 = {}

	table.insert(var_11_0, MainUISwitchView.New())
	table.insert(var_11_0, TabViewGroupFit.New(4, "middle/#go_mainUI"))
	arg_11_0:_addMainUISwitchList(var_11_0)

	arg_11_1[MainSwitchClassifyEnum.Classify.UI] = MultiView.New(var_11_0)
end

function var_0_0._addMainUI(arg_12_0, arg_12_1)
	local var_12_0 = {}

	arg_12_0._mainUIHeroView = SwitchMainHeroView.New()

	table.insert(var_12_0, SwitchMainUIShowView.New())
	table.insert(var_12_0, SwitchMainActivityEnterView.New())
	table.insert(var_12_0, SwitchMainActExtraDisplay.New())
	table.insert(var_12_0, arg_12_0._mainUIHeroView)
	table.insert(var_12_0, SwitchMainUIEagleAnimView.New())
	table.insert(var_12_0, SwitchMainUIView.New())

	arg_12_1[1] = MultiView.New(var_12_0)
	arg_12_0._mainUIViews = var_12_0

	return arg_12_1[1]
end

function var_0_0._addFightUISwitch(arg_13_0, arg_13_1)
	local var_13_0 = {}

	table.insert(var_13_0, FightUISwitchView.New())

	local var_13_1 = MixScrollParam.New()

	var_13_1.scrollGOPath = "root/#go_right/#scroll_style"
	var_13_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_13_1.prefabUrl = arg_13_0._viewSetting.tabRes[1][3][2]
	var_13_1.cellClass = FightUISwitchItem
	var_13_1.scrollDir = ScrollEnum.ScrollDirV
	var_13_1.lineCount = 1

	table.insert(var_13_0, LuaMixScrollView.New(FightUISwitchListModel.instance, var_13_1))

	arg_13_1[MainEnum.SwitchType.FightUI] = MultiView.New(var_13_0)
end

function var_0_0.switchTab(arg_14_0, arg_14_1)
	arg_14_0:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_14_1)

	if arg_14_0._displayView and arg_14_0._displayView:isShowView() then
		if arg_14_1 == MainEnum.SwitchType.Scene then
			arg_14_0._displayView:showTab()
		else
			arg_14_0._displayView:hideTab()
		end
	end
end

function var_0_0.switchClassifyTab(arg_15_0, arg_15_1)
	arg_15_0._classifyTabId = arg_15_1

	arg_15_0:dispatchEvent(ViewEvent.ToSwitchTab, 3, arg_15_1)
end

function var_0_0.getClassify(arg_16_0)
	return arg_16_0._classifyTabId or MainSwitchClassifyEnum.Classify.Scene
end

function var_0_0.isInitMainFullView(arg_17_0)
	return false
end

function var_0_0.playCloseAnim(arg_18_0, arg_18_1)
	local var_18_0 = false

	if arg_18_0._lastTabId then
		local var_18_1 = arg_18_0._views[2] and arg_18_0._views[2]._tabViews[arg_18_0._lastTabId]

		if var_18_1 and var_18_1.viewGO then
			local var_18_2 = SLFramework.AnimatorPlayer.Get(var_18_1.viewGO)

			if var_18_2 then
				local function var_18_3()
					arg_18_0:switchTab(arg_18_1)
				end

				var_18_2:Play("close", var_18_3, arg_18_0)

				var_18_0 = true
			end
		end
	end

	local var_18_4 = arg_18_0._views[2] and arg_18_0._views[2]._tabViews[arg_18_1]

	if var_18_4 and var_18_4.viewGO then
		local var_18_5 = var_18_4.viewGO:GetComponent(typeof(UnityEngine.Animator))

		if var_18_5 then
			var_18_5.enabled = true

			var_18_5:Play("open", 0, 0)
		end
	end

	arg_18_0._lastTabId = arg_18_1

	if not var_18_0 then
		arg_18_0:switchTab(arg_18_1)
	end
end

function var_0_0.overrideCloseFunc(arg_20_0)
	local var_20_0 = false

	if arg_20_0._lastTabId then
		local var_20_1 = arg_20_0._views[2] and arg_20_0._views[2]._tabViews[arg_20_0._lastTabId]

		if var_20_1 and var_20_1.viewGO then
			local var_20_2 = SLFramework.AnimatorPlayer.Get(var_20_1.viewGO)

			if var_20_2 then
				var_20_2:Play("close", arg_20_0.closeThis, arg_20_0)

				var_20_0 = true
			end
		end
	end

	if not var_20_0 then
		arg_20_0:closeThis()
	end
end

return var_0_0
