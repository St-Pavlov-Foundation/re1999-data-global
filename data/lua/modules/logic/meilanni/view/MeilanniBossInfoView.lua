module("modules.logic.meilanni.view.MeilanniBossInfoView", package.seeall)

slot0 = class("MeilanniBossInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._txtbossname = gohelper.findChildText(slot0.viewGO, "#txt_bossname")
	slot0._btnpreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#txt_bossname/#btn_preview")
	slot0._simagebossicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bossicon")
	slot0._scrollproperty = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_property")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_property/Viewport/#go_content")
	slot0._gopropertyitem = gohelper.findChild(slot0.viewGO, "#scroll_property/Viewport/#go_content/#go_propertyitem")
	slot0._txtgossipdesc = gohelper.findChildText(slot0.viewGO, "#txt_gossipdesc")
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnpreview:AddClickListener(slot0._btnpreviewOnClick, slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnpreview:RemoveClickListener()
	slot0._btnclose1:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnpreviewOnClick(slot0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(slot0._battleId)
end

function slot0._btnclose1OnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._mapId = slot0.viewParam.mapId
	slot0._mapInfo = MeilanniModel.instance:getMapInfo(slot0._mapId)
	slot0._mapConfig = lua_activity108_map.configDict[slot0._mapId]
	slot0._ruleGoList = slot0:getUserDataTb_()
	slot0._ruleGoThreatList = slot0:getUserDataTb_()
	slot0._showExcludeRules = slot0.viewParam.showExcludeRules

	if slot0._showExcludeRules then
		slot1 = slot0.viewParam.rulesInfo
		slot0._oldRules = slot1[1]
		slot0._newRules = slot1[2]
	end

	slot0:_showBossDetail()

	if slot0._showExcludeRules then
		TaskDispatcher.runDelay(slot0._adjustScrollPos, slot0, 0.1)
		TaskDispatcher.runDelay(slot0._showExcludeRuleEffect, slot0, 1)
		TaskDispatcher.runDelay(slot0.closeThis, slot0, 2)
	end

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function slot0._adjustScrollPos(slot0)
	for slot4 = #slot0._oldRules + 1, #slot0._newRules do
		if slot0._ruleGoList[slot0._newRules[slot4]].transform:GetSiblingIndex() >= 2 then
			recthelper.setAnchorY(slot0._gocontent.transform, math.abs(recthelper.getAnchorY(slot6.transform)) - 20)
		end
	end
end

function slot0._showExcludeRuleEffect(slot0)
	for slot4 = #slot0._oldRules + 1, #slot0._newRules do
		slot5 = slot0._newRules[slot4]
		slot6 = slot0._ruleGoList[slot5]

		slot0:_setGoExcludeRule(slot6, true)
		slot0:_addThreat(slot6, slot5, true)
	end

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_delete_features)
end

function slot0._showBossDetail(slot0)
	if slot0._isShowBossDetail then
		return
	end

	slot0._isShowBossDetail = true
	slot0._txtgossipdesc.text = slot0._mapConfig.enemyInfo

	slot0._simagebossicon:LoadImage(ResUrl.getMeilanniIcon(slot0._mapConfig.monsterIcon))

	slot8 = "#"
	slot4 = nil

	for slot8, slot9 in ipairs(GameUtil.splitString2(MeilanniConfig.instance:getLastEvent(slot0._mapId).interactParam, true, "|", slot8)) do
		if slot9[1] == MeilanniEnum.ElementType.Battle then
			slot4 = slot9[2]

			break
		end
	end

	if not slot4 then
		return
	end

	slot0._battleId = slot4
	slot10 = "|"
	slot11 = "#"

	for slot10, slot11 in ipairs(GameUtil.splitString2(lua_battle.configDict[slot4].additionRule, true, slot10, slot11)) do
		slot12 = slot11[2]
		slot13 = lua_rule.configDict[slot12]
		slot14 = gohelper.cloneInPlace(slot0._gopropertyitem)

		gohelper.setActive(slot14, true)

		gohelper.findChildText(slot14, "txt_desc").text = slot13.desc
		gohelper.findChildText(slot14, "tag/image_bg/txt_namecn").text = slot13.name
		slot0._ruleGoList[slot12] = slot14
		slot17 = slot0:_isExcludeRule(slot12)

		slot0:_setGoExcludeRule(slot14, slot17)

		if slot17 then
			gohelper.setAsLastSibling(slot14)
		else
			gohelper.setAsFirstSibling(slot14)
		end

		slot0:_addThreat(slot14, slot12, slot17)
	end

	if not MeilanniView.getMonsterId(slot4) then
		return
	end

	slot0._txtbossname.text = lua_monster.configDict[slot7].highPriorityName
end

function slot0._addThreat(slot0, slot1, slot2, slot3)
	slot5 = slot0:_getThreatByRuleId(slot2)
	slot0._ruleGoThreatList[slot1] = slot0._ruleGoThreatList[slot1] or {}

	for slot10 = 1, slot5 do
		slot11 = slot6[slot10] or gohelper.cloneInPlace(gohelper.findChild(slot1, "tag/image_bg/txt_namecn/threat/go_threatitem"))
		slot6[slot10] = slot11

		gohelper.setActive(slot11, true)

		if slot3 then
			UISpriteSetMgr.instance:setMeilanniSprite(gohelper.findChildImage(slot11, "icon"), slot0:_getThreatIcon(slot5, false))
		else
			UISpriteSetMgr.instance:setMeilanniSprite(slot12, slot0:_getThreatIcon(slot5, true))
		end
	end
end

function slot0._getThreatIcon(slot0, slot1, slot2)
	if slot1 == 1 then
		return slot2 and "bg_weixiezhi" or "bg_weixiezhi_dis"
	elseif slot1 == 2 then
		return slot2 and "bg_weixiezhi_1" or "bg_weixiezhi_1_dis"
	else
		return slot2 and "bg_weixiezhi_2" or "bg_weixiezhi_2_dis"
	end
end

function slot0._getThreatByRuleId(slot0, slot1)
	for slot5, slot6 in pairs(lua_activity108_rule.configDict) do
		if string.find(slot6.rules, tostring(slot1)) then
			return slot6.threat
		end
	end

	return 0
end

function slot0._setGoExcludeRule(slot0, slot1, slot2)
	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildText(slot1, "tag/image_bg/txt_namecn"), slot2 and 0.45 or 1)
	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildText(slot1, "txt_desc"), slot2 and 0.45 or 1)

	if not slot2 then
		return
	end

	gohelper.setActive(gohelper.findChild(slot1, "txt_desc/go_disable"), true)
	gohelper.setActive(gohelper.findChild(slot1, "tag/image_bg/go_disable"), true)
	UISpriteSetMgr.instance:setMeilanniSprite(gohelper.findChildImage(slot1, "tag/image_bg"), "bg_tuya_1")
end

function slot0._isExcludeRule(slot0, slot1)
	if slot0._oldRules then
		return tabletool.indexOf(slot0._oldRules, slot1)
	end

	return slot0._mapInfo and slot0._mapInfo:isExcludeRule(slot1)
end

function slot0.onClose(slot0)
	slot0._simagebossicon:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	TaskDispatcher.cancelTask(slot0._showExcludeRuleEffect, slot0)
	TaskDispatcher.cancelTask(slot0._adjustScrollPos, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function slot0.onDestroyView(slot0)
end

return slot0
