module("modules.logic.herogroup.view.HeroGroupBalanceTipView", package.seeall)

slot0 = class("HeroGroupBalanceTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "#btn_close")
	slot0._txtroleLv = gohelper.findChildTextMesh(slot0.viewGO, "lv/#txt_roleLv")
	slot0._txtequipLv = gohelper.findChildTextMesh(slot0.viewGO, "equipLv/#txt_equipLv")
	slot0._txttalent = gohelper.findChildTextMesh(slot0.viewGO, "talent/#txt_talent")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot4 = "lv/rankobj"
	slot0._rankGo = gohelper.findChild(slot0.viewGO, slot4)
	slot0._ranks = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot0._ranks[slot4] = gohelper.findChild(slot0._rankGo, "rank" .. slot4)
	end
end

function slot0.onOpen(slot0)
	slot1, slot2, slot3 = HeroGroupBalanceHelper.getBalanceLv()
	slot4, slot5 = HeroConfig.instance:getShowLevel(slot1)

	for slot9 = 1, 3 do
		gohelper.setActive(slot0._ranks[slot9], slot5 - 1 == slot9)
	end

	slot0._txtroleLv.text = "Lv.<size=38>" .. slot4
	slot0._txtequipLv.text = "Lv.<size=38>" .. slot3
	slot0._txttalent.text = "Lv.<size=38>" .. slot2

	if slot5 == 1 then
		slot0._txtroleLv.alignment = TMPro.TextAlignmentOptions.Center

		recthelper.setAnchorX(slot0._txtroleLv.transform, 0)
	end
end

return slot0
