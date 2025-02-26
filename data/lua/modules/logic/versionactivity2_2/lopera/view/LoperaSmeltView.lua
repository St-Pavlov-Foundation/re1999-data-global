module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltView", package.seeall)

slot0 = class("LoperaSmeltView", BaseView)
slot1 = LoperaEnum.MapCfgIdx
slot2 = VersionActivity2_2Enum.ActivityId.Lopera
slot3 = "<color=#21631a>%s</color>"
slot4 = 4
slot5 = 5
slot6 = 0.3

function slot0.onInitView(slot0)
	slot0._btnType1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/Tab/Tab1")
	slot0._btnType2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/Tab/Tab2")
	slot0._btnType3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/Tab/Tab3")
	slot0._goReddot1 = gohelper.findChild(slot0.viewGO, "Right/Tab/Tab1/#go_reddot")
	slot0._goReddot2 = gohelper.findChild(slot0.viewGO, "Right/Tab/Tab2/#go_reddot")
	slot0._goReddot3 = gohelper.findChild(slot0.viewGO, "Right/Tab/Tab3/#go_reddot")
	slot0._btnSmelt = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Smelt")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "Left/#scroll_List/Viewport/Content/#go_Item")
	slot0._goItemRoot = gohelper.findChild(slot0.viewGO, "Left/#scroll_List/Viewport/Content")
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._goItem, false)

	slot0._tipsGo = gohelper.findChild(slot0.viewGO, "Left/#go_Tips")
	slot0._tipsItemIcon = gohelper.findChildImage(slot0._tipsGo, "image_TipsBG/#image_Icon")
	slot0._tipsValueText = gohelper.findChildText(slot0._tipsGo, "image_TipsBG/#txt_PropDescr")
	slot0._tipsTypeText = gohelper.findChildText(slot0._tipsGo, "image_TipsBG/#txt_PropType")
	slot0._tipsNameText = gohelper.findChildText(slot0._tipsGo, "image_TipsBG/#txt_Prop")
	slot0._goFullCloseBg = gohelper.findChild(slot0.viewGO, "#btn_TipsClose")
	slot0._fullCloseBg = gohelper.findChildButton(slot0.viewGO, "#btn_TipsClose")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnSmelt:AddClickListener(slot0._onClickSmelt, slot0)
	slot0._btnType1:AddClickListener(slot0._onTabChange, slot0, 1)
	slot0._btnType2:AddClickListener(slot0._onTabChange, slot0, 2)
	slot0._btnType3:AddClickListener(slot0._onTabChange, slot0, 3)
	slot0._fullCloseBg:AddClickListener(slot0._closeTipsBtnClick, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.GoodItemClick, slot0._onClickItem, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.ComposeDone, slot0._onSmeltResult, slot0)

	slot0._redDot1Comp = RedDotController.instance:addNotEventRedDot(slot0._goReddot1, slot0._showRedDot1, slot0)
	slot0._redDot2Comp = RedDotController.instance:addNotEventRedDot(slot0._goReddot2, slot0._showRedDot2, slot0)
	slot0._redDot3Comp = RedDotController.instance:addNotEventRedDot(slot0._goReddot3, slot0._showRedDot3, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnSmelt:RemoveClickListener()
	slot0._btnType1:RemoveClickListener()
	slot0._btnType2:RemoveClickListener()
	slot0._btnType3:RemoveClickListener()
	slot0._fullCloseBg:RemoveClickListener()
end

function slot0._onClickSmelt(slot0)
	if LoperaController.instance:checkCanCompose(slot0._selectTabIdx) then
		LoperaController.instance:composeItem(slot0._selectTabIdx)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_youyu_alchemy_success)
	else
		GameFacade.showToast(ToastEnum.CharacterExSkill)
	end
end

function slot0._onTabChange(slot0, slot1, slot2)
	if slot0._selectTabIdx == slot1 then
		return
	end

	slot0._selectTabIdx = slot1

	if not slot2 then
		slot0._viewAnimator:Play(UIAnimationName.Switch, 0, 0)
	end

	TaskDispatcher.runDelay(slot0._doTabChangeRefresh, slot0, uv0)
end

function slot0._doTabChangeRefresh(slot0)
	slot0:refreshTabItems(slot0._selectTabIdx)
	slot0:refreshTabMaterials(slot0._selectTabIdx)
	slot0:refreshTabProducts(slot0._selectTabIdx)
	slot0:_refreshBtnState()
