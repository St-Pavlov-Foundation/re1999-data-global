module("modules.logic.sp01.odyssey.view.OdysseyDungeonInteractView", package.seeall)

local var_0_0 = class("OdysseyDungeonInteractView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnfullscreen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fullscreen")
	arg_1_0._gooptionItem = gohelper.findChild(arg_1_0.viewGO, "#go_optionItem")
	arg_1_0._godialogOptionItem = gohelper.findChild(arg_1_0.viewGO, "#go_dialogOptionItem")
	arg_1_0._godialogPanel = gohelper.findChild(arg_1_0.viewGO, "#go_dialogPanel")
	arg_1_0._goheroIcon = gohelper.findChild(arg_1_0.viewGO, "#go_dialogPanel/dialog/role/#go_heroIcon")
	arg_1_0._imagedialogHero = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_dialogPanel/dialog/role/#go_heroIcon/#image_dialogHero")
	arg_1_0._goname = gohelper.findChild(arg_1_0.viewGO, "#go_dialogPanel/dialog/role/#go_name")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_dialogPanel/dialog/role/#go_name/#txt_name")
	arg_1_0._godialogOptionList = gohelper.findChild(arg_1_0.viewGO, "#go_dialogPanel/#go_dialogOptionList")
	arg_1_0._gooptionPanel = gohelper.findChild(arg_1_0.viewGO, "#go_optionPanel")
	arg_1_0._txtoptionTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_optionPanel/panel/title/#txt_optionTitle")
	arg_1_0._txtoptionTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#go_optionPanel/panel/title/#txt_optionTitleEn")
	arg_1_0._txtoptionDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_optionPanel/panel/#scroll_desc/Viewport/Content/#txt_optionDesc")
	arg_1_0._gooption = gohelper.findChild(arg_1_0.viewGO, "#go_optionPanel/panel/#go_option")
	arg_1_0._imagepicture = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_optionPanel/panel/#image_picture")
	arg_1_0._gofightPanel = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel")
	arg_1_0._goheroLevel = gohelper.findChild(arg_1_0.viewGO, "#go_heroLevel")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfullscreen:AddClickListener(arg_2_0._btnfullscreenOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfullscreen:RemoveClickListener()
end

function var_0_0._btnfullscreenOnClick(arg_4_0)
	if arg_4_0.roleTmpFadeInComp and arg_4_0.roleTmpFadeInComp:isPlaying() then
		arg_4_0.roleTmpFadeInComp:conFinished()

		return
	end

	if arg_4_0.narrationTmpFadeInComp and arg_4_0.narrationTmpFadeInComp:isPlaying() then
		arg_4_0.narrationTmpFadeInComp:conFinished()

		return
	end

	if arg_4_0.elementType == OdysseyEnum.ElementType.Dialog then
		if not arg_4_0.hasOption then
			arg_4_0.curDialogStep = arg_4_0.dialogConfig.nextStep

			if arg_4_0.curDialogStep > 0 then
				arg_4_0:doDialogStep()
			else
				arg_4_0:onOptionStepFinish()
				arg_4_0:closeThis()
			end
		end
	else
		arg_4_0:closeThis()
	end
end

function var_0_0.optionItemClick(arg_5_0, arg_5_1)
	if not arg_5_1.isUnlock then
		local var_5_0, var_5_1 = OdysseyDungeonModel.instance:checkConditionCanUnlock(arg_5_1.optionConfig.unlockCondition)

		if var_5_1.type == OdysseyEnum.ConditionType.Item then
			local var_5_2 = OdysseyConfig.instance:getItemConfig(var_5_1.itemId)

			GameFacade.showToast(ToastEnum.OdysseyLackItem, var_5_2.name)
		elseif var_5_1.type == OdysseyEnum.ConditionType.Level then
			GameFacade.showToast(ToastEnum.OdysseyLackLevel)
		end

		return
	end

	arg_5_0.curClickOptionItem = arg_5_1
	arg_5_0.isNotFinish = arg_5_1.optionConfig.notFinish == OdysseyEnum.ElementOptionNotFinish

	local var_5_3 = arg_5_1.optionConfig.story

	if arg_5_0.elementType == OdysseyEnum.ElementType.Dialog then
		arg_5_0.curDialogStep = arg_5_1.optionData[2]

		arg_5_0:doDialogStep()
	elseif var_5_3 > 0 then
		StoryController.instance:playStory(var_5_3)

		local var_5_4 = {
			elementId = arg_5_0.elementConfig.id,
			optionId = arg_5_1.optionConfig.id
		}

		OdysseyDungeonModel.instance:setStoryOptionParam(var_5_4)
		arg_5_0:closeThis()
	else
		arg_5_0:onOptionStepFinish()
		arg_5_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.panelGOMap = arg_6_0:getUserDataTb_()

	for iter_6_0, iter_6_1 in ipairs(OdysseyEnum.ElementTypeRoot) do
		arg_6_0.panelGOMap[iter_6_0] = arg_6_0["_go" .. iter_6_1 .. "Panel"]
	end

	arg_6_0.optionItemList = arg_6_0:getUserDataTb_()

	gohelper.setActive(arg_6_0._gooptionItem, false)
	gohelper.setActive(arg_6_0._godialogOptionItem, false)
	gohelper.setActive(arg_6_0._goheroLevel, false)

	arg_6_0.godialogNarration = gohelper.findChild(arg_6_0.viewGO, "#go_dialogPanel/dialog/narration")
	arg_6_0.godialogRole = gohelper.findChild(arg_6_0.viewGO, "#go_dialogPanel/dialog/role")

	gohelper.setActive(arg_6_0.godialogNarration, false)
	gohelper.setActive(arg_6_0.godialogRole, false)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.elementConfig = arg_8_0.viewParam.config
	arg_8_0.elementType = arg_8_0.elementConfig.type
	arg_8_0.levelGO = arg_8_0.viewContainer:getResInst(arg_8_0.viewContainer:getSetting().otherRes[2], arg_8_0._goheroLevel)
	arg_8_0.levelComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0.levelGO, OdysseyDungeonLevelComp)

	arg_8_0:refreshUI()
	arg_8_0:setDungeonUIShowState(false)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, arg_8_0.elementConfig.id, OdysseyEnum.ElementAnimName.Select)
