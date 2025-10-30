module("modules.logic.gm.controller.GMController", package.seeall)

local var_0_0 = class("GMController", BaseController)

var_0_0.debugViewGO = nil
var_0_0.Event = {
	OnRecvGMMsg = 3,
	ChangeSelectHeroItem = 2
}
var_0_0.GMNodesPrefabUrl = "ui/viewres/gm/gmnodes.prefab"

function var_0_0.onInit(arg_1_0)
	arg_1_0:_setDebugViewVisible()
	arg_1_0:ignoreHeartBeatLog()

	arg_1_0.isShowEditorFightUI = true
	arg_1_0.showEnemy = true
	arg_1_0.__testHotFix = false
end

function var_0_0.onInitFinish(arg_2_0)
	if isDebugBuild then
		TaskDispatcher.runDelay(arg_2_0._delayInit, arg_2_0, 2)
	end
end

function var_0_0._delayInit(arg_3_0)
	if isDebugBuild then
		arg_3_0:initShowAudioLog()
		arg_3_0:_loadGMNodes()
		logNormal(string.format("isDebugBuild, openGM:%s", GameConfig.OpenGm and "true" or "false"))
		TaskDispatcher.runRepeat(arg_3_0._onFrame, arg_3_0, 0.1)

		local var_3_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, -1)

		GMLangController.instance:init()

		if SLFramework.FrameworkSettings.IsEditor then
			if var_3_0 == -1 then
				PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1)
			end

			return
		end

		if not GameConfig.OpenGm then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 0)

			return
		end

		if var_3_0 == -1 then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1)
		end
	end
end

function var_0_0.isOpenGM(arg_4_0)
	return isDebugBuild and PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1) == 1
end

function var_0_0.stopKeyListener(arg_5_0)
	logNormal("stop gm key listener")
	TaskDispatcher.cancelTask(arg_5_0._onFrame, arg_5_0)
end

function var_0_0.getCurrency(arg_6_0)
	local var_6_0 = CurrencyModel.instance:getDiamond()
	local var_6_1 = CurrencyModel.instance:getFreeDiamond()
	local var_6_2 = CurrencyModel.instance:getGold()
	local var_6_3 = CurrencyModel.instance:getPower()
	local var_6_4 = DungeonMapModel.instance:getRewardPointValue(101)
	local var_6_5 = DungeonMapModel.instance:getRewardPointValue(102)

	logError(string.format("粹雨滴：%s,  纯雨滴：%s    利齿子儿：%s,   体力：%s", var_6_0, var_6_1, var_6_2, var_6_3))
	logError(string.format("奖励点 —— 第一章：%s, 第二章：%s", var_6_4, var_6_5))
	GameFacade.showToast(ToastEnum.GMCurrency, "粹雨滴", var_6_0)
	GameFacade.showToast(ToastEnum.GMCurrency, "纯雨滴", var_6_1)
	GameFacade.showToast(ToastEnum.GMCurrency, "利齿子儿", var_6_2)
	GameFacade.showToast(ToastEnum.GMCurrency, "体力", var_6_3)
end

function var_0_0.sendGM(arg_7_0, arg_7_1)
	if isDebugBuild then
		GMRpc.instance:sendGMRequest(arg_7_1)
	end
end

function var_0_0.back2Main(arg_8_0)
	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()
end

function var_0_0._setDebugViewVisible(arg_9_0)
	var_0_0.debugViewGO = gohelper.find("DebugView")

	local var_9_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewDebugView, 0) == 1

	gohelper.setActive(var_0_0.debugViewGO, var_9_0)
end

