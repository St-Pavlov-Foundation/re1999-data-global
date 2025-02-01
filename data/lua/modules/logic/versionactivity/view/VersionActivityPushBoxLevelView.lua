module("modules.logic.versionactivity.view.VersionActivityPushBoxLevelView", package.seeall)

slot0 = class("VersionActivityPushBoxLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._scrolllevels = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_levels")
	slot0._golevel10 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level10")
	slot0._golevel9 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level9")
	slot0._golevel8 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level8")
	slot0._golevel7 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level7")
	slot0._golevel6 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level6")
	slot0._golevel5 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level5")
	slot0._golevel4 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level4")
	slot0._golevel3 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level3")
	slot0._golevel2 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level2")
	slot0._golevel1 = gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content/#go_level1")
	slot0._gotaskred = gohelper.findChild(slot0.viewGO, "#btn_task/#go_task_red")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "top/#txt_remaintime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.DataEvent.ReceiveTaskRewardReply, slot0._onReceiveTaskRewardReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
end

function slot0._btntaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxTaskView)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("pushbox/full/bg"))

	slot0._ani = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0._playOpenAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function slot0.onOpen(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.VersionActivityPushBoxNewLevelOpen, 0) then
		GameFacade.showToast(ToastEnum.VersionActivityPushBoxNewLevelOpen)
	end

	TaskDispatcher.runDelay(slot0._playOpenAudio, slot0, 0.5)

	slot0._activity_data = ActivityModel.instance:getActivityInfo()[PushBoxModel.instance:getCurActivityID()]

	slot0.viewContainer._navigateButtonView:setOverrideClose(slot0._onNavigateCloseCallback, slot0)
	slot0.viewContainer._navigateButtonView:setOverrideHome(slot0._onNavigateHomeCallback, slot0)

	slot0._episode_list = PushBoxEpisodeConfig.instance:getEpisodeList()
	slot1 = slot0.viewParam and slot0.viewParam.id
	slot2 = nil

	for slot6 = 1, 10 do
		gohelper.findChildComponent(slot0["_golevel" .. slot6], "go_info/go_finish", typeof(UnityEngine.Animation)).enabled = false

		if not slot0._episode_list[slot6] then
			gohelper.setActive(slot0["_golevel" .. slot6], false)
		else
			if PushBoxModel.instance:getPassData(slot0._episode_list[slot6].id) then
				-- Nothing
			elseif not slot2 then
				slot2 = true

				gohelper.setActive(gohelper.findChild(slot0["_golevel" .. slot6], "go_info"), true)
			else
				gohelper.setActive(slot8, false)
				slot0["_golevel" .. slot6]:GetComponent(typeof(UnityEngine.Animator)):Play("in")
			end

			if slot1 == slot0._episode_list[slot6].id then
				if slot6 > 5 then
					recthelper.setAnchorX(gohelper.findChild(slot0.viewGO, "#scroll_levels/Viewport/Content").transform, -950)
				end

				if slot0.viewParam.win then
					slot0._new_finish_episode = slot0._episode_list[slot6].id
				end
			end
		end
	end

	slot0:_refreshLevelData()
	slot0:_updateDeadline()
	TaskDispatcher.runRepeat(slot0._updateDeadline, slot0, 60)
end

function slot0._updateDeadline(slot0)
	slot0._txtremaintime.text = string.format(luaLang("remain"), ActivityModel.instance:getActivityInfo()[PushBoxModel.instance:getCurActivityID()]:getRemainTimeStr2ByEndTime())
end

function slot0._refreshLevelData(slot0)
	for slot5, slot6 in ipairs(slot0._episode_list) do
		slot8 = PushBoxModel.instance:getPassData(slot6.id)
		slot9 = slot0["_golevel" .. slot5]
		gohelper.findChildTextMesh(slot9, "go_info/txt_title").text = slot6.name
		slot11 = gohelper.findChild(slot9, "go_info/go_lock")
		slot12 = gohelper.findChild(slot9, "go_info/go_finish")
		slot14 = gohelper.findChildTextMesh(slot9, "go_info/go_lock/go_speciallock/txt_unlocktime")
		slot15 = gohelper.findChild(slot9, "go_info/go_lock/go_speciallock")
		slot16 = gohelper.findChild(slot9, "go_info/go_lock/go_normallock")
		slot17 = gohelper.findChild(slot9, "go_info/txt_index")
		slot18 = gohelper.findChild(slot9, "maplock")

		gohelper.setActive(slot18, not slot8)
		gohelper.setActive(gohelper.findChild(slot9, "map"), slot8)

		slot18:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = false and 1 or 0.5

		if slot8 then
			UISpriteSetMgr.instance:setPushBoxSprite(gohelper.findChildImage(slot9, "simage_map"), string.format("gk_%02d", slot5), true)
		else
			UISpriteSetMgr.instance:setPushBoxSprite(slot13, string.format("gkj_%02d", slot5), true)

			slot21 = PushBoxModel.instance:getStageOpened(slot7)

			gohelper.setActive(slot15, not slot21)
			gohelper.setActive(slot16, slot21)

			if not slot21 then
				slot14.text = os.date("%m.%d", PushBoxModel.instance:getEpisodeOpenTime(slot7)) .. luaLang("unlock")
			end
		end

		slot1 = slot8

		gohelper.setActive(slot12, slot8 and slot8.state == 1)
		gohelper.setActive(slot11, not slot8)
		gohelper.setActive(slot17, slot8)
		gohelper.findChildClickWithAudio(slot9, "btn_click"):AddClickListener(slot0._episodeClick, slot0, slot7)
		gohelper.setActive(gohelper.findChild(slot9, "go_selectedbg"), false)
		gohelper.setActive(gohelper.findChild(slot9, "go_selected"), false)

		if slot0._new_finish_episode == slot7 then
			slot0._new_finish_obj = slot12

			gohelper.setActive(slot12, false)
			TaskDispatcher.runDelay(slot0._playNewFinish, slot0, 1.5)
		end
	end

	RedDotController.instance:addRedDot(slot0._gotaskred, RedDotEnum.DotNode.VersionActivityPushBoxTask)
