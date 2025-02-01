module("modules.logic.voyage.view.VoyagePopupRewardViewItem", package.seeall)

slot0 = class("VoyagePopupRewardViewItem", ActivityGiftForTheVoyageItemBase)

function slot0.onInitView(slot0)
	slot0._imagenum = gohelper.findChildImage(slot0.viewGO, "#image_num")
	slot0._gonum = gohelper.findChild(slot0.viewGO, "#go_num")
	slot0._goimgall = gohelper.findChild(slot0.viewGO, "#go_imgall")
	slot0._txttaskdesc = gohelper.findChildText(slot0.viewGO, "#txt_taskdesc")
	slot0._scrollRewards = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_Rewards")
	slot0._goRewards = gohelper.findChild(slot0.viewGO, "#scroll_Rewards/Viewport/#go_Rewards")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._gonumTrans = slot0._gonum.transform
	slot0._bg = gohelper.findChild(slot0.viewGO, "bg")
end

slot1 = 1

function slot0.onUpdateMO(slot0, slot1)
	for slot7 = 1 + uv0, math.max(slot0._index, slot0._gonumTrans.childCount) do
		if slot2 <= slot7 - 1 then
			break
		end

		GameUtil.setActive01(slot0._gonumTrans:GetChild(slot7 - 1), slot0._index == slot7 - uv0)
	end

	ZProj.UGUIHelper.SetColorAlpha(slot0._bg:GetComponent(gohelper.Type_Image), slot1.id > 0 and 0.7 or 1)
	uv1.super.onUpdateMO(slot0, slot1)
end

function slot0.onRefresh(slot0)
	slot1 = slot0._mo
	slot0._txttaskdesc.text = slot1.desc

	gohelper.setActive(slot0._goimgall, slot1.id == -1)
	slot0:_refreshRewardList(slot0._goRewards)

	slot0._scrollRewards.horizontalNormalizedPosition = 0
end

return slot0