end

function var_0_0.setDungeonUIShowState(arg_9_0, arg_9_1)
	if arg_9_0.elementType == OdysseyEnum.ElementType.Dialog then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.SetDungeonUIShowState, OdysseyEnum.DungeonUISideType.Bottom, arg_9_1)
	else
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.SetDungeonUIShowState, OdysseyEnum.DungeonUISideType.Right, arg_9_1)
	end
end

function var_0_0.refreshUI(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(OdysseyEnum.ElementTypeRoot) do
		gohelper.setActive(arg_10_0.panelGOMap[iter_10_0], iter_10_0 == arg_10_0.elementType)
	end

	if arg_10_0.elementType == OdysseyEnum.ElementType.Dialog then
		arg_10_0.curDialogStep = 1
		arg_10_0.dialogOptionMap = arg_10_0:getUserDataTb_()

		TaskDispatcher.runDelay(arg_10_0.doDialogStep, arg_10_0, 0.4)
	elseif arg_10_0.elementType == OdysseyEnum.ElementType.Option then
		arg_10_0:refreshOptionPanel()
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_unfold)
	elseif arg_10_0.elementType == OdysseyEnum.ElementType.Fight then
		arg_10_0.fightPanelView = arg_10_0.viewContainer:getInteractFightView()

		arg_10_0.fightPanelView:refreshFightPanel()
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_unfold)
	end

	gohelper.setActive(arg_10_0._btnfullscreen.gameObject, arg_10_0.elementType == OdysseyEnum.ElementType.Dialog)
	arg_10_0:refreshLevel()
end

