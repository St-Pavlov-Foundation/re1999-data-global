module("modules.logic.custompickchoice.view.NewbieCustomPickView", package.seeall)

slot0 = class("NewbieCustomPickView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "mask")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "bg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "TitleBG/Title")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "Tips2")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._goChar1Root = gohelper.findChild(slot0.viewGO, "Hero/#go_Hero1")
	slot0._goChar2Root = gohelper.findChild(slot0.viewGO, "Hero/#go_Hero2")
	slot0._goChar3Root = gohelper.findChild(slot0.viewGO, "Hero/#go_Hero3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0.closeThis, slot0)
	slot0:addEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0:removeEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
	slot0:removeEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, slot0.closeThis, slot0)
end

function slot0._btnconfirmOnClick(slot0)
	CustomPickChoiceController.instance:tryChoice(slot0.viewParam)
end

function slot0._editableInitView(slot0)
	slot0._HeroItems = {}
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	CustomPickChoiceController.instance:onOpenView()

	slot1 = slot0.viewParam and slot0.viewParam.styleId

	if slot1 and CustomPickChoiceEnum.FixedText[slot1] then
		for slot6, slot7 in pairs(slot2) do
			if slot0[slot6] then
				slot0[slot6].text = luaLang(slot7)
			end
		end
	end

	if slot1 and CustomPickChoiceEnum.ComponentVisible[slot1] then
		for slot7, slot8 in pairs(slot3) do
			if slot0[slot7] then
				gohelper.setActive(slot0[slot7], slot8)
			end
		end
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshSelectCount()
	slot0:refreshList()
end

function slot0.refreshSelectCount(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnconfirm.gameObject, CustomPickChoiceListModel.instance:getSelectCount() ~= CustomPickChoiceListModel.instance:getMaxSelectCount())
end

function slot0.refreshList(slot0)
	slot0:updateCharItem(CustomPickChoiceListModel.instance.allHeroList[1], 1, slot0._HeroItems, slot0._goChar1Root)
	slot0:updateCharItem(CustomPickChoiceListModel.instance.allHeroList[2], 2, slot0._HeroItems, slot0._goChar2Root)
	slot0:updateCharItem(CustomPickChoiceListModel.instance.allHeroList[3], 3, slot0._HeroItems, slot0._goChar3Root)
end

function slot0.updateCharItem(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0:getOrCreateItem(slot2, slot3, slot4)
	slot7 = nil

	if slot1.id and slot6 ~= 0 then
		slot7 = HeroConfig.instance:getHeroCO(slot6)
	end

	slot9 = 0
	slot10 = 0

	if HeroModel.instance:getByHeroId(slot6) then
		slot9 = slot8.exSkillLevel + 1
	end

	slot11 = HeroMo.New()

	slot11:initFromConfig(slot7)

	slot11.rank = slot1.rank
	slot11.exSkillLevel = slot10

	slot5:setSelect(CustomPickChoiceListModel.instance:isHeroIdSelected(slot6))
	slot5:onUpdateMO(slot11)

	slot15 = slot9 > 0

	gohelper.setActive(gohelper.findChild(slot4, "#go_Have"), slot15)
	gohelper.setActive(gohelper.findChild(slot4, "#go_NoHave"), not slot15)
end

function slot0.getOrCreateItem(slot0, slot1, slot2, slot3)
	if not slot2[slot1] then
		slot4 = IconMgr.instance:getCommonHeroItem(slot3)

		slot4:addClickListener(slot0._onItemClick, slot0)
		slot4:setLevelContentShow(false)
		slot4:setExSkillActive(true)

		slot4.btnLongPress = SLFramework.UGUI.UILongPressListener.Get(slot4.go)

		slot4.btnLongPress:SetLongPressTime({
			0.5,
			99999
		})
		slot4.btnLongPress:AddLongPressListener(slot0._onLongClickItem, slot0, slot1)

		slot2[slot1] = slot4
	end

	return slot2[slot1]
end

function slot0._onItemClick(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	CustomPickChoiceController.instance:setSelect(slot1.heroId)
end

function slot0._onLongClickItem(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_rolesopen)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = CustomPickChoiceListModel.instance.allHeroList[slot1].id
	})
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._HeroItems) do
		slot5.btnLongPress:RemoveLongPressListener()
	end
end

function slot0.onDestroyView(slot0)
	CustomPickChoiceController.instance:onCloseView()
end

return slot0