function var_0_0._onFrame(arg_10_0)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.F2) then
		arg_10_0:getCurrency()
	end

	local var_10_0 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)
	local var_10_1 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl)
	local var_10_2 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) and var_10_0 and var_10_1

	var_10_2 = var_10_2 or UnityEngine.Input.touchCount >= 5

	if var_10_2 and isDebugBuild and (SLFramework.FrameworkSettings.IsEditor or GameConfig.OpenGm) then
		if ViewMgr.instance:isOpen(ViewName.LoadingView) then
			arg_10_0._lastTime = Time.time

			return
		end

		local var_10_3 = arg_10_0._lastTime or 0

		if Time.time - var_10_3 <= 1 then
			return
		end

		arg_10_0._lastTime = Time.time

		local var_10_4 = arg_10_0:isOpenGM() and 0 or 1

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, var_10_4)
		MainController.instance:dispatchEvent(MainEvent.OnChangeGMBtnStatus)

		if var_10_4 == 1 then
			GameFacade.showToast(ToastEnum.IconId, "GM开启")
			arg_10_0:openGMView()
		else
			GameFacade.showToast(ToastEnum.IconId, "GM关闭")
		end

		return
	end

	if var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		GMRpc.instance:sendGMRequest("set fight 1")

		if ViewMgr.instance:isOpen(ViewName.DiceHeroGameView) then
			GMRpc.instance:sendGMRequest("diceFightWin")
			TaskDispatcher.runDelay(function()
				if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
					ViewMgr.instance:openView(ViewName.DiceHeroResultView, {
						status = DiceHeroFightModel.instance.finishResult
					})
					DiceHeroStatHelper.instance:sendFightEnd(DiceHeroFightModel.instance.finishResult, DiceHeroFightModel.instance.isFirstWin)

					DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None
				end
			end, arg_10_0, 0.5)
		end

		return
	end

	if var_10_0 and var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.G) then
		arg_10_0:openGMView()
	elseif var_10_0 and var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Q) then
		LoginController.instance:logout()
	elseif var_10_0 and var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.R) then
		ViewMgr.instance:openView(ViewName.ProtoTestView)
	elseif var_10_1 and var_10_0 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha1) then
		arg_10_0:playRightSkill(1)
	elseif var_10_1 and var_10_0 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha2) then
		arg_10_0:playRightSkill(2)
	elseif var_10_1 and var_10_0 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha3) then
		arg_10_0:playRightSkill(3)
	elseif var_10_1 and var_10_0 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha4) then
		-- block empty
	elseif var_10_1 and var_10_0 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha5) then
		-- block empty
	elseif var_10_1 and var_10_0 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Alpha6) then
		-- block empty
	elseif var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.C) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.L) then
		FightController.instance:dispatchEvent(FightEvent.GMCopyRoundLog)
	elseif var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.F) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.L) then
		ViewMgr.instance:openView(ViewName.FightEditorStateView)
	elseif var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.M) then
		arg_10_0:playFightSceneSpineAnimation(SpineAnimState.born)
	elseif var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.N) then
		arg_10_0:playFightSceneSpineAnimation(SpineAnimState.victory)
	elseif var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.E) then
		arg_10_0:switchEnemyVisible()
	elseif var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.H) then
		arg_10_0.isShowEditorFightUI = not arg_10_0.isShowEditorFightUI

		arg_10_0:refreshSkillEditorView()
	elseif var_10_0 and var_10_1 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.T) then
		if arg_10_0.______SocketReceiverCD_______ and os.clock() - arg_10_0.______SocketReceiverCD_______ < 1 then
			return
		end

		require("tolua.reflection")
		tolua.loadassembly("Assembly-CSharp")

		local var_10_5 = SLFramework.SocketMgr.Instance:GetSocketClient(0)
		local var_10_6 = tolua.findtype("SLFramework.TcpSocketClient")
		local var_10_7 = tolua.getproperty(var_10_6, "Receive", 20):Get(var_10_5, {})
		local var_10_8 = tolua.findtype("SLFramework.SocketReceiver")
		local var_10_9 = tolua.getfield(var_10_8, "thread", 36):Get(var_10_7)
		local var_10_10 = tolua.findtype("System.Threading.Thread")
		local var_10_11 = tolua.getproperty(var_10_10, "ThreadState", 20):Get(var_10_9, {})
		local var_10_12 = tolua.getmethod(var_10_10, "Resume")
		local var_10_13 = tolua.getmethod(var_10_10, "Suspend")

		if tostring(var_10_11):find("Suspended") or tostring(var_10_11):find("SuspendRequested") then
			var_10_12:Call(var_10_9)
			GameFacade.showToast(ToastEnum.IconId, "恢复网络")
		else
			var_10_13:Call(var_10_9)
			GameFacade.showToast(ToastEnum.IconId, "暂停网络")
		end

		arg_10_0.______SocketReceiverCD_______ = os.clock()
	end

	local var_10_14 = UnityEngine.PlayerPrefs
	local var_10_15 = PlayerPrefsKey.OpenGM

	if not string.nilorempty(var_10_14.GetString(var_10_15, nil)) then
		var_10_14.DeleteKey(var_10_15)
		ViewMgr.instance:openView(ViewName.GMToolView2)
	end
