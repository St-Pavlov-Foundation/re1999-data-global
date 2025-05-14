module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupListView", package.seeall)

local var_0_0 = class("VersionActivity_1_2_HeroGroupListView", HeroGroupListView)

function var_0_0._onHeroGroupExit(arg_1_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if arg_1_0._openTweenIdList then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_1_1)
		end
	end

	arg_1_0._closeTweenIdList = {}

	for iter_1_2 = 1, 4 do
		local var_1_0 = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - iter_1_2), nil, arg_1_0._closeTweenFinish, arg_1_0, iter_1_2, EaseType.Linear)

		table.insert(arg_1_0._closeTweenIdList, var_1_0)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(ViewName.VersionActivity_1_2_HeroGroupView, false, false)
end

return var_0_0
