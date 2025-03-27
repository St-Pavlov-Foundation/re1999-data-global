module("modules.logic.versionactivity2_4.pinball.view.PinballUpgradeView", package.seeall)

slot0 = class("PinballUpgradeView", BaseView)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildSingleImage(slot0.viewGO, "#image_icon")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "#txt_buildingname")
	slot0._txttitle = gohelper.findChildTextMesh(slot0.viewGO, "#scroll_dec/Viewport/Content/#txt_title")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "#scroll_dec/Viewport/Content/#txt_dec")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnremove = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_remove")
	slot0._goupgrade = gohelper.findChild(slot0.viewGO, "#go_upgrade")
	slot0._btnupgrade = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_upgrade/#btn_upgrade")
	slot0._btnupgradeEffect = gohelper.findChild(slot0.viewGO, "#go_upgrade/#btn_upgrade/vx_ink")
	slot0._txtnowlv = gohelper.findChildTextMesh(slot0.viewGO, "#go_upgrade/#txt_nowLv")
	slot0._txtnextlv = gohelper.findChildTextMesh(slot0.viewGO, "#go_upgrade/#txt_nextLv")
	slot0._gomax = gohelper.findChild(slot0.viewGO, "#go_max")
	slot0._txtmaxlv = gohelper.findChildTextMesh(slot0.viewGO, "#go_max/#txt_lv")
	slot0._gocostitem = gohelper.findChild(slot0.viewGO, "#go_upgrade/#go_currency/go_item")
	slot0._gopreviewitem = gohelper.findChild(slot0.viewGO, "#go_preview/#go_group/go_item")
	slot0._gopreviewtitle = gohelper.findChild(slot0.viewGO, "#go_preview/txt_preview")
	slot0._topCurrencyRoot = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "vx_upgrade")
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnremove:AddClickListener(slot0.removeBuilding, slot0)
	slot0._btnupgrade:AddClickListener(slot0.upgradeBuilding, slot0)
	PinballController.instance:registerCallback(PinballEvent.UpgradeBuilding, slot0._buildingUpdate, slot0)
	PinballController.instance:registerCallback(PinballEvent.RemoveBuilding, slot0._buildingRemove, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnremove:RemoveClickListener()
	slot0._btnupgrade:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.UpgradeBuilding, slot0._buildingUpdate, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.RemoveBuilding, slot0._buildingRemove, slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio3)
	slot0:createCurrencyItem()
	slot0:_refreshBuilding()
end

function slot0._refreshBuilding(slot0)
	if not PinballModel.instance:getBuildingInfo(slot0.viewParam.index) then
		return
	end

	slot3 = slot1.nextCo

	slot0._imageicon:LoadImage(string.format("singlebg/v2a4_tutushizi_singlebg/building/%s.png", slot1.baseCo.icon))

	slot0._txtname.text = slot1.baseCo.name
	slot0._txttitle.text = slot1.baseCo.desc
	slot0._txtdesc.text = slot1.baseCo.desc2

	gohelper.setActive(slot0._gomax, not slot3)
	gohelper.setActive(slot0._goupgrade, slot3)
	gohelper.setActive(slot0._gopreviewtitle, slot3)
	gohelper.setActive(slot0._btnremove, slot1.co.destory)

	if slot3 then
		slot0._txtnowlv.text = slot2.level
		slot0._txtnextlv.text = slot3.level

		slot0:updateCost(slot3)

		slot4 = slot0._costNoEnough and true or slot0:checkLock(slot3) or false

		ZProj.UGUIHelper.SetGrayscale(slot0._btnupgrade.gameObject, slot4)
		gohelper.setActive(slot0._btnupgradeEffect, not slot4)
	else
		slot0._txtmaxlv.text = slot2.level
	end

	slot0:updatePreview(slot2, slot3)
end

function slot0.createCurrencyItem(slot0)
	for slot5, slot6 in ipairs({
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.currency, slot0._topCurrencyRoot), PinballCurrencyItem):setCurrencyType(slot6)
	end
end

