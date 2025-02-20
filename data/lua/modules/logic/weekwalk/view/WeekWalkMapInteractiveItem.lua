module("modules.logic.weekwalk.view.WeekWalkMapInteractiveItem", package.seeall)

slot0 = class("WeekWalkMapInteractiveItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "rotate/bg/#simage_bg")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "rotate/bg/#txt_info")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_mask")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_mask/Scroll View/Viewport/#go_scroll")
	slot0._gochatarea = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_chatarea")
	slot0._gochatitem = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_chatarea/#go_chatitem")
	slot0._goimportanttips = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_importanttips")
	slot0._txttipsinfo = gohelper.findChildText(slot0.viewGO, "rotate/bg/#go_importanttips/bg/#txt_tipsinfo")
	slot0._goop1 = gohelper.findChild(slot0.viewGO, "rotate/#go_op1")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "rotate/#go_op1/#go_rewards")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "rotate/#go_op1/#go_normal")
	slot0._gonorewards = gohelper.findChild(slot0.viewGO, "rotate/#go_op1/#go_normal/#go_norewards")
	slot0._gohasrewards = gohelper.findChild(slot0.viewGO, "rotate/#go_op1/#go_normal/#go_hasrewards")
	slot0._goboss = gohelper.findChild(slot0.viewGO, "rotate/#go_op1/#go_boss")
	slot0._gobossnorewards = gohelper.findChild(slot0.viewGO, "rotate/#go_op1/#go_boss/#go_bossnorewards")
	slot0._gobosshasrewards = gohelper.findChild(slot0.viewGO, "rotate/#go_op1/#go_boss/#go_bosshasrewards")
	slot0._btndoit = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op1/#btn_doit")
	slot0._goop2 = gohelper.findChild(slot0.viewGO, "rotate/#go_op2")
	slot0._gounfinishtask = gohelper.findChild(slot0.viewGO, "rotate/#go_op2/#go_unfinishtask")
	slot0._txtunfinishtask = gohelper.findChildText(slot0.viewGO, "rotate/#go_op2/#go_unfinishtask/#txt_unfinishtask")
	slot0._btnunfinishtask = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op2/#go_unfinishtask/#btn_unfinishtask")
	slot0._gofinishtask = gohelper.findChild(slot0.viewGO, "rotate/#go_op2/#go_finishtask")
	slot0._txtfinishtask = gohelper.findChildText(slot0.viewGO, "rotate/#go_op2/#go_finishtask/#txt_finishtask")
	slot0._btnfinishtask = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op2/#go_finishtask/#btn_finishtask")
	slot0._goop3 = gohelper.findChild(slot0.viewGO, "rotate/#go_op3")
	slot0._gofinishFight = gohelper.findChild(slot0.viewGO, "rotate/#go_op3/#go_finishFight")
	slot0._txtwin = gohelper.findChildText(slot0.viewGO, "rotate/#go_op3/#go_finishFight/bg/#txt_win")
	slot0._btnwin = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op3/#go_finishFight/bg/#btn_win")
	slot0._gounfinishedFight = gohelper.findChild(slot0.viewGO, "rotate/#go_op3/#go_unfinishedFight")
	slot0._txtfight = gohelper.findChildText(slot0.viewGO, "rotate/#go_op3/#go_unfinishedFight/bg/#txt_fight")
	slot0._btnfight = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op3/#go_unfinishedFight/bg/#btn_fight")
	slot0._goop4 = gohelper.findChild(slot0.viewGO, "rotate/#go_op4")
	slot0._gonext = gohelper.findChild(slot0.viewGO, "rotate/#go_op4/#go_next")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op4/#go_next/#btn_next")
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "rotate/#go_op4/#go_options")
	slot0._gotalkitem = gohelper.findChild(slot0.viewGO, "rotate/#go_op4/#go_options/#go_talkitem")
	slot0._gofinishtalk = gohelper.findChild(slot0.viewGO, "rotate/#go_op4/#go_finishtalk")
	slot0._btnfinishtalk = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op4/#go_finishtalk/#btn_finishtalk")
	slot0._goop5 = gohelper.findChild(slot0.viewGO, "rotate/#go_op5")
	slot0._gosubmit = gohelper.findChild(slot0.viewGO, "rotate/#go_op5/#go_submit")
	slot0._btnsubmit = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op5/#go_submit/#btn_submit")
	slot0._inputanswer = gohelper.findChildInputField(slot0.viewGO, "rotate/#go_op5/#input_answer")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btndoit:AddClickListener(slot0._btndoitOnClick, slot0)
	slot0._btnunfinishtask:AddClickListener(slot0._btnunfinishtaskOnClick, slot0)
	slot0._btnfinishtask:AddClickListener(slot0._btnfinishtaskOnClick, slot0)
	slot0._btnwin:AddClickListener(slot0._btnwinOnClick, slot0)
	slot0._btnfight:AddClickListener(slot0._btnfightOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnfinishtalk:AddClickListener(slot0._btnfinishtalkOnClick, slot0)
	slot0._btnsubmit:AddClickListener(slot0._btnsubmitOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btndoit:RemoveClickListener()
	slot0._btnunfinishtask:RemoveClickListener()
	slot0._btnfinishtask:RemoveClickListener()
	slot0._btnwin:RemoveClickListener()
	slot0._btnfight:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnfinishtalk:RemoveClickListener()
	slot0._btnsubmit:RemoveClickListener()
end

function slot0._btnsubmitOnClick(slot0)
	slot0._inputanswer = gohelper.findChildTextMeshInputField(slot0.viewGO, "rotate/#go_op5/#input_answer")

	if slot0._inputanswer:GetText() == slot0._config.param then
		slot0:_onHide()
		DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	else
		slot0._inputanswer:SetText("")
		GameFacade.showToast(ToastEnum.DungeonMapInteractive)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btncloseOnClick(slot0)
	if slot0._playScrollAnim then
		return
	end

	slot0:_onHide()
end

function slot0._btnfinishtalkOnClick(slot0)
	slot0:_onHide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	if slot0._config.skipFinish == 1 then
		return
	end

	slot0:_sendFinishDialog()
end

function slot0._sendFinishDialog(slot0)
	if slot0._elementInfo:getType() == WeekWalkEnum.ElementType.Dialog then
		WeekwalkRpc.instance:sendWeekwalkDialogRequest(slot0._config.id, tonumber(slot0._option_param) or 0)
	end
end

function slot0._btndoitOnClick(slot0)
	slot0:_onHide()

	slot1 = slot0._elementInfo.elementId

	WeekWalkModel.instance:setBattleElementId(slot1)
	WeekwalkRpc.instance:sendBeforeStartWeekwalkBattleRequest(slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnfightOnClick(slot0)
	slot0:_onHide()

	slot1 = tonumber(slot0._config.param)
	DungeonModel.instance.curLookEpisodeId = slot1

	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnunfinishtaskOnClick(slot0)
	slot0:_onHide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnfinishtaskOnClick(slot0)
	slot0:_onHide()
	WeekwalkRpc.instance:sendWeekwalkGeneralRequest(slot0._elementInfo.elementId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnnextOnClick(slot0)
	if slot0._playScrollAnim then
		return
	end

	slot0:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btntalkitemOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._nextAnimator = slot0._gonext:GetComponent(typeof(UnityEngine.Animator))
	slot0._imgMask = slot0._gomask:GetComponent(gohelper.Type_Image)
end

function slot0._playAnim(slot0, slot1, slot2)
	slot1:GetComponent(typeof(UnityEngine.Animator)):Play(slot2)
end

function slot0._onShow(slot0)
	if slot0._show then
		return
	end

	slot0._mapElement:setWenHaoVisible(false)

	slot0._show = true

	gohelper.setActive(slot0.viewGO, true)
	slot0:_playAnim(slot0._gonext, "dungeonmap_interactive_in")
	TaskDispatcher.cancelTask(slot0._showCloseBtn, slot0)
	TaskDispatcher.runDelay(slot0._showCloseBtn, slot0, 0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function slot0._showCloseBtn(slot0)
	gohelper.setActive(slot0._btnclose.gameObject, true)
end

function slot0._onOutAnimationFinished(slot0)
	gohelper.setActive(slot0.viewGO, false)
	UIBlockMgr.instance:endBlock("dungeonmap_interactive_out")
	gohelper.destroy(slot0.viewGO)
end

function slot0._onHide(slot0)
	if not slot0._show then
		return
	end

	slot0:_clearScroll()
	slot0._mapElement:setWenHaoVisible(true)

	slot0._show = false

	gohelper.setActive(slot0._btnclose.gameObject, false)
	UIBlockMgr.instance:startBlock("dungeonmap_interactive_out")
	slot0:_playAnim(slot0._gonext, "dungeonmap_interactive_btn_out")

	slot5 = "dungeonmap_interactive_btn_out"

	slot0:_playAnim(slot0._gofinishtalk, slot5)

	slot4 = AudioEnum.UI.play_ui_checkpoint_continuedisappear

	AudioMgr.instance:trigger(slot4)

	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot0:_playAnim(slot5[1], "dungeonmap_interactive_btn_out")
	end

	TaskDispatcher.runDelay(slot0._onOutAnimationFinished, slot0, 0.23)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._optionBtnList = slot0:getUserDataTb_()
	slot0._dialogItemList = slot0:getUserDataTb_()
	slot0._dialogItemCacheList = slot0:getUserDataTb_()

	slot0:onInitView()
	slot0:addEvents()
	slot0:_editableAddEvents()
end

function slot0._editableAddEvents(slot0)
end

function slot0._OnClickElement(slot0, slot1)
	slot0._mapElement = slot1

	if slot0._show then
		slot0:_onHide()

		return
	end

	slot0:_onShow()

	slot0._config = slot0._mapElement._config
	slot0._elementGo = slot0._mapElement._go
	slot0._elementInfo = slot0._mapElement._info
	slot0._elementX, slot0._elementY, slot0._elementZ = transformhelper.getPos(slot0._elementGo.transform)

	if not string.nilorempty(slot0._config.offsetPos or "2#3") then
		slot0._elementAddX = slot0._elementX + (string.splitToNumber(slot2, "#")[1] or 0)
		slot0._elementAddY = slot0._elementY + (slot3[2] or 0)
	end

	slot0.viewGO.transform.position = Vector3(slot0._elementAddX, slot0._elementAddY, slot0._elementZ)
	slot3 = not string.nilorempty(slot0._config.flagText)

	gohelper.setActive(slot0._goimportanttips, slot3)

	if slot3 then
		slot0._txttipsinfo.text = slot0._config.flagText
	end

	gohelper.setActive(slot0._txtinfo.gameObject, false)
	gohelper.setActive(slot0._gochatarea, slot0._elementInfo:getType() == WeekWalkEnum.ElementType.Dialog)

	if slot4 == WeekWalkEnum.ElementType.General then
		slot0:_directlyComplete()
	elseif slot4 == WeekWalkEnum.ElementType.Battle then
		if tonumber(slot0._elementInfo:getPrevParam()) then
			gohelper.setActive(slot0._gochatarea, true)
			slot0:_playStory(slot6)
		end

		slot0:_showTypeGo(slot4)
	elseif slot4 == DungeonEnum.ElementType.Task then
		slot0:_showTask()
	elseif slot5 then
		slot0:_showTypeGo(slot4)
		slot0:_playStory()
	elseif slot4 == DungeonEnum.ElementType.Question then
		slot0:_playQuestion()
	else
		logError("element type undefined!")
	end

	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("tc3.png"))
end

function slot0._showTypeGo(slot0, slot1)
	for slot5 = 1, WeekWalkEnum.ElementType.MaxCount do
		gohelper.setActive(slot0["_goop" .. slot5], slot5 == slot1)
	end

	if slot1 == WeekWalkEnum.ElementType.Battle then
		slot2 = slot0._config.isBoss > 0

		gohelper.setActive(slot0._gonormal, not slot2)
		gohelper.setActive(slot0._goboss, slot2)
		slot0:_showRewards(slot2)
	end
end

function slot0._showRewards(slot0, slot1)
	if not ((string.splitToNumber(slot0._config.bonusGroup, "#")[2] or 0) > 0) then
		gohelper.setActive(not slot1 and slot0._gonorewards or slot0._gobossnorewards, true)

		return
	end

	gohelper.setActive(not slot1 and slot0._gohasrewards or slot0._gobosshasrewards, true)

	if not GameUtil.splitString2(WeekWalkConfig.instance:getBonus(slot3, WeekWalkModel.instance:getLevel()), true, "|", "#") then
		return
	end

	for slot11, slot12 in ipairs(slot7) do
		slot13 = IconMgr.instance:getCommonItemIcon(slot0._gorewards)

		slot13:setMOValue(slot12[1], slot12[2], slot12[3])
		slot13:setScale(0.39)
		slot13:customOnClickCallback(slot0._openRewardView, slot7)
	end
end

function slot0._playQuestion(slot0)
	slot0._txtinfo.text = slot0._config.desc
end

function slot0._showTask(slot0)
	slot0._txtinfo.text = slot0._config.desc
	slot2 = string.splitToNumber(slot0._config.param, "#")
	slot0._finishTask = slot2[3] <= ItemModel.instance:getItemQuantity(slot2[1], slot2[2])

	gohelper.setActive(slot0._gofinishtask, slot0._finishTask)
	gohelper.setActive(slot0._gounfinishtask, not slot0._finishTask)

	if slot0._finishTask then
		slot0._txtfinishtask.text = string.format("%s%s<color=#00ff00>%s</color>/%s", luaLang("dungeon_map_submit"), ItemModel.instance:getItemConfig(slot2[1], slot2[2]).name, slot5, slot3)
	else
		slot0._txtunfinishtask.text = string.format("%s%s<color=#ff0000>%s</color>/%s", luaLang("dungeon_map_submit"), slot4.name, slot5, slot3)
	end
end

function slot0._directlyComplete(slot0)
	slot0._txtinfo.text = slot0._config.desc
end

function slot0._playNextSectionOrDialog(slot0)
	slot0:_clearDialog()

	if slot0._dialogIndex <= #slot0._sectionList then
		slot0:_playNextDialog()

		return
	end

	if table.remove(slot0._sectionStack) then
		slot0:_playSection(slot1[1], slot1[2])
	else
		slot0:_refreshDialogBtnState()
	end
end

function slot0._playStory(slot0, slot1)
	slot0:_clearDialog()

	slot0._sectionStack = {}
	slot0._optionId = 0
	slot0._mainSectionId = "0"
	slot0._sectionId = slot0._mainSectionId
	slot0._dialogIndex = nil
	slot0._historyList = {}
	slot0._dialogId = slot1 or tonumber(slot0._elementInfo:getParam())

	slot0:_initHistoryItem()

	slot0._historyList.id = slot0._dialogId

	slot0:_playSection(slot0._sectionId, slot0._dialogIndex)
end

function slot0._initHistoryItem(slot0)
	if #slot0._elementInfo.historylist == 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = string.split(slot6, "#")
		slot0._historyList[slot7[1]] = tonumber(slot7[2])
	end

	if not slot0._historyList.id or slot2 ~= slot0._dialogId then
		slot0._historyList = {}

		return
	end

	slot0._option_param = slot0._historyList.option
	slot3 = slot0._mainSectionId

	slot0:_addSectionHistory(slot3, slot0._historyList[slot3])

	if not slot0._dialogIndex then
		slot0._dialogIndex = slot4
		slot0._sectionId = slot3
	end
end

function slot0._addSectionHistory(slot0, slot1, slot2)
	slot3 = WeekWalkConfig.instance:getDialog(slot0._dialogId, slot1)
	slot4 = nil
	slot4 = slot1 == slot0._mainSectionId and slot2 > #slot3 or slot2 >= #slot3

	for slot8, slot9 in ipairs(slot3) do
		if slot8 < slot2 or slot4 then
			if slot9.type == "dialog" then
				table.insert(slot0._dialogItemList, slot0:_addDialogItem("dialog", slot9.content, slot9.speaker))
			end

			if slot9.type == "options" then
				slot10 = string.split(slot9.content, "#")
				slot12 = {}
				slot13 = {}

				for slot17, slot18 in ipairs(string.split(slot9.param, "#")) do
					if WeekWalkConfig.instance:getDialog(slot0._dialogId, slot18) and slot19.type == "random" then
						for slot23, slot24 in ipairs(slot19) do
							slot25 = string.split(slot24.option_param, "#")

							table.insert(slot12, slot10[slot17])
							table.insert(slot13, slot25[2])
							table.insert(slot12, slot10[slot17])
							table.insert(slot13, slot25[3])
						end
					elseif slot19 then
						table.insert(slot12, slot10[slot17])
						table.insert(slot13, slot18)
					else
						table.insert(slot0._dialogItemList, slot0:_addDialogItem("option", string.format("<indent=4.7em><color=#c95318>\"%s\"</color>", slot10[slot17])))
					end
				end

				for slot17, slot18 in ipairs(slot13) do
					if slot0._historyList[slot18] then
						table.insert(slot0._dialogItemList, slot0:_addDialogItem("option", string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", slot12[slot17])))
						slot0:_addSectionHistory(slot18, slot19)
					end
				end
			end
		else
			break
		end
	end

	if not slot4 then
		if not slot0._dialogIndex then
			slot0._dialogIndex = slot2
			slot0._sectionId = slot1

			return
		end

		table.insert(slot0._sectionStack, 1, {
			slot1,
			slot2
		})
	end
end

function slot0._playSection(slot0, slot1, slot2)
	slot0:_setSectionData(slot1, slot2)
	slot0:_playNextDialog()
end

function slot0._setSectionData(slot0, slot1, slot2)
	slot0._sectionList = WeekWalkConfig.instance:getDialog(slot0._dialogId, slot1)

	if slot0._sectionList and not string.nilorempty(slot0._sectionList.option_param) then
		slot0._option_param = slot0._sectionList.option_param
	end

	if not string.nilorempty(slot0._option_param) then
		slot0._historyList.option = slot0._option_param
	end

	slot0._dialogIndex = slot2 or 1
	slot0._sectionId = slot1
end

function slot0._playNextDialog(slot0)
	if slot0._sectionList[slot0._dialogIndex] and slot1.type == "dialog" then
		slot0:_showDialog("dialog", slot1.content, slot1.speaker)
	elseif slot1 and slot1.type == "options" then
		slot0:_showOptionByConfig(slot1)

		return
	end

	slot0._dialogIndex = slot0._dialogIndex + 1

	if #slot0._sectionStack > 0 and #slot0._sectionList < slot0._dialogIndex then
		slot2 = table.remove(slot0._sectionStack)

		slot0:_setSectionData(slot2[1], slot2[2])
	end

	slot0:_showOptionByConfig(slot0._sectionList[slot0._dialogIndex])

	if slot0._dissolveInfo then
		gohelper.setActive(slot0._curBtnGo, false)
	end
end

function slot0._showOptionByConfig(slot0, slot1)
	slot2 = false

	if slot1 and slot1.type == "options" then
		slot0._dialogIndex = slot0._dialogIndex + 1
		slot3 = string.split(slot1.content, "#")
		slot4 = string.split(slot1.param, "#")

		for slot8, slot9 in pairs(slot0._optionBtnList) do
			gohelper.setActive(slot9[1], false)
		end

		for slot8, slot9 in ipairs(slot3) do
			slot0:_addDialogOption(slot8, slot4[slot8], slot9)
		end

		slot2 = true
	end

	slot0:_refreshDialogBtnState(slot2)
end

function slot0._refreshDialogBtnState(slot0, slot1)
	gohelper.setActive(slot0._gooptions, slot1)

	if slot1 then
		slot0._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(slot0._gofinishtalk.gameObject, false)

		slot0._curBtnGo = slot0._gooptions

		return
	end

	if #slot0._sectionStack > 0 or slot0._dialogIndex <= #slot0._sectionList then
		slot0._curBtnGo = slot0._gonext

		gohelper.setActive(slot0._gonext.gameObject, slot2)
		slot0._nextAnimator:Play("dungeonmap_interactive_btn_in1")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		slot0._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		slot0._curBtnGo = slot0._gofinishtalk
	end

	slot3 = not slot2

	gohelper.setActive(slot0._gofinishtalk.gameObject, slot3)

	if slot3 then
		if not slot0._elementInfo:getNextType() then
			return
		end

		slot0:_sendFinishDialog()
		slot0:_showTypeGo(slot4)
	end
end

function slot0._addDialogOption(slot0, slot1, slot2, slot3)
	slot4 = slot0._optionBtnList[slot1] and slot0._optionBtnList[slot1][1] or gohelper.cloneInPlace(slot0._gotalkitem)
	slot0._maxOptionIndex = slot1

	gohelper.setActive(slot4, false)

	gohelper.findChildText(slot4, "txt_talkitem").text = slot3

	gohelper.findChildButtonWithAudio(slot4, "btn_talkitem"):AddClickListener(slot0._onOptionClick, slot0, {
		slot2,
		slot3,
		slot1
	})

	if not slot0._optionBtnList[slot1] then
		slot0._optionBtnList[slot1] = {
			slot4,
			slot6
		}
	end
end

function slot0._onOptionClick(slot0, slot1)
	if slot0._playScrollAnim then
		return
	end

	slot0:_clearDialog()
	slot0:_showDialog("option", string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", slot1[2]))

	slot0._showOption = true
	slot0._optionId = slot1[3]

	slot0:_checkOption(slot1[1])
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._checkOption(slot0, slot1)
	if not WeekWalkConfig.instance:getDialog(slot0._dialogId, slot1) then
		slot0:_playNextSectionOrDialog()

		return
	end

	if slot0._dialogIndex <= #slot0._sectionList then
		table.insert(slot0._sectionStack, {
			slot0._sectionId,
			slot0._dialogIndex
		})
	end

	if slot2.type == "random" then
		for slot6, slot7 in ipairs(slot2) do
			slot8 = string.split(slot7.option_param, "#")
			slot13 = nil

			slot0:_playSection(math.random(100) <= tonumber(slot8[1]) and slot8[2] or slot8[3])

			break
		end
	else
		slot0:_playSection(slot1)
	end
end

function slot0._showDialog(slot0, slot1, slot2, slot3)
	if slot0._elementInfo:getType() == WeekWalkEnum.ElementType.Dialog then
		slot0._historyList[slot0._sectionId] = slot0._dialogIndex
		slot4 = {}

		for slot8, slot9 in pairs(slot0._historyList) do
			table.insert(slot4, string.format("%s#%s", slot8, slot9))
		end

		WeekwalkRpc.instance:sendWeekwalkDialogHistoryRequest(slot0._config.id, slot4)
		slot0._elementInfo:updateHistoryList(slot4)
	end

	slot4 = slot0:_addDialogItem(slot1, slot2, slot3)

	if slot0._showOption and slot0._addDialog then
		-- Nothing
	end

	slot0._showOption = false

	table.insert(slot0._dialogItemList, slot4)

	slot0._addDialog = true
end

function slot0._addDialogItem(slot0, slot1, slot2, slot3)
	slot4 = table.remove(slot0._dialogItemCacheList) or gohelper.cloneInPlace(slot0._gochatitem)

	transformhelper.setLocalPos(slot4.transform, 0, 0, 200)
	gohelper.setActive(slot4, true)
	gohelper.setAsLastSibling(slot4)

	gohelper.findChildText(slot4, "name").text = not string.nilorempty(slot3) and slot3 .. ":" or ""

	gohelper.setActive(gohelper.findChild(slot4, "usericon"), not slot3)

	slot7 = gohelper.findChildText(slot4, "info")
	slot7.text = string.nilorempty(slot3) and slot2 or "<indent=4.7em>" .. slot2

	SLFramework.UGUI.GuiHelper.SetColor(slot7, string.nilorempty(slot3) and "#9E967B" or "#D0CFCF")

	return slot4
end

function slot0._clearDialog(slot0)
	slot0._playScrollAnim = true

	gohelper.setActive(slot0._gomask, false)
	TaskDispatcher.runDelay(slot0._delayScroll, slot0, 0)
end

function slot0._delayScroll(slot0)
	gohelper.setActive(slot0._gomask, true)

	slot0._imgMask.enabled = true
	slot1 = slot0._curScrollGo or slot0._goscroll

	for slot5, slot6 in ipairs(slot0._dialogItemList) do
		gohelper.addChild(slot1, slot6)

		slot6.transform.position = slot6.transform.position
		slot8, slot9, slot10 = transformhelper.getLocalPos(slot6.transform)

		transformhelper.setLocalPos(slot6.transform, slot8, slot9, 0)
	end

	slot0._dialogItemList = slot0:getUserDataTb_()

	gohelper.setActive(slot1, true)

	slot0._curScrollGo = slot1

	if slot1 then
		if slot0._dissolveInfo then
			slot3 = slot0._dissolveInfo[3]
			slot0._dissolveInfo[2].text = ""
		end

		slot0:_scrollEnd(slot1)
	end
end

function slot0._scrollEnd(slot0, slot1)
	if slot1 ~= slot0._curScrollGo then
		gohelper.destroy(slot1)
	else
		if slot0._dissolveInfo then
			TaskDispatcher.runDelay(slot0._onDissolveStart, slot0, 0.3)

			return
		end

		slot0:_onDissolveFinish()
	end
end

function slot0._onDissolveStart(slot0)
	slot0._dissolveInfo[2].text = slot0._dissolveInfo[3]
	slot0._imgMask.enabled = false

	slot0._dissolveInfo[1]:GetComponent(typeof(UnityEngine.Animation)):Play("dungeonmap_chatarea")
	TaskDispatcher.runDelay(slot0._onDissolveFinish, slot0, 1.3)
end

function slot0._onDissolveFinish(slot0)
	gohelper.setActive(slot0._curBtnGo, true)

	slot0._dissolveInfo = nil
	slot0._playScrollAnim = false

	if slot0._curBtnGo == slot0._gooptions then
		for slot4 = 1, slot0._maxOptionIndex do
			if (slot4 - 1) * 0.03 > 0 then
				gohelper.setActive(slot0._optionBtnList[slot4][1], false)
				TaskDispatcher.runDelay(function ()
					if not gohelper.isNil(uv0) then
						gohelper.setActive(uv0, true)
					end
				end, nil, slot5)
			else
				gohelper.setActive(slot6, true)
			end
		end
	end
end

function slot0._clearScroll(slot0)
	slot0._showOption = false
	slot0._dissolveInfo = nil
	slot0._playScrollAnim = false

	TaskDispatcher.cancelTask(slot0._delayScroll, slot0)

	if slot0._oldScrollGo then
		gohelper.destroy(slot0._oldScrollGo)

		slot0._oldScrollGo = nil
	end

	if slot0._curScrollGo then
		gohelper.destroy(slot0._curScrollGo)

		slot0._curScrollGo = nil
	end

	slot0._dialogItemList = slot0:getUserDataTb_()
end

function slot0._editableRemoveEvents(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2]:RemoveClickListener()
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._showCloseBtn, slot0)
	TaskDispatcher.cancelTask(slot0._delayScroll, slot0)
	TaskDispatcher.cancelTask(slot0._onDissolveStart, slot0)
	TaskDispatcher.cancelTask(slot0._onDissolveFinish, slot0)
	slot0:removeEvents()
	slot0:_editableRemoveEvents()
	slot0._simagebg:UnLoadImage()
end

return slot0
