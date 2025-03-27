module("modules.logic.versionactivity2_4.pinball.entity.PinballBuildingEntity", package.seeall)

slot0 = class("PinballBuildingEntity", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
	slot0._effect = gohelper.create3d(slot1, "effect")

	gohelper.setActive(slot0._effect, false)
	PrefabInstantiate.Create(slot0._effect):startLoad("scenes/v2a4_m_s12_ttsz_jshd/prefab/vx_building.prefab")
end

function slot0.initCo(slot0, slot1)
	slot0.co = slot1
	slot2 = string.splitToNumber(slot0.co.pos, "#") or {}

	transformhelper.setLocalPosXY(slot0.trans, slot2[1] or 0, slot2[2] or 0)
	slot0:checkLoadRes(true)
end

function slot0.setUI(slot0, slot1)
	slot0.ui = slot1
	slot0._uiFollower = gohelper.onceAddComponent(slot1, typeof(ZProj.UIFollower))

	slot0._uiFollower:Set(CameraMgr.instance:getMainCamera(), CameraMgr.instance:getUICamera(), ViewMgr.instance:getUIRoot().transform, slot0.trans, 0, 0, 0, 0, 0)
	slot0._uiFollower:SetEnable(true)

	slot0._gonormal = gohelper.findChild(slot1, "#go_normal")
	slot0._gomain = gohelper.findChild(slot1, "#go_main")
	slot0._goopers = gohelper.findChild(slot1, "#go_opers")
	slot0._gocanupgrade = gohelper.findChild(slot1, "#go_normal/#go_arrow")
	slot0._gocanupgrade2 = gohelper.findChild(slot1, "#go_opers/#btn_upgrade/go_reddot")
	slot0._gotalentred = gohelper.findChild(slot1, "#go_opers/#btn_talent/go_reddot")
	slot0._btnRemove = gohelper.findChildButtonWithAudio(slot1, "#go_opers/#btn_remove")
	slot0._btnUpgrade = gohelper.findChildButtonWithAudio(slot1, "#go_opers/#btn_upgrade")
	slot0._btnUpgradeMax = gohelper.findChildButtonWithAudio(slot1, "#go_opers/#btn_check")
	slot0._btnTalent = gohelper.findChildButtonWithAudio(slot1, "#go_opers/#btn_talent")
	slot0._btnClickThis = gohelper.findChildButtonWithAudio(slot1, "")
	slot0._gooperbigbg = gohelper.findChild(slot1, "#go_opers/circle_big")
	slot0._goopersmallbg = gohelper.findChild(slot1, "#go_opers/circle_small")
	slot0._normalLv = gohelper.findChildTextMesh(slot1, "#go_normal/#txt_lv")
	slot0._mainCityLv = gohelper.findChildTextMesh(slot1, "#go_main/#txt_lv")
	slot0._mainCityNum = gohelper.findChildTextMesh(slot1, "#go_main/#txt_num")
	slot0._mainCitySlider0 = gohelper.findChildImage(slot1, "#go_main/#go_slider/#go_slider0")
	slot0._mainCitySlider1 = gohelper.findChildImage(slot1, "#go_main/#go_slider/#go_slider1")
	slot0._mainCitySlider2 = gohelper.findChildImage(slot1, "#go_main/#go_slider/#go_slider2")
	slot0._mainCitySlider3 = gohelper.findChildImage(slot1, "#go_main/#go_slider/#go_slider3")
	slot0._mainCitySlider4 = gohelper.findChildImage(slot1, "#go_main/#go_slider/#go_slider4")
	slot0._goFood = gohelper.findChildAnim(slot1, "#go_food")
	slot0._txtFoodNum = gohelper.findChildTextMesh(slot1, "#go_food/#txt_num")
	slot0._goDialog = gohelper.findChild(slot1, "#go_dialog")
	slot0._txtunlock = gohelper.findChildTextMesh(slot1, "#txt_unlock")

	slot0:addClickCb(slot0._btnRemove, slot0._onRemoveClick, slot0)
	slot0:addClickCb(slot0._btnUpgrade, slot0._onUpgradeClick, slot0)
	slot0:addClickCb(slot0._btnUpgradeMax, slot0._onUpgradeClick, slot0)
	slot0:addClickCb(slot0._btnTalent, slot0._onTalentClick, slot0)
	slot0:addClickCb(slot0._btnClickThis, slot0._guideClick, slot0)
	gohelper.setActive(slot0._gooperbigbg, slot0.co.size == 4)
	gohelper.setActive(slot0._goopersmallbg, slot0.co.size == 1)
	recthelper.setAnchorY(slot0._txtunlock.transform, slot0.co.size == 1 and -50 or -78)
	slot0:_refreshUI()
	slot0:_onTalentRedChange()
end

function slot0._guideClick(slot0)
	if slot0:_realClick() then
		PinballController.instance:dispatchEvent(PinballEvent.OnClickBuilding, slot1)
	end
end

function slot0.setUIScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.ui.transform, slot1, slot1, slot1)
end

