module("modules.logic.gm.controller.GMController", package.seeall)

slot0 = class("GMController", BaseController)
slot0.debugViewGO = nil
slot0.Event = {
	ChangeSelectHeroItem = 2
}
slot0.GMNodesPrefabUrl = "ui/viewres/gm/gmnodes.prefab"

function slot0.onInit(slot0)
	slot0:_setDebugViewVisible()
	slot0:ignoreHeartBeatLog()

	slot0.isShowEditorFightUI = true
	slot0.showEnemy = true
end

function slot0.onInitFinish(slot0)
	if isDebugBuild then
		TaskDispatcher.runDelay(slot0._delayInit, slot0, 2)
	end
end

function slot0._delayInit(slot0)
	if isDebugBuild then
		slot0:initShowAudioLog()
		slot0:_loadGMNodes()
		logNormal(string.format("isDebugBuild, openGM:%s", GameConfig.OpenGm and "true" or "false"))
		TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.1)

		if SLFramework.FrameworkSettings.IsEditor then
			if PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, -1) == -1 then
				PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1)
			end

			return
		end

		if not GameConfig.OpenGm then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 0)

			return
		end

		if slot1 == -1 then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1)
		end
	end
end

function slot0.isOpenGM(slot0)
	return isDebugBuild and PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1) == 1
end

function slot0.stopKeyListener(slot0)
	logNormal("stop gm key listener")
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
end

function slot0.getCurrency(slot0)
	slot1 = CurrencyModel.instance:getDiamond()
	slot2 = CurrencyModel.instance:getFreeDiamond()
	slot3 = CurrencyModel.instance:getGold()
	slot4 = CurrencyModel.instance:getPower()

	logError(string.format("粹雨滴：%s,  纯雨滴：%s    利齿子儿：%s,   体力：%s", slot1, slot2, slot3, slot4))
	logError(string.format("奖励点 —— 第一章：%s, 第二章：%s", DungeonMapModel.instance:getRewardPointValue(101), DungeonMapModel.instance:getRewardPointValue(102)))
	GameFacade.showToast(ToastEnum.GMCurrency, "粹雨滴", slot1)
	GameFacade.showToast(ToastEnum.GMCurrency, "纯雨滴", slot2)
	GameFacade.showToast(ToastEnum.GMCurrency, "利齿子儿", slot3)
	GameFacade.showToast(ToastEnum.GMCurrency, "体力", slot4)
end

function slot0.sendGM(slot0, slot1)
	if isDebugBuild then
		GMRpc.instance:sendGMRequest(slot1)
	end
end

function slot0.back2Main(slot0)
	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()
end

function slot0._setDebugViewVisible(slot0)
	uv0.debugViewGO = gohelper.find("DebugView")

	gohelper.setActive(uv0.debugViewGO, PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewDebugView, 0) == 1)
end

