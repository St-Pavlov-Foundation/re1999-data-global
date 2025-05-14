module("modules.logic.player.view.ShowCharacterViewContainer", package.seeall)

local var_0_0 = class("ShowCharacterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_rolecontainer/#scroll_card"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = ShowCharacterCardItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 7
	var_1_1.cellWidth = 267
	var_1_1.cellHeight = 550
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	var_1_1.frameUpdateMs = 100

	local var_1_2 = {}

	for iter_1_0 = 1, 14 do
		var_1_2[iter_1_0] = math.ceil(iter_1_0 - 1) % 7 * 0.06
	end

	table.insert(var_1_0, LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, var_1_1, var_1_2))
	table.insert(var_1_0, ShowCharacterView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 101, arg_2_0.onClose, arg_2_0.onClose, nil, arg_2_0)

	return {
		arg_2_0.navigationView
	}
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Open)
	arg_3_0.navigationView:resetHomeBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

function var_0_0.onClose(arg_4_0)
	local var_4_0 = PlayerModel.instance:getShowHeroUid()

	PlayerRpc.instance:sendSetShowHeroUniqueIdsRequest(var_4_0)
end

return var_0_0
