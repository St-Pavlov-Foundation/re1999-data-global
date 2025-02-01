module("modules.logic.bossrush.view.V1a4_BossRush_ResultView", package.seeall)

slot0 = class("V1a4_BossRush_ResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Title/#simage_Title")
	slot0._btnRank = gohelper.findChildButtonWithAudio(slot0.viewGO, "Title/#btn_Rank")
	slot0._simagePlayerHead = gohelper.findChildSingleImage(slot0.viewGO, "Player/PlayerHead/#simage_PlayerHead")
	slot0._txtPlayerName = gohelper.findChildText(slot0.viewGO, "Player/#txt_PlayerName")
	slot0._txtTime = gohelper.findChildText(slot0.viewGO, "Player/#txt_Time")
	slot0._goAssessScore = gohelper.findChild(slot0.viewGO, "Right/#go_AssessScore")
	slot0._goGroup = gohelper.findChild(slot0.viewGO, "Right/#go_Group")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnRank:AddClickListener(slot0._btnRankOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnRank:RemoveClickListener()
end

function slot0._btnRankOnClick(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0._editableInitView(slot0)
	slot0._bossBgList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot0._bossBgList[slot4] = gohelper.findChild(slot0.viewGO, "boss_topbg" .. slot4)
	end

	slot0:_initAssessScore()
	slot0:_initHeroGroup()

	slot0._click = gohelper.getClick(slot0.viewGO)

	slot0._click:AddClickListener(slot0.closeThis, slot0)
	NavigateMgr.instance:addEscape(ViewName.V1a4_BossRush_ResultView, slot0.closeThis, slot0)
end

function slot0._initAssessScore(slot0)
	slot1 = V1a4_BossRush_Assess_Score
	slot0._assessScore = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_result_assess, slot0._goAssessScore, slot1.__name), slot1)

	slot0._assessScore:setActiveDesc(false)
	slot0._assessIcon:initData(slot0, false)
end

function slot0._initHeroGroup(slot0)
	slot1 = V1a4_BossRush_HeroGroup
	slot0._heroGroup = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_herogroup, slot0._goGroup, slot1.__cname), slot1, slot0.viewContainer)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._curStage, slot0._curLayer = BossRushModel.instance:getBattleStageAndLayer()
	slot2 = PlayerModel.instance:getPlayinfo().portrait

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simagePlayerHead)
	end

	slot0._liveHeadIcon:setLiveHead(slot2)

	slot0._txtTime.text = TimeUtil.getServerDateUTCToString()
	slot0._txtPlayerName.text = slot1.name

	slot0:_refresh()
end

function slot0.onOpenFinish(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
end

function slot0.onClose(slot0)
	slot0._click:RemoveClickListener()
	FightController.onResultViewClose()
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageTitle:UnLoadImage()
	slot0._simagePlayerHead:UnLoadImage()
	GameUtil.onDestroyViewMember(slot0, "_heroGroup")
	GameUtil.onDestroyViewMember(slot0, "_assessScore")
end

function slot0._refresh(slot0)
	if not slot0._curStage then
		return
	end

	for slot6, slot7 in ipairs(slot0._bossBgList) do
		gohelper.setActive(slot7, (slot1 == 1 and 1 or slot1 == 2 and 3 or 2) == slot6)
	end

	slot0._simageFullBG:LoadImage(BossRushConfig.instance:getResultViewFullBgSImage(slot1))
	slot0._simageTitle:LoadImage(BossRushConfig.instance:getResultViewNameSImage(slot1))
	slot0._assessScore:setData_ResultView(slot1, BossRushModel.instance:getFightScore())
	slot0._assessScore:setActiveNewRecord(BossRushModel.instance:checkIsNewHighestPointRecord(slot1))
	slot0._heroGroup:setDataByCurFightParam()
end

return slot0
