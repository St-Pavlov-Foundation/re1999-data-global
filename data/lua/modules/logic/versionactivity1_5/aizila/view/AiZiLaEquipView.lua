module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEquipView", package.seeall)

slot0 = class("AiZiLaEquipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG")
	slot0._goequipitem = gohelper.findChild(slot0.viewGO, "Left/Sticker1/#go_equipitem")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Right/#txt_Title")
	slot0._txtEffect = gohelper.findChildText(slot0.viewGO, "Right/#txt_Effect")
	slot0._txtNextEffect = gohelper.findChildText(slot0.viewGO, "Right/#txt_Effect/#txt_NextEffect")
	slot0._goLv = gohelper.findChild(slot0.viewGO, "Right/#go_Lv")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "Right/#go_Lv/#txt_level")
	slot0._txtnextlevel = gohelper.findChildText(slot0.viewGO, "Right/#go_Lv/#txt_nextlevel")
	slot0._scrolluplevelItem = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_Lv/#scroll_uplevelItem")
	slot0._gouplevelItems = gohelper.findChild(slot0.viewGO, "Right/#go_Lv/#scroll_uplevelItem/Viewport/#go_uplevelItems")
	slot0._btnuplevel = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Lv/Btn/#btn_uplevel")
	slot0._goRedPoint = gohelper.findChild(slot0.viewGO, "Right/#go_Lv/Btn/#btn_uplevel/#go_RedPoint")
	slot0._btnunUplevel = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Lv/Btn/#btn_unUplevel")
	slot0._goLvMax = gohelper.findChild(slot0.viewGO, "Right/#go_LvMax")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnuplevel:AddClickListener(slot0._btnuplevelOnClick, slot0)
	slot0._btnunUplevel:AddClickListener(slot0._btnunUplevelOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnuplevel:RemoveClickListener()
	slot0._btnunUplevel:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
end

function slot0._btnuplevelOnClick(slot0)
	if slot0._isLockUpLevel then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaUpLevelInGame)

		return
	end

	if (slot0._equipCfg or slot0._nextEquipCfg) and slot1.equipId and not slot0:_isLockType(slot1.typeId) then
		slot0:_setLockType(slot1.typeId, 0.5)
		Activity144Rpc.instance:sendAct144UpgradeEquipRequest(slot0._actId, slot1.equipId)
	end
end

function slot0._btnunUplevelOnClick(slot0)
	GameFacade.showToast(slot0._isLockUpLevel and ToastEnum.V1a5AiZiLaUpLevelInGame or ToastEnum.V1a5AiZiLaUpLevelItemLack)
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	slot5 = AiZiLaEnum.ComponentType.Animator
	slot0._animatorRight = gohelper.findChildComponent(slot0.viewGO, "Right", slot5)
	slot0._equipItemList = {}
	slot0._actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	slot4 = slot0._actId
	slot0._equipCoTypeList = AiZiLaConfig.instance:getEquipCoTypeList(slot4)
	slot0._upLevelNextTimeDic = {}

	for slot4, slot5 in ipairs(slot0._equipCoTypeList) do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._goequipitem, gohelper.findChild(slot0.viewGO, "Left/Sticker" .. slot4), "go_equipitem"), AiZiLaEquipItem, slot0)

		if slot0._selectTypeId == nil then
			slot0._selectTypeId = slot5.typeId
		end

		slot8:setCfg(slot5)
		table.insert(slot0._equipItemList, slot8)
	end

	gohelper.setActive(slot0._goequipitem, false)

	slot0._goodsItemGo = slot0:getResInst(AiZiLaGoodsItem.prefabPath2, slot0.viewGO)

	gohelper.setActive(slot0._goodsItemGo, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._isLockUpLevel = ViewMgr.instance:isOpen(ViewName.AiZiLaGameView)

	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0.closeThis, slot0)
	end

	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.UISelectEquipType, slot0._onSelectEquitType, slot0)
	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.OnEquipUpLevel, slot0._onEquipUpLevel, slot0)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper2)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayRefreshUI, slot0)
end

function slot0._onEquipUpLevel(slot0, slot1)
	if AiZiLaConfig.instance:getEquipCo(AiZiLaModel.instance:getCurActivityID(), slot1) then
		if slot0._selectTypeId == slot3.typeId and slot0._animatorRight then
			slot0:_refreshData()

			if not slot0._isDelayRefreshUIIng then
				slot0._isDelayRefreshUIIng = true

				slot0._animatorRight:Play("refresh", 0, 0)
				slot0:_setLockType(slot3.typeId, 0.53)
				TaskDispatcher.runDelay(slot0._onDelayRefreshUI, slot0, 0.5)
				AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_equip_update)
			end
		else
			slot0:refreshUI()
		end

		slot0:_refreshEquipItemUpLevel(slot3.typeId)
	else
		slot0:refreshUI()
	end