function var_0_0.doDialogStep(arg_11_0)
	arg_11_0.dialogConfig = OdysseyConfig.instance:getDialogConfig(arg_11_0.elementConfig.id, arg_11_0.curDialogStep)

	if not arg_11_0.dialogConfig then
		arg_11_0:onOptionStepFinish()
		arg_11_0:closeThis()

		return
	end

	local var_11_0 = not string.nilorempty(arg_11_0.dialogConfig.picture)

	gohelper.setActive(arg_11_0._goheroIcon, var_11_0)

	if var_11_0 then
		arg_11_0._imagedialogHero:LoadImage(ResUrl.getSp01OdysseySingleBg("map/" .. arg_11_0.dialogConfig.picture))
	end

	local var_11_1 = not string.nilorempty(arg_11_0.dialogConfig.name)

	gohelper.setActive(arg_11_0._goname, var_11_1)
	gohelper.setActive(arg_11_0.godialogRole, var_11_1)
	gohelper.setActive(arg_11_0.godialogNarration, not var_11_1)

	arg_11_0._txtname.text = arg_11_0.dialogConfig.name

	local var_11_2 = string.replaceSpace(arg_11_0.dialogConfig.desc)

	if not arg_11_0.roleTmpFadeInComp then
		arg_11_0.roleTmpFadeInComp = MonoHelper.addLuaComOnceToGo(arg_11_0.godialogRole, TMPFadeIn)
	end

	if not arg_11_0.narrationTmpFadeInComp then
		arg_11_0.narrationTmpFadeInComp = MonoHelper.addLuaComOnceToGo(arg_11_0.godialogNarration, TMPFadeIn)
	end

	arg_11_0.hasOption = not string.nilorempty(arg_11_0.dialogConfig.optionList)

	if arg_11_0.hasOption then
		if var_11_1 then
			arg_11_0.roleTmpFadeInComp:playNormalText(var_11_2, arg_11_0.showDialogOptionList, arg_11_0)
		else
			arg_11_0.narrationTmpFadeInComp:playNormalText(var_11_2, arg_11_0.showDialogOptionList, arg_11_0)
		end

		gohelper.setActive(arg_11_0._godialogOptionList, false)

		local var_11_3 = GameUtil.splitString2(arg_11_0.dialogConfig.optionList, true)

		arg_11_0:createAndRefreshOptionItem(var_11_3, arg_11_0._godialogOptionList, arg_11_0._godialogOptionItem)
	else
		if var_11_1 then
			arg_11_0.roleTmpFadeInComp:playNormalText(var_11_2)
		else
			arg_11_0.narrationTmpFadeInComp:playNormalText(var_11_2)
		end

		gohelper.setActive(arg_11_0._godialogOptionList, false)
	end
end

function var_0_0.showDialogOptionList(arg_12_0)
	gohelper.setActive(arg_12_0._godialogOptionList, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_choice)
end

function var_0_0.createAndRefreshOptionItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0.elementType == OdysseyEnum.ElementType.Dialog

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_1 = arg_13_0.optionItemList[iter_13_0]

		if not var_13_1 then
			var_13_1 = arg_13_0:getUserDataTb_()
			var_13_1.go = gohelper.clone(arg_13_3, arg_13_2, "optionItem_" .. iter_13_0)
			var_13_1.normalbg = gohelper.findChild(var_13_1.go, "go_normalbg")
			var_13_1.lockbg = gohelper.findChild(var_13_1.go, "go_lockbg")
			var_13_1.txtdesc = gohelper.findChildText(var_13_1.go, "content/txt_desc")
			var_13_1.txtsubDesc = gohelper.findChildText(var_13_1.go, "content/txt_subdesc")
			var_13_1.btnClick = gohelper.findChildButtonWithAudio(var_13_1.go, "btn_click")

			var_13_1.btnClick:AddClickListener(arg_13_0.optionItemClick, arg_13_0, var_13_1)

			arg_13_0.optionItemList[iter_13_0] = var_13_1
		end

		gohelper.setActive(var_13_1.go, true)

		local var_13_2, var_13_3 = arg_13_0:getOptionUnlockAndSubDesc(iter_13_1)

		gohelper.setActive(var_13_1.lockbg, not var_13_2)
		gohelper.setActive(var_13_1.normalbg, var_13_2)

		var_13_1.isUnlock = var_13_2
		var_13_1.optionData = iter_13_1
		var_13_1.optionConfig = OdysseyConfig.instance:getOptionConfig(iter_13_1[1])
		var_13_1.txtdesc.text = var_13_1.optionConfig.desc

		local var_13_4 = not string.nilorempty(var_13_3)

		gohelper.setActive(var_13_1.txtsubDesc.gameObject, var_13_4)

		var_13_1.txtsubDesc.text = var_13_3 or ""

		if var_13_0 then
			SLFramework.UGUI.GuiHelper.SetColor(var_13_1.txtdesc, var_13_2 and "#C5D9E6" or "#7F8D97")
		else
			SLFramework.UGUI.GuiHelper.SetColor(var_13_1.txtdesc, var_13_2 and "#1D313E" or "#7B868D")
		end

		SLFramework.UGUI.GuiHelper.SetColor(var_13_1.txtsubDesc, var_13_2 and "#21723B" or "#A54A4A")
	end

	for iter_13_2 = #arg_13_1 + 1, #arg_13_0.optionItemList do
		gohelper.setActive(arg_13_0.optionItemList[iter_13_2].go, false)
	end