function slot0._onFrame(slot0)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.F2) then
		slot0:getCurrency()
	end

	slot1 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Q) then
		if ViewMgr.instance:isOpen(ViewName.V2a4_WarmUp_DialogueView) then
			V2a4_WarmUpController.instance:log()
		else
			slot3 = 12436

			ActivityModel.instance:setActivityInfo({
				activityInfos = {
					{
						currentStage = 0,
						isUnlock = true,
						endTime = 1735678800000.0,
						online = true,
						isReceiveAllBonus = false,
						isNewStage = false,
						startTime = 1733000400000.0,
						id = slot3
					}
				}
			})
			Activity125Testing.instance:_test()
			Activity125Model.instance:setSelectEpisodeId(slot3, 1)
			ActivityModel.instance:setTargetActivityCategoryId(slot3)
			ViewMgr.instance:openView(ViewName.ActivityBeginnerView)
		end
	end

	if (UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) and slot1 and slot2 or UnityEngine.Input.touchCount >= 5) and isDebugBuild and (SLFramework.FrameworkSettings.IsEditor or GameConfig.OpenGm) then
		if ViewMgr.instance:isOpen(ViewName.LoadingView) then
			slot0._lastTime = Time.time

			return
		end

		if Time.time - (slot0._lastTime or 0) <= 1 then
			return
		end

		slot0._lastTime = Time.time
		slot5 = slot0:isOpenGM() and 0 or 1

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, slot5)
		MainController.instance:dispatchEvent(MainEvent.OnChangeGMBtnStatus)

		if slot5 == 1 then
			GameFacade.showToast(ToastEnum.IconId, "GM开启")
			slot0:openGMView()
		else
			GameFacade.showToast(ToastEnum.IconId, "GM关闭")
		end

		return
	end

	if slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		GMRpc.instance:sendGMRequest("set fight 1")

		return
	end

	if slot1 and slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.G) then
		slot0:openGMView()
	elseif slot1 and slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Q) then
		LoginController.instance:logout()
	elseif slot1 and slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.R) then
		ViewMgr.instance:openView(ViewName.ProtoTestView)
	elseif slot2 and slot1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha1) then
		slot0:playRightSkill(1)
	elseif slot2 and slot1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha2) then
		slot0:playRightSkill(2)
	elseif slot2 and slot1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha3) then
		slot0:playRightSkill(3)
	elseif slot2 and slot1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha4) then
		-- Nothing
	elseif slot2 and slot1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha5) then
		-- Nothing
	elseif slot2 and slot1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha6) then
		-- Nothing
	elseif slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.C) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.L) then
		FightController.instance:dispatchEvent(FightEvent.GMCopyRoundLog)
	elseif slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.F) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.L) then
		ViewMgr.instance:openView(ViewName.FightEditorStateView)
	elseif slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.M) then
		slot0:playFightSceneSpineAnimation(SpineAnimState.born)
	elseif slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.N) then
		slot0:playFightSceneSpineAnimation(SpineAnimState.victory)
	elseif slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.E) then
		slot0:switchEnemyVisible()
	elseif slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.H) then
		slot0.isShowEditorFightUI = not slot0.isShowEditorFightUI

		slot0:refreshSkillEditorView()
	elseif slot1 and slot2 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.T) then
		if slot0.______SocketReceiverCD_______ and os.clock() - slot0.______SocketReceiverCD_______ < 1 then
			return
		end

		require("tolua.reflection")
		tolua.loadassembly("Assembly-CSharp")

		slot11 = tolua.findtype("System.Threading.Thread")
		slot15 = tolua.getmethod(slot11, "Suspend")

		if tostring(tolua.getproperty(slot11, "ThreadState", 20):Get(tolua.getfield(tolua.findtype("SLFramework.SocketReceiver"), "thread", 36):Get(tolua.getproperty(tolua.findtype("SLFramework.TcpSocketClient"), "Receive", 20):Get(SLFramework.SocketMgr.Instance:GetSocketClient(0), {})), {})):find("Suspended") or tostring(slot13):find("SuspendRequested") then
			tolua.getmethod(slot11, "Resume"):Call(slot10)
			GameFacade.showToast(ToastEnum.IconId, "恢复网络")
		else
			slot15:Call(slot10)
			GameFacade.showToast(ToastEnum.IconId, "暂停网络")
		end

		slot0.______SocketReceiverCD_______ = os.clock()
	end

	if not string.nilorempty(UnityEngine.PlayerPrefs.GetString(PlayerPrefsKey.OpenGM, nil)) then
		slot4.DeleteKey(slot5)
		ViewMgr.instance:openView(ViewName.GMToolView2)
	end
end

function slot0.openGMView(slot0)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		ViewMgr.instance:closeView(ViewName.GMToolView)
		ViewMgr.instance:openView(ViewName.GMToolView2)
	else
		ViewMgr.instance:closeView(ViewName.GMToolView2)
		ViewMgr.instance:openView(ViewName.GMToolView)
	end
end

function slot0.ignoreHeartBeatLog(slot0)
	LuaSocketMgr.instance:setIgnoreSomeCmdLog({
		"GetServerTimeRequest",
		"GetServerTimeReply"
	})
end

function slot0.resumeHeartBeatLog(slot0)
	LuaSocketMgr.instance:setIgnoreSomeCmdLog()
end

