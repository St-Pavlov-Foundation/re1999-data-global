module("modules.logic.tower.view.fight.TowerHeroGroupFightView", package.seeall)

slot0 = class("TowerHeroGroupFightView", HeroGroupFightView)
slot1 = 4

function slot0._editableInitView(slot0)
	uv0 = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication) or uv0
	slot0._multiplication = 1
	slot0._goherogroupcontain = gohelper.findChild(slot0.viewGO, "herogroupcontain")
	slot0._goBtnContain = gohelper.findChild(slot0.viewGO, "#go_container/btnContain")
	slot0._btnContainAnim = slot0._goBtnContain:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._gomask, false)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._onModifyHeroGroup, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupName, slot0._initFightGroupDrop, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._onModifySnapshot, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, slot0._onClickHeroGroupItem, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
	slot0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.isShowHelpBtnIcon, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, slot0._onUseRecommendGroup, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, slot0._showGuideDragEffect, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUpdateRecommendLevel, slot0._refreshTips, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, slot0._heroMoveForward, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, slot0.refreshDoubleDropTips, slot0)

	if BossRushController.instance:isInBossRushFight() then
		gohelper.addUIClickAudio(slot0._btnstart.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(slot0._btnstarthard.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(slot0._btnstartreplay.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
	else
		gohelper.addUIClickAudio(slot0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(slot0._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(slot0._btnstartreplay.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	end

	gohelper.addUIClickAudio(slot0._btnReplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)

	slot0._iconGO = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._btncloth.gameObject)
	slot5 = 1

	recthelper.setAnchor(slot0._iconGO.transform, -100, slot5)

	slot0._tweeningId = 0
	slot0._replayMode = false
	slot0._multSpeedItems = {}

	for slot5 = 1, uv0 do
		slot0:_setMultSpeedItem(slot0._gomultContent.transform:GetChild(slot5 - 1).gameObject, uv0 - slot5 + 1)
	end

	gohelper.setActive(slot0._gomultispeed, false)
end

function slot0._enterFight(slot0)
	if HeroGroupModel.instance.episodeId then
		slot0._closeWithEnteringFight = true

		if FightController.instance:setFightHeroSingleGroup() then
			slot0.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			slot2 = {
				fightParam = slot3,
				chapterId = slot3.chapterId,
				episodeId = slot3.episodeId,
				useRecord = slot0._replayMode
			}
			slot3 = FightModel.instance:getFightParam()

			if slot0._replayMode then
				slot3.isReplay = true
				slot3.multiplication = slot0._multiplication
			else
				slot3.isReplay = false
				slot3.multiplication = 1
			end

			slot2.multiplication = slot3.multiplication

			TowerController.instance:startFight(slot2)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function slot0._initFightGroupDrop(slot0)
	if not slot0:_noAidHero() then
		return
	end

	if DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).type == DungeonEnum.EpisodeType.TowerBoss then
		table.insert({}, HeroGroupModel.instance:getCommonGroupName())
	else
		for slot8 = 1, 4 do
			slot4[slot8] = HeroGroupModel.instance:getCommonGroupName(slot8)
		end
	end

	slot0._dropherogroup:ClearOptions()
	slot0._dropherogroup:AddOptions(slot4)
	slot0._dropherogroup:SetValue(HeroGroupModel.instance:getHeroGroupSelectIndex() - 1)
	gohelper.setActive(slot0._btnmodifyname, false)
end

function slot0._onClickHeroGroupItem(slot0, slot1)
	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	uv0.super._onClickHeroGroupItem(slot0, slot1)
end

function slot0._groupDropValueChanged(slot0, slot1)
	uv0.super._groupDropValueChanged(slot0, slot1)
	gohelper.setActive(slot0._btnmodifyname, false)
end

return slot0
