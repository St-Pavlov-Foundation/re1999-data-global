module("modules.logic.versionactivity2_5.challenge.view.repress.Act183RepressView", package.seeall)

local var_0_0 = class("Act183RepressView", BaseView)
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "root/herocontainer/#go_heroitem")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "root/rules/#go_ruleitem")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	local var_4_0 = arg_4_0._selectHeroIndex ~= var_0_1
	local var_4_1 = arg_4_0._selectRuleIndex ~= var_0_2

	if var_4_0 ~= var_4_1 then
		return
	end

	if not var_4_0 and not var_4_1 then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act183UnselectAnyRepress, MsgBoxEnum.BoxType.Yes_No, arg_4_0._sendRpcToChooseRepress, nil, nil, arg_4_0)

		return
	end

	arg_4_0:_sendRpcToChooseRepress()
end

function var_0_0._sendRpcToChooseRepress(arg_5_0)
	Act183Controller.instance:tryChooseRepress(arg_5_0._activityId, arg_5_0._episodeId, arg_5_0._selectRuleIndex, arg_5_0._selectHeroIndex, function()
		arg_5_0:closeThis()
	end, arg_5_0)
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenRepressView)

	arg_9_0._activityId = arg_9_0.viewParam and arg_9_0.viewParam.activityId
	arg_9_0._episodeMo = arg_9_0.viewParam and arg_9_0.viewParam.episodeMo
	arg_9_0._episodeId = arg_9_0._episodeMo and arg_9_0._episodeMo:getEpisodeId()
	arg_9_0._fightResultMo = arg_9_0.viewParam and arg_9_0.viewParam.fightResultMo
	arg_9_0._heroes = arg_9_0._fightResultMo and arg_9_0._fightResultMo:getHeroes()
	arg_9_0._heroes = arg_9_0._heroes or arg_9_0._episodeMo:getHeroes()
	arg_9_0._repressMo = arg_9_0._episodeMo and arg_9_0._episodeMo:getRepressMo()
	arg_9_0._ruleDescs = Act183Config.instance:getEpisodeAllRuleDesc(arg_9_0._episodeId)
	arg_9_0._heroItemTab = arg_9_0:getUserDataTb_()
	arg_9_0._ruleItemTab = arg_9_0:getUserDataTb_()
	arg_9_0._hasRepress = arg_9_0._repressMo:hasRepress() and not arg_9_0._fightResultMo
	arg_9_0._selectHeroIndex = arg_9_0._hasRepress and arg_9_0._repressMo:getHeroIndex() or var_0_1
	arg_9_0._selectRuleIndex = arg_9_0._hasRepress and arg_9_0._repressMo:getRuleIndex() or var_0_2

	arg_9_0:refreshHeroList()
	arg_9_0:refreshRuleList()
end

function var_0_0.refreshHeroList(arg_10_0)
	if not arg_10_0._heroes then
		logError("编队数据为空")

		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._heroes) do
		local var_10_0 = arg_10_0:_getOrCreateHeroItem(iter_10_0)
		local var_10_1 = arg_10_0:_isSelectRepressHero(iter_10_0)
		local var_10_2 = iter_10_1:getHeroMo()

		var_10_0.item:onUpdateMO(var_10_2)
		var_10_0.item:setSelect(var_10_1)
		var_10_0.item:setNewShow(false)
		gohelper.setActive(var_10_0.viewGO, true)
	end
end