function slot0.updatePreview(slot0, slot1, slot2)
	slot3 = {}
	slot5 = {}

	if not string.nilorempty(slot1.effect) then
		for slot10, slot11 in pairs(GameUtil.splitString2(slot4, true)) do
			if slot11[1] == PinballEnum.BuildingEffectType.AddScore then
				table.insert(slot3, {
					resType = PinballEnum.ResType.Score,
					value = slot11[2]
				})

				slot5[slot11[1]] = #slot3
			elseif slot11[1] == PinballEnum.BuildingEffectType.AddFood then
				table.insert(slot3, {
					resType = PinballEnum.ResType.Food,
					value = slot11[2]
				})

				slot5[slot11[1]] = #slot3
			elseif slot11[1] == PinballEnum.BuildingEffectType.AddPlay then
				table.insert(slot3, {
					resType = PinballEnum.ResType.Play,
					value = slot11[2]
				})

				slot5[slot11[1]] = #slot3
			elseif slot11[1] == PinballEnum.BuildingEffectType.CostFood then
				table.insert(slot3, {
					resType = PinballEnum.ResType.Food,
					value = slot11[2],
					text = luaLang("pinball_food_need")
				})

				slot5[slot11[1]] = #slot3
			elseif slot11[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				table.insert(slot3, {
					resType = PinballEnum.ResType.Play,
					value = slot11[2],
					text = luaLang("pinball_play_need")
				})

				slot5[slot11[1]] = #slot3
			end
		end
	end

	if slot2 and not string.nilorempty(slot2.effect) then
		for slot10, slot11 in pairs(GameUtil.splitString2(slot4, true)) do
			if slot11[1] == PinballEnum.BuildingEffectType.AddScore then
				if slot5[slot11[1]] then
					slot3[slot12].nextVal = slot11[2]
				else
					table.insert(slot3, {
						resType = PinballEnum.ResType.Score,
						nextVal = slot11[2]
					})
				end
			elseif slot11[1] == PinballEnum.BuildingEffectType.AddFood then
				if slot5[slot11[1]] then
					slot3[slot12].nextVal = slot11[2]
				else
					table.insert(slot3, {
						resType = PinballEnum.ResType.Food,
						nextVal = slot11[2]
					})
				end
			elseif slot11[1] == PinballEnum.BuildingEffectType.AddPlay then
				if slot5[slot11[1]] then
					slot3[slot12].nextVal = slot11[2]
				else
					table.insert(slot3, {
						resType = PinballEnum.ResType.Play,
						nextVal = slot11[2]
					})
				end
			elseif slot11[1] == PinballEnum.BuildingEffectType.CostFood then
				if slot5[slot11[1]] then
					slot3[slot12].nextVal = slot11[2]
				else
					table.insert(slot3, {
						resType = PinballEnum.ResType.Food,
						nextVal = slot11[2],
						text = luaLang("pinball_food_need")
					})
				end
			elseif slot11[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				if slot5[slot11[1]] then
					slot3[slot12].nextVal = slot11[2]
				else
					table.insert(slot3, {
						resType = PinballEnum.ResType.Play,
						nextVal = slot11[2],
						text = luaLang("pinball_play_need")
					})
				end
			end
		end
	end

	for slot9, slot10 in pairs(slot3) do
		slot10.haveNext = slot2
	end

	slot0._goeffects = slot0._goeffects or slot0:getUserDataTb_()

	tabletool.clear(slot0._goeffects)
	gohelper.CreateObjList(slot0, slot0._createEffectItem, slot3, nil, slot0._gopreviewitem)
end

function slot0._createEffectItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildImage(slot1, "#image_icon")
	slot5 = gohelper.findChildTextMesh(slot1, "#txt_base")
	slot6 = gohelper.findChildTextMesh(slot1, "#txt_curnum")
	slot7 = gohelper.findChildTextMesh(slot1, "#txt_num")

	table.insert(slot0._goeffects, gohelper.findChild(slot1, "vx_eff"))

	if not lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot2.resType] then
		logError("资源配置不存在" .. slot2.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot4, slot9.icon)

	slot5.text = slot2.text or slot9.name

	if slot2.haveNext then
		slot6.text = string.format("%d", slot2.value or 0)

		if (slot2.nextVal or 0) - (slot2.value or 0) >= 0 then
			slot7.text = string.format("<color=#BCFF85>+%s", slot10)
		else
			slot7.text = string.format("<color=#FC8A6A>%s", slot10)
		end
	else
		slot6.text = ""
		slot7.text = string.format("%d", slot2.value)
	end
end

function slot0.updateCost(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1.cost) then
		for slot8, slot9 in pairs(GameUtil.splitString2(slot3, true)) do
			table.insert(slot2, {
				resType = slot9[1],
				value = slot9[2]
			})
		end
	end

	slot0._costNoEnough = nil

	gohelper.CreateObjList(slot0, slot0._createCostItem, slot2, nil, slot0._gocostitem)
end

function slot0.checkLock(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if string.nilorempty(slot1.condition) then
		return false
	end

	for slot8, slot9 in pairs(GameUtil.splitString2(slot3, true)) do
		if slot9[1] == PinballEnum.ConditionType.Talent then
			if not PinballModel.instance:getTalentMo(slot9[2]) then
				if slot2 then
					GameFacade.showToast(ToastEnum.Act178TalentCondition, lua_activity178_talent.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot11].name)
				end

				return true
			end
		elseif slot10 == PinballEnum.ConditionType.Score and PinballModel.instance.maxProsperity < slot9[2] then
			if slot2 then
				GameFacade.showToast(ToastEnum.Act178ScoreCondition, PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot11))
			end

			return true
		end
	end

	return false
