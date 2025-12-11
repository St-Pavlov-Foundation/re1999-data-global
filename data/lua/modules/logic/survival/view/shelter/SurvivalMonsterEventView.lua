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

	arg_1_0._goNpc = gohelper.findChild(arg_1_0.viewGO, "Panel/Npc")

	gohelper.setActive(arg_1_0._goNpc, false)
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

	if not arg_9_0._fight:isFighting() then
		GameFacade.showToast(ToastEnum.SurvivalBossDotOpen, arg_9_0._fight.beginTime)

		return
	end

	arg_9_0:enterFight()
end

function var_0_0.enterFight(arg_10_0)
	arg_10_0:_enterFight()
end

local var_0_1 = ZProj.UIEffectsCollection

function var_0_0._enterFight(arg_11_0)
	if arg_11_0._fight:getBattleId() then
		UIBlockHelper.instance:startBlock("SurvivalMonsterEventView_EnterFight")
		SurvivalController.instance:tryEnterShelterFight(arg_11_0._enterFightFinish, arg_11_0)
	end
end

function var_0_0._enterFightFinish(arg_12_0)
	UIBlockHelper.instance:endBlock("SurvivalMonsterEventView_EnterFight")
end

function var_0_0._editableInitView(arg_13_0)
	gohelper.setActive(arg_13_0._goNpcitem, false)
	gohelper.setActive(arg_13_0._gobuffitem, false)
	arg_13_0:addEventCb(SurvivalController.instance, SurvivalEvent.UpdateView, arg_13_0.updateView, arg_13_0)

	arg_13_0._fightUIEffect = var_0_1.Get(arg_13_0._btnFight.gameObject)
	arg_13_0._fightBtnAnchorX, arg_13_0._fightBtnAnchorY = recthelper.getAnchor(arg_13_0._btnFight.transform)
	arg_13_0._resetBtnAnchorX, arg_13_0._resetBtnAnchorY = recthelper.getAnchor(arg_13_0._btnReset.transform)
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	arg_15_0.showType = arg_15_0.viewParam.showType
	arg_15_0._fight = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()
	arg_15_0._fightConfig = arg_15_0._fight.fightCo

	arg_15_0:_initConfigInfo()
	arg_15_0:updateView()
end

function var_0_0.refreshShowType(arg_16_0)
	gohelper.setActive(arg_16_0._gotips, arg_16_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Watch)
	gohelper.setActive(arg_16_0._btnWatch.gameObject, arg_16_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Watch)
	gohelper.setActive(arg_16_0._goscore, arg_16_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Normal)
	gohelper.setActive(arg_16_0._btnFight.gameObject, arg_16_0.showType == SurvivalEnum.SurvivalMonsterEventViewShowType.Normal)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitBossEventView, arg_16_0.showType)
end

function var_0_0.updateView(arg_17_0)
	local var_17_0 = SurvivalShelterModel.instance:getWeekInfo()

	arg_17_0._fight = var_17_0:getMonsterFight()

	arg_17_0:_refreshState()

	local var_17_1 = arg_17_0._fightConfig.score
	local var_17_2 = var_17_0.equipBox:getAllScore()
	local var_17_3 = "#843034"

	if var_17_1 < var_17_2 then
		var_17_3 = "#19623f"
	end

	arg_17_0._txtrecommendscore.text = arg_17_0._fightConfig.score
	arg_17_0._txtcurscore.text = var_17_0.equipBox:getAllScore()
	arg_17_0._txtcurscore.color = GameUtil.parseColor(var_17_3)

	local var_17_4 = arg_17_0._fight.endTime - var_17_0.day

	if var_17_4 == 0 then
		arg_17_0._txttips.text = luaLang("survivalmonstereventview_monster_toady")
	else
		arg_17_0._txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_SurvivalMonsterEventView_tips"), var_17_4)
	end

	TaskDispatcher.runDelay(arg_17_0._updateNpcInfo, arg_17_0, 0.5)
end