function slot0.addEventListeners(slot0)
	PinballController.instance:registerCallback(PinballEvent.OnClickBuilding, slot0._onClickBuilding, slot0)
	PinballController.instance:registerCallback(PinballEvent.AddBuilding, slot0._buildingUpdate, slot0)
	PinballController.instance:registerCallback(PinballEvent.UpgradeBuilding, slot0._buildingUpdate, slot0)
	PinballController.instance:registerCallback(PinballEvent.RemoveBuilding, slot0._buildingUpdate, slot0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, slot0._refreshMainCityUI, slot0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, slot0._refreshCanUpgrade, slot0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, slot0._refreshHoleLock, slot0)
	PinballController.instance:registerCallback(PinballEvent.EndRound, slot0._refreshUI, slot0)
	PinballController.instance:registerCallback(PinballEvent.GetReward, slot0._onGetReward, slot0)
	PinballController.instance:registerCallback(PinballEvent.TalentRedChange, slot0._onTalentRedChange, slot0)
end

function slot0.removeEventListeners(slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OnClickBuilding, slot0._onClickBuilding, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.AddBuilding, slot0._buildingUpdate, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.UpgradeBuilding, slot0._buildingUpdate, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.RemoveBuilding, slot0._buildingUpdate, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, slot0._refreshMainCityUI, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, slot0._refreshCanUpgrade, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, slot0._refreshHoleLock, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.EndRound, slot0._refreshUI, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.GetReward, slot0._onGetReward, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.TalentRedChange, slot0._onTalentRedChange, slot0)
end

function slot0._buildingUpdate(slot0, slot1)
	if slot1 ~= slot0.co.index then
		return
	end

	slot0:_refreshUI()
	slot0:checkLoadRes()
end

function slot0._refreshUI(slot0)
	gohelper.setActive(slot0._gomain, slot0:isMainCity())
	gohelper.setActive(slot0._gonormal, not slot0:isEmpty() and not slot0:isMainCity())
	gohelper.setActive(slot0._btnTalent, slot0:isTalent())
	gohelper.setActive(slot0._goopers, false)

	if slot0:getInfo() then
		if slot0:isMainCity() then
			slot0:_refreshMainCityUI()
		else
			slot0._normalLv.text = slot1.level
		end

		slot3 = GameUtil.splitString2(slot1.baseCo.uiOffset, true) or {}

		recthelper.setAnchor(slot0._gonormal.transform, slot3[1][1], slot3[1][2])
		recthelper.setAnchor(slot0._goopers.transform, slot3[2][1], slot3[2][2])
		recthelper.setAnchor(slot0._goFood.transform, slot3[3][1], slot3[3][2])
		recthelper.setAnchor(slot0._goDialog.transform, slot3[3][1], slot3[3][2])
		gohelper.setActive(slot0._btnRemove, slot1.co.destory)
		gohelper.setActive(slot0._goFood, slot1.food > 0)
		gohelper.setActive(slot0._goDialog, slot1.interact > 0)
		gohelper.setActive(slot0._btnUpgrade, slot1.nextCo)
		gohelper.setActive(slot0._btnUpgradeMax, not slot1.nextCo)

		if slot1.food > 0 then
			slot0._txtFoodNum.text = slot1.food
		end
	else
		gohelper.setActive(slot0._btnRemove, false)
		gohelper.setActive(slot0._goFood, false)
		gohelper.setActive(slot0._goDialog, false)
	end

	slot0:_refreshCanUpgrade()
	slot0:_refreshHoleLock()
end

