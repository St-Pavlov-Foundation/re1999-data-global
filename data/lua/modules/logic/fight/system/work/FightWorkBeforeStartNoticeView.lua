module("modules.logic.fight.system.work.FightWorkBeforeStartNoticeView", package.seeall)

slot0 = class("FightWorkBeforeStartNoticeView", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if not FightReplayModel.instance:isReplay() and ViewMgr.instance:isOpen(ViewName.FightQuitTipView) then
		FightController.instance:registerCallback(FightEvent.OnFightQuitTipViewClose, slot0.bootLogic, slot0)
	else
		slot0:bootLogic()
	end
end

function slot0.bootLogic(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnFightQuitTipViewClose, slot0.bootLogic, slot0)

	if uv0.canShowTips() and not FightModel.instance:isAuto() then
		FightController.instance:dispatchEvent(FightEvent.SetPlayCardPartOutScreen)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		FightController.instance:openFightSpecialTipView(true)
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.FightSpecialTipView or tabletool.indexOf(SeasonFightHandler.SeasonFightRuleTipViewList, slot1) then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.canShowTips()
	if not GMFightShowState.roundSpecialView then
		return false
	end

	slot1 = nil

	if DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightParam().episodeId) and not string.nilorempty(slot2.battleDesc) then
		slot1 = true
	end

	if lua_battle.configDict[slot0.battleId] and not string.nilorempty(slot3.additionRule) then
		if (slot2 and slot2.type) == DungeonEnum.EpisodeType.Meilanni then
			slot6 = HeroGroupFightViewRule.meilanniExcludeRules(GameUtil.splitString2(slot3.additionRule, true, "|", "#"))
			slot1 = slot1 or slot6 and #slot6 > 0
		else
			slot1 = SeasonFightHandler.canSeasonShowTips(slot5, slot4)
		end
	elseif slot4 == DungeonEnum.EpisodeType.Rouge then
		slot6 = RougeMapModel.instance:getCurNode() and slot5.eventMo
		slot7 = slot6 and slot6:getSurpriseAttackList()
		slot1 = slot7 and #slot7 > 0
	end

	if slot1 and (not GuideModel.instance:isDoingFirstGuide() or GuideController.instance:isForbidGuides()) and not FightReplayModel.instance:isReplay() then
		return true
	else
		return false
	end

	return false
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnFightQuitTipViewClose, slot0.bootLogic, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	FightController.instance:dispatchEvent(FightEvent.SetPlayCardPartOriginPos)
end

return slot0
