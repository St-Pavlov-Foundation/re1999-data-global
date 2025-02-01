module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupEditViewContainer", package.seeall)

slot0 = class("VersionActivity_1_2_HeroGroupEditViewContainer", HeroGroupEditViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = HeroGroupEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 440
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 37

	for slot6 = 1, 15 do
	end

	return {
		VersionActivity_1_2_HeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(HeroGroupEditListModel.instance, slot1, {
			[slot6] = math.ceil((slot6 - 1) % 5) * 0.03
		}),
		slot0:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0._overrideClose(slot0)
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.VersionActivity_1_2_HeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.VersionActivity_1_2_HeroGroupEditView, nil, true)
	end
end

return slot0