function slot0._refreshCanUpgrade(slot0)
	slot1 = true

	if slot0:getInfo() and slot2.nextCo then
		if not string.nilorempty(slot3.condition) then
			for slot9, slot10 in pairs(GameUtil.splitString2(slot4, true)) do
				if slot10[1] == PinballEnum.ConditionType.Talent then
					if not PinballModel.instance:getTalentMo(slot10[2]) then
						slot1 = false

						break
					end
				elseif slot11 == PinballEnum.ConditionType.Score and PinballModel.instance.maxProsperity < slot10[2] then
					slot1 = false

					break
				end
			end
		end

		if slot1 and not string.nilorempty(slot3.cost) then
			for slot10, slot11 in pairs(GameUtil.splitString2(slot5, true)) do
				if PinballModel.instance:getResNum(slot11[1]) < slot11[2] then
					slot1 = false

					break
				end
			end
		end
	else
		slot1 = false
	end

	gohelper.setActive(slot0._gocanupgrade, slot1)
	gohelper.setActive(slot0._gocanupgrade2, slot1)
end

function slot0._onTalentRedChange(slot0)
	if not slot0:isTalent() then
		return
	end

	gohelper.setActive(slot0._gotalentred, PinballModel.instance:getTalentRed(slot0:getInfo().baseCo.id))
end

function slot0._refreshHoleLock(slot0)
	slot1 = nil

	if slot0:isEmpty() and PinballModel.instance.maxProsperity < slot0.co.condition then
		slot1 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot2)
	end

	gohelper.setActive(slot0._txtunlock, slot1)

	if slot1 then
		slot0._txtunlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_unlock"), slot1)
	end

	if slot0:isEmpty() then
		slot0:checkLoadRes(true)
	end
end

function slot0.getEmptyPath(slot0)
	slot1 = nil

	return PinballModel.instance.maxProsperity < slot0.co.condition and (slot0.co.size == 1 and "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_3.prefab" or "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_4.prefab") or slot0.co.size == 1 and "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_1.prefab" or "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_2.prefab"
end

function slot0._refreshMainCityUI(slot0)
	slot0._mainCityLv.text, slot2, slot3 = PinballModel.instance:getScoreLevel()
	slot4, slot5 = PinballModel.instance:getResNum(PinballEnum.ResType.Score)
	slot6 = 0
	slot7 = 0
	slot8 = 0

	if slot5 == slot4 then
		slot0._mainCityNum.text = string.format("%d/%d", slot4, slot3)

		if slot3 == slot2 then
			slot7 = 1
		else
			slot7 = (slot4 - slot2) / (slot3 - slot2)
		end
	else
		slot0._mainCityNum.text = string.format("%d<color=%s>(%+d)</color>/%d", slot4, slot4 < slot5 and "#BCFF85" or "#FC8A6A", slot5 - slot4, slot3)

		if slot4 < slot5 then
			if slot3 == slot2 then
				slot7 = 1
			else
				slot6 = (slot5 - slot2) / (slot3 - slot2)
				slot7 = (slot4 - slot2) / (slot3 - slot2)

				if slot3 < slot5 then
					slot9, slot10, slot11 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot5)
					slot8 = (slot5 - slot10) / (slot11 - slot10)
				end
			end
		elseif slot2 <= slot5 then
			slot6 = (slot4 - slot2) / (slot3 - slot2)
			slot7 = (slot5 - slot2) / (slot3 - slot2)
		else
			slot9, slot10, slot11 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot5)
			slot6 = 1
			slot7 = (slot5 - slot10) / (slot11 - slot10)
			slot8 = (slot4 - slot2) / (slot3 - slot2)
		end
	end

	slot0._mainCitySlider0.fillAmount = slot6
	slot0._mainCitySlider1.fillAmount = slot6
	slot0._mainCitySlider2.fillAmount = slot7
	slot0._mainCitySlider3.fillAmount = slot8
	slot0._mainCitySlider4.fillAmount = slot8

	gohelper.setActive(slot0._mainCitySlider0, slot5 < slot4)
	gohelper.setActive(slot0._mainCitySlider4, slot5 < slot4)
	gohelper.setActive(slot0._mainCitySlider1, slot4 < slot5)
	gohelper.setActive(slot0._mainCitySlider3, slot4 < slot5)
end