function slot0.refreshSkillEditorView(slot0)
	if not slot0.goUiRoot then
		slot0.goUiRoot = gohelper.find("UIRoot")
	end

	if not slot0.goCameraRoot then
		slot0.goCameraRoot = gohelper.find("cameraroot")
	end

	if not slot0.goIDRoot then
		slot0.goIDRoot = gohelper.find("IDCanvas")
	end

	slot0.goNameBar = gohelper.findChild(slot0.goUiRoot, "HUD/NameBar")
	slot0.goSkillEffectStatView = gohelper.findChild(slot0.goUiRoot, "POPUP_TOP/SkillEffectStatView")
	slot0.goSkillEditorView = gohelper.findChild(slot0.goUiRoot, "TOP/SkillEditorView")
	slot0.goText = gohelper.findChild(slot0.goUiRoot, "Text")
	slot0.goSubHero = gohelper.findChild(slot0.goCameraRoot, "SceneRoot/FightScene/Entitys/Player_-1")

	if not slot0.goIDPopup then
		slot0.goIDPopup = gohelper.findChild(slot0.goIDRoot, "POPUP")
	end

	slot0.goFloat = gohelper.findChild(slot0.goUiRoot, "HUD/Float")

	gohelper.setActive(slot0.goNameBar, slot0.isShowEditorFightUI)
	gohelper.setActive(slot0.goSkillEffectStatView, slot0.isShowEditorFightUI)
	gohelper.setActive(slot0.goSkillEditorView, slot0.isShowEditorFightUI)
	gohelper.setActive(slot0.goText, slot0.isShowEditorFightUI)
	gohelper.setActive(slot0.goSubHero, slot0.isShowEditorFightUI)
	gohelper.setActive(slot0.goIDPopup, slot0.isShowEditorFightUI)
	gohelper.setActive(slot0.goFloat, slot0.isShowEditorFightUI)
end

function slot0.getIsShowEditorFightUI(slot0)
	return slot0.isShowEditorFightUI
end

function slot0.playRightSkill(slot0, slot1)
	if ViewMgr.instance:getContainer(ViewName.SkillEditorView) then
		slot2.rightSkillEditorSideView._skillSelectView._curSkillId = SkillConfig.instance:getHeroBaseSkillIdDict(slot2.rightSkillEditorSideView._skillSelectView._entityMO.modelId)[slot1]

		slot2.rightSkillEditorSideView:_onClickFight()
	end
end

function slot0.playFightSceneSpineAnimation(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.SkillEditorView) then
		return
	end

	if not GameSceneMgr.instance:getCurScene() then
		return
	end

	slot3 = nil

	if not ((not SkillEditorMgr.instance.cur_select_entity_id or slot2.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)) and slot2.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])) then
		logError("所选对象错误，请从新选择对象")

		return
	end

	slot0._attacker = slot3

	TaskDispatcher.cancelTask(slot0.resetAnim, slot0)
	slot0._attacker.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)

	if FightConfig.instance:getSkinSpineActionDict(slot0._attacker:getMO().skin) and slot4[slot1] and slot5.effectRemoveTime > 0 then
		TaskDispatcher.runDelay(slot0.resetAnim, slot0, slot5.effectRemoveTime / FightModel.instance:getSpeed())
	else
		slot0._ani_need_transition, slot0._transition_ani = FightHelper.needPlayTransitionAni(slot0._attacker, slot1)

		slot0._attacker.spine:addAnimEventCallback(slot0._onAnimEvent, slot0)
	end

	slot3.spine:play(slot1, false, true)
end

function slot0.resetAnim(slot0)
	if slot0._attacker then
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		slot0._attacker.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot0._attacker:resetAnimState()
	end
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3)
	if slot2 == SpineAnimEvent.ActionComplete then
		if slot0._ani_need_transition and slot0._transition_ani == slot1 then
			return
		end

		slot0:resetAnim()
	end
end

function slot0.getVisualInteractiveMgr(slot0)
	if not slot0.viaMgr then
		slot0.viaMgr = VisualInteractiveAreaMgr.New()

		slot0.viaMgr:init()
	end

	return slot0.viaMgr
end

function slot0.getVisualInteractive(slot0)
	return slot0.visualInteractive or false
end

function slot0.setVisualInteractive(slot0, slot1)
	slot0.visualInteractive = slot1
end

function slot0.switchEnemyVisible(slot0)
	slot0.showEnemy = not slot0.showEnemy

	gohelper.setActive(gohelper.find("UIRoot/HUD/NameBar/Monster_1"), slot0.showEnemy)
	gohelper.setActive(gohelper.find("cameraroot/SceneRoot/FightScene/Entitys/Monster_1"), slot0.showEnemy)