function var_0_0._getOrCreateHeroItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._heroItemTab[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.viewGO = gohelper.cloneInPlace(arg_11_0._goheroitem, "heroitem_" .. arg_11_1)
		var_11_0.gopos = gohelper.findChild(var_11_0.viewGO, "go_pos")
		var_11_0.item = IconMgr.instance:getCommonHeroItem(var_11_0.gopos)

		var_11_0.item:setStyle_CharacterBackpack()

		var_11_0.btnclick = gohelper.findChildButtonWithAudio(var_11_0.viewGO, "btn_click")

		var_11_0.btnclick:AddClickListener(arg_11_0._onClickHeroItem, arg_11_0, arg_11_1)

		arg_11_0._heroItemTab[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0._onClickHeroItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:_isSelectRepressHero(arg_12_1)

	arg_12_0:_onSelectRepressHero(arg_12_1, not var_12_0)
end

function var_0_0._isSelectRepressHero(arg_13_0, arg_13_1)
	return arg_13_0._selectHeroIndex == arg_13_1
end

function var_0_0._onSelectRepressHero(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._selectHeroIndex = arg_14_2 and arg_14_1 or var_0_1

	if arg_14_2 and arg_14_0._selectRuleIndex == var_0_2 then
		arg_14_0._selectRuleIndex = var_0_3
	elseif not arg_14_2 then
		arg_14_0._selectRuleIndex = var_0_2
	end

	arg_14_0:refreshHeroList()
	arg_14_0:refreshRuleList()
end

function var_0_0.releaseAllHeroItems(arg_15_0)
	if arg_15_0._heroItemTab then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._heroItemTab) do
			iter_15_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.refreshRuleList(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._ruleDescs) do
		local var_16_0 = arg_16_0:_getOrCreateRuleItem(iter_16_0)
		local var_16_1 = arg_16_0:_isSelectRepressRule(iter_16_0)

		var_16_0.txtdesc.text = HeroSkillModel.instance:skillDesToSpot(iter_16_1)

		gohelper.setActive(var_16_0.viewGO, true)
		gohelper.setActive(var_16_0.goselect, var_16_1)
		gohelper.setActive(var_16_0.gorepress, var_16_1)
		Act183Helper.setRuleIcon(arg_16_0._episodeId, iter_16_0, var_16_0.imageicon)
		var_16_0.animrepress:Play(var_16_1 and "in" or "idle", 0, 0)
	end
end

function var_0_0._getOrCreateRuleItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._ruleItemTab[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.viewGO = gohelper.cloneInPlace(arg_17_0._goruleitem, "ruleitem_" .. arg_17_1)
		var_17_0.imageicon = gohelper.findChildImage(var_17_0.viewGO, "image_icon")
		var_17_0.gorepress = gohelper.findChild(var_17_0.viewGO, "image_icon/go_repress")
		var_17_0.animrepress = gohelper.onceAddComponent(var_17_0.gorepress, gohelper.Type_Animator)
		var_17_0.txtdesc = gohelper.findChildText(var_17_0.viewGO, "txt_desc")
		var_17_0.goselect = gohelper.findChild(var_17_0.viewGO, "go_select")
		var_17_0.btnclick = gohelper.findChildButtonWithAudio(var_17_0.viewGO, "btn_click")

		var_17_0.btnclick:AddClickListener(arg_17_0._onClickRuleItem, arg_17_0, arg_17_1)

		arg_17_0._ruleItemTab[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0._onClickRuleItem(arg_18_0, arg_18_1)
	arg_18_0:_onSelectRepressRule(arg_18_1, true)
end

function var_0_0.releaseAllRuleItems(arg_19_0)
	if arg_19_0._ruleItemTab then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._ruleItemTab) do
			iter_19_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0._isSelectRepressRule(arg_20_0, arg_20_1)
	return arg_20_0._selectRuleIndex == arg_20_1
end

function var_0_0._onSelectRepressRule(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._selectRuleIndex = arg_21_2 and arg_21_1 or var_0_2
	arg_21_0._selectHeroIndex = arg_21_2 and arg_21_0._selectHeroIndex or var_0_1

	if arg_21_2 and arg_21_0._selectHeroIndex == var_0_1 then
		arg_21_0._selectHeroIndex = 1
	end

	arg_21_0:refreshRuleList()
	arg_21_0:refreshHeroList()
end

function var_0_0.onClose(arg_22_0)
	arg_22_0:releaseAllHeroItems()
	arg_22_0:releaseAllRuleItems()
end

function var_0_0.onDestroyView(arg_23_0)
	return
end

return var_0_0