function var_0_0._refreshState(arg_18_0)
	arg_18_0:refreshShowType()
	gohelper.setActive(arg_18_0._btnReset, arg_18_0._fight:canShowReset())

	local var_18_0 = arg_18_0._fight:isFighting()

	if arg_18_0._fightUIEffect then
		arg_18_0._fightUIEffect:SetGray(not var_18_0)
	end

	local var_18_1 = arg_18_0._fight:canShowFightBtn()

	gohelper.setActive(arg_18_0._btnFight, var_18_1)

	local var_18_2 = arg_18_0._resetBtnAnchorX
	local var_18_3 = arg_18_0._resetBtnAnchorY

	if not var_18_1 then
		var_18_2, var_18_3 = arg_18_0._fightBtnAnchorX, arg_18_0._fightBtnAnchorY
	end

	recthelper.setAnchor(arg_18_0._btnReset.transform, var_18_2, var_18_3)
end

function var_0_0._initConfigInfo(arg_19_0)
	if arg_19_0._fightConfig == nil then
		return
	end

	arg_19_0._txtTitle.text = arg_19_0._fightConfig.name
	arg_19_0._txttitledec.text = arg_19_0._fightConfig.desc

	local var_19_0 = arg_19_0._fightConfig.image

	arg_19_0._simageMap:LoadImage(var_19_0)
end

function var_0_0._updateNpcInfo(arg_20_0)
	if arg_20_0._fight == nil then
		logError("SurvivalMonsterEventView:_updateNpcInfo() self._fight is nil")

		return
	end

	arg_20_0:_refreshSchemes()

	local var_20_0 = SurvivalShelterNpcMonsterListModel.instance:getSelectList()

	if var_20_0 == nil then
		return
	end

	if arg_20_0._repressNpcItems == nil then
		arg_20_0._repressNpcItems = arg_20_0:getUserDataTb_()
	end

	local var_20_1 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.ShelterMonsterSelectNpcMax)
	local var_20_2 = var_20_1 and tonumber(var_20_1) or 0

	for iter_20_0 = 1, var_20_2 do
		local var_20_3 = arg_20_0._repressNpcItems[iter_20_0]
		local var_20_4 = var_20_0[iter_20_0]

		if var_20_3 == nil then
			local var_20_5 = gohelper.cloneInPlace(arg_20_0._goNpcitem)

			var_20_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_5, SurvivalMonsterEventSmallNpcItem)

			gohelper.setActive(var_20_5, true)
			table.insert(arg_20_0._repressNpcItems, var_20_3)
		end

		var_20_3:setIsCanEnterSelect(arg_20_0._fight:canEnterSelectNpc())
		var_20_3:setNeedShowEmpty(arg_20_0._fight:canEnterSelectNpc())
		var_20_3:updateItem(var_20_4)
	end
end

function var_0_0._refreshSchemes(arg_21_0)
	local var_21_0 = arg_21_0._fight.schemes

	if arg_21_0._schemesItems == nil then
		arg_21_0._schemesItems = arg_21_0:getUserDataTb_()
	end

	local var_21_1 = arg_21_0._fight:isFighting()

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		local var_21_2 = arg_21_0._schemesItems[iter_21_0]

		if var_21_2 == nil then
			local var_21_3 = gohelper.cloneInPlace(arg_21_0._gobuffitem)

			var_21_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_3, SurvivalMonsterEventBuffItem)

			var_21_2:initItem(iter_21_0, arg_21_0._fight:getIntrudeSchemeMo(iter_21_0))

			arg_21_0._schemesItems[iter_21_0] = var_21_2

			gohelper.setActive(var_21_3, true)
		end

		if not var_21_1 then
			iter_21_1 = SurvivalShelterMonsterModel.instance:calBuffIsRepress(iter_21_0)
		end

		var_21_2:updateItem(iter_21_1)
	end
end

function var_0_0.onClose(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._updateNpcInfo, arg_22_0)

	if arg_22_0._fight:canEnterSelectNpc() then
		SurvivalShelterNpcMonsterListModel.instance:setSelectNpcByList(nil)
	end
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0._simageMap:UnLoadImage()
end

return var_0_0
