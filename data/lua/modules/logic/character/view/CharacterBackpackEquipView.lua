module("modules.logic.character.view.CharacterBackpackEquipView", package.seeall)

slot0 = class("CharacterBackpackEquipView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollequip = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_equip")
	slot0._goequipsort = gohelper.findChild(slot0.viewGO, "#go_equipsort")
	slot0._btnequiplv = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipsort/bg/#btn_equiplv")
	slot0._btnequiprare = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipsort/bg/#btn_equiprare")
	slot0._btnequiptime = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipsort/bg/#btn_equiptime")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipsort/#btn_filter")
	slot0._txtequipbackpacknum = gohelper.findChildText(slot0.viewGO, "go_num/#txt_equipbackpacknum")
	slot0._btncompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "compose/#btn_compose")
	slot0._simageheart = gohelper.findChildSingleImage(slot0.viewGO, "#simage_heart")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnequiplv:AddClickListener(slot0._btnequiplvOnClick, slot0)
	slot0._btnequiprare:AddClickListener(slot0._btnequiprareOnClick, slot0)
	slot0._btnequiptime:AddClickListener(slot0._btnequiptimeOnClick, slot0)
	slot0._btncompose:AddClickListener(slot0._btncomposeOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnequiplv:RemoveClickListener()
	slot0._btnequiprare:RemoveClickListener()
	slot0._btnequiptime:RemoveClickListener()
	slot0._btncompose:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._ani = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(slot0._btnequiplv.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(slot0._btnequiprare.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(slot0._btnequiptime.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(slot0._btncompose.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Open)

	slot4 = ResUrl.getCharacterIcon

	slot0._simageheart:LoadImage(slot4("bg_beijingwenli_xinzang"))

	slot0._equipLvBtns = slot0:getUserDataTb_()
	slot0._equipLvArrow = slot0:getUserDataTb_()
	slot0._equipQualityBtns = slot0:getUserDataTb_()
	slot0._equipQualityArrow = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		slot0._equipLvBtns[slot4] = gohelper.findChild(slot0._btnequiplv.gameObject, "btn" .. tostring(slot4))
		slot0._equipLvArrow[slot4] = gohelper.findChild(slot0._equipLvBtns[slot4], "txt/arrow").transform
		slot0._equipQualityBtns[slot4] = gohelper.findChild(slot0._btnequiprare.gameObject, "btn" .. tostring(slot4))
		slot0._equipQualityArrow[slot4] = gohelper.findChild(slot0._equipQualityBtns[slot4], "txt/arrow").transform
	end

	gohelper.setActive(slot0._equipLvArrow[1].gameObject, false)
	gohelper.setActive(slot0._equipQualityArrow[1].gameObject, false)

	slot0.goNotFilter = gohelper.findChild(slot0.viewGO, "#go_equipsort/#btn_filter/#go_notfilter")
	slot0.goFilter = gohelper.findChild(slot0.viewGO, "#go_equipsort/#btn_filter/#go_filter")

	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0.refreshEquip, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, slot0.refreshEquip, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, slot0.onEquipTypeHasChange, slot0)
end

function slot0._btncomposeOnClick(slot0)
	EquipController.instance:openEquipDecomposeView()
end

function slot0._btnequiplvOnClick(slot0)
	CharacterBackpackEquipListModel.instance:sortByLevel()
	slot0:_refreshEquipBtnIcon()
end

function slot0._btnequiprareOnClick(slot0)
	CharacterBackpackEquipListModel.instance:sortByQuality()
	slot0:_refreshEquipBtnIcon()
end

function slot0._btnequiptimeOnClick(slot0)
	CharacterBackpackEquipListModel.instance:sortByTime()
	slot0:_refreshEquipBtnIcon()
end

function slot0._btnfilterOnClick(slot0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = slot0.viewName
	})
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.filterMo = EquipFilterModel.instance:generateFilterMo(slot0.viewName)

	slot0.viewContainer:setCurrentSelectCategoryId(ItemEnum.CategoryType.Equip)

	slot0._ani.enabled = #slot0.tabContainer._tabAbLoaders < 2
	slot0._scrollequip.verticalNormalizedPosition = 1

	slot0:refreshEquip()
	slot0:_refreshEquipBtnIcon()
end

function slot0._refreshEquipBtnIcon(slot0)
	gohelper.setActive(slot0._equipLvBtns[1], CharacterBackpackEquipListModel.instance:getBtnTag() ~= 1)
	gohelper.setActive(slot0._equipLvBtns[2], slot1 == 1)
	gohelper.setActive(slot0._equipQualityBtns[1], slot1 ~= 2)
	gohelper.setActive(slot0._equipQualityBtns[2], slot1 == 2)

	slot2, slot3, slot4 = CharacterBackpackEquipListModel.instance:getRankState()

	transformhelper.setLocalScale(slot0._equipLvArrow[2], 1, slot2, 1)
	transformhelper.setLocalScale(slot0._equipQualityArrow[2], 1, slot3, 1)
end

function slot0.refreshEquip(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(EquipModel.instance:getEquips()) do
		if slot7.config and slot0.filterMo:checkIsIncludeTag(slot7.config) then
			table.insert(slot2, slot7)
		end
	end

	CharacterBackpackEquipListModel.instance:setEquipListNew(slot2)
	slot0:_showEquipBackpackNum()
	slot0:refreshFilterBtn()
end

function slot0.onEquipTypeHasChange(slot0, slot1)
	if slot0.viewName ~= slot1 then
		return
	end

	slot0._scrollequip.verticalNormalizedPosition = 1

	slot0:refreshEquip()
end

function slot0._showEquipBackpackNum(slot0)
	slot0._txtequipbackpacknum.text = string.format("%s ：%s/%s", luaLang("equip"), CharacterBackpackEquipListModel.instance:getCount(), EquipConfig.instance:getEquipBackpackMaxCount())
end

function slot0.refreshFilterBtn(slot0)
	slot1 = slot0.filterMo:isFiltering()

	gohelper.setActive(slot0.goNotFilter, not slot1)
	gohelper.setActive(slot0.goFilter, slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	EquipFilterModel.instance:clear(slot0.viewName)
	CharacterBackpackEquipListModel.instance:clearEquipList()
	slot0._simageheart:UnLoadImage()
end

return slot0