end

function slot0._createCostItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildTextMesh(slot1, "#txt_num")
	slot5 = gohelper.findChildImage(slot1, "#txt_num/#image_icon")

	if not lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot2.resType] then
		logError("资源配置不存在" .. slot2.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot5, slot6.icon)

	slot7 = ""

	if PinballModel.instance:getResNum(slot2.resType) < slot2.value then
		slot7 = "<color=#FC8A6A>"
		slot0._costNoEnough = slot0._costNoEnough or slot6.name
	end

	slot4.text = string.format("%s-%d", slot7, slot2.value)
end

function slot0.removeBuilding(slot0)
	PinballController.instance:removeBuilding(slot0.viewParam.index)
end

function slot0.upgradeBuilding(slot0)
	if not PinballModel.instance:getBuildingInfo(slot0.viewParam.index) then
		return
	end

	if slot0._costNoEnough then
		GameFacade.showToast(ToastEnum.DiamondBuy, slot0._costNoEnough)

		return
	end

	if slot0:checkLock(slot1.nextCo, true) then
		return
	end

	Activity178Rpc.instance:sendAct178Build(VersionActivity2_4Enum.ActivityId.Pinball, slot1.configId, PinballEnum.BuildingOperType.Upgrade, slot0.viewParam.index)
end

function slot0._buildingUpdate(slot0, slot1)
	if slot1 == slot0.viewParam.index then
		gohelper.setActive(slot0._goeffect, false)
		gohelper.setActive(slot0._goeffect, true)

		for slot5, slot6 in pairs(slot0._goeffects) do
			gohelper.setActive(slot6, false)
			gohelper.setActive(slot6, true)
		end

		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio34)
		UIBlockMgr.instance:startBlock("PinballUpgradeView_Effect")
		TaskDispatcher.runDelay(slot0._effectEnd, slot0, 1)
	end
end

function slot0._effectEnd(slot0)
	UIBlockMgr.instance:endBlock("PinballUpgradeView_Effect")
	slot0:_refreshBuilding()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._effectEnd, slot0)
	UIBlockMgr.instance:endBlock("PinballUpgradeView_Effect")
end

function slot0._buildingRemove(slot0, slot1)
	if slot1 == slot0.viewParam.index then
		slot0:closeThis()
	end
end

return slot0
