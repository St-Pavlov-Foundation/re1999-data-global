module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupListView", package.seeall)

slot0 = class("VersionActivity_1_2_HeroGroupListView", HeroGroupListView)

function slot0._onHeroGroupExit(slot0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if slot0._openTweenIdList then
		for slot4, slot5 in ipairs(slot0._openTweenIdList) do
			ZProj.TweenHelper.KillById(slot5)
		end
	end

	slot0._closeTweenIdList = {}

	for slot4 = 1, 4 do
		table.insert(slot0._closeTweenIdList, ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - slot4), nil, slot0._closeTweenFinish, slot0, slot4, EaseType.Linear))
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(ViewName.VersionActivity_1_2_HeroGroupView, false, false)
end

return slot0
