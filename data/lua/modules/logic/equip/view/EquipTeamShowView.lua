module("modules.logic.equip.view.EquipTeamShowView", package.seeall)

slot0 = class("EquipTeamShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnCloseEquipTeamShowView, slot0._closeThisView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0._inTeam = true
	slot0._targetEquipUid = EquipTeamListModel.instance:getTeamEquip()[1]

	slot0:_refreshUI()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, false)
end

function slot0._closeThisView(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0._targetEquipUid = slot0.viewParam[1]
	slot0._inTeam = slot0.viewParam[2]

	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0._showHideItem2 = false
	slot0._lastItem2Uid = nil
	slot0._itemList = slot0._itemList or slot0:getUserDataTb_()
	slot0._itemTipList = slot0._itemTipList or slot0:getUserDataTb_()
	slot0._targetEquipUid = slot0.viewParam[1]
	slot0._inTeam = slot0.viewParam[2]

	slot0:_refreshUI()
end

slot0.TeamShowItemPosList = {
	{
		-134.1,
		23.4
	},
	{
		420,
		23.4
	}
}

function slot0._refreshUI(slot0)
	slot0._heroId = EquipTeamListModel.instance:getHero() and slot1.heroId
	slot0._showHideItem2 = false
	slot2 = 2

	if slot0._inTeam then
		slot0:addItem(uv0.TeamShowItemPosList[slot2][1], uv0.TeamShowItemPosList[slot2][2], slot0._targetEquipUid, true, nil, 1)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, false)

		return
	end

	slot5 = uv0.TeamShowItemPosList[slot2]

	if EquipTeamListModel.instance:getTeamEquip()[1] and EquipModel.instance:getEquip(slot4) then
		slot0._showHideItem2 = true

		slot0:addItem(slot5[1], slot5[2], slot0._targetEquipUid, false, true, 1)

		slot5 = uv0.TeamShowItemPosList[slot2 - 1]

		slot0:addItem(slot5[1], slot5[2], slot4, true, true, 2)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, true)
	else
		slot0:addItem(uv0.TeamShowItemPosList[slot2][1], uv0.TeamShowItemPosList[slot2][2], slot0._targetEquipUid, false, false, 1)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, false)
	end

	if slot0.viewContainer.animBgUpdate then
		slot0.viewContainer:animBgUpdate()
	end
end

function slot0.addItem(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot0._itemTipList[slot6] then
		table.insert(slot0._itemTipList, slot6, slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0.viewGO, "item" .. slot6))
	end

	if slot0._itemTipList[2] then
		gohelper.setActive(slot0._itemTipList[2], slot0._showHideItem2)

		if slot6 == 2 and slot0._lastItem2Uid ~= slot3 then
			gohelper.setActive(slot0._itemTipList[2], false)

			slot0._lastItem2Uid = slot3
		end
	end

	gohelper.setActive(slot8, true)
	recthelper.setAnchor(slot8.transform, slot1, slot2)

	if not slot0._itemList[slot6] then
		slot9 = EquipTeamShowItem.New()

		table.insert(slot0._itemList, slot6, slot9)
		slot9:initView(slot8, {
			slot3,
			slot4,
			slot5,
			slot0,
			slot0._heroId,
			slot6
		})
	else
		slot9.viewParam = {
			slot3,
			slot4,
			slot5,
			slot0,
			slot0._heroId,
			slot6
		}

		slot9:onUpdateParam()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._itemList) do
		slot5:destroyView()
	end
end

return slot0
