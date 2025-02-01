module("modules.logic.equip.view.EquipInfoTeamShowViewContainer", package.seeall)

slot0 = class("EquipInfoTeamShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_equipcontainer/#scroll_equip"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 3
	slot1.cellWidth = 170
	slot1.cellHeight = 157.5
	slot1.cellSpaceH = 22
	slot1.cellSpaceV = 31
	slot1.startSpace = 13
	slot1.minUpdateCountInFrame = 15

	if slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView or slot0.viewParam.heroMo and slot0.viewParam.heroMo:isTrial() or slot0.viewParam.heroMo and slot0.viewParam.heroMo:isOtherPlayerHero() then
		slot0.listModel = EquipInfoTeamListModel.instance
		slot1.cellClass = EquipInfoTeamItem
	elseif slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		slot0.listModel = CharacterEquipSettingListModel.instance
		slot1.cellClass = CharacterEquipSettingItem
	elseif slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView or slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView or slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView then
		slot0.listModel = EquipInfoTeamListModel.instance
		slot1.cellClass = EquipInfoTeamItem
	elseif slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
		slot0.listModel = EquipInfoTeamListModel.instance
		slot1.cellClass = EquipInfoTeamItem
	elseif slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		slot0.listModel = V1a6_CachotEquipInfoTeamListModel.instance
		slot1.cellClass = V1a6_CachotEquipInfoTeamItem
	else
		logError("not found from view ...")

		slot0.listModel = EquipInfoTeamListModel.instance
		slot1.cellClass = EquipInfoTeamItem
	end

	return {
		EquipInfoTeamShowView.New(),
		TabViewGroup.New(1, "#go_btns"),
		LuaListScrollView.New(slot0.listModel, slot1)
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.EquipInfo)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.getBalanceEquipLv(slot0)
	if slot0.viewParam.balanceEquipLv then
		return slot1
	end

	slot2, slot3, slot4 = HeroGroupBalanceHelper.getBalanceLv()

	return slot4
end

function slot0.getListModel(slot0)
	return slot0.listModel
end

return slot0
