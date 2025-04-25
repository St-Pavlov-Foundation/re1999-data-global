module("modules.logic.versionactivity2_5.challenge.view.Act183FightSuccView", package.seeall)

slot0 = class("Act183FightSuccView", FightSuccView)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._additionitem = gohelper.findChild(slot0.viewGO, "goalcontent/goallist/addition")
end

function slot0._onClickClose(slot0)
	if not slot0._canClick or slot0._isStartToCloseView then
		return
	end

	if slot0._reChallenge and slot0._episodeType ~= Act183Enum.EpisodeType.Boss and ActivityHelper.getActivityStatus(slot0._activityId) == ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act183ReplaceResult, MsgBoxEnum.BoxType.Yes_No, slot0._confrimReplaceResult, slot0._cancelReplaceResult, nil, slot0, slot0)

		return
	end

	slot0:_reallyStartToCloseView()
end

function slot0._confrimReplaceResult(slot0)
	Activity183Rpc.instance:sendAct183ReplaceResultRequest(slot0._activityId, slot0._episodeId, slot0._reallyStartToCloseView, slot0)
end

function slot0._cancelReplaceResult(slot0)
	Act183Model.instance:clearBattleFinishedInfo()
	slot0:_reallyStartToCloseView()
end

function slot0._reallyStartToCloseView(slot0)
	uv0.super._onClickClose(slot0)

	slot0._isStartToCloseView = true
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)

	slot0._conditionItemTab = slot0:getUserDataTb_()

	slot0:initBattleFinishInfo()
	slot0:refreshFightConditions()
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onClickClose, slot0)
end

function slot0.initBattleFinishInfo(slot0)
	slot1 = Act183Model.instance:getBattleFinishedInfo()
	slot0._activityId = slot1.activityId
	slot0._episodeMo = slot1.episodeMo
	slot0._fightResultMo = slot1.fightResultMo
	slot0._episodeId = slot0._episodeMo and slot0._episodeMo:getEpisodeId()
	slot0._episodeType = slot0._episodeMo and slot0._episodeMo:getEpisodeType()
	slot0._reChallenge = slot1 and slot1.reChallenge
end

function slot0.refreshFightConditions(slot0)
	if slot0._episodeMo:getConditionIds() then
		for slot5, slot6 in ipairs(slot1) do
			slot0:_getOrCreateConditionItem(slot5).txtcondition.text = Act183Config.instance:getConditionCo(slot6) and slot9.decs1 or ""

			UISpriteSetMgr.instance:setChallengeSprite(slot7.imagestar, slot0._fightResultMo:isConditionPass(slot6) and "v2a5_challenge_dungeon_reward_star_01" or "v2a5_challenge_dungeon_reward_star_02", true)
			gohelper.setActive(slot7.viewGO, true)
		end
	end
end

function slot0._getOrCreateConditionItem(slot0, slot1)
	if not slot0._conditionItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._additionitem, "fightcondition_" .. slot1)
		slot2.txtcondition = gohelper.findChildText(slot2.viewGO, "condition")
		slot2.imagestar = gohelper.findChildImage(slot2.viewGO, "star")
		slot0._conditionItemTab[slot1] = slot2
	end

	return slot2
end

return slot0
