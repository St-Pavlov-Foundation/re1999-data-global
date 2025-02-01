module("modules.logic.rouge.view.RougeCollectionEnchantIconItem", package.seeall)

slot0 = class("RougeCollectionEnchantIconItem", RougeCollectionIconItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._holeImageTab = slot0:getUserDataTb_()

	slot0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, slot0.updateEnchantInfo, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1.cfgId)

	slot0._mo = slot1

	slot0:refreshAllHoles()
end

function slot0.refreshAllHoles(slot0)
	slot1 = slot0._collectionCfg and slot0._collectionCfg.holeNum or 0

	gohelper.setActive(slot0._goholetool, slot1 > 0)

	if slot1 > 0 then
		gohelper.CreateObjList(slot0, slot0.refrehHole, slot0._mo:getAllEnchantId() or {}, slot0._goholetool, slot0._goholeitem)
	end
end

function slot0.refrehHole(slot0, slot1, slot2, slot3)
	slot6 = slot2 and slot2 > 0

	gohelper.setActive(gohelper.findChild(slot1, "go_get"), slot6)
	gohelper.setActive(gohelper.findChild(slot1, "go_none"), not slot6)

	if not slot6 then
		return
	end

	slot7 = gohelper.findChildSingleImage(slot1, "go_get/image_enchanticon")
	slot8, slot9 = slot0._mo:getEnchantIdAndCfgId(slot3)

	slot7:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot9))

	slot0._holeImageTab[slot7] = true
end

function slot0.updateEnchantInfo(slot0, slot1)
	if not slot0._mo or slot0._mo.id ~= slot1 then
		return
	end

	slot0:refreshAllHoles()
end

function slot0.destroy(slot0)
	if slot0._holeImageTab then
		for slot4, slot5 in pairs(slot0._holeImageTab) do
			slot4:UnLoadImage()
		end
	end

	uv0.super.destroy(slot0)
end

return slot0