end

function var_0_0.openGMView(arg_12_0)
	if arg_12_0:checkNeedOpenGM2View() then
		ViewMgr.instance:closeView(ViewName.GMToolView)
		ViewMgr.instance:openView(ViewName.GMToolView2)
	else
		ViewMgr.instance:closeView(ViewName.GMToolView2)
		ViewMgr.instance:openView(ViewName.GMToolView)
	end
end

function var_0_0.checkNeedOpenGM2View(arg_13_0)
	if SkillEditorMgr and SkillEditorMgr.instance and SkillEditorMgr.instance.inEditMode then
		return true
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return true
	end
end

function var_0_0.ignoreHeartBeatLog(arg_14_0)
	LuaSocketMgr.instance:setIgnoreSomeCmdLog({
		"GetServerTimeRequest",
		"GetServerTimeReply"
	})
end

function var_0_0.resumeHeartBeatLog(arg_15_0)
	LuaSocketMgr.instance:setIgnoreSomeCmdLog()
end

function var_0_0.refreshSkillEditorView(arg_16_0)
	if not arg_16_0.goUiRoot then
		arg_16_0.goUiRoot = gohelper.find("UIRoot")
	end

	if not arg_16_0.goCameraRoot then
		arg_16_0.goCameraRoot = gohelper.find("cameraroot")
	end

	if not arg_16_0.goIDRoot then
		arg_16_0.goIDRoot = gohelper.find("IDCanvas")
	end

	arg_16_0.goNameBar = gohelper.findChild(arg_16_0.goUiRoot, "HUD/NameBar")
	arg_16_0.goSkillEffectStatView = gohelper.findChild(arg_16_0.goUiRoot, "POPUP_TOP/SkillEffectStatView")
	arg_16_0.goSkillEditorView = gohelper.findChild(arg_16_0.goUiRoot, "TOP/SkillEditorView")
	arg_16_0.goText = gohelper.findChild(arg_16_0.goUiRoot, "Text")
	arg_16_0.goSubHero = gohelper.findChild(arg_16_0.goCameraRoot, "SceneRoot/FightScene/Entitys/Player_-1")

	if not arg_16_0.goIDPopup then
		arg_16_0.goIDPopup = gohelper.findChild(arg_16_0.goIDRoot, "POPUP")
	end

	arg_16_0.goFloat = gohelper.findChild(arg_16_0.goUiRoot, "HUD/Float")

	gohelper.setActive(arg_16_0.goNameBar, arg_16_0.isShowEditorFightUI)
	gohelper.setActive(arg_16_0.goSkillEffectStatView, arg_16_0.isShowEditorFightUI)
	gohelper.setActive(arg_16_0.goSkillEditorView, arg_16_0.isShowEditorFightUI)
	gohelper.setActive(arg_16_0.goText, arg_16_0.isShowEditorFightUI)
	gohelper.setActive(arg_16_0.goSubHero, arg_16_0.isShowEditorFightUI)
	gohelper.setActive(arg_16_0.goIDPopup, arg_16_0.isShowEditorFightUI)
	gohelper.setActive(arg_16_0.goFloat, arg_16_0.isShowEditorFightUI)
end

function var_0_0.getIsShowEditorFightUI(arg_17_0)
	return arg_17_0.isShowEditorFightUI
end

