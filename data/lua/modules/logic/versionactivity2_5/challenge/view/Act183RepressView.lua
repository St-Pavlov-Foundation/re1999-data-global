module("modules.logic.versionactivity2_5.challenge.view.Act183RepressView", package.seeall)

slot0 = class("Act183RepressView", BaseView)
slot1 = 0
slot2 = 0
slot3 = 1

function slot0.onInitView(slot0)
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "root/herocontainer/#go_heroitem")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "root/rules/#go_ruleitem")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	if slot0._selectHeroIndex ~= uv0 ~= (slot0._selectRuleIndex ~= uv1) then
		return
	end

	if not slot1 and not slot2 then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act183UnselectAnyRepress, MsgBoxEnum.BoxType.Yes_No, slot0._sendRpcToChooseRepress, nil, , slot0)

		return
	end

	slot0:_sendRpcToChooseRepress()
end

function slot0._sendRpcToChooseRepress(slot0)
	Act183Controller.instance:tryChooseRepress(slot0._activityId, slot0._episodeId, slot0._selectRuleIndex, slot0._selectHeroIndex, function ()
		uv0:closeThis()
	end, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenRepressView)

	slot0._activityId = slot0.viewParam and slot0.viewParam.activityId
	slot0._episodeMo = slot0.viewParam and slot0.viewParam.episodeMo
	slot0._episodeId = slot0._episodeMo and slot0._episodeMo:getEpisodeId()
	slot0._fightResultMo = slot0.viewParam and slot0.viewParam.fightResultMo
	slot0._heroes = slot0._fightResultMo and slot0._fightResultMo:getHeroes()
	slot0._heroes = slot0._heroes or slot0._episodeMo:getHeroes()
	slot0._repressMo = slot0._episodeMo and slot0._episodeMo:getRepressMo()
	slot0._ruleDescs = Act183Config.instance:getEpisodeAllRuleDesc(slot0._episodeId)
	slot0._heroItemTab = slot0:getUserDataTb_()
	slot0._ruleItemTab = slot0:getUserDataTb_()
	slot0._hasRepress = slot0._repressMo:hasRepress() and not slot0._fightResultMo
	slot0._selectHeroIndex = slot0._hasRepress and slot0._repressMo:getHeroIndex() or uv0
	slot0._selectRuleIndex = slot0._hasRepress and slot0._repressMo:getRuleIndex() or uv1

	slot0:refreshHeroList()
	slot0:refreshRuleList()
end

function slot0.refreshHeroList(slot0)
	if not slot0._heroes then
		logError("编队数据为空")

		return
	end

	for slot4, slot5 in ipairs(slot0._heroes) do
		slot6 = slot0:_getOrCreateHeroItem(slot4)

		slot6.item:onUpdateMO(slot5:getHeroMo())
		slot6.item:setSelect(slot0:_isSelectRepressHero(slot4))
		slot6.item:setNewShow(false)
		gohelper.setActive(slot6.viewGO, true)
	end
end

function slot0._getOrCreateHeroItem(slot0, slot1)
	if not slot0._heroItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goheroitem, "heroitem_" .. slot1)
		slot2.gopos = gohelper.findChild(slot2.viewGO, "go_pos")
		slot2.item = IconMgr.instance:getCommonHeroItem(slot2.gopos)
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._onClickHeroItem, slot0, slot1)

		slot0._heroItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._onClickHeroItem(slot0, slot1)
	slot0:_onSelectRepressHero(slot1, not slot0:_isSelectRepressHero(slot1))
end

function slot0._isSelectRepressHero(slot0, slot1)
	return slot0._selectHeroIndex == slot1
end

function slot0._onSelectRepressHero(slot0, slot1, slot2)
	slot0._selectHeroIndex = slot2 and slot1 or uv0

	if slot2 and slot0._selectRuleIndex == uv1 then
		slot0._selectRuleIndex = uv2
	elseif not slot2 then
		slot0._selectRuleIndex = uv1
	end

	slot0:refreshHeroList()
	slot0:refreshRuleList()
end

function slot0.releaseAllHeroItems(slot0)
	if slot0._heroItemTab then
		for slot4, slot5 in pairs(slot0._heroItemTab) do
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0.refreshRuleList(slot0)
	for slot4, slot5 in ipairs(slot0._ruleDescs) do
		slot6 = slot0:_getOrCreateRuleItem(slot4)
		slot7 = slot0:_isSelectRepressRule(slot4)
		slot6.txtdesc.text = HeroSkillModel.instance:skillDesToSpot(slot5)

		gohelper.setActive(slot6.viewGO, true)
		gohelper.setActive(slot6.goselect, slot7)
		gohelper.setActive(slot6.gorepress, slot7)
		Act183Helper.setRuleIcon(slot0._episodeId, slot4, slot6.imageicon)
		slot6.animrepress:Play(slot7 and "in" or "idle", 0, 0)
	end
end

function slot0._getOrCreateRuleItem(slot0, slot1)
	if not slot0._ruleItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goruleitem, "ruleitem_" .. slot1)
		slot2.imageicon = gohelper.findChildImage(slot2.viewGO, "image_icon")
		slot2.gorepress = gohelper.findChild(slot2.viewGO, "image_icon/go_repress")
		slot2.animrepress = gohelper.onceAddComponent(slot2.gorepress, gohelper.Type_Animator)
		slot2.txtdesc = gohelper.findChildText(slot2.viewGO, "txt_desc")
		slot2.goselect = gohelper.findChild(slot2.viewGO, "go_select")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._onClickRuleItem, slot0, slot1)

		slot0._ruleItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._onClickRuleItem(slot0, slot1)
	slot0:_onSelectRepressRule(slot1, true)
end

function slot0.releaseAllRuleItems(slot0)
	if slot0._ruleItemTab then
		for slot4, slot5 in pairs(slot0._ruleItemTab) do
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0._isSelectRepressRule(slot0, slot1)
	return slot0._selectRuleIndex == slot1
end

function slot0._onSelectRepressRule(slot0, slot1, slot2)
	slot0._selectRuleIndex = slot2 and slot1 or uv0
	slot0._selectHeroIndex = slot2 and slot0._selectHeroIndex or uv1

	if slot2 and slot0._selectHeroIndex == uv1 then
		slot0._selectHeroIndex = 1
	end

	slot0:refreshRuleList()
	slot0:refreshHeroList()
end

function slot0.onClose(slot0)
	slot0:releaseAllHeroItems()
	slot0:releaseAllRuleItems()
end

function slot0.onDestroyView(slot0)
end

return slot0
