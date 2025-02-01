module("modules.logic.fight.view.FightSkillSelectViewContainer", package.seeall)

slot0 = class("FightSkillSelectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightSkillSelectView.New(),
		FightSkillSelectOutline.New()
	}
end

function slot0.openFightFocusView(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot2.type == DungeonEnum.EpisodeType.Cachot then
		slot3 = V1a6_CachotHeroGroupController.instance

		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = V1a6_CachotHeroGroupModel.instance:getCurGroupMO(),
			setEquipInfo = {
				slot3.getFightFocusEquipInfo,
				slot3
			},
			entityId = slot1
		})

		return
	end

	if slot2 and slot2.type == DungeonEnum.EpisodeType.Rouge then
		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = RougeHeroGroupModel.instance:getCurGroupMO(),
			entityId = slot1,
			balanceHelper = RougeHeroGroupBalanceHelper
		})

		return
	end

	ViewMgr.instance:openView(ViewName.FightFocusView, {
		entityId = slot1
	})
end

return slot0
