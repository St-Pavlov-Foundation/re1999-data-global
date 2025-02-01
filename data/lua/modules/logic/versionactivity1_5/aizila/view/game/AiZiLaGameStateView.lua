module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameStateView", package.seeall)

slot0 = class("AiZiLaGameStateView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnfullClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fullClose")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#txt_Title")
	slot0._gostateItem = gohelper.findChild(slot0.viewGO, "#go_stateItem")
	slot0._goState = gohelper.findChild(slot0.viewGO, "#go_stateItem/#go_State")
	slot0._goeffdown = gohelper.findChild(slot0.viewGO, "#go_stateItem/#go_State/#go_effdown")
	slot0._goeffup = gohelper.findChild(slot0.viewGO, "#go_stateItem/#go_State/#go_effup")
	slot0._txteffDesc = gohelper.findChildText(slot0.viewGO, "#go_stateItem/#go_State/#txt_effDesc")
	slot0._scrollequip = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_equip")
	slot0._goEquip = gohelper.findChild(slot0.viewGO, "#scroll_equip/Viewport/Content/#go_Equip")
	slot0._goequipState = gohelper.findChild(slot0.viewGO, "#scroll_equip/Viewport/Content/#go_equipState")
	slot0._goEffect = gohelper.findChild(slot0.viewGO, "#scroll_equip/Viewport/Content/#go_Effect")
	slot0._gogameState = gohelper.findChild(slot0.viewGO, "#scroll_equip/Viewport/Content/#go_gameState")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfullClose:AddClickListener(slot0._btnfullCloseOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfullClose:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnfullCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	transformhelper.setLocalPos(slot0._gostateItem.transform, 0, 0, 0)
	gohelper.setActive(slot0._gostateItem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0.closeThis, slot0)
	end

	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, slot0.closeThis, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshUI(slot0)
	slot2 = slot0:_getGameStateDataList()

	gohelper.setActive(slot0._goEquip, slot0:_getEquipStateDataList() and #slot1 > 0)
	gohelper.setActive(slot0._goEffect, slot2 and #slot2 > 0)
	gohelper.CreateObjList(slot0, slot0._onEquipStateItem, slot1, slot0._goequipState, slot0._gostateItem, AiZiLaGameStateItem)
	gohelper.CreateObjList(slot0, slot0._onGameStateItem, slot2, slot0._gogameState, slot0._gostateItem, AiZiLaGameStateItem)
end

function slot0._getEquipStateDataList(slot0)
	slot1 = {}

	tabletool.addValues(slot1, AiZiLaModel.instance:getEquipMOList())

	return slot1
end

function slot0._getGameStateDataList(slot0)
	slot1 = {}

	for slot8, slot9 in ipairs(AiZiLaGameModel.instance:getBuffIdList() or {}) do
		if AiZiLaConfig.instance:getBuffCo(AiZiLaGameModel.instance:getActivityID(), slot9) then
			table.insert(slot1, slot10)
		else
			logError(string.format("[export_状态] buff配置找不到。 activityId:%s buffId:%s", slot3, slot9))
		end
	end

	return slot1
end

function slot0._onEquipStateItem(slot0, slot1, slot2, slot3)
	if slot2:getConfig() then
		slot1:setStateStr(GameUtil.getSubPlaceholderLuaLang(luaLang("v1a5_aizila_role_state_effect_desc"), {
			slot5.name,
			slot5.effectDesc
		}))
	end

	slot1:setShowUp(true)
end

function slot0._onGameStateItem(slot0, slot1, slot2, slot3)
	if slot2 then
		slot1:setStateStr(slot4.effectDesc)
		slot1:setShowUp(slot4.reduction ~= 1)
	end
end

return slot0
