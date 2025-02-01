module("modules.logic.rouge.view.RougeFavoriteCollectionView", package.seeall)

slot0 = class("RougeFavoriteCollectionView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_fullbg")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "#go_bottom")
	slot0._btnlist = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_bottom/#btn_list")
	slot0._golistselected = gohelper.findChild(slot0.viewGO, "#go_bottom/#btn_list/#go_list_selected")
	slot0._btnhandbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_bottom/#btn_handbook")
	slot0._gohandbookselected = gohelper.findChild(slot0.viewGO, "#go_bottom/#btn_handbook/#go_handbook_selected")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlist:AddClickListener(slot0._btnlistOnClick, slot0)
	slot0._btnhandbook:AddClickListener(slot0._btnhandbookOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlist:RemoveClickListener()
	slot0._btnhandbook:RemoveClickListener()
end

function slot0._btnlistOnClick(slot0)
	if slot0._listSelected then
		return
	end

	slot0.viewContainer:selectTabView(1)
	slot0:_setBtnListSelected(true)
end

function slot0._btnhandbookOnClick(slot0)
	if slot0._listSelected == false then
		return
	end

	slot0.viewContainer:selectTabView(2)
	slot0:_setBtnListSelected(false)
end

function slot0._setBtnListSelected(slot0, slot1)
	slot0._listSelected = slot1

	gohelper.setActive(slot0._golistselected, slot1)
	gohelper.setActive(slot0._gohandbookselected, not slot1)
end

function slot0._editableInitView(slot0)
	slot0:_setBtnListSelected(true)
	gohelper.setActive(slot0._gobottom, RougeOutsideModel.instance:passedLayerId(RougeEnum.FirstLayerId))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio6)
end

function slot0.onClose(slot0)
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Collection) > 0 then
		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(RougeOutsideModel.instance:season(), RougeEnum.FavoriteType.Collection, 0)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
