module("modules.logic.rouge.view.RougeIllustrationListItem", package.seeall)

slot0 = class("RougeIllustrationListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_Selected")
	slot0._goUnlocked = gohelper.findChild(slot0.viewGO, "#go_Unlocked")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_Unlocked/#go_new")
	slot0._simageItemPic = gohelper.findChildSingleImage(slot0.viewGO, "#go_Unlocked/#simage_ItemPic")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "#go_Unlocked/#txt_Name")
	slot0._txtNameEn = gohelper.findChildText(slot0.viewGO, "#go_Unlocked/#txt_Name/#txt_NameEn")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Unlocked/#btn_click")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	RougeController.instance:openRougeIllustrationDetailView(slot0._mo)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goSelected, false)

	slot0._click = gohelper.getClickWithDefaultAudio(slot0._goLocked, slot0)

	slot0._click:AddClickListener(slot0._onClick, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, slot0._updateNewFlag, slot0)
end

function slot0._onClick(slot0)
	GameFacade.showToast(ToastEnum.RougeIllustrationLockTip)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1.config

	slot0._simageItemPic:LoadImage(slot0._mo.image)

	slot0._txtName.text = slot0._mo.name
	slot0._txtNameEn.text = slot0._mo.nameEn

	if UnityEngine.Time.frameCount - RougeIllustrationListModel.instance.startFrameCount < 10 then
		slot0._aniamtor = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)

		slot0._aniamtor:Play("open")
	end

	slot2 = RougeOutsideModel.instance:passedAnyEventId(slot1.eventIdList)

	gohelper.setActive(slot0._goUnlocked, slot2)
	gohelper.setActive(slot0._goLocked, not slot2)

	if slot2 then
		slot0:_updateNewFlag()
	end
end

function slot0._updateNewFlag(slot0)
	slot0._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Illustration, slot0._mo.id) ~= nil

	gohelper.setActive(slot0._gonew, slot0._showNewFlag)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()
	end
end

return slot0