function var_0_0.playRightSkill(arg_18_0, arg_18_1)
	local var_18_0 = ViewMgr.instance:getContainer(ViewName.SkillEditorView)

	if var_18_0 then
		local var_18_1 = var_18_0.rightSkillEditorSideView._skillSelectView._entityMO.modelId
		local var_18_2 = SkillConfig.instance:getHeroBaseSkillIdDict(var_18_1)

		var_18_0.rightSkillEditorSideView._skillSelectView._curSkillId = var_18_2[arg_18_1]

		var_18_0.rightSkillEditorSideView:_onClickFight()
	end
end

function var_0_0.playFightSceneSpineAnimation(arg_19_0, arg_19_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.SkillEditorView) then
		return
	end

	local var_19_0 = GameSceneMgr.instance:getCurScene()

	if not var_19_0 then
		return
	end

	local var_19_1

	if SkillEditorMgr.instance.cur_select_entity_id then
		var_19_1 = var_19_0.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		var_19_1 = var_19_0.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if not var_19_1 then
		logError("所选对象错误，请从新选择对象")

		return
	end

	arg_19_0._attacker = var_19_1

	local var_19_2 = FightConfig.instance:getSkinSpineActionDict(arg_19_0._attacker:getMO().skin)
	local var_19_3 = var_19_2 and var_19_2[arg_19_1]

	TaskDispatcher.cancelTask(arg_19_0.resetAnim, arg_19_0)
	arg_19_0._attacker.spine:removeAnimEventCallback(arg_19_0._onAnimEvent, arg_19_0)

	if var_19_3 and var_19_3.effectRemoveTime > 0 then
		local var_19_4 = var_19_3.effectRemoveTime / FightModel.instance:getSpeed()

		TaskDispatcher.runDelay(arg_19_0.resetAnim, arg_19_0, var_19_4)
	else
		arg_19_0._ani_need_transition, arg_19_0._transition_ani = FightHelper.needPlayTransitionAni(arg_19_0._attacker, arg_19_1)

		arg_19_0._attacker.spine:addAnimEventCallback(arg_19_0._onAnimEvent, arg_19_0)
	end

	var_19_1.spine:play(arg_19_1, false, true)
end

function var_0_0.resetAnim(arg_20_0)
	if arg_20_0._attacker then
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		arg_20_0._attacker.spine:removeAnimEventCallback(arg_20_0._onAnimEvent, arg_20_0)
		arg_20_0._attacker:resetAnimState()
	end
end

