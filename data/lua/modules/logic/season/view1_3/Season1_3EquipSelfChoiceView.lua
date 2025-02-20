module("modules.logic.season.view1_3.Season1_3EquipSelfChoiceView", package.seeall)

slot0 = class("Season1_3EquipSelfChoiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg2")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "root/mask/#scroll_item")
	slot0._gocarditem = gohelper.findChild(slot0.viewGO, "root/mask/#scroll_item/viewport/itemcontent/#go_carditem")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_ok")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0.goempty = gohelper.findChild(slot0.viewGO, "root/right/#go_empty")
	slot0.gocardinfo = gohelper.findChild(slot0.viewGO, "root/right/#go_cardinfo")
	slot0.txtcardname = gohelper.findChildTextMesh(slot0.viewGO, "root/right/#go_cardinfo/#txt_curcardname")
	slot0.godescitem = gohelper.findChild(slot0.viewGO, "root/right/#go_cardinfo/#scroll_info/Viewport/Content/#go_descitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.SelectSelfChoiceCard, slot0.selectSelfChoiceCard, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose1:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(Activity104Controller.instance, Activity104Event.SelectSelfChoiceCard, slot0.selectSelfChoiceCard, slot0)
end

function slot0._btnclose1OnClick(slot0)
end

function slot0._btnokOnClick(slot0)
	Activity104EquipSelfChoiceController.instance:sendSelectCard(slot0.handleSendChoice, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	Activity104EquipSelfChoiceController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	if not Activity104EquipSelfChoiceController:checkOpenParam(slot0.viewParam.actId, slot0.viewParam.costItemUid) then
		slot0:delayClose()

		return
	end

	slot0:selectSelfChoiceCard()
	Activity104EquipSelfChoiceController.instance:onOpenView(slot1, slot2)
end

function slot0.selectSelfChoiceCard(slot0, slot1)
	if not SeasonConfig.instance:getSeasonEquipCo(slot1) then
		gohelper.setActive(slot0.goempty, true)
		gohelper.setActive(slot0.gocardinfo, false)

		return
	end

	gohelper.setActive(slot0.goempty, false)
	gohelper.setActive(slot0.gocardinfo, true)

	slot0.txtcardname.text = slot2.name
	slot3 = SeasonEquipMetaUtils.getSkillEffectStrList(slot2)
	slot4 = SeasonEquipMetaUtils.getCareerColorBrightBg(slot1)

	if not slot0._skillItems then
		slot0._skillItems = {}
	end

	slot8 = #slot0._skillItems

	for slot8 = 1, math.max(slot8, #slot3) do
		slot9 = slot0:getOrCreateSkillText(slot8)

		if slot3[slot8] then
			gohelper.setActive(slot9.go, true)

			slot9.txtDesc.text = slot3[slot8]

			SLFramework.UGUI.GuiHelper.SetColor(slot9.txtDesc, slot4)
			SLFramework.UGUI.GuiHelper.SetColor(slot9.imagePoint, slot4)
		else
			gohelper.setActive(slot9.go, false)
		end
	end
end

function slot0.getOrCreateSkillText(slot0, slot1)
	if not slot0._skillItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0.godescitem, "desc" .. tostring(slot1))
		slot2.txtDesc = gohelper.findChildText(slot2.go, "txt_desc")
		slot2.imagePoint = gohelper.findChildImage(slot2.go, "dot")
		slot0._skillItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

function slot0.delayClose(slot0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 0.001)
end

function slot0.handleSendChoice(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0:closeThis()

	if slot0.viewParam.successCall then
		slot0.viewParam.successCall(slot0.viewParam.successCallObj)
	end
end

return slot0