end

function slot0._loadGMNodes(slot0)
	slot0._gmNodeLoader = MultiAbLoader.New()

	slot0._gmNodeLoader:addPath(uv0.GMNodesPrefabUrl)
	slot0._gmNodeLoader:startLoad(slot0._onLoadGMNodesFinish, slot0)
end

function slot0._onLoadGMNodesFinish(slot0, slot1)
	slot0._prefab = slot1:getFirstAssetItem():GetResource()
end

function slot0.getGMNode(slot0, slot1, slot2)
	if isDebugBuild then
		if not slot0._prefab then
			return nil
		end

		if gohelper.findChild(slot0._prefab, slot1) then
			return gohelper.clone(slot3, slot2, slot3.name)
		else
			logError("找不到GM节点：" .. slot1)
		end
	end
end

function slot0.initShowAudioLog(slot0)
	slot0.showAudioLog = PlayerPrefsHelper.getNumber("showAudioLogKey", 0) == 1
	ZProj.AudioManager.Instance.gmOpenLog = slot0.showAudioLog

	if slot0.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		slot0:initClearAudioLogBtn()
	end
end

function slot0.getShowAudioLog(slot0)
	return slot0.showAudioLog
end

function slot0.setShowAudioLog(slot0, slot1)
	if slot1 == slot0.showAudioLog then
		return
	end

	slot0.showAudioLog = slot1

	PlayerPrefsHelper.setNumber("showAudioLogKey", slot1 and 1 or 0)

	if slot0.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		slot0:initClearAudioLogBtn()
	else
		ZProj.AudioEditorTool.Instance:HideAudioLog()
	end
end

function slot0.initClearAudioLogBtn(slot0)
	if not gohelper.isNil(slot0.clearAudioLogBtn) then
		return
	end

	TaskDispatcher.cancelTask(slot0._initClearAudioLogBtn, slot0)
	TaskDispatcher.runRepeat(slot0._initClearAudioLogBtn, slot0, 1)
end

function slot0._initClearAudioLogBtn(slot0)
	if gohelper.isNil(gohelper.find("UIRoot/TOP/audiolog(Clone)")) then
		return
	end

	slot0.clearAudioLogBtn = SLFramework.UGUI.ButtonWrap.GetWithPath(slot1, "clearBtn")

	slot0.clearAudioLogBtn:AddClickListener(slot0.onClickClearAudio, slot0)

	slot0.txtLog = gohelper.findChildText(slot1, "Scroll View/Viewport/Content")

	TaskDispatcher.cancelTask(slot0._initClearAudioLogBtn, slot0)
end

function slot0.onClickClearAudio(slot0)
	if not gohelper.isNil(slot0.txtLog) then
		slot0.txtLog.text = ""
	end
end

function slot0.invokeCSharpInstanceMethod(slot0, slot1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	slot2 = tolua.findtype(slot0)

	tolua.getmethod(slot2, slot1):Call(tolua.getproperty(slot2.BaseType, "Instance"):Get(nil, ))
end

function slot0.TestFightByBattleId(slot0, slot1)
	if not (slot1 and lua_battle.configDict[slot1]) then
		return
	end

	slot3 = FightController.instance:setFightParamByBattleId(slot1)

	HeroGroupModel.instance:setParam(slot1, nil, )

	if not HeroGroupModel.instance:getCurGroupMO() then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	slot5, slot6 = slot4:getMainList()
	slot7, slot8 = slot4:getSubList()
	slot9 = slot4:getAllHeroEquips()

	for slot13, slot14 in ipairs(lua_episode.configList) do
		if slot14.battleId == slot1 then
			slot3.episodeId = slot14.id
			FightResultModel.instance.episodeId = slot14.id

			DungeonModel.instance:SetSendChapterEpisodeId(slot14.chapterId, slot14.id)

			break
		end
	end

	if not slot3.episodeId then
		slot3.episodeId = 10101
	end

	slot3:setMySide(slot4.clothId, slot5, slot7, slot9)
	FightController.instance:sendTestFightId(slot3)
end

slot0.instance = slot0.New()

return slot0
