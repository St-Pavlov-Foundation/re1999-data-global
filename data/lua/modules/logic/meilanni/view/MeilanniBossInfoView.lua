module("modules.logic.meilanni.view.MeilanniBossInfoView", package.seeall)

local var_0_0 = class("MeilanniBossInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._txtbossname = gohelper.findChildText(arg_1_0.viewGO, "#txt_bossname")
	arg_1_0._btnpreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#txt_bossname/#btn_preview")
	arg_1_0._simagebossicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bossicon")
	arg_1_0._scrollproperty = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_property")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_property/Viewport/#go_content")
	arg_1_0._gopropertyitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_property/Viewport/#go_content/#go_propertyitem")
	arg_1_0._txtgossipdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_gossipdesc")
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnpreview:AddClickListener(arg_2_0._btnpreviewOnClick, arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnpreview:RemoveClickListener()
	arg_3_0._btnclose1:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnpreviewOnClick(arg_5_0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(arg_5_0._battleId)
end

function var_0_0._btnclose1OnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._mapId = arg_9_0.viewParam.mapId
	arg_9_0._mapInfo = MeilanniModel.instance:getMapInfo(arg_9_0._mapId)
	arg_9_0._mapConfig = lua_activity108_map.configDict[arg_9_0._mapId]
	arg_9_0._ruleGoList = arg_9_0:getUserDataTb_()
	arg_9_0._ruleGoThreatList = arg_9_0:getUserDataTb_()
	arg_9_0._showExcludeRules = arg_9_0.viewParam.showExcludeRules

	if arg_9_0._showExcludeRules then
		local var_9_0 = arg_9_0.viewParam.rulesInfo

		arg_9_0._oldRules = var_9_0[1]
		arg_9_0._newRules = var_9_0[2]
	end

	arg_9_0:_showBossDetail()

	if arg_9_0._showExcludeRules then
		TaskDispatcher.runDelay(arg_9_0._adjustScrollPos, arg_9_0, 0.1)
		TaskDispatcher.runDelay(arg_9_0._showExcludeRuleEffect, arg_9_0, 1)
		TaskDispatcher.runDelay(arg_9_0.closeThis, arg_9_0, 2)
	end

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function var_0_0._adjustScrollPos(arg_10_0)
	for iter_10_0 = #arg_10_0._oldRules + 1, #arg_10_0._newRules do
		local var_10_0 = arg_10_0._newRules[iter_10_0]
		local var_10_1 = arg_10_0._ruleGoList[var_10_0]

		if var_10_1.transform:GetSiblingIndex() >= 2 then
			local var_10_2 = math.abs(recthelper.getAnchorY(var_10_1.transform))

			recthelper.setAnchorY(arg_10_0._gocontent.transform, var_10_2 - 20)
		end
	end
end

function var_0_0._showExcludeRuleEffect(arg_11_0)
	for iter_11_0 = #arg_11_0._oldRules + 1, #arg_11_0._newRules do
		local var_11_0 = arg_11_0._newRules[iter_11_0]
		local var_11_1 = arg_11_0._ruleGoList[var_11_0]

		arg_11_0:_setGoExcludeRule(var_11_1, true)
		arg_11_0:_addThreat(var_11_1, var_11_0, true)
	end

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_delete_features)
end

function var_0_0._showBossDetail(arg_12_0)
	if arg_12_0._isShowBossDetail then
		return
	end

	arg_12_0._isShowBossDetail = true
	arg_12_0._txtgossipdesc.text = arg_12_0._mapConfig.enemyInfo

	local var_12_0 = arg_12_0._mapConfig.monsterIcon

	arg_12_0._simagebossicon:LoadImage(ResUrl.getMeilanniIcon(var_12_0))

	local var_12_1 = MeilanniConfig.instance:getLastEvent(arg_12_0._mapId)
	local var_12_2 = GameUtil.splitString2(var_12_1.interactParam, true, "|", "#")
	local var_12_3

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		if iter_12_1[1] == MeilanniEnum.ElementType.Battle then
			var_12_3 = iter_12_1[2]

			break
		end
	end

	if not var_12_3 then
		return
	end

	arg_12_0._battleId = var_12_3

	local var_12_4 = lua_battle.configDict[var_12_3]
	local var_12_5 = GameUtil.splitString2(var_12_4.additionRule, true, "|", "#")

	for iter_12_2, iter_12_3 in ipairs(var_12_5) do
		local var_12_6 = iter_12_3[2]
		local var_12_7 = lua_rule.configDict[var_12_6]
		local var_12_8 = gohelper.cloneInPlace(arg_12_0._gopropertyitem)

		gohelper.setActive(var_12_8, true)

		local var_12_9 = gohelper.findChildText(var_12_8, "txt_desc")
		local var_12_10 = gohelper.findChildText(var_12_8, "tag/image_bg/txt_namecn")

		var_12_9.text = var_12_7.desc
		var_12_10.text = var_12_7.name
		arg_12_0._ruleGoList[var_12_6] = var_12_8

		local var_12_11 = arg_12_0:_isExcludeRule(var_12_6)

		arg_12_0:_setGoExcludeRule(var_12_8, var_12_11)

		if var_12_11 then
			gohelper.setAsLastSibling(var_12_8)
		else
			gohelper.setAsFirstSibling(var_12_8)
		end

		arg_12_0:_addThreat(var_12_8, var_12_6, var_12_11)
	end

	local var_12_12 = MeilanniView.getMonsterId(var_12_3)

	if not var_12_12 then
		return
	end

	local var_12_13 = lua_monster.configDict[var_12_12]

	arg_12_0._txtbossname.text = var_12_13.highPriorityName
end

function var_0_0._addThreat(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = gohelper.findChild(arg_13_1, "tag/image_bg/txt_namecn/threat/go_threatitem")
	local var_13_1 = arg_13_0:_getThreatByRuleId(arg_13_2)
	local var_13_2 = arg_13_0._ruleGoThreatList[arg_13_1] or {}

	arg_13_0._ruleGoThreatList[arg_13_1] = var_13_2

	for iter_13_0 = 1, var_13_1 do
		local var_13_3 = var_13_2[iter_13_0] or gohelper.cloneInPlace(var_13_0)

		var_13_2[iter_13_0] = var_13_3

		gohelper.setActive(var_13_3, true)

		local var_13_4 = gohelper.findChildImage(var_13_3, "icon")

		if arg_13_3 then
			UISpriteSetMgr.instance:setMeilanniSprite(var_13_4, arg_13_0:_getThreatIcon(var_13_1, false))
		else
			UISpriteSetMgr.instance:setMeilanniSprite(var_13_4, arg_13_0:_getThreatIcon(var_13_1, true))
		end
	end
end

function var_0_0._getThreatIcon(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 1 then
		return arg_14_2 and "bg_weixiezhi" or "bg_weixiezhi_dis"
	elseif arg_14_1 == 2 then
		return arg_14_2 and "bg_weixiezhi_1" or "bg_weixiezhi_1_dis"
	else
		return arg_14_2 and "bg_weixiezhi_2" or "bg_weixiezhi_2_dis"
	end
end

function var_0_0._getThreatByRuleId(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(lua_activity108_rule.configDict) do
		if string.find(iter_15_1.rules, tostring(arg_15_1)) then
			return iter_15_1.threat
		end
	end

	return 0
end

function var_0_0._setGoExcludeRule(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = gohelper.findChildText(arg_16_1, "txt_desc")
	local var_16_1 = gohelper.findChildText(arg_16_1, "tag/image_bg/txt_namecn")

	ZProj.UGUIHelper.SetColorAlpha(var_16_1, arg_16_2 and 0.45 or 1)
	ZProj.UGUIHelper.SetColorAlpha(var_16_0, arg_16_2 and 0.45 or 1)

	if not arg_16_2 then
		return
	end

	local var_16_2 = gohelper.findChild(arg_16_1, "txt_desc/go_disable")
	local var_16_3 = gohelper.findChild(arg_16_1, "tag/image_bg/go_disable")
	local var_16_4 = gohelper.findChildImage(arg_16_1, "tag/image_bg")

	gohelper.setActive(var_16_2, true)
	gohelper.setActive(var_16_3, true)
	UISpriteSetMgr.instance:setMeilanniSprite(var_16_4, "bg_tuya_1")
end

function var_0_0._isExcludeRule(arg_17_0, arg_17_1)
	if arg_17_0._oldRules then
		return tabletool.indexOf(arg_17_0._oldRules, arg_17_1)
	end

	return arg_17_0._mapInfo and arg_17_0._mapInfo:isExcludeRule(arg_17_1)
end

function var_0_0.onClose(arg_18_0)
	arg_18_0._simagebossicon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_18_0.closeThis, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._showExcludeRuleEffect, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._adjustScrollPos, arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
