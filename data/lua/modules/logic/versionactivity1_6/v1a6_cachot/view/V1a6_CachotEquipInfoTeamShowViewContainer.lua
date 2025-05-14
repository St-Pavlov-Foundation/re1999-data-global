module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEquipInfoTeamShowViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotEquipInfoTeamShowViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_equipcontainer/#scroll_equip"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 3
	var_1_0.cellWidth = 170
	var_1_0.cellHeight = 157.5
	var_1_0.cellSpaceH = 22
	var_1_0.cellSpaceV = 31
	var_1_0.startSpace = 13
	var_1_0.minUpdateCountInFrame = 15

	local var_1_1 = arg_1_0.viewParam.heroMo and arg_1_0.viewParam.heroMo:isTrial()

	if arg_1_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView or var_1_1 then
		arg_1_0.listModel = EquipInfoTeamListModel.instance
		var_1_0.cellClass = EquipInfoTeamItem
	elseif arg_1_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		arg_1_0.listModel = CharacterEquipSettingListModel.instance
		var_1_0.cellClass = CharacterEquipSettingItem
	elseif arg_1_0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView then
		arg_1_0.listModel = EquipInfoTeamListModel.instance
		var_1_0.cellClass = EquipInfoTeamItem
	elseif arg_1_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
		arg_1_0.listModel = V1a6_CachotEquipInfoTeamListModel.instance
		var_1_0.cellClass = V1a6_CachotEquipInfoTeamItem
	elseif arg_1_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		arg_1_0.listModel = V1a6_CachotEquipInfoTeamListModel.instance
		var_1_0.cellClass = V1a6_CachotEquipInfoTeamItem
	else
		logError("not found from view ...")

		arg_1_0.listModel = EquipInfoTeamListModel.instance
		var_1_0.cellClass = EquipInfoTeamItem
	end

	return {
		V1a6_CachotEquipInfoTeamShowView.New(),
		TabViewGroup.New(1, "#go_btns"),
		LuaListScrollView.New(arg_1_0.listModel, var_1_0)
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.EquipInfo)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.getListModel(arg_3_0)
	return arg_3_0.listModel
end

return var_0_0
