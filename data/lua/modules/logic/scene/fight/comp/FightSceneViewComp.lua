module("modules.logic.scene.fight.comp.FightSceneViewComp", package.seeall)

slot0 = class("FightSceneViewComp", BaseSceneComp)

function slot0.onScenePrepared(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.FightSkillSelectView)
	ViewMgr.instance:openView(ViewName.FightView)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	ViewMgr.instance:closeView(ViewName.FightView)
	ViewMgr.instance:closeView(ViewName.FightSkillSelectView, true)
	ViewMgr.instance:closeView(ViewName.FightTechniqueView, true)
	ViewMgr.instance:closeView(ViewName.FightTechniqueTipsView, true)
	ViewMgr.instance:closeView(ViewName.FightStatView, true)
	ViewMgr.instance:closeView(ViewName.FightSkillTargetView, true)
	ViewMgr.instance:closeView(ViewName.FightCardIntroduceView, true)
	ViewMgr.instance:closeView(ViewName.FightCardMixIntroduceView, true)
	ViewMgr.instance:closeView(ViewName.FightCardDescView, true)
	ViewMgr.instance:closeView(ViewName.FightFocusView, true)
	ViewMgr.instance:closeView(ViewName.FightBuffTipsView, true)
	ViewMgr.instance:closeView(ViewName.FightSpecialTipView, true)
	ViewMgr.instance:closeView(ViewName.FightQuitTipView, true)
	ViewMgr.instance:closeView(ViewName.FightDiceView, true)
	ViewMgr.instance:closeView(ViewName.HelpView, true)
	SeasonFightHandler.closeSeasonFightRuleTipView()
	ViewMgr.instance:closeView(ViewName.FightSkillStrengthenView, true)
	ViewMgr.instance:closeView(ViewName.FightSeasonChangeHeroSelectView, true)
	ViewMgr.instance:closeView(ViewName.FightChangeHeroSelectSkillTargetView, true)
	ViewMgr.instance:closeView(ViewName.FightNaNaTargetView, true)
	ViewMgr.instance:closeView(ViewName.FightCardDeckView, true)
end

return slot0
