module("modules.logic.fight.view.FightFocusViewContainer", package.seeall)

slot0 = class("FightFocusViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightFocusView.New(),
		TabViewGroup.New(1, "fightinfocontainer/skilltipview")
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._skillTipView = SkillTipView.New()

		return {
			slot0._skillTipView
		}
	end
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot1)
end

function slot0.showSkillTipView(slot0, slot1, slot2, slot3)
	slot0._skillTipView:showInfo(slot1, slot2, slot3)
end

function slot0.hideSkillTipView(slot0)
	slot0._skillTipView:hideInfo()
end

function slot0.playOpenTransition(slot0)
	uv0.super.playOpenTransition(slot0, {
		anim = "open"
	})
end

function slot0.playCloseTransition(slot0)
	uv0.super.playCloseTransition(slot0, {
		anim = "close"
	})
end

return slot0