end

function slot0._closeTipsBtnClick(slot0)
	gohelper.setActive(slot0._tipsGo, false)
	gohelper.setActive(slot0._goFullCloseBg, false)
end

function slot0._editableInitView(slot0)
	slot0._tabStateGroup = {}

	for slot4 = 1, 3 do
		slot0._tabStateGroup[slot4] = slot0:getUserDataTb_()
		slot0._tabStateGroup[slot4].unSelect = gohelper.findChild(slot0.viewGO, string.format("Right/Tab/Tab%s/#go_UnSelect", slot4))
		slot0._tabStateGroup[slot4].select = gohelper.findChild(slot0.viewGO, string.format("Right/Tab/Tab%s/#go_Selected", slot4))
		slot0._tabStateGroup[slot4].txtUnSelect = gohelper.findChildText(slot0.viewGO, string.format("Right/Tab/Tab%s/#go_UnSelect/#txt_Tab", slot4))
		slot0._tabStateGroup[slot4].txtSelected = gohelper.findChildText(slot0.viewGO, string.format("Right/Tab/Tab%s/#go_Selected/#txt_Tab", slot4))
	end
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam
	slot0._selectTabIdx = -1
	slot0._defaultTab = 1

	slot0:_onTabChange(slot0._defaultTab, true)
	slot0:_refreshTabsTtile()
	slot0:refreshAllItems()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_uimIn_details_open)
end

function slot0.onExitGame(slot0)
	slot0:closeThis()
end

function slot0.refreshView(slot0)
	slot0:refreshTabItems(slot0._selectTabIdx)
	slot0:refreshTabMaterials(slot0._selectTabIdx)
	slot0:refreshTabProducts(slot0._selectTabIdx)
	slot0:refreshAllItems()
	slot0:_refreshRedDot()
end

function slot0.refreshAllItems(slot0)
	slot0._itemCfgList = Activity168Config.instance:getGameItemListCfg(uv0)

	table.sort(slot0._itemCfgList, slot0._itemListSort)
	gohelper.CreateObjList(slot0, slot0._createItem, slot0._itemCfgList, slot0._goItemRoot, slot0._goItem, LoperaGoodsItem)
end

function slot0._itemListSort(slot0, slot1)
	if Activity168Model.instance:getItemCount(slot0.itemId) == 0 and Activity168Model.instance:getItemCount(slot1.itemId) == 0 then
		return slot0.itemId < slot1.itemId
	elseif slot2 > 0 and slot3 == 0 then
		return true
	elseif slot2 == 0 and slot3 > 0 then
		return false
	elseif slot2 > 0 and slot3 > 0 then
		slot5 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. slot1.itemId, 0)

		if GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. slot0.itemId, 0) == 1 and slot5 == 0 then
			return false
		end

		if slot4 == 0 and slot5 == 1 then
			return true
		end

		if slot4 == slot5 then
			return slot0.itemId < slot1.itemId
		end
	end
end

function slot0._refreshTabsTtile(slot0)
	for slot5, slot6 in ipairs(Activity168Config.instance:getComposeTypeList(VersionActivity2_2Enum.ActivityId.Lopera)) do
		slot0._tabStateGroup[slot5].txtUnSelect.text = slot6.name
		slot0._tabStateGroup[slot5].txtSelected.text = slot6.name
	end
end

