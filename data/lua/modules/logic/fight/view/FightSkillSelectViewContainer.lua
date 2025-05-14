module("modules.logic.fight.view.FightSkillSelectViewContainer", package.seeall)

local var_0_0 = class("FightSkillSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightSkillSelectView.New(),
		FightSkillSelectOutline.New()
	}
end

function var_0_0.openFightFocusView(arg_2_0, arg_2_1)
	local var_2_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_2_0 and var_2_0.type == DungeonEnum.EpisodeType.Cachot then
		local var_2_1 = V1a6_CachotHeroGroupController.instance

		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = V1a6_CachotHeroGroupModel.instance:getCurGroupMO(),
			setEquipInfo = {
				var_2_1.getFightFocusEquipInfo,
				var_2_1
			},
			entityId = arg_2_1
		})

		return
	end

	if var_2_0 and var_2_0.type == DungeonEnum.EpisodeType.Rouge then
		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = RougeHeroGroupModel.instance:getCurGroupMO(),
			entityId = arg_2_1,
			balanceHelper = RougeHeroGroupBalanceHelper
		})

		return
	end

	ViewMgr.instance:openView(ViewName.FightFocusView, {
		entityId = arg_2_1
	})
end

return var_0_0