end

function slot0._onDelayRefreshUI(slot0)
	slot0._isDelayRefreshUIIng = false

	slot0:refreshUI()
end

function slot0._onSelectEquitType(slot0, slot1)
	slot0._selectTypeId = slot1

	slot0:refreshUI()
end

function slot0._refreshData(slot0)
	slot0._selectEquipMO = AiZiLaModel.instance:getEquipMO(slot0._selectTypeId)

	if slot0._selectEquipMO then
		slot0._equipCfg = slot0._selectEquipMO:getConfig()
		slot0._nextEquipCfg = slot0._selectEquipMO:getNextConfig()
		slot0._costparams = slot0._selectEquipMO:getCostParams()
	else
		slot0._equipCfg = nil
		slot0._nextEquipCfg = slot0:_findInitCfg(slot0._selectTypeId)
		slot0._costparams = AiZiLaHelper.getCostParams(slot0._nextEquipCfg)
	end
end

function slot0.refreshUI(slot0)
	slot0:_refreshData()

	slot1 = false

	if slot0._selectEquipMO then
		slot1 = slot0._selectEquipMO:isMaxLevel()
		slot0._txtlevel.text = formatLuaLang("v1a5_aizila_level", slot0._equipCfg.level)
		slot0._txtEffect.text = formatLuaLang("v1a5_aizila_equip_effect", slot0._equipCfg.effectDesc)
		slot0._txtTitle.text = slot0._equipCfg.name
	else
		slot0._txtlevel.text = luaLang("v1a5_aizila_nolevel")
		slot0._txtEffect.text = luaLang("v1a5_aizila_equip_noeffect")
		slot0._txtTitle.text = slot0._nextEquipCfg.name
	end

	if not slot1 then
		slot0._txtnextlevel.text = formatLuaLang("v1a5_aizila_level", slot0._nextEquipCfg.level)
		slot0._txtNextEffect.text = formatLuaLang("v1a5_aizila_equip_effect_nextlv", slot0._nextEquipCfg.effectDesc)
		slot2 = not slot0._isLockUpLevel and AiZiLaHelper.checkCostParams(slot0._costparams)

		gohelper.setActive(slot0._btnuplevel, slot2)
		gohelper.setActive(slot0._btnunUplevel, not slot2)
		RedDotController.instance:addRedDot(slot0._goRedPoint, RedDotEnum.DotNode.V1a5AiZiLaEquipUpLevel, slot0._selectTypeId)
	end

	gohelper.setActive(slot0._goLvMax, slot1)
	gohelper.setActive(slot0._goLv, not slot1)
	gohelper.setActive(slot0._txtnextlevel, not slot1)
	gohelper.setActive(slot0._txtNextEffect, not slot1)
	gohelper.CreateObjList(slot0, slot0._onShowUplevelItem, slot0._costparams, slot0._gouplevelItems, slot0._goodsItemGo, AiZiLaGoodsItem)
	slot0:_refreshEquipItem()
end

function slot0._onShowUplevelItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)

	if slot1._isUpLevelInit ~= true then
		slot1._isUpLevelInit = true

		slot1:setShowCount(true, false)
	end

	slot1:setCountStr(string.format("<color=%s>%s</color><color=#3C322B>/%s</color>", AiZiLaModel.instance:getItemQuantity(slot2.itemId) < slot2.itemNum and "#de4618" or "#4a7900", slot5, slot4))
end

function slot0._findInitCfg(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._equipCoTypeList) do
		if slot6.typeId == slot1 then
			return slot6
		end
	end
end

function slot0._refreshEquipItem(slot0)
	for slot4, slot5 in ipairs(slot0._equipItemList) do
		slot5:onSelect(slot5:getTypeId() == slot0._selectTypeId)
		slot5:refreshUI(slot0._isLockUpLevel)
	end
end

function slot0._refreshEquipItemUpLevel(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._equipItemList) do
		if slot6:getTypeId() == slot1 then
			slot6:refreshUpLevel()
		end
	end
end

function slot0.playViewAnimator(slot0, slot1)
	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0._isLockType(slot0, slot1)
	if slot1 and slot0._upLevelNextTimeDic[slot1] and Time.time < slot0._upLevelNextTimeDic[slot1] then
		return true
	end

	return false
end

function slot0._setLockType(slot0, slot1, slot2)
	if slot1 and slot2 then
		slot0._upLevelNextTimeDic[slot1] = Time.time + slot2
	end
end

return slot0