function slot0.checkLoadRes(slot0, slot1)
	slot3 = ""

	if PrefabInstantiate.Create(slot0.go):getPath() == ((slot0:isEmpty() or string.format("scenes/v2a4_m_s12_ttsz_jshd/prefab/%s.prefab", slot0:getInfo().baseCo.res)) and slot0:getEmptyPath()) then
		return
	end

	slot2:dispose()
	slot2:startLoad(slot3)

	if not slot0:isEmpty() and not slot1 then
		gohelper.setActive(slot0._effect, false)
		gohelper.setActive(slot0._effect, true)
		TaskDispatcher.cancelTask(slot0._hideEffect, slot0)
		TaskDispatcher.runDelay(slot0._hideEffect, slot0, 3)
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio4)

		PinballModel.instance.guideHole = slot0.co.index

		if slot0:isTalent() then
			PinballController.instance:dispatchEvent(PinballEvent.GuideBuildTalent)
		else
			PinballController.instance:dispatchEvent(PinballEvent.GuideBuildHouse)
		end
	end
end

function slot0._hideEffect(slot0)
	gohelper.setActive(slot0._effect, false)
end

function slot0._onClickBuilding(slot0, slot1)
	gohelper.setActive(slot0._goopers, slot1 == slot0.co.index)

	if slot1 == slot0.co.index then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio2)
	end
end

function slot0.isMainCity(slot0)
	return slot0:getInfo() and slot1:isMainCity()
end

function slot0.isTalent(slot0)
	return slot0:getInfo() and slot1:isTalent()
end

function slot0.isEmpty(slot0)
	return not slot0:getInfo()
end

function slot0._onRemoveClick(slot0)
	PinballController.instance:removeBuilding(slot0.co.index)
end

function slot0._onUpgradeClick(slot0)
	ViewMgr.instance:openView(ViewName.PinballUpgradeView, {
		index = slot0.co.index
	})
end

function slot0._onTalentClick(slot0)
	if not slot0:getInfo() then
		return
	end

	ViewMgr.instance:openView(ViewName.PinballTalentView, {
		index = slot0.co.index,
		info = slot0:getInfo()
	})
end

function slot0._onFoodClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	Activity178Rpc.instance:sendAct178GetReward(VersionActivity2_4Enum.ActivityId.Pinball, 0)
end

function slot0._onGetReward(slot0, slot1)
	if slot1 == 0 or slot1 == slot0.co.index then
		slot0._goFood:Play("click", 0, 0)
		TaskDispatcher.cancelTask(slot0._refreshUI, slot0)
		TaskDispatcher.runDelay(slot0._refreshUI, slot0, 1.167)
	end
end

function slot0._onDialogClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	Activity178Rpc.instance:sendAct178Interact(VersionActivity2_4Enum.ActivityId.Pinball, slot0.co.index, slot0.triggerDialog, slot0)
end

function slot0.triggerDialog(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	if not slot0:getInfo() then
		return
	end

	TipDialogController.instance:openTipDialogView(slot4.interact)

	slot4.interact = 0

	slot0:_refreshUI()
end

function slot0.getInfo(slot0)
	return PinballModel.instance:getBuildingInfo(slot0.co.index)
end

function slot0.tryClick(slot0, slot1, slot2)
	slot3 = slot0.trans.position - slot1
	slot4 = 2

	if slot0.co.size == 4 then
		slot4 = 4
	end

	if math.abs(slot3.x) < slot4 * slot2 and math.abs(slot3.y) < slot4 then
		return slot0:_realClick()
	end
end

function slot0._realClick(slot0)
	if slot0:isMainCity() then
		if slot0:getInfo().interact > 0 then
			slot0:_onDialogClick()
		end

		return
	end

	if slot0:isEmpty() then
		if PinballModel.instance.maxProsperity < slot0.co.condition then
			GameFacade.showToast(ToastEnum.Act178ScoreCondition, PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot2))

			return
		end

		ViewMgr.instance:openView(ViewName.PinballBuildView, {
			index = slot0.co.index,
			size = slot0.co.size
		})
	else
		slot2 = nil

		if slot1.food > 0 then
			slot0:_onFoodClick()
		elseif slot1.interact > 0 then
			slot0:_onDialogClick()
		elseif not slot0._goopers.activeSelf then
			slot2 = slot0.co.index
		end

		return slot2
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._hideEffect, slot0)
	TaskDispatcher.cancelTask(slot0._refreshUI, slot0)
end

return slot0