function slot0.refreshTabItems(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(Activity168Config.instance:getComposeTypeList(uv0)) do
		if slot8.composeType == slot1 then
			slot2 = slot8

			break
		end
	end
end

function slot0.refreshTabMaterials(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(Activity168Config.instance:getComposeTypeList(uv0)) do
		if slot8.composeType == slot1 then
			slot2 = slot8

			break
		end
	end

	slot4 = string.split(slot2.costItems, "|")

	for slot8 = 1, uv1 do
		slot9 = gohelper.findChild(slot0.viewGO, string.format("Right/Prop/Prop%s/#go_Have", slot8))
		slot10 = gohelper.findChild(slot0.viewGO, string.format("Right/Prop/Prop%s/#go_Empty", slot8))

		if slot8 <= #slot4 and slot4[slot8] or nil then
			slot12 = string.splitToNumber(slot11, "#")
			slot13 = slot12[1]
			slot15 = Activity168Config.instance:getGameItemCfg(uv0, slot13)

			UISpriteSetMgr.instance:setLoperaItemSprite(gohelper.findChildImage(slot9, "#image_Icon"), slot15.icon, false)

			gohelper.findChildText(slot9, "#txt_PropName").text = slot15.name
			gohelper.findChildText(slot9, "#txt_Num").text = string.format(uv2, Activity168Model.instance:getItemCount(slot13)) .. "/" .. slot12[2]
		end

		gohelper.setActive(slot10, slot11 == nil)
		gohelper.setActive(slot9, slot11 ~= nil)
	end
end

function slot0.refreshTabProducts(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(Activity168Config.instance:getComposeTypeList(uv0)) do
		if slot8.composeType == slot1 then
			slot2 = slot8

			break
		end
	end

	slot4 = Activity168Config.instance:getGameItemListCfg(uv0, slot1)

	for slot8 = 1, uv1 do
		slot9 = gohelper.findChild(slot0.viewGO, string.format("Right/Output/Prop%s/#go_Have", slot8))
		slot10 = gohelper.findChild(slot0.viewGO, string.format("Right/Output/Prop%s/#go_Empty", slot8))

		if slot8 <= #slot4 and slot4[slot8] or nil then
			UISpriteSetMgr.instance:setLoperaItemSprite(gohelper.findChildImage(slot9, "#image_Icon"), slot11.icon, false)

			gohelper.findChildText(slot9, "#txt_PropName").text = slot11.name
		end

		gohelper.setActive(slot10, slot11 == nil)
		gohelper.setActive(slot9, slot11 ~= nil)
	end
end

function slot0._refreshGoodItemTips(slot0, slot1)
	slot2 = slot0._itemCfgList[slot1]
	slot0._tipsValueText.text = slot2.desc

	if Activity168Config.instance:getComposeTypeCfg(uv0, slot2.compostType) then
		slot0._tipsTypeText.text = slot3.name
	end

	gohelper.setActive(slot0._tipsTypeText.gameObject, slot3 ~= nil)

	slot0._tipsNameText.text = slot2.name

	UISpriteSetMgr.instance:setLoperaItemSprite(slot0._tipsItemIcon, slot2.icon, false)
end

function slot0._refreshBtnState(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnSmelt.gameObject, not LoperaController.instance:checkCanCompose(slot0._selectTabIdx))

	for slot5, slot6 in ipairs(slot0._tabStateGroup) do
		gohelper.setActive(slot6.select, slot5 == slot0._selectTabIdx)
		gohelper.setActive(slot6.unSelect, slot5 ~= slot0._selectTabIdx)
	end
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateData(slot2, Activity168Model.instance:getItemCount(slot2.itemId) and slot5 or 0, slot3, {
		showNewFlag = true
	})
end

function slot0._onClickItem(slot0, slot1)
	gohelper.setActive(slot0._tipsGo, true)
	gohelper.setActive(slot0._goFullCloseBg, true)

	slot3 = slot0._tipsGo.transform

	slot3:SetParent(gohelper.findChild(slot0._goItemRoot, slot1).transform, true)
	recthelper.setAnchorX(slot3, 130)
	recthelper.setAnchorY(slot3, -30)
	slot3:SetParent(slot0.viewGO.transform, true)
	slot0:_refreshGoodItemTips(slot1)
end

function slot0._onSmeltResult(slot0)
	LoperaController.instance:openSmeltResultView()
	slot0:refreshView()
	slot0:_refreshBtnState()
	slot0:_refreshRedDot()
end

function slot0._showRedDot1(slot0)
	return slot0:_checkShowRedDot(1)
end

function slot0._showRedDot2(slot0)
	return slot0:_checkShowRedDot(2)
end

function slot0._showRedDot3(slot0)
	return slot0:_checkShowRedDot(3)
end

function slot0._checkShowRedDot(slot0, slot1)
	return LoperaController.instance:checkCanCompose(slot1)
end

function slot0._refreshRedDot(slot0)
	if slot0._redDot1Comp then
		slot0._redDot1Comp:refreshRedDot()
	end

	if slot0._redDot2Comp then
		slot0._redDot2Comp:refreshRedDot()
	end

	if slot0._redDot3Comp then
		slot0._redDot3Comp:refreshRedDot()
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._doTabChangeRefresh, slot0)
end

return slot0
