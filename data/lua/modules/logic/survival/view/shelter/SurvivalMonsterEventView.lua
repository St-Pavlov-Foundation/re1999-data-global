module("modules.logic.survival.view.shelter.SurvivalMonsterEventView", package.seeall)

local var_0_0 = class("SurvivalMonsterEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageMap = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Left/#simage_Map")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Panel/Title/#txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "Panel/Title/#txt_TitleEn")
	arg_1_0._goscore = gohelper.findChild(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/#go_score")
	arg_1_0._txtrecommendscore = gohelper.findChildText(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/#go_score/recommend/#txt_recommend_score")
	arg_1_0._txtcurscore = gohelper.findChildText(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/#go_score/current/#txt_cur_score")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/#go_tips")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/#go_tips/#txt_tips")
	arg_1_0._txttitledec = gohelper.findChildText(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/#txt_titledec")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem")
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem/#go_unfinish")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem/scroll_buffDec/Viewport/Content/#txt_dec")
	arg_1_0._txtdecfinished = gohelper.findChildText(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem/scroll_buffDec/Viewport/Content/#txt_dec_finished")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.viewGO, "Panel/Buff/Viewport/Content/layout/#go_buffitem/#go_finished")
	arg_1_0._goNpcitem = gohelper.findChild(arg_1_0.viewGO, "Panel/Npc/layout/#go_Npcitem")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "Panel/Npc/layout/#go_Npcitem/#go_empty")
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "Panel/Npc/layout/#go_Npcitem/#go_has")
	arg_1_0._simagehero = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Npc/layout/#go_Npcitem/#go_has/#simage_hero")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Npc/layout/#go_Npcitem/#btn_click")
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Btns/#btn_Reset")
	arg_1_0._btnFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Btns/#btn_Fight")
	arg_1_0._btnWatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Btns/#btn_Watch")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._btnResetOnClick, arg_2_0)
	arg_2_0._btnFight:AddClickListener(arg_2_0._btnFightOnClick, arg_2_0)
	arg_2_0._btnWatch:AddClickListener(arg_2_0._btnWatchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnReset:RemoveClickListener()
	arg_3_0._btnFight:RemoveClickListener()
	arg_3_0._btnWatch:RemoveClickListener()
end

function var_0_0._btnWatchOnClick(arg_4_0)
	arg_4_0:closeThis()

	if arg_4_0._fight and arg_4_0._fight:canShowEntity() then
		SurvivalMapHelper.instance:gotoMonster(arg_4_0._fight.fightId, nil, true)
	end
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnclickOnClick(arg_7_0)
	return
end

function var_0_0._btnResetOnClick(arg_8_0)
	if arg_8_0._fight then
		UIBlockHelper.instance:startBlock("SurvivalMonsterEventView_Reset", 1)
		SurvivalWeekRpc.instance:sendSurvivalIntrudeReExterminateRequest()
	end
end

function var_0_0._btnFightOnClick(arg_9_0)
	if arg_9_0._fight == nil then
		return
	end

	if not arg_9_0._fight:canFight() then
		local var_9_0 = SurvivalShelterModel.instance:getWeekInfo()
		local var_9_1 = arg_9_0._fight.endTime - var_9_0.day

		GameFacade.showToast(ToastEnum.SurvivalBossDotOpen, var_9_1)

		return
	end

	if #SurvivalShelterNpcMonsterListModel.instance:getSelectList() == 0 then
		arg_9_0:_noSelectNpcEnterFight()
	else
		arg_9_0:enterFight()
	end
end

function var_0_0._noSelectNpcEnterFight(arg_10_0)
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.SurvivalMonsterSureNoSelectNpc, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, arg_10_0.enterFight, nil, nil, arg_10_0)
end

function var_0_0.enterFight(arg_11_0)
	if arg_11_0._fight.status == SurvivalEnum.ShelterMonsterFightState.NoStart then
		local var_11_0 = SurvivalShelterNpcMonsterListModel.instance:getSelectList()

		SurvivalWeekRpc.instance:sendSurvivalIntrudeExterminateRequest(var_11_0, arg_11_0._enterFight, arg_11_0)
	else
		arg_11_0:_enterFight()
	end
end

local var_0_1 = ZProj.UIEffectsCollection

function var_0_0._enterFight(arg_12_0)
	if arg_12_0._fight:getBattleId() then
		UIBlockHelper.instance:startBlock("SurvivalMonsterEventView_EnterFight")
		SurvivalController.instance:tryEnterShelterFight(arg_12_0._enterFightFinish, arg_12_0)
	end
end

function var_0_0._enterFightFinish(arg_13_0)
	UIBlockHelper.instance:endBlock("SurvivalMonsterEventView_EnterFight")
end

function var_0_0._editableInitView(arg_14_0)
	gohelper.setActive(arg_14_0._goNpcitem, false)
	gohelper.setActive(arg_14_0._gobuffitem, false)
	arg_14_0:addEventCb(SurvivalController.instance, SurvivalEvent.UpdateView, arg_14_0.updateView, arg_14_0)

	arg_14_0._goNpc = gohelper.findChild(arg_14_0.viewGO, "Panel/Npc")
	arg_14_0._fightUIEffect = var_0_1.Get(arg_14_0._btnFight.gameObject)
	arg_14_0._fightBtnAnchorX, arg_14_0._fightBtnAnchorY = recthelper.getAnchor(arg_14_0._btnFight.transform)
	arg_14_0._resetBtnAnchorX, arg_14_0._resetBtnAnchorY = recthelper.getAnchor(arg_14_0._btnReset.transform)
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0.showType = arg_16_0.viewParam.showType
	arg_16_0._fight = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()
	arg_16_0._fightConfig = arg_16_0._fight.fightCo

	arg_16_0:_initConfigInfo()
	arg_16_0:updateView()
end

function var_0_0.refreshShowType(arg_17_0)
	gohelper.setActive(arg_17_0._gotips, arg_17_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Watch)
	gohelper.setActive(arg_17_0._btnWatch.gameObject, arg_17_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Watch)
	gohelper.setActive(arg_17_0._goscore, arg_17_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Normal)
	gohelper.setActive(arg_17_0._btnReset.gameObject, arg_17_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Normal)
	gohelper.setActive(arg_17_0._btnFight.gameObject, arg_17_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Normal)
	gohelper.setActive(arg_17_0._goNpc, arg_17_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Normal)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitBossEventView, arg_17_0.showType)
end

function var_0_0.updateView(arg_18_0)
	local var_18_0 = SurvivalShelterModel.instance:getWeekInfo()

	arg_18_0._fight = var_18_0:getMonsterFight()

	arg_18_0:_refreshState()

	local var_18_1 = arg_18_0._fightConfig.score
	local var_18_2 = var_18_0.equipBox:getAllScore()
	local var_18_3 = "#843034"

	if var_18_1 < var_18_2 then
		var_18_3 = "#19623f"
	end

	arg_18_0._txtrecommendscore.text = arg_18_0._fightConfig.score
	arg_18_0._txtcurscore.text = var_18_0.equipBox:getAllScore()
	arg_18_0._txtcurscore.color = GameUtil.parseColor(var_18_3)

	local var_18_4 = arg_18_0._fight.endTime - var_18_0.day

	if var_18_4 == 0 then
		arg_18_0._txttips.text = luaLang("survivalmonstereventview_monster_toady")
	else
		arg_18_0._txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_SurvivalMonsterEventView_tips"), var_18_4)
	end

	TaskDispatcher.runDelay(arg_18_0._updateNpcInfo, arg_18_0, 0.5)
end

function var_0_0._refreshState(arg_19_0)
	arg_19_0:refreshShowType()
	gohelper.setActive(arg_19_0._btnReset, arg_19_0._fight:canShowReset())

	local var_19_0 = arg_19_0._fight:canFight()

	if arg_19_0._fightUIEffect then
		arg_19_0._fightUIEffect:SetGray(not var_19_0)
	end

	local var_19_1 = arg_19_0._fight:canShowFightBtn()

	gohelper.setActive(arg_19_0._btnFight, var_19_1)

	local var_19_2 = arg_19_0._resetBtnAnchorX
	local var_19_3 = arg_19_0._resetBtnAnchorY

	if not var_19_1 then
		var_19_2, var_19_3 = arg_19_0._fightBtnAnchorX, arg_19_0._fightBtnAnchorY
	end

	recthelper.setAnchor(arg_19_0._btnReset.transform, var_19_2, var_19_3)
end

function var_0_0._initConfigInfo(arg_20_0)
	if arg_20_0._fightConfig == nil then
		return
	end

	arg_20_0._txtTitle.text = arg_20_0._fightConfig.name
	arg_20_0._txttitledec.text = arg_20_0._fightConfig.desc

	local var_20_0 = arg_20_0._fightConfig.image

	arg_20_0._simageMap:LoadImage(var_20_0)
end

function var_0_0._updateNpcInfo(arg_21_0)
	if arg_21_0._fight == nil then
		logError("SurvivalMonsterEventView:_updateNpcInfo() self._fight is nil")

		return
	end

	arg_21_0:_refreshSchemes()

	local var_21_0 = SurvivalShelterNpcMonsterListModel.instance:getSelectList()

	if var_21_0 == nil then
		return
	end

	if arg_21_0._repressNpcItems == nil then
		arg_21_0._repressNpcItems = arg_21_0:getUserDataTb_()
	end

	local var_21_1 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.ShelterMonsterSelectNpcMax)
	local var_21_2 = var_21_1 and tonumber(var_21_1) or 0

	for iter_21_0 = 1, var_21_2 do
		local var_21_3 = arg_21_0._repressNpcItems[iter_21_0]
		local var_21_4 = var_21_0[iter_21_0]

		if var_21_3 == nil then
			local var_21_5 = gohelper.cloneInPlace(arg_21_0._goNpcitem)

			var_21_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_5, SurvivalMonsterEventSmallNpcItem)

			gohelper.setActive(var_21_5, true)
			table.insert(arg_21_0._repressNpcItems, var_21_3)
		end

		var_21_3:setIsCanEnterSelect(arg_21_0._fight:canEnterSelectNpc())
		var_21_3:setNeedShowEmpty(arg_21_0._fight:canEnterSelectNpc())
		var_21_3:updateItem(var_21_4)
	end
end

function var_0_0._refreshSchemes(arg_22_0)
	local var_22_0 = arg_22_0._fight.schemes

	if arg_22_0._schemesItems == nil then
		arg_22_0._schemesItems = arg_22_0:getUserDataTb_()
	end

	local var_22_1 = arg_22_0._fight:isFighting()

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		local var_22_2 = arg_22_0._schemesItems[iter_22_0]

		if var_22_2 == nil then
			local var_22_3 = gohelper.cloneInPlace(arg_22_0._gobuffitem)

			var_22_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_3, SurvivalMonsterEventBuffItem)

			var_22_2:initItem(iter_22_0)

			arg_22_0._schemesItems[iter_22_0] = var_22_2

			gohelper.setActive(var_22_3, true)
		end

		if not var_22_1 then
			iter_22_1 = SurvivalShelterMonsterModel.instance:calBuffIsRepress(iter_22_0)
		end

		var_22_2:updateItem(iter_22_1)
	end
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._updateNpcInfo, arg_23_0)

	if arg_23_0._fight:canEnterSelectNpc() then
		SurvivalShelterNpcMonsterListModel.instance:setSelectNpcByList(nil)
	end
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0._simageMap:UnLoadImage()
end

return var_0_0
