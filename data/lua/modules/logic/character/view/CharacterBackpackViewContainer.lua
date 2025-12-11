module("modules.logic.character.view.CharacterBackpackViewContainer", package.seeall)

local var_0_0 = class("CharacterBackpackViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_container"),
		CharacterBackpackView.New(),
		CommonRainEffectView.New("bg/#go_glowcontainer")
	}
end

function var_0_0.playCardOpenAnimation(arg_2_0)
	if arg_2_0._cardScrollView then
		arg_2_0._cardScrollView:playOpenAnimation()
	end
end

function var_0_0.playEquipOpenAnimation(arg_3_0)
	if arg_3_0._equipScrollView then
		arg_3_0._equipScrollView:playOpenAnimation()
	end
end

function var_0_0.buildTabViews(arg_4_0, arg_4_1)
	if arg_4_1 == 1 then
		arg_4_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, arg_4_0._closeCallback, nil, nil, arg_4_0)

		return {
			arg_4_0._navigateButtonView
		}
	elseif arg_4_1 == 2 then
		local var_4_0 = ListScrollParam.New()

		var_4_0.scrollGOPath = "#scroll_card"
		var_4_0.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_4_0.prefabUrl = arg_4_0._viewSetting.otherRes[1]
		var_4_0.cellClass = CharacterBackpackCardListItem
		var_4_0.scrollDir = ScrollEnum.ScrollDirV
		var_4_0.lineCount = 6
		var_4_0.cellWidth = 250
		var_4_0.cellHeight = 555
		var_4_0.cellSpaceH = 18
		var_4_0.cellSpaceV = 20
		var_4_0.startSpace = 9
		var_4_0.frameUpdateMs = 100

		local var_4_1 = {}

		for iter_4_0 = 1, 12 do
			var_4_1[iter_4_0] = math.ceil((iter_4_0 - 1) % 6) * 0.06
		end

		arg_4_0._cardScrollView = LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, var_4_0, var_4_1)

		return {
			MultiView.New({
				arg_4_0._cardScrollView,
				CharacterBackpackHeroView.New()
			})
		}
	end
end

function var_0_0.switchTab(arg_5_0, arg_5_1)
	arg_5_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_5_1)
end

function var_0_0._closeCallback(arg_6_0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function var_0_0.onContainerOpen(arg_7_0)
	arg_7_0.notPlayAnimation = true
end

function var_0_0.onContainerClose(arg_8_0)
	arg_8_0.notPlayAnimation = false
end

function var_0_0.onContainerOpenFinish(arg_9_0)
	arg_9_0._navigateButtonView:resetCloseBtnAudioId(AudioEnum.UI.UI_Rolesclose)
	arg_9_0._navigateButtonView:resetHomeBtnAudioId(AudioEnum.UI.UI_Rolesclose)
end

return var_0_0
