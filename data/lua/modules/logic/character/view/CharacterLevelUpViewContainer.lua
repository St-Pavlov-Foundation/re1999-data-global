module("modules.logic.character.view.CharacterLevelUpViewContainer", package.seeall)

slot0 = class("CharacterLevelUpViewContainer", BaseViewContainer)
slot1 = 130

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "anim/lv/#go_Lv/#scroll_Num"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "anim/lv/#go_Lv/#scroll_Num/Viewport/Content/#go_Item"
	slot1.cellClass = CharacterLevelItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = uv0
	slot1.cellHeight = 120
	slot1.startSpace = 280
	slot1.endSpace = 280
	slot0.characterLevelUpView = CharacterLevelUpView.New()

	return {
		slot0.characterLevelUpView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		LuaListScrollView.New(CharacterLevelListModel.instance, slot1)
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot2 = CurrencyEnum.CurrencyType

	return {
		CurrencyView.New({
			slot2.Gold,
			slot2.HeroExperience
		}, slot0._onCurrencyClick, slot0, true)
	}
end

function slot0._onCurrencyClick(slot0)
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpViewClick)
end

function slot0.setWaitHeroLevelUpRefresh(slot0, slot1)
	slot0._waitHeroLevelUpRefresh = slot1
end

function slot0.getWaitHeroLevelUpRefresh(slot0)
	return slot0._waitHeroLevelUpRefresh
end

function slot0.setLocalUpLevel(slot0, slot1)
	slot0.localUpLevel = slot1
end

function slot0.getLocalUpLevel(slot0)
	return slot0.localUpLevel
end

function slot0.onContainerClose(slot0)
	slot0:setWaitHeroLevelUpRefresh(false)
	slot0:setLocalUpLevel()
end

function slot0.getLevelItemWidth(slot0)
	return uv0
end

function slot0.playCloseTransition(slot0, slot1)
	if GuideModel.instance:getDoingGuideId() == 108 then
		slot0:onPlayCloseTransitionFinish()
	else
		uv0.super.playCloseTransition(slot0, slot1)
	end
end

return slot0
