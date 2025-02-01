module("modules.logic.toughbattle.view.ToughBattleMapView", package.seeall)

slot0 = class("ToughBattleMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._gostage1 = gohelper.findChild(slot0.viewGO, "#go_stagebg_1")
	slot0._gostage2 = gohelper.findChild(slot0.viewGO, "#go_stagebg_2")
	slot0._imgstage = gohelper.findChildImage(slot0.viewGO, "title/#simage_stagenum")
	slot0._txttitle = gohelper.findChildTextMesh(slot0.viewGO, "title/#txt_title")
	slot0._btnAbort = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_abort")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_progress")
	slot0._txtprogress = gohelper.findChildTextMesh(slot0.viewGO, "#go_progress/bg/#txt_progress")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "#go_progress/progressbg/#image_progress")
end

function slot0.addEvents(slot0)
	slot0._btnAbort:AddClickListener(slot0._onAbort, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnAbort:RemoveClickListener()
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, slot0.checkLoadingAndRefresh, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.checkLoadingAndRefresh, slot0)
end

function slot0.onOpen(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false, DungeonEnum.EpisodeListVisibleSource.ToughBattle)

	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.rolelist, slot0.viewGO, "rolelist"), ToughBattleRoleListComp, slot0.viewParam)

	slot2:setClickCallBack(slot0.onRoleSelect, slot0)

	slot0._roleComp = slot2

	if slot0:isSceneLoading() then
		slot0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, slot0.checkLoadingAndRefresh, slot0)
		slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.checkLoadingAndRefresh, slot0)
		gohelper.setActive(slot0.viewGO, false)
	else
		slot0:checkLoadingAndRefresh()
	end
end

function slot0.isSceneLoading(slot0)
	if GameGlobalMgr.instance:getLoadingState() and slot1:getLoadingViewName() then
		return true
	end
end

function slot0.playOpenAnim(slot0)
	slot0._viewAnim:Play("open", 0, 0)
	slot0._roleComp:playAnim("open")
end

function slot0.checkLoadingAndRefresh(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, slot0.checkLoadingAndRefresh, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.checkLoadingAndRefresh, slot0)
	slot0:refreshStage()
	slot0:playOpenAnim()
end

function slot0.refreshStage(slot0)
	slot2 = 1

	if #slot0:getInfo().passChallengeIds >= 3 and not slot0.viewParam.lastFightSuccIndex then
		slot2 = 2
	end

	gohelper.setActive(slot0._gostage1, slot2 == 1)
	gohelper.setActive(slot0._gostage2, slot2 == 2)
	gohelper.setActive(slot0._goprogress, slot2 == 1)
	UISpriteSetMgr.instance:setToughBattleSprite(slot0._imgstage, "toughbattle_fighttitlebg" .. slot2)

	slot0._txttitle.text = slot2 == 1 and luaLang("toughbattle_stage1_title") or luaLang("toughbattle_stage2_title")

	if slot2 == 1 then
		if slot0.viewParam.lastFightSuccIndex then
			slot3 = #slot1.passChallengeIds - 1
		end

		slot0._txtprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("toughbattle_mapview_txt_progress"), {
			slot3,
			3
		})
		slot0._imageprogress.fillAmount = slot3 / 3

		if slot0.viewParam.lastFightSuccIndex then
			ToughBattleController.instance:dispatchEvent(ToughBattleEvent.BeginPlayFightSucessAnim)
			UIBlockHelper.instance:startBlock("ToughBattleMapViewAnim", 0.6, slot0.viewName)
			ZProj.TweenHelper.DOFillAmount(slot0._imageprogress, (slot3 + 1) / 3, 0.6, slot0.onTweenEnd, slot0, nil, EaseType.OutQuad)
		else
			ZProj.TweenHelper.KillByObj(slot0._imageprogress)
		end
	end
end

function slot0.onTweenEnd(slot0)
	slot2 = #slot0:getInfo().passChallengeIds
	slot0._imageprogress.fillAmount = slot2 / 3
	slot0._txtprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("toughbattle_mapview_txt_progress"), {
		slot2,
		3
	})

	if slot0.viewParam.lastFightSuccIndex then
		slot0.viewParam.lastFightSuccIndex = nil

		if slot2 >= 3 then
			UIBlockHelper.instance:startBlock("ToughBattleMapView_ShowLoading", 0.6, slot0.viewName)
			TaskDispatcher.runDelay(slot0._delayShowLoading, slot0, 0.6)
		end
	end
end

function slot0._delayShowLoading(slot0)
	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.StageUpdate)
	ViewMgr.instance:openView(slot0.viewParam.mode == ToughBattleEnum.Mode.Act and ViewName.ToughBattleActLoadingView or ViewName.ToughBattleLoadingView, {
		stage = 2
	})
	slot0:refreshStage()
end

function slot0.onClose(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true, DungeonEnum.EpisodeListVisibleSource.ToughBattle)
	TaskDispatcher.cancelTask(slot0._delayShowLoading, slot0)
	ZProj.TweenHelper.KillByObj(slot0._imageprogress)
	slot0._roleComp:playAnim("close")
	TaskDispatcher.cancelTask(slot0.checkLoadingAndRefresh, slot0)
end

function slot0.getInfo(slot0)
	return slot0.viewParam.mode == ToughBattleEnum.Mode.Act and ToughBattleModel.instance:getActInfo() or ToughBattleModel.instance:getStoryInfo()
end

function slot0.onRoleSelect(slot0, slot1)
	ViewMgr.instance:openView(ViewName.ToughBattleSkillView, {
		isShowList = true,
		showCo = slot1,
		mode = slot0.viewParam.mode
	})
end

function slot0._onAbort(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.ToughBattleAbort, MsgBoxEnum.BoxType.Yes_No, slot0._onClickSure, nil, , slot0, nil, )
end

function slot0._onClickSure(slot0)
	if slot0.viewParam.mode == ToughBattleEnum.Mode.Act then
		Activity158Rpc.instance:sendAct158AbandonChallengeRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, slot0._onRecvMsg, slot0)
	else
		SiegeBattleRpc.instance:sendAbandonSiegeBattleRequest(slot0._onRecvMsg, slot0)
	end
end

function slot0._onRecvMsg(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		ViewMgr.instance:openView(slot0.viewParam.mode == ToughBattleEnum.Mode.Act and ViewName.ToughBattleActEnterView or ViewName.ToughBattleEnterView, slot0.viewParam)
		slot0:closeThis()
	end
end

return slot0
