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

function var_0_0.openGMView(arg_11_0)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		ViewMgr.instance:closeView(ViewName.GMToolView)
		ViewMgr.instance:openView(ViewName.GMToolView2)
	else
		ViewMgr.instance:closeView(ViewName.GMToolView2)
		ViewMgr.instance:openView(ViewName.GMToolView)
	end
end

function var_0_0.ignoreHeartBeatLog(arg_12_0)
	LuaSocketMgr.instance:setIgnoreSomeCmdLog({
		"GetServerTimeRequest",
		"GetServerTimeReply"
	})
end

function var_0_0.resumeHeartBeatLog(arg_13_0)
	LuaSocketMgr.instance:setIgnoreSomeCmdLog()
end

function var_0_0.refreshSkillEditorView(arg_14_0)
	if not arg_14_0.goUiRoot then
		arg_14_0.goUiRoot = gohelper.find("UIRoot")
	end

	if not arg_14_0.goCameraRoot then
		arg_14_0.goCameraRoot = gohelper.find("cameraroot")
	end

	if not arg_14_0.goIDRoot then
		arg_14_0.goIDRoot = gohelper.find("IDCanvas")
	end

	arg_14_0.goNameBar = gohelper.findChild(arg_14_0.goUiRoot, "HUD/NameBar")
	arg_14_0.goSkillEffectStatView = gohelper.findChild(arg_14_0.goUiRoot, "POPUP_TOP/SkillEffectStatView")
	arg_14_0.goSkillEditorView = gohelper.findChild(arg_14_0.goUiRoot, "TOP/SkillEditorView")
	arg_14_0.goText = gohelper.findChild(arg_14_0.goUiRoot, "Text")
	arg_14_0.goSubHero = gohelper.findChild(arg_14_0.goCameraRoot, "SceneRoot/FightScene/Entitys/Player_-1")

	if not arg_14_0.goIDPopup then
		arg_14_0.goIDPopup = gohelper.findChild(arg_14_0.goIDRoot, "POPUP")
	end

	arg_14_0.goFloat = gohelper.findChild(arg_14_0.goUiRoot, "HUD/Float")

	gohelper.setActive(arg_14_0.goNameBar, arg_14_0.isShowEditorFightUI)
	gohelper.setActive(arg_14_0.goSkillEffectStatView, arg_14_0.isShowEditorFightUI)
	gohelper.setActive(arg_14_0.goSkillEditorView, arg_14_0.isShowEditorFightUI)
	gohelper.setActive(arg_14_0.goText, arg_14_0.isShowEditorFightUI)
	gohelper.setActive(arg_14_0.goSubHero, arg_14_0.isShowEditorFightUI)
	gohelper.setActive(arg_14_0.goIDPopup, arg_14_0.isShowEditorFightUI)
	gohelper.setActive(arg_14_0.goFloat, arg_14_0.isShowEditorFightUI)
end

function var_0_0.getIsShowEditorFightUI(arg_15_0)
	return arg_15_0.isShowEditorFightUI
end

function var_0_0.playRightSkill(arg_16_0, arg_16_1)
	local var_16_0 = ViewMgr.instance:getContainer(ViewName.SkillEditorView)

	if var_16_0 then
		local var_16_1 = var_16_0.rightSkillEditorSideView._skillSelectView._entityMO.modelId
		local var_16_2 = SkillConfig.instance:getHeroBaseSkillIdDict(var_16_1)

		var_16_0.rightSkillEditorSideView._skillSelectView._curSkillId = var_16_2[arg_16_1]

		var_16_0.rightSkillEditorSideView:_onClickFight()
	end
end

