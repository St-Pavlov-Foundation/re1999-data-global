module("modules.logic.weekwalk.view.WeekWalkMapInteractiveItem", package.seeall)

local var_0_0 = class("WeekWalkMapInteractiveItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/bg/#simage_bg")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/bg/#txt_info")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_mask")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_mask/Scroll View/Viewport/#go_scroll")
	arg_1_0._gochatarea = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_chatarea")
	arg_1_0._gochatitem = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_chatarea/#go_chatitem")
	arg_1_0._goimportanttips = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_importanttips")
	arg_1_0._txttipsinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/bg/#go_importanttips/bg/#txt_tipsinfo")
	arg_1_0._goop1 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op1")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op1/#go_rewards")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op1/#go_normal")
	arg_1_0._gonorewards = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op1/#go_normal/#go_norewards")
	arg_1_0._gohasrewards = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op1/#go_normal/#go_hasrewards")
	arg_1_0._goboss = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op1/#go_boss")
	arg_1_0._gobossnorewards = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op1/#go_boss/#go_bossnorewards")
	arg_1_0._gobosshasrewards = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op1/#go_boss/#go_bosshasrewards")
	arg_1_0._btndoit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op1/#btn_doit")
	arg_1_0._goop2 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op2")
	arg_1_0._gounfinishtask = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op2/#go_unfinishtask")
	arg_1_0._txtunfinishtask = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op2/#go_unfinishtask/#txt_unfinishtask")
	arg_1_0._btnunfinishtask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op2/#go_unfinishtask/#btn_unfinishtask")
	arg_1_0._gofinishtask = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op2/#go_finishtask")
	arg_1_0._txtfinishtask = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op2/#go_finishtask/#txt_finishtask")
	arg_1_0._btnfinishtask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op2/#go_finishtask/#btn_finishtask")
	arg_1_0._goop3 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op3")
	arg_1_0._gofinishFight = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op3/#go_finishFight")
	arg_1_0._txtwin = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op3/#go_finishFight/bg/#txt_win")
	arg_1_0._btnwin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op3/#go_finishFight/bg/#btn_win")
	arg_1_0._gounfinishedFight = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op3/#go_unfinishedFight")
	arg_1_0._txtfight = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op3/#go_unfinishedFight/bg/#txt_fight")
	arg_1_0._btnfight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op3/#go_unfinishedFight/bg/#btn_fight")
	arg_1_0._goop4 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4")
	arg_1_0._gonext = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4/#go_next")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op4/#go_next/#btn_next")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4/#go_options")
	arg_1_0._gotalkitem = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4/#go_options/#go_talkitem")
	arg_1_0._gofinishtalk = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4/#go_finishtalk")
	arg_1_0._btnfinishtalk = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op4/#go_finishtalk/#btn_finishtalk")
	arg_1_0._goop5 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op5")
	arg_1_0._gosubmit = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op5/#go_submit")
	arg_1_0._btnsubmit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op5/#go_submit/#btn_submit")
	arg_1_0._inputanswer = gohelper.findChildInputField(arg_1_0.viewGO, "rotate/#go_op5/#input_answer")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndoit:AddClickListener(arg_2_0._btndoitOnClick, arg_2_0)
	arg_2_0._btnunfinishtask:AddClickListener(arg_2_0._btnunfinishtaskOnClick, arg_2_0)
	arg_2_0._btnfinishtask:AddClickListener(arg_2_0._btnfinishtaskOnClick, arg_2_0)
	arg_2_0._btnwin:AddClickListener(arg_2_0._btnwinOnClick, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnfinishtalk:AddClickListener(arg_2_0._btnfinishtalkOnClick, arg_2_0)
	arg_2_0._btnsubmit:AddClickListener(arg_2_0._btnsubmitOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndoit:RemoveClickListener()
	arg_3_0._btnunfinishtask:RemoveClickListener()
	arg_3_0._btnfinishtask:RemoveClickListener()
	arg_3_0._btnwin:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnfinishtalk:RemoveClickListener()
	arg_3_0._btnsubmit:RemoveClickListener()
end

function var_0_0._btnsubmitOnClick(arg_4_0)
	arg_4_0._inputanswer = gohelper.findChildTextMeshInputField(arg_4_0.viewGO, "rotate/#go_op5/#input_answer")

	if arg_4_0._inputanswer:GetText() == arg_4_0._config.param then
		arg_4_0:_onHide()
		DungeonRpc.instance:sendMapElementRequest(arg_4_0._config.id)
	else
		arg_4_0._inputanswer:SetText("")
		GameFacade.showToast(ToastEnum.DungeonMapInteractive)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btncloseOnClick(arg_5_0)
	if arg_5_0._playScrollAnim then
		return
	end

	arg_5_0:_onHide()
end

function var_0_0._btnfinishtalkOnClick(arg_6_0)
	arg_6_0:_onHide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	if arg_6_0._config.skipFinish == 1 then
		return
	end

	arg_6_0:_sendFinishDialog()
end

function var_0_0._sendFinishDialog(arg_7_0)
	if arg_7_0._elementInfo:getType() == WeekWalkEnum.ElementType.Dialog then
		WeekwalkRpc.instance:sendWeekwalkDialogRequest(arg_7_0._config.id, tonumber(arg_7_0._option_param) or 0)
	end
end

function var_0_0._btndoitOnClick(arg_8_0)
	arg_8_0:_onHide()

	local var_8_0 = arg_8_0._elementInfo.elementId

	WeekWalkModel.instance:setBattleElementId(var_8_0)
	WeekwalkRpc.instance:sendBeforeStartWeekwalkBattleRequest(var_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnfightOnClick(arg_9_0)
	arg_9_0:_onHide()

	local var_9_0 = tonumber(arg_9_0._config.param)

	DungeonModel.instance.curLookEpisodeId = var_9_0

	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0)

	DungeonFightController.instance:enterFight(var_9_1.chapterId, var_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnunfinishtaskOnClick(arg_10_0)
	arg_10_0:_onHide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnfinishtaskOnClick(arg_11_0)
	arg_11_0:_onHide()

	local var_11_0 = arg_11_0._elementInfo.elementId

	WeekwalkRpc.instance:sendWeekwalkGeneralRequest(var_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnnextOnClick(arg_12_0)
	if arg_12_0._playScrollAnim then
		return
	end

	arg_12_0:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btntalkitemOnClick(arg_13_0)
	return
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._nextAnimator = arg_14_0._gonext:GetComponent(typeof(UnityEngine.Animator))
	arg_14_0._imgMask = arg_14_0._gomask:GetComponent(gohelper.Type_Image)
end

function var_0_0._playAnim(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1:GetComponent(typeof(UnityEngine.Animator)):Play(arg_15_2)
end

function var_0_0._onShow(arg_16_0)
	if arg_16_0._show then
		return
	end

	arg_16_0._mapElement:setWenHaoVisible(false)

	arg_16_0._show = true

	gohelper.setActive(arg_16_0.viewGO, true)
	arg_16_0:_playAnim(arg_16_0._gonext, "dungeonmap_interactive_in")
	TaskDispatcher.cancelTask(arg_16_0._showCloseBtn, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._showCloseBtn, arg_16_0, 0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function var_0_0._showCloseBtn(arg_17_0)
	gohelper.setActive(arg_17_0._btnclose.gameObject, true)
end

function var_0_0._onOutAnimationFinished(arg_18_0)
	gohelper.setActive(arg_18_0.viewGO, false)
	UIBlockMgr.instance:endBlock("dungeonmap_interactive_out")
	gohelper.destroy(arg_18_0.viewGO)
end

function var_0_0._onHide(arg_19_0)
	if not arg_19_0._show then
		return
	end

	arg_19_0:_clearScroll()
	arg_19_0._mapElement:setWenHaoVisible(true)

	arg_19_0._show = false

	gohelper.setActive(arg_19_0._btnclose.gameObject, false)
	UIBlockMgr.instance:startBlock("dungeonmap_interactive_out")
	arg_19_0:_playAnim(arg_19_0._gonext, "dungeonmap_interactive_btn_out")
	arg_19_0:_playAnim(arg_19_0._gofinishtalk, "dungeonmap_interactive_btn_out")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

	for iter_19_0, iter_19_1 in pairs(arg_19_0._optionBtnList) do
		arg_19_0:_playAnim(iter_19_1[1], "dungeonmap_interactive_btn_out")
	end

	TaskDispatcher.runDelay(arg_19_0._onOutAnimationFinished, arg_19_0, 0.23)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
end

function var_0_0.init(arg_20_0, arg_20_1)
	arg_20_0.viewGO = arg_20_1
	arg_20_0._optionBtnList = arg_20_0:getUserDataTb_()
	arg_20_0._dialogItemList = arg_20_0:getUserDataTb_()
	arg_20_0._dialogItemCacheList = arg_20_0:getUserDataTb_()

	arg_20_0:onInitView()
	arg_20_0:addEvents()
	arg_20_0:_editableAddEvents()
end

function var_0_0._editableAddEvents(arg_21_0)
	return
end

function var_0_0._OnClickElement(arg_22_0, arg_22_1)
	arg_22_0._mapElement = arg_22_1

	if arg_22_0._show then
		arg_22_0:_onHide()

		return
	end

	arg_22_0:_onShow()

	arg_22_0._config = arg_22_0._mapElement._config
	arg_22_0._elementGo = arg_22_0._mapElement._go
	arg_22_0._elementInfo = arg_22_0._mapElement._info
	arg_22_0._elementX, arg_22_0._elementY, arg_22_0._elementZ = transformhelper.getPos(arg_22_0._elementGo.transform)

	local var_22_0 = arg_22_0._config.offsetPos or "2#3"

	if not string.nilorempty(var_22_0) then
		local var_22_1 = string.splitToNumber(var_22_0, "#")

		arg_22_0._elementAddX = arg_22_0._elementX + (var_22_1[1] or 0)
		arg_22_0._elementAddY = arg_22_0._elementY + (var_22_1[2] or 0)
	end

	arg_22_0.viewGO.transform.position = Vector3(arg_22_0._elementAddX, arg_22_0._elementAddY, arg_22_0._elementZ)

	local var_22_2 = not string.nilorempty(arg_22_0._config.flagText)

	gohelper.setActive(arg_22_0._goimportanttips, var_22_2)

	if var_22_2 then
		arg_22_0._txttipsinfo.text = arg_22_0._config.flagText
	end

	local var_22_3 = arg_22_0._elementInfo:getType()
	local var_22_4 = var_22_3 == WeekWalkEnum.ElementType.Dialog

	gohelper.setActive(arg_22_0._txtinfo.gameObject, false)
	gohelper.setActive(arg_22_0._gochatarea, var_22_4)

	if var_22_3 == WeekWalkEnum.ElementType.General then
		arg_22_0:_directlyComplete()
	elseif var_22_3 == WeekWalkEnum.ElementType.Battle then
		local var_22_5 = tonumber(arg_22_0._elementInfo:getPrevParam())

		if var_22_5 then
			gohelper.setActive(arg_22_0._gochatarea, true)
			arg_22_0:_playStory(var_22_5)
		end

		arg_22_0:_showTypeGo(var_22_3)
	elseif var_22_3 == DungeonEnum.ElementType.Task then
		arg_22_0:_showTask()
	elseif var_22_4 then
		arg_22_0:_showTypeGo(var_22_3)
		arg_22_0:_playStory()
	elseif var_22_3 == DungeonEnum.ElementType.Question then
		arg_22_0:_playQuestion()
	else
		logError("element type undefined!")
	end

	arg_22_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("tc3.png"))
end

function var_0_0._showTypeGo(arg_23_0, arg_23_1)
	for iter_23_0 = 1, WeekWalkEnum.ElementType.MaxCount do
		gohelper.setActive(arg_23_0["_goop" .. iter_23_0], iter_23_0 == arg_23_1)
	end

	if arg_23_1 == WeekWalkEnum.ElementType.Battle then
		local var_23_0 = arg_23_0._config.isBoss > 0

		gohelper.setActive(arg_23_0._gonormal, not var_23_0)
		gohelper.setActive(arg_23_0._goboss, var_23_0)
		arg_23_0:_showRewards(var_23_0)
	end
end

function var_0_0._showRewards(arg_24_0, arg_24_1)
	local var_24_0 = string.splitToNumber(arg_24_0._config.bonusGroup, "#")[2] or 0

	if not (var_24_0 > 0) then
		gohelper.setActive(not arg_24_1 and arg_24_0._gonorewards or arg_24_0._gobossnorewards, true)

		return
	end

	gohelper.setActive(not arg_24_1 and arg_24_0._gohasrewards or arg_24_0._gobosshasrewards, true)

	local var_24_1 = WeekWalkModel.instance:getLevel()
	local var_24_2 = WeekWalkConfig.instance:getBonus(var_24_0, var_24_1)
	local var_24_3 = GameUtil.splitString2(var_24_2, true, "|", "#")

	if not var_24_3 then
		return
	end

	for iter_24_0, iter_24_1 in ipairs(var_24_3) do
		local var_24_4 = IconMgr.instance:getCommonItemIcon(arg_24_0._gorewards)

		var_24_4:setMOValue(iter_24_1[1], iter_24_1[2], iter_24_1[3])
		var_24_4:setScale(0.39)
		var_24_4:customOnClickCallback(arg_24_0._openRewardView, var_24_3)
	end
end

function var_0_0._playQuestion(arg_25_0)
	arg_25_0._txtinfo.text = arg_25_0._config.desc
end

function var_0_0._showTask(arg_26_0)
	arg_26_0._txtinfo.text = arg_26_0._config.desc

	local var_26_0 = arg_26_0._config.param
	local var_26_1 = string.splitToNumber(var_26_0, "#")
	local var_26_2 = var_26_1[3]
	local var_26_3 = ItemModel.instance:getItemConfig(var_26_1[1], var_26_1[2])
	local var_26_4 = ItemModel.instance:getItemQuantity(var_26_1[1], var_26_1[2])

	arg_26_0._finishTask = var_26_2 <= var_26_4

	gohelper.setActive(arg_26_0._gofinishtask, arg_26_0._finishTask)
	gohelper.setActive(arg_26_0._gounfinishtask, not arg_26_0._finishTask)

	if arg_26_0._finishTask then
		arg_26_0._txtfinishtask.text = string.format("%s%s<color=#00ff00>%s</color>/%s", luaLang("dungeon_map_submit"), var_26_3.name, var_26_4, var_26_2)
	else
		arg_26_0._txtunfinishtask.text = string.format("%s%s<color=#ff0000>%s</color>/%s", luaLang("dungeon_map_submit"), var_26_3.name, var_26_4, var_26_2)
	end
end

function var_0_0._directlyComplete(arg_27_0)
	arg_27_0._txtinfo.text = arg_27_0._config.desc
end

function var_0_0._playNextSectionOrDialog(arg_28_0)
	arg_28_0:_clearDialog()

	if #arg_28_0._sectionList >= arg_28_0._dialogIndex then
		arg_28_0:_playNextDialog()

		return
	end

	local var_28_0 = table.remove(arg_28_0._sectionStack)

	if var_28_0 then
		arg_28_0:_playSection(var_28_0[1], var_28_0[2])
	else
		arg_28_0:_refreshDialogBtnState()
	end
end

function var_0_0._playStory(arg_29_0, arg_29_1)
	arg_29_0:_clearDialog()

	arg_29_0._sectionStack = {}
	arg_29_0._optionId = 0
	arg_29_0._mainSectionId = "0"
	arg_29_0._sectionId = arg_29_0._mainSectionId
	arg_29_0._dialogIndex = nil
	arg_29_0._historyList = {}
	arg_29_0._dialogId = arg_29_1 or tonumber(arg_29_0._elementInfo:getParam())

	arg_29_0:_initHistoryItem()

	arg_29_0._historyList.id = arg_29_0._dialogId

	arg_29_0:_playSection(arg_29_0._sectionId, arg_29_0._dialogIndex)
end

function var_0_0._initHistoryItem(arg_30_0)
	local var_30_0 = arg_30_0._elementInfo.historylist

	if #var_30_0 == 0 then
		return
	end

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		local var_30_1 = string.split(iter_30_1, "#")

		arg_30_0._historyList[var_30_1[1]] = tonumber(var_30_1[2])
	end

	local var_30_2 = arg_30_0._historyList.id

	if not var_30_2 or var_30_2 ~= arg_30_0._dialogId then
		arg_30_0._historyList = {}

		return
	end

	arg_30_0._option_param = arg_30_0._historyList.option

	local var_30_3 = arg_30_0._mainSectionId
	local var_30_4 = arg_30_0._historyList[var_30_3]

	arg_30_0:_addSectionHistory(var_30_3, var_30_4)

	if not arg_30_0._dialogIndex then
		arg_30_0._dialogIndex = var_30_4
		arg_30_0._sectionId = var_30_3
	end
end

function var_0_0._addSectionHistory(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = WeekWalkConfig.instance:getDialog(arg_31_0._dialogId, arg_31_1)
	local var_31_1

	if arg_31_1 == arg_31_0._mainSectionId then
		var_31_1 = arg_31_2 > #var_31_0
	else
		var_31_1 = arg_31_2 >= #var_31_0
	end

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if iter_31_0 < arg_31_2 or var_31_1 then
			if iter_31_1.type == "dialog" then
				local var_31_2 = arg_31_0:_addDialogItem("dialog", iter_31_1.content, iter_31_1.speaker)

				table.insert(arg_31_0._dialogItemList, var_31_2)
			end

			if iter_31_1.type == "options" then
				local var_31_3 = string.split(iter_31_1.content, "#")
				local var_31_4 = string.split(iter_31_1.param, "#")
				local var_31_5 = {}
				local var_31_6 = {}

				for iter_31_2, iter_31_3 in ipairs(var_31_4) do
					local var_31_7 = WeekWalkConfig.instance:getDialog(arg_31_0._dialogId, iter_31_3)

					if var_31_7 and var_31_7.type == "random" then
						for iter_31_4, iter_31_5 in ipairs(var_31_7) do
							local var_31_8 = string.split(iter_31_5.option_param, "#")
							local var_31_9 = var_31_8[2]
							local var_31_10 = var_31_8[3]

							table.insert(var_31_5, var_31_3[iter_31_2])
							table.insert(var_31_6, var_31_9)
							table.insert(var_31_5, var_31_3[iter_31_2])
							table.insert(var_31_6, var_31_10)
						end
					elseif var_31_7 then
						table.insert(var_31_5, var_31_3[iter_31_2])
						table.insert(var_31_6, iter_31_3)
					else
						local var_31_11 = string.format("<indent=4.7em><color=#c95318>\"%s\"</color>", var_31_3[iter_31_2])
						local var_31_12 = arg_31_0:_addDialogItem("option", var_31_11)

						table.insert(arg_31_0._dialogItemList, var_31_12)
					end
				end

				for iter_31_6, iter_31_7 in ipairs(var_31_6) do
					local var_31_13 = arg_31_0._historyList[iter_31_7]

					if var_31_13 then
						local var_31_14 = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", var_31_5[iter_31_6])
						local var_31_15 = arg_31_0:_addDialogItem("option", var_31_14)

						table.insert(arg_31_0._dialogItemList, var_31_15)
						arg_31_0:_addSectionHistory(iter_31_7, var_31_13)
					end
				end
			end
		else
			break
		end
	end

	if not var_31_1 then
		if not arg_31_0._dialogIndex then
			arg_31_0._dialogIndex = arg_31_2
			arg_31_0._sectionId = arg_31_1

			return
		end

		table.insert(arg_31_0._sectionStack, 1, {
			arg_31_1,
			arg_31_2
		})
	end
end

function var_0_0._playSection(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0:_setSectionData(arg_32_1, arg_32_2)
	arg_32_0:_playNextDialog()
end

function var_0_0._setSectionData(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._sectionList = WeekWalkConfig.instance:getDialog(arg_33_0._dialogId, arg_33_1)

	if arg_33_0._sectionList and not string.nilorempty(arg_33_0._sectionList.option_param) then
		arg_33_0._option_param = arg_33_0._sectionList.option_param
	end

	if not string.nilorempty(arg_33_0._option_param) then
		arg_33_0._historyList.option = arg_33_0._option_param
	end

	arg_33_0._dialogIndex = arg_33_2 or 1
	arg_33_0._sectionId = arg_33_1
end

function var_0_0._playNextDialog(arg_34_0)
	local var_34_0 = arg_34_0._sectionList[arg_34_0._dialogIndex]

	if var_34_0 and var_34_0.type == "dialog" then
		arg_34_0:_showDialog("dialog", var_34_0.content, var_34_0.speaker)
	elseif var_34_0 and var_34_0.type == "options" then
		arg_34_0:_showOptionByConfig(var_34_0)

		return
	end

	arg_34_0._dialogIndex = arg_34_0._dialogIndex + 1

	if #arg_34_0._sectionStack > 0 and #arg_34_0._sectionList < arg_34_0._dialogIndex then
		local var_34_1 = table.remove(arg_34_0._sectionStack)

		arg_34_0:_setSectionData(var_34_1[1], var_34_1[2])
	end

	local var_34_2 = arg_34_0._sectionList[arg_34_0._dialogIndex]

	arg_34_0:_showOptionByConfig(var_34_2)

	if arg_34_0._dissolveInfo then
		gohelper.setActive(arg_34_0._curBtnGo, false)
	end
end

function var_0_0._showOptionByConfig(arg_35_0, arg_35_1)
	local var_35_0 = false

	if arg_35_1 and arg_35_1.type == "options" then
		arg_35_0._dialogIndex = arg_35_0._dialogIndex + 1

		local var_35_1 = string.split(arg_35_1.content, "#")
		local var_35_2 = string.split(arg_35_1.param, "#")

		for iter_35_0, iter_35_1 in pairs(arg_35_0._optionBtnList) do
			gohelper.setActive(iter_35_1[1], false)
		end

		for iter_35_2, iter_35_3 in ipairs(var_35_1) do
			arg_35_0:_addDialogOption(iter_35_2, var_35_2[iter_35_2], iter_35_3)
		end

		var_35_0 = true
	end

	arg_35_0:_refreshDialogBtnState(var_35_0)
end

function var_0_0._refreshDialogBtnState(arg_36_0, arg_36_1)
	gohelper.setActive(arg_36_0._gooptions, arg_36_1)

	if arg_36_1 then
		arg_36_0._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(arg_36_0._gofinishtalk.gameObject, false)

		arg_36_0._curBtnGo = arg_36_0._gooptions

		return
	end

	local var_36_0 = #arg_36_0._sectionStack > 0 or #arg_36_0._sectionList >= arg_36_0._dialogIndex

	if var_36_0 then
		arg_36_0._curBtnGo = arg_36_0._gonext

		gohelper.setActive(arg_36_0._gonext.gameObject, var_36_0)
		arg_36_0._nextAnimator:Play("dungeonmap_interactive_btn_in1")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		arg_36_0._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		arg_36_0._curBtnGo = arg_36_0._gofinishtalk
	end

	local var_36_1 = not var_36_0

	gohelper.setActive(arg_36_0._gofinishtalk.gameObject, var_36_1)

	if var_36_1 then
		local var_36_2 = arg_36_0._elementInfo:getNextType()

		if not var_36_2 then
			return
		end

		arg_36_0:_sendFinishDialog()
		arg_36_0:_showTypeGo(var_36_2)
	end
end

function var_0_0._addDialogOption(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = arg_37_0._optionBtnList[arg_37_1] and arg_37_0._optionBtnList[arg_37_1][1] or gohelper.cloneInPlace(arg_37_0._gotalkitem)

	arg_37_0._maxOptionIndex = arg_37_1

	gohelper.setActive(var_37_0, false)

	gohelper.findChildText(var_37_0, "txt_talkitem").text = arg_37_3

	local var_37_1 = gohelper.findChildButtonWithAudio(var_37_0, "btn_talkitem")

	var_37_1:AddClickListener(arg_37_0._onOptionClick, arg_37_0, {
		arg_37_2,
		arg_37_3,
		arg_37_1
	})

	if not arg_37_0._optionBtnList[arg_37_1] then
		arg_37_0._optionBtnList[arg_37_1] = {
			var_37_0,
			var_37_1
		}
	end
end

function var_0_0._onOptionClick(arg_38_0, arg_38_1)
	if arg_38_0._playScrollAnim then
		return
	end

	local var_38_0 = arg_38_1[1]
	local var_38_1 = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", arg_38_1[2])

	arg_38_0:_clearDialog()
	arg_38_0:_showDialog("option", var_38_1)

	arg_38_0._showOption = true
	arg_38_0._optionId = arg_38_1[3]

	arg_38_0:_checkOption(var_38_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._checkOption(arg_39_0, arg_39_1)
	local var_39_0 = WeekWalkConfig.instance:getDialog(arg_39_0._dialogId, arg_39_1)

	if not var_39_0 then
		arg_39_0:_playNextSectionOrDialog()

		return
	end

	if #arg_39_0._sectionList >= arg_39_0._dialogIndex then
		table.insert(arg_39_0._sectionStack, {
			arg_39_0._sectionId,
			arg_39_0._dialogIndex
		})
	end

	if var_39_0.type == "random" then
		for iter_39_0, iter_39_1 in ipairs(var_39_0) do
			local var_39_1 = string.split(iter_39_1.option_param, "#")
			local var_39_2 = tonumber(var_39_1[1])
			local var_39_3 = var_39_1[2]
			local var_39_4 = var_39_1[3]
			local var_39_5 = math.random(100)
			local var_39_6

			if var_39_5 <= var_39_2 then
				var_39_6 = var_39_3
			else
				var_39_6 = var_39_4
			end

			arg_39_0:_playSection(var_39_6)

			break
		end
	else
		arg_39_0:_playSection(arg_39_1)
	end
end

function var_0_0._showDialog(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if arg_40_0._elementInfo:getType() == WeekWalkEnum.ElementType.Dialog then
		arg_40_0._historyList[arg_40_0._sectionId] = arg_40_0._dialogIndex

		local var_40_0 = {}

		for iter_40_0, iter_40_1 in pairs(arg_40_0._historyList) do
			table.insert(var_40_0, string.format("%s#%s", iter_40_0, iter_40_1))
		end

		WeekwalkRpc.instance:sendWeekwalkDialogHistoryRequest(arg_40_0._config.id, var_40_0)
		arg_40_0._elementInfo:updateHistoryList(var_40_0)
	end

	local var_40_1 = arg_40_0:_addDialogItem(arg_40_1, arg_40_2, arg_40_3)

	if arg_40_0._showOption and arg_40_0._addDialog then
		-- block empty
	end

	arg_40_0._showOption = false

	table.insert(arg_40_0._dialogItemList, var_40_1)

	arg_40_0._addDialog = true
end

function var_0_0._addDialogItem(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = table.remove(arg_41_0._dialogItemCacheList) or gohelper.cloneInPlace(arg_41_0._gochatitem)

	transformhelper.setLocalPos(var_41_0.transform, 0, 0, 200)
	gohelper.setActive(var_41_0, true)
	gohelper.setAsLastSibling(var_41_0)

	gohelper.findChildText(var_41_0, "name").text = not string.nilorempty(arg_41_3) and arg_41_3 .. ":" or ""

	local var_41_1 = gohelper.findChild(var_41_0, "usericon")

	gohelper.setActive(var_41_1, not arg_41_3)

	local var_41_2 = gohelper.findChildText(var_41_0, "info")

	var_41_2.text = string.nilorempty(arg_41_3) and arg_41_2 or "<indent=4.7em>" .. arg_41_2

	SLFramework.UGUI.GuiHelper.SetColor(var_41_2, string.nilorempty(arg_41_3) and "#9E967B" or "#D0CFCF")

	return var_41_0
end

function var_0_0._clearDialog(arg_42_0)
	arg_42_0._playScrollAnim = true

	gohelper.setActive(arg_42_0._gomask, false)
	TaskDispatcher.runDelay(arg_42_0._delayScroll, arg_42_0, 0)
end

function var_0_0._delayScroll(arg_43_0)
	gohelper.setActive(arg_43_0._gomask, true)

	arg_43_0._imgMask.enabled = true

	local var_43_0 = arg_43_0._curScrollGo or arg_43_0._goscroll

	for iter_43_0, iter_43_1 in ipairs(arg_43_0._dialogItemList) do
		local var_43_1 = iter_43_1.transform.position

		gohelper.addChild(var_43_0, iter_43_1)

		iter_43_1.transform.position = var_43_1

		local var_43_2, var_43_3, var_43_4 = transformhelper.getLocalPos(iter_43_1.transform)

		transformhelper.setLocalPos(iter_43_1.transform, var_43_2, var_43_3, 0)
	end

	arg_43_0._dialogItemList = arg_43_0:getUserDataTb_()

	gohelper.setActive(var_43_0, true)

	arg_43_0._curScrollGo = var_43_0

	if var_43_0 then
		if arg_43_0._dissolveInfo then
			local var_43_5 = arg_43_0._dissolveInfo[2]
			local var_43_6 = arg_43_0._dissolveInfo[3]

			var_43_5.text = ""
		end

		arg_43_0:_scrollEnd(var_43_0)
	end
end

function var_0_0._scrollEnd(arg_44_0, arg_44_1)
	if arg_44_1 ~= arg_44_0._curScrollGo then
		gohelper.destroy(arg_44_1)
	else
		if arg_44_0._dissolveInfo then
			TaskDispatcher.runDelay(arg_44_0._onDissolveStart, arg_44_0, 0.3)

			return
		end

		arg_44_0:_onDissolveFinish()
	end
end

function var_0_0._onDissolveStart(arg_45_0)
	local var_45_0 = arg_45_0._dissolveInfo[1]

	arg_45_0._dissolveInfo[2].text = arg_45_0._dissolveInfo[3]
	arg_45_0._imgMask.enabled = false

	var_45_0:GetComponent(typeof(UnityEngine.Animation)):Play("dungeonmap_chatarea")
	TaskDispatcher.runDelay(arg_45_0._onDissolveFinish, arg_45_0, 1.3)
end

function var_0_0._onDissolveFinish(arg_46_0)
	gohelper.setActive(arg_46_0._curBtnGo, true)

	arg_46_0._dissolveInfo = nil
	arg_46_0._playScrollAnim = false

	if arg_46_0._curBtnGo == arg_46_0._gooptions then
		for iter_46_0 = 1, arg_46_0._maxOptionIndex do
			local var_46_0 = (iter_46_0 - 1) * 0.03
			local var_46_1 = arg_46_0._optionBtnList[iter_46_0][1]

			if var_46_0 > 0 then
				gohelper.setActive(var_46_1, false)
				TaskDispatcher.runDelay(function()
					if not gohelper.isNil(var_46_1) then
						gohelper.setActive(var_46_1, true)
					end
				end, nil, var_46_0)
			else
				gohelper.setActive(var_46_1, true)
			end
		end
	end
end

function var_0_0._clearScroll(arg_48_0)
	arg_48_0._showOption = false
	arg_48_0._dissolveInfo = nil
	arg_48_0._playScrollAnim = false

	TaskDispatcher.cancelTask(arg_48_0._delayScroll, arg_48_0)

	if arg_48_0._oldScrollGo then
		gohelper.destroy(arg_48_0._oldScrollGo)

		arg_48_0._oldScrollGo = nil
	end

	if arg_48_0._curScrollGo then
		gohelper.destroy(arg_48_0._curScrollGo)

		arg_48_0._curScrollGo = nil
	end

	arg_48_0._dialogItemList = arg_48_0:getUserDataTb_()
end

function var_0_0._editableRemoveEvents(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(arg_49_0._optionBtnList) do
		iter_49_1[2]:RemoveClickListener()
	end
end

function var_0_0.onDestroy(arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._showCloseBtn, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._delayScroll, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._onDissolveStart, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._onDissolveFinish, arg_50_0)
	arg_50_0:removeEvents()
	arg_50_0:_editableRemoveEvents()
	arg_50_0._simagebg:UnLoadImage()
end

return var_0_0
