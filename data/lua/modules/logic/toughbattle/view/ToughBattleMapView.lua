module("modules.logic.toughbattle.view.ToughBattleMapView", package.seeall)

local var_0_0 = class("ToughBattleMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gostage1 = gohelper.findChild(arg_1_0.viewGO, "#go_stagebg_1")
	arg_1_0._gostage2 = gohelper.findChild(arg_1_0.viewGO, "#go_stagebg_2")
	arg_1_0._imgstage = gohelper.findChildImage(arg_1_0.viewGO, "title/#simage_stagenum")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "title/#txt_title")
	arg_1_0._btnAbort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_abort")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._txtprogress = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_progress/bg/#txt_progress")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "#go_progress/progressbg/#image_progress")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnAbort:AddClickListener(arg_2_0._onAbort, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnAbort:RemoveClickListener()
	arg_3_0:removeEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, arg_3_0.checkLoadingAndRefresh, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0.checkLoadingAndRefresh, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false, DungeonEnum.EpisodeListVisibleSource.ToughBattle)

	local var_4_0 = arg_4_0:getResInst(arg_4_0.viewContainer._viewSetting.otherRes.rolelist, arg_4_0.viewGO, "rolelist")
	local var_4_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_0, ToughBattleRoleListComp, arg_4_0.viewParam)

	var_4_1:setClickCallBack(arg_4_0.onRoleSelect, arg_4_0)

	arg_4_0._roleComp = var_4_1

	if arg_4_0:isSceneLoading() then
		arg_4_0:addEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, arg_4_0.checkLoadingAndRefresh, arg_4_0)
		arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0.checkLoadingAndRefresh, arg_4_0)
		gohelper.setActive(arg_4_0.viewGO, false)
	else
		arg_4_0:checkLoadingAndRefresh()
	end
end

function var_0_0.isSceneLoading(arg_5_0)
	local var_5_0 = GameGlobalMgr.instance:getLoadingState()

	if var_5_0 and var_5_0:getLoadingViewName() then
		return true
	end
end

function var_0_0.playOpenAnim(arg_6_0)
	arg_6_0._viewAnim:Play("open", 0, 0)
	arg_6_0._roleComp:playAnim("open")
end

function var_0_0.checkLoadingAndRefresh(arg_7_0)
	gohelper.setActive(arg_7_0.viewGO, true)
	arg_7_0:removeEventCb(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, arg_7_0.checkLoadingAndRefresh, arg_7_0)
	arg_7_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_7_0.checkLoadingAndRefresh, arg_7_0)
	arg_7_0:refreshStage()
	arg_7_0:playOpenAnim()
end

function var_0_0.refreshStage(arg_8_0)
	local var_8_0 = arg_8_0:getInfo()
	local var_8_1 = 1

	if #var_8_0.passChallengeIds >= 3 and not arg_8_0.viewParam.lastFightSuccIndex then
		var_8_1 = 2
	end

	gohelper.setActive(arg_8_0._gostage1, var_8_1 == 1)
	gohelper.setActive(arg_8_0._gostage2, var_8_1 == 2)
	gohelper.setActive(arg_8_0._goprogress, var_8_1 == 1)
	UISpriteSetMgr.instance:setToughBattleSprite(arg_8_0._imgstage, "toughbattle_fighttitlebg" .. var_8_1)

	arg_8_0._txttitle.text = var_8_1 == 1 and luaLang("toughbattle_stage1_title") or luaLang("toughbattle_stage2_title")

	if var_8_1 == 1 then
		local var_8_2 = #var_8_0.passChallengeIds

		if arg_8_0.viewParam.lastFightSuccIndex then
			var_8_2 = var_8_2 - 1
		end

		arg_8_0._txtprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("toughbattle_mapview_txt_progress"), {
			var_8_2,
			3
		})
		arg_8_0._imageprogress.fillAmount = var_8_2 / 3

		if arg_8_0.viewParam.lastFightSuccIndex then
			ToughBattleController.instance:dispatchEvent(ToughBattleEvent.BeginPlayFightSucessAnim)
			UIBlockHelper.instance:startBlock("ToughBattleMapViewAnim", 0.6, arg_8_0.viewName)
			ZProj.TweenHelper.DOFillAmount(arg_8_0._imageprogress, (var_8_2 + 1) / 3, 0.6, arg_8_0.onTweenEnd, arg_8_0, nil, EaseType.OutQuad)
		else
			ZProj.TweenHelper.KillByObj(arg_8_0._imageprogress)
		end
	end
end

function var_0_0.onTweenEnd(arg_9_0)
	local var_9_0 = #arg_9_0:getInfo().passChallengeIds

	arg_9_0._imageprogress.fillAmount = var_9_0 / 3
	arg_9_0._txtprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("toughbattle_mapview_txt_progress"), {
		var_9_0,
		3
	})

	if arg_9_0.viewParam.lastFightSuccIndex then
		arg_9_0.viewParam.lastFightSuccIndex = nil

		if var_9_0 >= 3 then
			UIBlockHelper.instance:startBlock("ToughBattleMapView_ShowLoading", 0.6, arg_9_0.viewName)
			TaskDispatcher.runDelay(arg_9_0._delayShowLoading, arg_9_0, 0.6)
		end
	end
end

function var_0_0._delayShowLoading(arg_10_0)
	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.StageUpdate)

	local var_10_0 = arg_10_0.viewParam.mode == ToughBattleEnum.Mode.Act and ViewName.ToughBattleActLoadingView or ViewName.ToughBattleLoadingView

	ViewMgr.instance:openView(var_10_0, {
		stage = 2
	})
	arg_10_0:refreshStage()
end

function var_0_0.onClose(arg_11_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true, DungeonEnum.EpisodeListVisibleSource.ToughBattle)
	TaskDispatcher.cancelTask(arg_11_0._delayShowLoading, arg_11_0)
	ZProj.TweenHelper.KillByObj(arg_11_0._imageprogress)
	arg_11_0._roleComp:playAnim("close")
	TaskDispatcher.cancelTask(arg_11_0.checkLoadingAndRefresh, arg_11_0)
end

function var_0_0.getInfo(arg_12_0)
	return arg_12_0.viewParam.mode == ToughBattleEnum.Mode.Act and ToughBattleModel.instance:getActInfo() or ToughBattleModel.instance:getStoryInfo()
end

function var_0_0.onRoleSelect(arg_13_0, arg_13_1)
	ViewMgr.instance:openView(ViewName.ToughBattleSkillView, {
		isShowList = true,
		showCo = arg_13_1,
		mode = arg_13_0.viewParam.mode
	})
end

function var_0_0._onAbort(arg_14_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.ToughBattleAbort, MsgBoxEnum.BoxType.Yes_No, arg_14_0._onClickSure, nil, nil, arg_14_0, nil, nil)
end

function var_0_0._onClickSure(arg_15_0)
	if arg_15_0.viewParam.mode == ToughBattleEnum.Mode.Act then
		Activity158Rpc.instance:sendAct158AbandonChallengeRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, arg_15_0._onRecvMsg, arg_15_0)
	else
		SiegeBattleRpc.instance:sendAbandonSiegeBattleRequest(arg_15_0._onRecvMsg, arg_15_0)
	end
end

function var_0_0._onRecvMsg(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 == 0 then
		local var_16_0 = arg_16_0.viewParam.mode == ToughBattleEnum.Mode.Act and ViewName.ToughBattleActEnterView or ViewName.ToughBattleEnterView

		ViewMgr.instance:openView(var_16_0, arg_16_0.viewParam)
		arg_16_0:closeThis()
	end
end

return var_0_0