function var_0_0.playFightSceneSpineAnimation(arg_17_0, arg_17_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.SkillEditorView) then
		return
	end

	local var_17_0 = GameSceneMgr.instance:getCurScene()

	if not var_17_0 then
		return
	end

	local var_17_1

	if SkillEditorMgr.instance.cur_select_entity_id then
		var_17_1 = var_17_0.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		var_17_1 = var_17_0.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if not var_17_1 then
		logError("所选对象错误，请从新选择对象")

		return
	end

	arg_17_0._attacker = var_17_1

	local var_17_2 = FightConfig.instance:getSkinSpineActionDict(arg_17_0._attacker:getMO().skin)
	local var_17_3 = var_17_2 and var_17_2[arg_17_1]

	TaskDispatcher.cancelTask(arg_17_0.resetAnim, arg_17_0)
	arg_17_0._attacker.spine:removeAnimEventCallback(arg_17_0._onAnimEvent, arg_17_0)

	if var_17_3 and var_17_3.effectRemoveTime > 0 then
		local var_17_4 = var_17_3.effectRemoveTime / FightModel.instance:getSpeed()

		TaskDispatcher.runDelay(arg_17_0.resetAnim, arg_17_0, var_17_4)
	else
		arg_17_0._ani_need_transition, arg_17_0._transition_ani = FightHelper.needPlayTransitionAni(arg_17_0._attacker, arg_17_1)

		arg_17_0._attacker.spine:addAnimEventCallback(arg_17_0._onAnimEvent, arg_17_0)
	end

	var_17_1.spine:play(arg_17_1, false, true)
end

function var_0_0.resetAnim(arg_18_0)
	if arg_18_0._attacker then
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		arg_18_0._attacker.spine:removeAnimEventCallback(arg_18_0._onAnimEvent, arg_18_0)
		arg_18_0._attacker:resetAnimState()
	end
end

