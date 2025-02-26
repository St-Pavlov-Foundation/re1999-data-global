module("modules.logic.rouge.dlc.101.view.RougeMapView_1_101", package.seeall)

slot0 = class("RougeMapView_1_101", BaseViewExtended)
slot0.AssetUrl = "ui/viewres/rouge/dlc/101/rougemapskillview.prefab"
slot0.ParentObjPath = "Left/#go_rougezhouyu"
slot1 = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}

function slot0.onInitView(slot0)
	slot0._heroSkillGO = gohelper.findChild(slot0.viewGO, "heroSkill")
	slot0._goSkillDescContent = gohelper.findChild(slot0.viewGO, "heroSkill/#go_detail/skillDescContent")
	slot0._goSkillDescItem = gohelper.findChild(slot0.viewGO, "heroSkill/#go_detail/skillDescContent/#go_skillDescItem")
	slot0._goSkillContent = gohelper.findChild(slot0.viewGO, "heroSkill/#go_simple/skillContent")
	slot0._goSkillItem = gohelper.findChild(slot0.viewGO, "heroSkill/#go_simple/skillContent/#go_skillitem")
	slot0._btnlimiter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_limiter")
	slot0._txtrisk = gohelper.findChildText(slot0.viewGO, "#btn_limiter/#txt_risk")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)
	RougeController.instance:registerCallback(RougeEvent.OnUpdateRougeInfoPower, slot0._onUpdateRougeInfoPower, slot0)
	RougeController.instance:registerCallback(RougeEvent.OnUpdateRougeInfo, slot0._onUpdateRougeInfo, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onUpdateMapInfo, slot0._onUpdateMapInfo, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, slot0._onChangeMapInfo, slot0)
	slot0._btnlimiter:AddClickListener(slot0._btnlimiterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlimiter:RemoveClickListener()
end

function slot0._btnlimiterOnClick(slot0)
	slot2 = RougeModel.instance:getRougeInfo() and slot1:getGameLimiterMo()

	RougeDLCController101.instance:openRougeLimiterOverView({
		limiterIds = slot2 and slot2:getLimiterIds(),
		buffIds = slot2 and slot2:getLimiterBuffIds(),
		totalRiskValue = slot2 and slot2:getRiskValue() or 0
	})
end

function slot0._editableInitView(slot0)
	slot0._state = uv0.Simple
	slot0._detailClick = slot0:getUserDataTb_()
	slot0._entryBtnClick = slot0:getUserDataTb_()
	slot0._animator = gohelper.onceAddComponent(slot0._heroSkillGO, gohelper.Type_Animator)

	slot0:checkAndShowLimiterEntry()
end

function slot0.checkAndShowLimiterEntry(slot0)
	slot2 = RougeModel.instance:getRougeInfo() and slot1:getGameLimiterMo()
	slot4 = slot2 ~= nil and (slot2 and slot2:getRiskValue() or 0) > 0

	gohelper.setActive(slot0._btnlimiter.gameObject, slot4)

	if not slot4 then
		return
	end

	slot0._txtrisk.text = slot3
end

function slot0._onUpdateRougeInfo(slot0)
	slot0:_updateUI()
end

function slot0._onUpdateRougeInfoPower(slot0)
	slot0:_updateUI()
end

function slot0._onUpdateMapInfo(slot0)
	slot0:_updateUI()
end

function slot0._onChangeMapInfo(slot0)
	slot0:_updateUI()
end

function slot0._setState(slot0)
	if slot0._state == uv0.Expanding then
		slot0._state = uv0.Detail
	elseif slot0._state == uv0.Shrinking then
		slot0._state = uv0.Simple
	end
end

function slot0._onTouch(slot0)
	if slot0._state == uv0.Detail then
		TaskDispatcher.runDelay(slot0._delayDealTouch, slot0, 0.01)
	end
end

function slot0._delayDealTouch(slot0)
	if not slot0._hasClickDetailIcon then
		slot0:_shrinkDetailUI()
	end

	slot0._hasClickDetailIcon = nil
end

function slot0._shrinkDetailUI(slot0)
	slot0._animator:Play("fight_heroskill_out", 0, 0)
	slot0._animator:Update(0)

	slot0._state = uv0.Shrinking

	TaskDispatcher.runDelay(slot0._setState, slot0, 0.533)
end

function slot0.onOpen(slot0)
	slot0:_updateUI()
end

function slot0._getPower(slot0)
	return RougeModel.instance:getRougeInfo() and slot1.power or 0
end

function slot0._getCoint(slot0)
	return RougeModel.instance:getRougeInfo() and slot1.coin or 0
end

function slot0._updateUI(slot0)
	slot0._mapSkills = RougeMapModel.instance:getMapSkillList()
	slot0._visible = (slot0._mapSkills and #slot0._mapSkills or 0) > 0

	gohelper.setActive(slot0._heroSkillGO, slot0._visible)

	if not slot0._visible then
		return
	end

	gohelper.CreateObjList(slot0, slot0._refreshMapSkillDetail, slot0._mapSkills, slot0._goSkillDescContent, slot0._goSkillDescItem)
	gohelper.CreateObjList(slot0, slot0._refreshMapSkillEntry, slot0._mapSkills, slot0._goSkillContent, slot0._goSkillItem)
end

function slot0._refreshMapSkillDetail(slot0, slot1, slot2, slot3)
	if lua_rouge_map_skill.configDict[slot2.id] then
		slot5 = RougeMapSkillCheckHelper.canUseMapSkill(slot2)

		gohelper.setActive(gohelper.findChild(slot1, "skill1/notcost1"), not slot5)
		gohelper.setActive(gohelper.findChild(slot1, "skill1/cancost1"), slot5)

		slot8 = slot4.icon

		UISpriteSetMgr.instance:setRouge2Sprite(gohelper.findChildImage(slot1, "skill1/notcost1"), slot8)
		UISpriteSetMgr.instance:setRouge2Sprite(gohelper.findChildImage(slot1, "skill1/cancost1"), slot8 .. "_light")

		gohelper.findChildText(slot1, "desc1").text = slot4.desc .. "\nCOST<color=#FFA500>-" .. slot4.powerCost .. "</color>"

		if not slot0._detailClick[slot3] then
			slot13 = gohelper.getClick(slot1)

			slot13:AddClickListener(slot0._onClickSkillIcon, slot0, slot3)

			slot0._detailClick[slot3] = slot13
		end
	else
		logError("肉鸽地图技能配置不存在:" .. tostring(slot2.id))
	end
end

function slot0._refreshMapSkillEntry(slot0, slot1, slot2, slot3)
	if lua_rouge_map_skill.configDict[slot2.id] then
		slot5 = RougeMapSkillCheckHelper.canUseMapSkill(slot2)

		gohelper.setActive(gohelper.findChild(slot1, "notcost"), not slot5)
		gohelper.setActive(gohelper.findChild(slot1, "cancost"), slot5)

		slot8 = slot4.icon

		UISpriteSetMgr.instance:setRouge2Sprite(gohelper.findChildImage(slot1, "notcost/#image_skill_normal"), slot8)
		UISpriteSetMgr.instance:setRouge2Sprite(gohelper.findChildImage(slot1, "cancost/#image_skill_light"), slot8 .. "_light")

		if not slot0._entryBtnClick[slot3] then
			slot11 = gohelper.findChildButtonWithAudio(slot1, "btn_click")

			slot11:AddClickListener(slot0._onClickEntrySkillIcon, slot0, slot3)

			slot0._entryBtnClick[slot3] = slot11
		end
	else
		logError("肉鸽地图技能配置不存在:" .. tostring(slot2.id))
	end
end

function slot0._onClickEntrySkillIcon(slot0, slot1)
	slot3, slot4 = RougeMapSkillCheckHelper.canUseMapSkill(slot0._mapSkills and slot0._mapSkills[slot1])

	if not slot3 and slot4 == RougeMapSkillCheckHelper.CantUseMapSkillReason.DoingEvent then
		RougeMapSkillCheckHelper.showCantUseMapSkillToast(slot4)

		return
	end

	if slot0._state == uv0.Simple then
		slot0._animator:Play("fight_heroskill_tips", 0, 0)
		slot0._animator:Update(0)

		slot0._state = uv0.Expanding

		TaskDispatcher.runDelay(slot0._setState, slot0, 0.533)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
	end
end

function slot0._onClickSkillIcon(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if not (slot0._mapSkills and slot0._mapSkills[slot1]) then
		return
	end

	slot0._hasClickDetailIcon = true
	slot3, slot4 = RougeMapSkillCheckHelper.canUseMapSkill(slot2)

	if slot3 then
		RougeRpc.instance:sendRougeUseMapSkillRequest(RougeModel.instance:getSeason(), slot2.id, function (slot0, slot1)
			if slot1 ~= 0 then
				return
			end

			uv0:_updateUI()
			uv0:_shrinkDetailUI()
			RougeMapSkillCheckHelper.executeUseMapSkillCallBack(uv1)
		end)
	else
		RougeMapSkillCheckHelper.showCantUseMapSkillToast(slot4)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayDealTouch, slot0)
	TaskDispatcher.cancelTask(slot0._setState, slot0)

	for slot4, slot5 in ipairs(slot0._detailClick) do
		slot5:RemoveClickListener()
	end

	for slot4, slot5 in ipairs(slot0._entryBtnClick) do
		slot5:RemoveClickListener()
	end

	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)
	RougeController.instance:unregisterCallback(RougeEvent.OnUpdateRougeInfoPower, slot0._onUpdateRougeInfoPower, slot0)
	RougeController.instance:unregisterCallback(RougeEvent.OnUpdateRougeInfo, slot0._onUpdateRougeInfo, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onUpdateMapInfo, slot0._onUpdateMapInfo, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, slot0._onChangeMapInfo, slot0)
end

return slot0