end

function var_0_0.getOptionUnlockAndSubDesc(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1[1]

	if not var_14_0 then
		return true
	end

	local var_14_1 = ""
	local var_14_2 = OdysseyConfig.instance:getOptionConfig(var_14_0)
	local var_14_3, var_14_4 = OdysseyDungeonModel.instance:checkConditionCanUnlock(var_14_2.unlockCondition)

	if not var_14_4 then
		return var_14_3, var_14_1
	end

	if var_14_4.type == OdysseyEnum.ConditionType.Item then
		local var_14_5 = OdysseyConfig.instance:getItemConfig(var_14_4.itemId)

		var_14_1 = arg_14_0:replaceSubDescData(var_14_2.subDesc, {
			var_14_5.name,
			var_14_4.curItemCount,
			var_14_4.unlockItemCount
		})
	elseif var_14_4.type == OdysseyEnum.ConditionType.Level then
		var_14_1 = arg_14_0:replaceSubDescData(var_14_2.subDesc, {
			var_14_4.unlockLevel
		})
	end

	return var_14_3, var_14_1
end

function var_0_0.replaceSubDescData(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1

	for iter_15_0 = 1, #arg_15_2 do
		var_15_0 = string.gsub(var_15_0, "▩" .. iter_15_0 .. "%%s", arg_15_2[iter_15_0])
	end

	return var_15_0
end

function var_0_0.onOptionStepFinish(arg_16_0)
	local var_16_0 = {
		optionId = arg_16_0.curClickOptionItem and arg_16_0.curClickOptionItem.optionConfig.id or nil
	}

	if not arg_16_0.isNotFinish then
		OdysseyRpc.instance:sendOdysseyMapInteractRequest(arg_16_0.elementConfig.id, var_16_0)
	end
end

function var_0_0.refreshOptionPanel(arg_17_0)
	local var_17_0 = OdysseyConfig.instance:getElemenetOptionConfig(arg_17_0.elementConfig.id)

	arg_17_0._txtoptionTitle.text = var_17_0.title
	arg_17_0._txtoptionDesc.text = var_17_0.desc

	local var_17_1 = {}
	local var_17_2 = string.splitToNumber(var_17_0.optionList, "#")

	for iter_17_0, iter_17_1 in ipairs(var_17_2) do
		table.insert(var_17_1, {
			iter_17_1
		})
	end

	arg_17_0._imagepicture:LoadImage(ResUrl.getSp01OdysseySingleBg(var_17_0.image))
	arg_17_0:createAndRefreshOptionItem(var_17_1, arg_17_0._gooption, arg_17_0._gooptionItem)
end

function var_0_0.refreshLevel(arg_18_0)
	if arg_18_0.elementType == OdysseyEnum.ElementType.Dialog then
		gohelper.setActive(arg_18_0._goheroLevel, false)

		return
	end

	gohelper.setActive(arg_18_0._goheroLevel, true)
	arg_18_0.levelComp:refreshUI()
	arg_18_0.levelComp:checkLevelDiffAndRefresh()
end

function var_0_0.onClose(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.optionItemList) do
		iter_19_1.btnClick:RemoveClickListener()
	end

	OdysseyDungeonModel.instance:setJumpNeedOpenElement(0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, arg_19_0.elementConfig.id, OdysseyEnum.ElementAnimName.Idle)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowInteractCloseBtn, false)
	AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, true)

	if arg_19_0.elementType == OdysseyEnum.ElementType.Option or arg_19_0.elementType == OdysseyEnum.ElementType.Fight then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_fold)
	end

	TaskDispatcher.cancelTask(arg_19_0.doDialogStep, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0._imagepicture:UnLoadImage()
	arg_20_0._imagedialogHero:UnLoadImage()
	arg_20_0:setDungeonUIShowState(true)
end

return var_0_0