function var_0_0._onAnimEvent(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_2 == SpineAnimEvent.ActionComplete then
		if arg_21_0._ani_need_transition and arg_21_0._transition_ani == arg_21_1 then
			return
		end

		arg_21_0:resetAnim()
	end
end

function var_0_0.getVisualInteractiveMgr(arg_22_0)
	if not arg_22_0.viaMgr then
		arg_22_0.viaMgr = VisualInteractiveAreaMgr.New()

		arg_22_0.viaMgr:init()
	end

	return arg_22_0.viaMgr
end

function var_0_0.getVisualInteractive(arg_23_0)
	return arg_23_0.visualInteractive or false
end

function var_0_0.setVisualInteractive(arg_24_0, arg_24_1)
	arg_24_0.visualInteractive = arg_24_1
end

function var_0_0.switchEnemyVisible(arg_25_0)
	arg_25_0.showEnemy = not arg_25_0.showEnemy

	local var_25_0 = gohelper.find("UIRoot/HUD/NameBar/Monster_1")
	local var_25_1 = gohelper.find("cameraroot/SceneRoot/FightScene/Entitys/Monster_1")

	gohelper.setActive(var_25_0, arg_25_0.showEnemy)
	gohelper.setActive(var_25_1, arg_25_0.showEnemy)
end

function var_0_0._loadGMNodes(arg_26_0)
	arg_26_0._gmNodeLoader = MultiAbLoader.New()

	arg_26_0._gmNodeLoader:addPath(var_0_0.GMNodesPrefabUrl)
	arg_26_0._gmNodeLoader:startLoad(arg_26_0._onLoadGMNodesFinish, arg_26_0)
end

function var_0_0._onLoadGMNodesFinish(arg_27_0, arg_27_1)
	arg_27_0._prefab = arg_27_1:getFirstAssetItem():GetResource()
end

function var_0_0.getGMNode(arg_28_0, arg_28_1, arg_28_2)
	if isDebugBuild then
		if not arg_28_0._prefab then
			return nil
		end

		local var_28_0 = gohelper.findChild(arg_28_0._prefab, arg_28_1)

		if var_28_0 then
			return (gohelper.clone(var_28_0, arg_28_2, var_28_0.name))
		else
			logError("找不到GM节点：" .. arg_28_1)
		end
	end
end

function var_0_0.initShowAudioLog(arg_29_0)
	arg_29_0.showAudioLog = PlayerPrefsHelper.getNumber("showAudioLogKey", 0) == 1
	ZProj.AudioManager.Instance.gmOpenLog = arg_29_0.showAudioLog

	if arg_29_0.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		arg_29_0:initClearAudioLogBtn()
	end
end

function var_0_0.getShowAudioLog(arg_30_0)
	return arg_30_0.showAudioLog
end

function var_0_0.setShowAudioLog(arg_31_0, arg_31_1)
	if arg_31_1 == arg_31_0.showAudioLog then
		return
	end

	arg_31_0.showAudioLog = arg_31_1

	PlayerPrefsHelper.setNumber("showAudioLogKey", arg_31_1 and 1 or 0)

	if arg_31_0.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		arg_31_0:initClearAudioLogBtn()
	else
		ZProj.AudioEditorTool.Instance:HideAudioLog()
	end
end

function var_0_0.initClearAudioLogBtn(arg_32_0)
	if not gohelper.isNil(arg_32_0.clearAudioLogBtn) then
		return
	end

	TaskDispatcher.cancelTask(arg_32_0._initClearAudioLogBtn, arg_32_0)
	TaskDispatcher.runRepeat(arg_32_0._initClearAudioLogBtn, arg_32_0, 1)
end

function var_0_0._initClearAudioLogBtn(arg_33_0)
	local var_33_0 = gohelper.find("UIRoot/TOP/audiolog(Clone)")

	if gohelper.isNil(var_33_0) then
		return
	end

	arg_33_0.clearAudioLogBtn = SLFramework.UGUI.ButtonWrap.GetWithPath(var_33_0, "clearBtn")

	arg_33_0.clearAudioLogBtn:AddClickListener(arg_33_0.onClickClearAudio, arg_33_0)

	arg_33_0.txtLog = gohelper.findChildText(var_33_0, "Scroll View/Viewport/Content")

	TaskDispatcher.cancelTask(arg_33_0._initClearAudioLogBtn, arg_33_0)
end

function var_0_0.onClickClearAudio(arg_34_0)
	if not gohelper.isNil(arg_34_0.txtLog) then
		arg_34_0.txtLog.text = ""
	end
end

function var_0_0.invokeCSharpInstanceMethod(arg_35_0, arg_35_1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	local var_35_0 = tolua.findtype(arg_35_0)
	local var_35_1 = var_35_0.BaseType
	local var_35_2 = tolua.getproperty(var_35_1, "Instance")

	tolua.getmethod(var_35_0, arg_35_1):Call(var_35_2:Get(nil, nil))
end

function var_0_0.TestFightByBattleId(arg_36_0, arg_36_1)
	if not (arg_36_1 and lua_battle.configDict[arg_36_1]) then
		return
	end

	local var_36_0 = FightController.instance:setFightParamByBattleId(arg_36_1)

	HeroGroupModel.instance:setParam(arg_36_1, nil, nil)

	local var_36_1 = HeroGroupModel.instance:getCurGroupMO()

	if not var_36_1 then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local var_36_2, var_36_3 = var_36_1:getMainList()
	local var_36_4, var_36_5 = var_36_1:getSubList()
	local var_36_6 = var_36_1:getAllHeroEquips()

	for iter_36_0, iter_36_1 in ipairs(lua_episode.configList) do
		if iter_36_1.battleId == arg_36_1 then
			var_36_0.episodeId = iter_36_1.id
			FightResultModel.instance.episodeId = iter_36_1.id

			DungeonModel.instance:SetSendChapterEpisodeId(iter_36_1.chapterId, iter_36_1.id)

			break
		end
	end

	if not var_36_0.episodeId then
		var_36_0.episodeId = 10101
	end

	var_36_0:setMySide(var_36_1.clothId, var_36_2, var_36_4, var_36_6)
	FightController.instance:sendTestFightId(var_36_0)
end

function var_0_0.initProfilerCmdFileCheck(arg_37_0)
	if arg_37_0._initProfiler then
		logNormal("profiler is inited")

		return
	end

	arg_37_0._initProfiler = true

	local var_37_0 = 10
	local var_37_1 = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "profiler")
	local var_37_2 = "profilerCmd.json"

	arg_37_0._profilerCmdFilePath = System.IO.Path.Combine(var_37_1, var_37_2)

	arg_37_0:_checkProfilerCmdFile()
	logNormal("begin checkProfilerCmdFile")
	TaskDispatcher.runRepeat(arg_37_0._checkProfilerCmdFile, arg_37_0, var_37_0)
end

function var_0_0._checkProfilerCmdFile(arg_38_0)
	logNormal("Checking Profiler Cmd File")

	if SLFramework.FileHelper.IsFileExists(arg_38_0._profilerCmdFilePath) then
		local var_38_0 = SLFramework.FileHelper.ReadText(arg_38_0._profilerCmdFilePath)

		if not var_38_0 or var_38_0 == "" then
			return
		end

		BenchmarkApi.AndroidLog("profilerCmd.json: " .. var_38_0)

		local var_38_1 = cjson.decode(var_38_0).cmds

		PerformanceRecorder.instance:doProfilerCmdAction(var_38_1)
		SLFramework.FileHelper.WriteTextToPath(arg_38_0._profilerCmdFilePath, "")
	end
end

function var_0_0.setRecordASFDCo(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_0.emitterId = tonumber(arg_39_1)
	arg_39_0.missileId = tonumber(arg_39_2)
	arg_39_0.explosionId = tonumber(arg_39_3)
end

function var_0_0.tempHasField(arg_40_0, arg_40_1)
	return false
end

function var_0_0.startASFDFlow(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if arg_41_0.asfdSequence then
		return
	end

	local var_41_0 = FightDataHelper.entityMgr:getASFDEntityMo(arg_41_2) or arg_41_0:createASFDEmitter(arg_41_2)
	local var_41_1 = {}

	for iter_41_0 = 1, arg_41_1 do
		local var_41_2 = {
			cardIndex = 1,
			actType = 1,
			fromId = var_41_0.id,
			toId = arg_41_3,
			actId = FightASFDConfig.instance.skillId,
			actEffect = {
				{
					targetId = arg_41_3,
					effectType = FightEnum.EffectType.EMITTERFIGHTNOTIFY,
					reserveStr = cjson.encode({
						splitNum = 0,
						emitterAttackNum = iter_41_0,
						emitterAttackMaxNum = arg_41_1
					}),
					HasField = var_0_0.tempHasField,
					cardInfoList = {},
					fightTasks = {}
				}
			}
		}
		local var_41_3 = FightStepData.New(var_41_2)

		table.insert(var_41_1, var_41_3)
	end

	arg_41_0.asfdSequence = FlowSequence.New()

	for iter_41_1, iter_41_2 in ipairs(var_41_1) do
		local var_41_4 = FightASFDFlow.New(iter_41_2, var_41_1[iter_41_1 + 1], iter_41_1)

		arg_41_0.asfdSequence:addWork(var_41_4)
	end

	TaskDispatcher.runDelay(arg_41_0.delayStartASFDFlow, arg_41_0, 1)
end

function var_0_0.delayStartASFDFlow(arg_42_0)
	var_0_0.srcGetASFDCoFunc = FightASFDHelper.getASFDCo
	FightASFDHelper.getASFDCo = var_0_0.tempGetASFDCo

	arg_42_0.asfdSequence:registerDoneListener(arg_42_0.onASFDDone, arg_42_0)
	arg_42_0.asfdSequence:start()
end

function var_0_0.tempGetASFDCo(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_1 == FightEnum.ASFDUnit.Emitter then
		local var_43_0 = var_0_0.instance.emitterId

		return lua_fight_asfd.configDict[var_43_0] or arg_43_2
	elseif arg_43_1 == FightEnum.ASFDUnit.Missile then
		local var_43_1 = var_0_0.instance.missileId

		return lua_fight_asfd.configDict[var_43_1] or arg_43_2
	elseif arg_43_1 == FightEnum.ASFDUnit.Explosion then
		local var_43_2 = var_0_0.instance.explosionId

		return lua_fight_asfd.configDict[var_43_2] or arg_43_2
	else
		return arg_43_2
	end
end

function var_0_0.onASFDDone(arg_44_0)
	FightASFDHelper.getASFDCo = var_0_0.srcGetASFDCoFunc
	arg_44_0.asfdSequence = nil
end

function var_0_0.createASFDEmitter(arg_45_0, arg_45_1)
	local var_45_0 = FightEntityMO.New()

	var_45_0:init({
		skin = 0,
		exSkillLevel = 0,
		userId = 0,
		career = 0,
		exSkill = 0,
		status = 0,
		position = 0,
		level = 0,
		teamType = 0,
		guard = 0,
		subCd = 0,
		exPoint = 0,
		shieldValue = 0,
		modelId = 0,
		uid = arg_45_1 == FightEnum.TeamType.MySide and "99998" or "-99998",
		entityType = FightEnum.EntityType.ASFDEmitter,
		side = arg_45_1,
		attr = {
			defense = 0,
			multiHpNum = 0,
			hp = 0,
			multiHpIdx = 0,
			mdefense = 0,
			technic = 0,
			attack = 0
		},
		buffs = {},
		skillGroup1 = {},
		skillGroup2 = {},
		passiveSkill = {},
		powerInfos = {},
		SummonedList = {}
	})

	var_45_0.side = arg_45_1

	local var_45_1 = FightDataHelper.entityMgr:addEntityMO(var_45_0)
	local var_45_2 = FightDataHelper.entityMgr:getOriginASFDEmitterList(var_45_1.side)

	table.insert(var_45_2, var_45_1)

	local var_45_3 = GameSceneMgr.instance:getCurScene()

	;(var_45_3 and var_45_3.entityMgr):addASFDUnit()

	return var_45_1
end

function var_0_0.getFightFloatPath(arg_46_0)
	return arg_46_0.fightFloatPath
end

function var_0_0.setFightFloatPath(arg_47_0, arg_47_1)
	arg_47_0.fightFloatPath = arg_47_1
end

function var_0_0.replaceGetFloatPathFunc(arg_48_0)
	if arg_48_0.replaced then
		return
	end

	arg_48_0.srcGetFightFloatPathFunc = FightFloatMgr.getFloatPrefab
	FightFloatMgr.getFloatPrefab = var_0_0.getFightFloatPathFunc
	arg_48_0.replaced = true
end

function var_0_0.getFightFloatPathFunc(arg_49_0)
	local var_49_0 = var_0_0.instance:getFightFloatPath()

	if var_49_0 then
		return ResUrl.getSceneUIPrefab("fight", var_49_0)
	end

	return var_0_0.instance.srcGetFightFloatPathFunc(arg_49_0)
end

function var_0_0.getHeroMaxLevel(arg_50_0, arg_50_1)
	arg_50_0.cacheHeroMaxLevelDict = arg_50_0.cacheHeroMaxLevelDict or {}

	local var_50_0 = arg_50_0.cacheHeroMaxLevelDict[arg_50_1]

	if var_50_0 then
		return var_50_0
	end

	local var_50_1 = SkillConfig.instance:getherolevelsCO(arg_50_1)

	if not var_50_1 then
		return 0
	end

	local var_50_2 = 0

	for iter_50_0, iter_50_1 in pairs(var_50_1) do
		if var_50_2 < iter_50_1.level then
			var_50_2 = iter_50_1.level
		end
	end

	arg_50_0.cacheHeroMaxLevelDict[arg_50_1] = var_50_2

	return var_50_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