end

function slot0._refreshTaskRed(slot0)
	slot2 = false

	for slot6, slot7 in ipairs(PushBoxEpisodeConfig.instance:getTaskList()) do
		if PushBoxModel.instance:getTaskData(slot7.taskId) and not slot8.hasGetBonus and slot7.maxProgress <= slot8.progress then
			slot2 = true

			break
		end
	end

	gohelper.setActive(slot0._gotaskred, slot2)
end

function slot0._onReceiveTaskRewardReply(slot0)
end

function slot0._playNewFinish(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_mark_finish)
	gohelper.setActive(slot0._new_finish_obj, true)

	slot1 = gohelper.onceAddComponent(slot0._new_finish_obj, typeof(UnityEngine.Animation))
	slot1.enabled = true

	slot1:Rewind()
	slot1:Play()
end

function slot0._episodeClick(slot0, slot1)
	if not PushBoxModel.instance:getPassData(slot1) then
		if PushBoxModel.instance:getEpisodeOpenTime(slot1) < ServerTime.now() then
			GameFacade.showToast(ToastEnum.ActivityPushBoxLevel)

			return
		else
			return
		end

		return
	end

	if slot0._activity_data:isExpired() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	slot2 = PushBoxEpisodeConfig.instance:getConfig(slot1)
	slot0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr

	slot0._game_mgr:startGame(slot2.id)

	slot0._cur_select_config = slot2
	slot4 = slot0["_golevel" .. tabletool.indexOf(slot0._episode_list, slot2)]

	gohelper.setActive(gohelper.findChild(slot4, "go_info/go_selectedbg"), true)
	gohelper.setActive(gohelper.findChild(slot4, "go_info/go_selected"), true)
	TaskDispatcher.runDelay(slot0._delaySelectEpisode, slot0, 0.3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_level_chosen)
end

function slot0._delaySelectEpisode(slot0)
	slot0._ani:Play("gameopen")
	TaskDispatcher.runDelay(slot0._delayEnterGame, slot0, 0.2)
end

function slot0._delayEnterGame(slot0)
	recthelper.setAnchorX(slot0.viewGO.transform, 10000)
	slot0:onClose()
	GuideController.instance:dispatchEvent(GuideEvent["OnPushBoxEnter" .. slot0._cur_select_config.id])
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxGameView)
	slot0._game_mgr:playOpenAni()
end

function slot0._onNavigateCloseCallback(slot0)
	if GameSceneMgr.instance:isPushBoxScene() then
		GameSceneMgr.instance:getCurScene().gameMgr:hideRoot()
	end

	slot0:onClose()
	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()
	end)
end

function slot0._onNavigateHomeCallback(slot0)
	if GameSceneMgr.instance:isPushBoxScene() then
		GameSceneMgr.instance:getCurScene().gameMgr:hideRoot()
	end

	NavigateButtonsView.homeClick()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._playOpenAudio, slot0)
	TaskDispatcher.cancelTask(slot0._delaySelectEpisode, slot0)
	TaskDispatcher.cancelTask(slot0._delayEnterGame, slot0)
	TaskDispatcher.cancelTask(slot0._playNewFinish, slot0)
	TaskDispatcher.cancelTask(slot0._updateDeadline, slot0)

	if slot0._episode_list then
		for slot4, slot5 in ipairs(slot0._episode_list) do
			slot6 = slot0["_golevel" .. slot4]

			gohelper.findChildClickWithAudio(slot6, "btn_click"):RemoveClickListener()
			slot6:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Close)
		end
	end

	slot0.viewContainer._navigateButtonView:setOverrideClose(nil, )
	slot0.viewContainer._navigateButtonView:setOverrideHome(nil, )
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
