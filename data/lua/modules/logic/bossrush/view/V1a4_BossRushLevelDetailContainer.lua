module("modules.logic.bossrush.view.V1a4_BossRushLevelDetailContainer", package.seeall)

slot0 = class("V1a4_BossRushLevelDetailContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._bossRushViewRule = V1a4_BossRushViewRule.New()
	slot0._levelDetail = V1a4_BossRushLevelDetail.New()

	return {
		slot0._levelDetail,
		TabViewGroup.New(1, "top_left"),
		slot0._bossRushViewRule
	}
end

function slot0.getBossRushViewRule(slot0)
	return slot0._bossRushViewRule
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, slot0._closeCallback, nil, , slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.playCloseTransition(slot0)
	slot0._levelDetail:playCloseTransition()
end

function slot0.playOpenTransition(slot0)
	slot0:onPlayOpenTransitionFinish()
end

function slot0.diffRootChild(slot0, slot1)
	slot0:setRootChild(slot1)

	return true
end

function slot0.setRootChild(slot0, slot1)
	slot1._goadditionRule = gohelper.findChild(gohelper.findChild(slot1.viewGO, "DetailPanel/Condition"), "#scroll_ConditionIcons")
	slot1._goruletemp = gohelper.findChild(slot1._goadditionRule, "#go_ruletemp")
	slot1._imagetagicon = gohelper.findChildImage(slot1._goruletemp, "#image_tagicon")
	slot1._gorulelist = gohelper.findChild(slot1._goadditionRule, "Viewport/content")
	slot1._btnadditionRuleclick = gohelper.findChildButtonWithAudio(slot1._goadditionRule, "#btn_additionRuleclick")
end

return slot0
