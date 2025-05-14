module("modules.logic.playercard.view.PlayerCardCharacterSwitchViewContainer", package.seeall)

local var_0_0 = class("PlayerCardCharacterSwitchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PlayerCardCharacterSwitchView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_characterswitchview/characterswitchview/right/mask/#scroll_card"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = PlayerCardCharacterSwitchItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 3
	var_1_1.cellWidth = 170
	var_1_1.cellHeight = 208
	var_1_1.cellSpaceH = 5
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 5
	var_1_1.endSpace = 0
	arg_1_0.scrollView = LuaListScrollView.New(PlayerCardCharacterSwitchListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideClose(arg_3_0)
	if not PlayerCardModel.instance:checkHeroDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, var_0_0.yesCallback, var_0_0.cancel)
	else
		arg_3_0:closeFunc()
	end
end

function var_0_0.cancel()
	local var_4_0, var_4_1, var_4_2, var_4_3 = PlayerCardModel.instance:getCardInfo():getMainHero()
	local var_4_4 = {
		heroId = var_4_0,
		skinId = var_4_1
	}

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshSwitchView, var_4_4)
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

function var_0_0.yesCallback()
	local var_5_0, var_5_1 = PlayerCardModel.instance:getSelectHero()

	PlayerCardCharacterSwitchListModel.instance:changeMainHero(var_5_0, var_5_1)
end

function var_0_0.closeFunc(arg_6_0)
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

return var_0_0