function var_0_0._onAnimEvent(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_2 == SpineAnimEvent.ActionComplete then
		if arg_19_0._ani_need_transition and arg_19_0._transition_ani == arg_19_1 then
			return
		end

		arg_19_0:resetAnim()
	end
end

function var_0_0.getVisualInteractiveMgr(arg_20_0)
	if not arg_20_0.viaMgr then
		arg_20_0.viaMgr = VisualInteractiveAreaMgr.New()

		arg_20_0.viaMgr:init()
	end

	return arg_20_0.viaMgr
end

function var_0_0.getVisualInteractive(arg_21_0)
	return arg_21_0.visualInteractive or false
end

function var_0_0.setVisualInteractive(arg_22_0, arg_22_1)
	arg_22_0.visualInteractive = arg_22_1
end

function var_0_0.switchEnemyVisible(arg_23_0)
	arg_23_0.showEnemy = not arg_23_0.showEnemy

	local var_23_0 = gohelper.find("UIRoot/HUD/NameBar/Monster_1")
	local var_23_1 = gohelper.find("cameraroot/SceneRoot/FightScene/Entitys/Monster_1")

	gohelper.setActive(var_23_0, arg_23_0.showEnemy)
	gohelper.setActive(var_23_1, arg_23_0.showEnemy)
end

function var_0_0._loadGMNodes(arg_24_0)
	arg_24_0._gmNodeLoader = MultiAbLoader.New()

	arg_24_0._gmNodeLoader:addPath(var_0_0.GMNodesPrefabUrl)
	arg_24_0._gmNodeLoader:startLoad(arg_24_0._onLoadGMNodesFinish, arg_24_0)
end

function var_0_0._onLoadGMNodesFinish(arg_25_0, arg_25_1)
	arg_25_0._prefab = arg_25_1:getFirstAssetItem():GetResource()
end

function var_0_0.getGMNode(arg_26_0, arg_26_1, arg_26_2)
	if isDebugBuild then
		if not arg_26_0._prefab then
			return nil
		end

		local var_26_0 = gohelper.findChild(arg_26_0._prefab, arg_26_1)

		if var_26_0 then
			return (gohelper.clone(var_26_0, arg_26_2, var_26_0.name))
		else
			logError("找不到GM节点：" .. arg_26_1)
		end
	end
end

function var_0_0.initShowAudioLog(arg_27_0)
	arg_27_0.showAudioLog = PlayerPrefsHelper.getNumber("showAudioLogKey", 0) == 1
	ZProj.AudioManager.Instance.gmOpenLog = arg_27_0.showAudioLog

	if arg_27_0.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		arg_27_0:initClearAudioLogBtn()
	end
end

function var_0_0.getShowAudioLog(arg_28_0)
	return arg_28_0.showAudioLog
end

function var_0_0.setShowAudioLog(arg_29_0, arg_29_1)
	if arg_29_1 == arg_29_0.showAudioLog then
		return
	end

	arg_29_0.showAudioLog = arg_29_1

	PlayerPrefsHelper.setNumber("showAudioLogKey", arg_29_1 and 1 or 0)

	if arg_29_0.showAudioLog then
		ZProj.AudioEditorTool.Instance:ShowAudioLog()
		arg_29_0:initClearAudioLogBtn()
	else
		ZProj.AudioEditorTool.Instance:HideAudioLog()
	end
end

function var_0_0.initClearAudioLogBtn(arg_30_0)
	if not gohelper.isNil(arg_30_0.clearAudioLogBtn) then
		return
	end

	TaskDispatcher.cancelTask(arg_30_0._initClearAudioLogBtn, arg_30_0)
	TaskDispatcher.runRepeat(arg_30_0._initClearAudioLogBtn, arg_30_0, 1)
end

function var_0_0._initClearAudioLogBtn(arg_31_0)
	local var_31_0 = gohelper.find("UIRoot/TOP/audiolog(Clone)")

	if gohelper.isNil(var_31_0) then
		return
	end

	arg_31_0.clearAudioLogBtn = SLFramework.UGUI.ButtonWrap.GetWithPath(var_31_0, "clearBtn")

	arg_31_0.clearAudioLogBtn:AddClickListener(arg_31_0.onClickClearAudio, arg_31_0)

	arg_31_0.txtLog = gohelper.findChildText(var_31_0, "Scroll View/Viewport/Content")

	TaskDispatcher.cancelTask(arg_31_0._initClearAudioLogBtn, arg_31_0)
end

function var_0_0.onClickClearAudio(arg_32_0)
	if not gohelper.isNil(arg_32_0.txtLog) then
		arg_32_0.txtLog.text = ""
	end
end

function var_0_0.invokeCSharpInstanceMethod(arg_33_0, arg_33_1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	local var_33_0 = tolua.findtype(arg_33_0)
	local var_33_1 = var_33_0.BaseType
	local var_33_2 = tolua.getproperty(var_33_1, "Instance")

	tolua.getmethod(var_33_0, arg_33_1):Call(var_33_2:Get(nil, nil))
end

function var_0_0.TestFightByBattleId(arg_34_0, arg_34_1)
	if not (arg_34_1 and lua_battle.configDict[arg_34_1]) then
		return
	end

	local var_34_0 = FightController.instance:setFightParamByBattleId(arg_34_1)

	HeroGroupModel.instance:setParam(arg_34_1, nil, nil)

	local var_34_1 = HeroGroupModel.instance:getCurGroupMO()

	if not var_34_1 then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local var_34_2, var_34_3 = var_34_1:getMainList()
	local var_34_4, var_34_5 = var_34_1:getSubList()
	local var_34_6 = var_34_1:getAllHeroEquips()

	for iter_34_0, iter_34_1 in ipairs(lua_episode.configList) do
		if iter_34_1.battleId == arg_34_1 then
			var_34_0.episodeId = iter_34_1.id
			FightResultModel.instance.episodeId = iter_34_1.id

			DungeonModel.instance:SetSendChapterEpisodeId(iter_34_1.chapterId, iter_34_1.id)

			break
		end
	end

	if not var_34_0.episodeId then
		var_34_0.episodeId = 10101
	end

	var_34_0:setMySide(var_34_1.clothId, var_34_2, var_34_4, var_34_6)
	FightController.instance:sendTestFightId(var_34_0)
end

function var_0_0.initProfilerCmdFileCheck(arg_35_0)
	if arg_35_0._initProfiler then
		return
	end

	arg_35_0._initProfiler = true

	local var_35_0 = 10
	local var_35_1 = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "profiler")
	local var_35_2 = "profilerCmd.json"

	arg_35_0._profilerCmdFilePath = System.IO.Path.Combine(var_35_1, var_35_2)

	logNormal("initProfilerCmdFileCheck")
	TaskDispatcher.runRepeat(arg_35_0._checkProfilerCmdFile, arg_35_0, var_35_0)
end

function var_0_0._checkProfilerCmdFile(arg_36_0)
	if SLFramework.FileHelper.IsFileExists(arg_36_0._profilerCmdFilePath) then
		local var_36_0 = SLFramework.FileHelper.ReadText(arg_36_0._profilerCmdFilePath)

		if not var_36_0 or var_36_0 == "" then
			return
		end

		logNormal("profilerCmd.json: " .. var_36_0)

		local var_36_1 = cjson.decode(var_36_0).cmds

		PerformanceRecorder.instance:doProfilerCmdAction(var_36_1)
		SLFramework.FileHelper.WriteTextToPath(arg_36_0._profilerCmdFilePath, "")
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
