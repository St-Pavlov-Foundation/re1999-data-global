module("modules.logic.gm.controller.GMController", package.seeall)

local var_0_0 = class("GMController", BaseController)

var_0_0.debugViewGO = nil
var_0_0.Event = {
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
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		ViewMgr.instance:closeView(ViewName.GMToolView)
		ViewMgr.instance:openView(ViewName.GMToolView2)
	else
		ViewMgr.instance:closeView(ViewName.GMToolView2)
		ViewMgr.instance:openView(ViewName.GMToolView)
	end
end

function var_0_0.ignoreHeartBeatLog(arg_13_0)
	LuaSocketMgr.instance:setIgnoreSomeCmdLog({
		"GetServerTimeRequest",
		"GetServerTimeReply"
	})
end

function var_0_0.resumeHeartBeatLog(arg_14_0)
	LuaSocketMgr.instance:setIgnoreSomeCmdLog()
end

function var_0_0.refreshSkillEditorView(arg_15_0)
	if not arg_15_0.goUiRoot then
		arg_15_0.goUiRoot = gohelper.find("UIRoot")
	end

	if not arg_15_0.goCameraRoot then
		arg_15_0.goCameraRoot = gohelper.find("cameraroot")
	end

	if not arg_15_0.goIDRoot then
		arg_15_0.goIDRoot = gohelper.find("IDCanvas")
	end

	arg_15_0.goNameBar = gohelper.findChild(arg_15_0.goUiRoot, "HUD/NameBar")
	arg_15_0.goSkillEffectStatView = gohelper.findChild(arg_15_0.goUiRoot, "POPUP_TOP/SkillEffectStatView")
	arg_15_0.goSkillEditorView = gohelper.findChild(arg_15_0.goUiRoot, "TOP/SkillEditorView")
	arg_15_0.goText = gohelper.findChild(arg_15_0.goUiRoot, "Text")
	arg_15_0.goSubHero = gohelper.findChild(arg_15_0.goCameraRoot, "SceneRoot/FightScene/Entitys/Player_-1")

	if not arg_15_0.goIDPopup then
		arg_15_0.goIDPopup = gohelper.findChild(arg_15_0.goIDRoot, "POPUP")
	end

	arg_15_0.goFloat = gohelper.findChild(arg_15_0.goUiRoot, "HUD/Float")

	gohelper.setActive(arg_15_0.goNameBar, arg_15_0.isShowEditorFightUI)
	gohelper.setActive(arg_15_0.goSkillEffectStatView, arg_15_0.isShowEditorFightUI)
	gohelper.setActive(arg_15_0.goSkillEditorView, arg_15_0.isShowEditorFightUI)
	gohelper.setActive(arg_15_0.goText, arg_15_0.isShowEditorFightUI)
	gohelper.setActive(arg_15_0.goSubHero, arg_15_0.isShowEditorFightUI)
	gohelper.setActive(arg_15_0.goIDPopup, arg_15_0.isShowEditorFightUI)
	gohelper.setActive(arg_15_0.goFloat, arg_15_0.isShowEditorFightUI)
end

function var_0_0.getIsShowEditorFightUI(arg_16_0)
	return arg_16_0.isShowEditorFightUI
end

function var_0_0.playRightSkill(arg_17_0, arg_17_1)
	local var_17_0 = ViewMgr.instance:getContainer(ViewName.SkillEditorView)

	if var_17_0 then
		local var_17_1 = var_17_0.rightSkillEditorSideView._skillSelectView._entityMO.modelId
		local var_17_2 = SkillConfig.instance:getHeroBaseSkillIdDict(var_17_1)

		var_17_0.rightSkillEditorSideView._skillSelectView._curSkillId = var_17_2[arg_17_1]

		var_17_0.rightSkillEditorSideView:_onClickFight()
	end
end

function var_0_0.playFightSceneSpineAnimation(arg_18_0, arg_18_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.SkillEditorView) then
		return
	end

	local var_18_0 = GameSceneMgr.instance:getCurScene()

	if not var_18_0 then
		return
	end

	local var_18_1

	if SkillEditorMgr.instance.cur_select_entity_id then
		var_18_1 = var_18_0.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		var_18_1 = var_18_0.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if not var_18_1 then
		logError("所选对象错误，请从新选择对象")

		return
	end

	arg_18_0._attacker = var_18_1

	local var_18_2 = FightConfig.instance:getSkinSpineActionDict(arg_18_0._attacker:getMO().skin)
	local var_18_3 = var_18_2 and var_18_2[arg_18_1]

	TaskDispatcher.cancelTask(arg_18_0.resetAnim, arg_18_0)
	arg_18_0._attacker.spine:removeAnimEventCallback(arg_18_0._onAnimEvent, arg_18_0)

	if var_18_3 and var_18_3.effectRemoveTime > 0 then
		local var_18_4 = var_18_3.effectRemoveTime / FightModel.instance:getSpeed()

		TaskDispatcher.runDelay(arg_18_0.resetAnim, arg_18_0, var_18_4)
	else
		arg_18_0._ani_need_transition, arg_18_0._transition_ani = FightHelper.needPlayTransitionAni(arg_18_0._attacker, arg_18_1)

		arg_18_0._attacker.spine:addAnimEventCallback(arg_18_0._onAnimEvent, arg_18_0)
	end

	var_18_1.spine:play(arg_18_1, false, true)
end

function var_0_0.resetAnim(arg_19_0)
	if arg_19_0._attacker then
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		arg_19_0._attacker.spine:removeAnimEventCallback(arg_19_0._onAnimEvent, arg_19_0)
		arg_19_0._attacker:resetAnimState()
	end
end

function var_0_0._onAnimEvent(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 == SpineAnimEvent.ActionComplete then
		if arg_20_0._ani_need_transition and arg_20_0._transition_ani == arg_20_1 then
			return
		end

		arg_20_0:resetAnim()
	end
end

function var_0_0.getVisualInteractiveMgr(arg_21_0)
	if not arg_21_0.viaMgr then
		arg_21_0.viaMgr = VisualInteractiveAreaMgr.New()

		arg_21_0.viaMgr:init()
	end

	return arg_21_0.viaMgr
end

function var_0_0.getVisualInteractive(arg_22_0)
	return arg_22_0.visualInteractive or false
end

function var_0_0.setVisualInteractive(arg_23_0, arg_23_1)
	arg_23_0.visualInteractive = arg_23_1
end

function var_0_0.switchEnemyVisible(arg_24_0)
	arg_24_0.showEnemy = not arg_24_0.showEnemy

	local var_24_0 = gohelper.find("UIRoot/HUD/NameBar/Monster_1")
	local var_24_1 = gohelper.find("cameraroot/SceneRoot/FightScene/Entitys/Monster_1")

	gohelper.setActive(var_24_0, arg_24_0.showEnemy)
	gohelper.setActive(var_24_1, arg_24_0.showEnemy)
end

function var_0_0._loadGMNodes(arg_25_0)
	arg_25_0._gmNodeLoader = MultiAbLoader.New()

	arg_25_0._gmNodeLoader:addPath(var_0_0.GMNodesPrefabUrl)
	arg_25_0._gmNodeLoader:startLoad(arg_25_0._onLoadGMNodesFinish, arg_25_0)
end

function var_0_0._onLoadGMNodesFinish(arg_26_0, arg_26_1)
	arg_26_0._prefab = arg_26_1:getFirstAssetItem():GetResource()
end

function var_0_0.getGMNode(arg_27_0, arg_27_1, arg_27_2)
	if isDebugBuild then
		if not arg_27_0._prefab then
			return nil
		end

		local var_27_0 = gohelper.findChild(arg_27_0._prefab, arg_27_1)

		if var_27_0 then
			return (gohelper.clone(var_27_0, arg_27_2, var_27_0.name))
		else
			logError("找不到GM节点：" .. arg_27_1)
		end
	end
end

function var_0_0.initShowAudioLog(arg_28_0)
	arg_28_0.showAudioLog = PlayerPrefsHelper.getNumber("showAudioLogKey", 0) == 1
	ZProj.AudioManager.Instance.gmOpenLog = arg_28_0.showAudioLog

	if arg_28_0.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		arg_28_0:initClearAudioLogBtn()
	end
end

function var_0_0.getShowAudioLog(arg_29_0)
	return arg_29_0.showAudioLog
end

function var_0_0.setShowAudioLog(arg_30_0, arg_30_1)
	if arg_30_1 == arg_30_0.showAudioLog then
		return
	end

	arg_30_0.showAudioLog = arg_30_1

	PlayerPrefsHelper.setNumber("showAudioLogKey", arg_30_1 and 1 or 0)

	if arg_30_0.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		arg_30_0:initClearAudioLogBtn()
	else
		ZProj.AudioEditorTool.Instance:HideAudioLog()
	end
end

function var_0_0.initClearAudioLogBtn(arg_31_0)
	if not gohelper.isNil(arg_31_0.clearAudioLogBtn) then
		return
	end

	TaskDispatcher.cancelTask(arg_31_0._initClearAudioLogBtn, arg_31_0)
	TaskDispatcher.runRepeat(arg_31_0._initClearAudioLogBtn, arg_31_0, 1)
end

function var_0_0._initClearAudioLogBtn(arg_32_0)
	local var_32_0 = gohelper.find("UIRoot/TOP/audiolog(Clone)")

	if gohelper.isNil(var_32_0) then
		return
	end

	arg_32_0.clearAudioLogBtn = SLFramework.UGUI.ButtonWrap.GetWithPath(var_32_0, "clearBtn")

	arg_32_0.clearAudioLogBtn:AddClickListener(arg_32_0.onClickClearAudio, arg_32_0)

	arg_32_0.txtLog = gohelper.findChildText(var_32_0, "Scroll View/Viewport/Content")

	TaskDispatcher.cancelTask(arg_32_0._initClearAudioLogBtn, arg_32_0)
end

function var_0_0.onClickClearAudio(arg_33_0)
	if not gohelper.isNil(arg_33_0.txtLog) then
		arg_33_0.txtLog.text = ""
	end
end

function var_0_0.invokeCSharpInstanceMethod(arg_34_0, arg_34_1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	local var_34_0 = tolua.findtype(arg_34_0)
	local var_34_1 = var_34_0.BaseType
	local var_34_2 = tolua.getproperty(var_34_1, "Instance")

	tolua.getmethod(var_34_0, arg_34_1):Call(var_34_2:Get(nil, nil))
end

function var_0_0.TestFightByBattleId(arg_35_0, arg_35_1)
	if not (arg_35_1 and lua_battle.configDict[arg_35_1]) then
		return
	end

	local var_35_0 = FightController.instance:setFightParamByBattleId(arg_35_1)

	HeroGroupModel.instance:setParam(arg_35_1, nil, nil)

	local var_35_1 = HeroGroupModel.instance:getCurGroupMO()

	if not var_35_1 then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local var_35_2, var_35_3 = var_35_1:getMainList()
	local var_35_4, var_35_5 = var_35_1:getSubList()
	local var_35_6 = var_35_1:getAllHeroEquips()

	for iter_35_0, iter_35_1 in ipairs(lua_episode.configList) do
		if iter_35_1.battleId == arg_35_1 then
			var_35_0.episodeId = iter_35_1.id
			FightResultModel.instance.episodeId = iter_35_1.id

			DungeonModel.instance:SetSendChapterEpisodeId(iter_35_1.chapterId, iter_35_1.id)

			break
		end
	end

	if not var_35_0.episodeId then
		var_35_0.episodeId = 10101
	end

	var_35_0:setMySide(var_35_1.clothId, var_35_2, var_35_4, var_35_6)
	FightController.instance:sendTestFightId(var_35_0)
end

function var_0_0.initProfilerCmdFileCheck(arg_36_0)
	if arg_36_0._initProfiler then
		return
	end

	arg_36_0._initProfiler = true

	local var_36_0 = 10
	local var_36_1 = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "profiler")
	local var_36_2 = "profilerCmd.json"

	arg_36_0._profilerCmdFilePath = System.IO.Path.Combine(var_36_1, var_36_2)

	arg_36_0:_checkProfilerCmdFile()
	TaskDispatcher.runRepeat(arg_36_0._checkProfilerCmdFile, arg_36_0, var_36_0)
end

function var_0_0._checkProfilerCmdFile(arg_37_0)
	if SLFramework.FileHelper.IsFileExists(arg_37_0._profilerCmdFilePath) then
		local var_37_0 = SLFramework.FileHelper.ReadText(arg_37_0._profilerCmdFilePath)

		if not var_37_0 or var_37_0 == "" then
			return
		end

		BenchmarkApi.AndroidLog("profilerCmd.json: " .. var_37_0)

		local var_37_1 = cjson.decode(var_37_0).cmds

		PerformanceRecorder.instance:doProfilerCmdAction(var_37_1)
		SLFramework.FileHelper.WriteTextToPath(arg_37_0._profilerCmdFilePath, "")
	end
end

function var_0_0.setRecordASFDCo(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	arg_38_0.emitterId = tonumber(arg_38_1)
	arg_38_0.missileId = tonumber(arg_38_2)
	arg_38_0.explosionId = tonumber(arg_38_3)
end

function var_0_0.tempHasField(arg_39_0, arg_39_1)
	return false
end

function var_0_0.startASFDFlow(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if arg_40_0.asfdSequence then
		return
	end

	local var_40_0 = FightDataHelper.entityMgr:getASFDEntityMo(arg_40_2) or arg_40_0:createASFDEmitter(arg_40_2)
	local var_40_1 = {}

	for iter_40_0 = 1, arg_40_1 do
		local var_40_2 = {
			cardIndex = 1,
			actType = 1,
			fromId = var_40_0.id,
			toId = arg_40_3,
			actId = FightASFDConfig.instance.skillId,
			actEffect = {
				{
					targetId = arg_40_3,
					effectType = FightEnum.EffectType.EMITTERFIGHTNOTIFY,
					reserveStr = cjson.encode({
						splitNum = 0,
						emitterAttackNum = iter_40_0,
						emitterAttackMaxNum = arg_40_1
					}),
					HasField = var_0_0.tempHasField,
					cardInfoList = {},
					fightTasks = {}
				}
			}
		}
		local var_40_3 = FightStepData.New(var_40_2)

		table.insert(var_40_1, var_40_3)
	end

	arg_40_0.asfdSequence = FlowSequence.New()

	for iter_40_1, iter_40_2 in ipairs(var_40_1) do
		local var_40_4 = FightASFDFlow.New(iter_40_2, var_40_1[iter_40_1 + 1], iter_40_1)

		arg_40_0.asfdSequence:addWork(var_40_4)
	end

	TaskDispatcher.runDelay(arg_40_0.delayStartASFDFlow, arg_40_0, 1)
end

function var_0_0.delayStartASFDFlow(arg_41_0)
	var_0_0.srcGetASFDCoFunc = FightASFDHelper.getASFDCo
	FightASFDHelper.getASFDCo = var_0_0.tempGetASFDCo

	arg_41_0.asfdSequence:registerDoneListener(arg_41_0.onASFDDone, arg_41_0)
	arg_41_0.asfdSequence:start()
end

function var_0_0.tempGetASFDCo(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_1 == FightEnum.ASFDUnit.Emitter then
		local var_42_0 = var_0_0.instance.emitterId

		return lua_fight_asfd.configDict[var_42_0] or arg_42_2
	elseif arg_42_1 == FightEnum.ASFDUnit.Missile then
		local var_42_1 = var_0_0.instance.missileId

		return lua_fight_asfd.configDict[var_42_1] or arg_42_2
	elseif arg_42_1 == FightEnum.ASFDUnit.Explosion then
		local var_42_2 = var_0_0.instance.explosionId

		return lua_fight_asfd.configDict[var_42_2] or arg_42_2
	else
		return arg_42_2
	end
end

function var_0_0.onASFDDone(arg_43_0)
	FightASFDHelper.getASFDCo = var_0_0.srcGetASFDCoFunc
	arg_43_0.asfdSequence = nil
end

function var_0_0.createASFDEmitter(arg_44_0, arg_44_1)
	local var_44_0 = FightEntityMO.New()

	var_44_0:init({
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
		uid = arg_44_1 == FightEnum.TeamType.MySide and "99998" or "-99998",
		entityType = FightEnum.EntityType.ASFDEmitter,
		side = arg_44_1,
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

	var_44_0.side = arg_44_1

	local var_44_1 = FightDataHelper.entityMgr:addEntityMO(var_44_0)
	local var_44_2 = FightDataHelper.entityMgr:getOriginASFDEmitterList(var_44_1.side)

	table.insert(var_44_2, var_44_1)

	local var_44_3 = GameSceneMgr.instance:getCurScene()

	;(var_44_3 and var_44_3.entityMgr):addASFDUnit()

	return var_44_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
