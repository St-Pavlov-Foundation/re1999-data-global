module("modules.logic.survival.view.shelter.ShelterHeroWareHouseViewContainer", package.seeall)

local var_0_0 = class("ShelterHeroWareHouseViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_card"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes.itemRes
	var_1_1.cellClass = ShelterHeroWareHouseItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 6
	var_1_1.cellWidth = 260
	var_1_1.cellHeight = 600
	var_1_1.cellSpaceH = 20
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 20
	var_1_1.frameUpdateMs = 100

	local var_1_2 = {}

	for iter_1_0 = 1, 12 do
		var_1_2[iter_1_0] = math.ceil((iter_1_0 - 1) % 6) * 0.06
	end

	arg_1_0._cardScrollView = LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, var_1_1, var_1_2)

	table.insert(var_1_0, arg_1_0._cardScrollView)
	table.insert(var_1_0, ShelterHeroWareHouseView.New())
	table.insert(var_1_0, CommonRainEffectView.New("bg/#go_glowcontainer"))
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.playCardOpenAnimation(arg_2_0)
	if arg_2_0._cardScrollView then
		arg_2_0._cardScrollView:playOpenAnimation()
	end
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_3_0._navigateButtonView
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0._navigateButtonView:resetCloseBtnAudioId(AudioEnum.UI.UI_Rolesclose)
	arg_4_0._navigateButtonView:resetHomeBtnAudioId(AudioEnum.UI.UI_Rolesclose)
end

function var_0_0.onContainerOpen(arg_5_0)
	arg_5_0.notPlayAnimation = true
end

function var_0_0.onContainerClose(arg_6_0)
	arg_6_0.notPlayAnimation = false
end

function var_0_0.playCloseTransition(arg_7_0)
	arg_7_0:onPlayCloseTransitionFinish()
end

return var_0_0
