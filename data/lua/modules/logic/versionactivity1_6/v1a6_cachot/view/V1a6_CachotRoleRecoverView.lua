module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverView", package.seeall)

slot0 = class("V1a6_CachotRoleRecoverView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_left")
	slot0._simageselect = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_left/#simage_select")
	slot0._gopresetcontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_left/scroll_view/Viewport/#go_presetcontent")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_right")
	slot0._gopreparecontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_right/scroll_view/Viewport/#go_preparecontent")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._gostart = gohelper.findChild(slot0.viewGO, "#go_start")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_start/#btn_start")
	slot0._gostartlight = gohelper.findChild(slot0.viewGO, "#go_start/#btn_start/#go_startlight")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
end

function slot0._btnstartOnClick(slot0)
	if not slot0._selectedMo or not slot0._selectedMo:getHeroMO() then
		GameFacade.showToast(ToastEnum.V1a6CachotToast10)

		return
	end

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventId, slot0._selectedMo:getHeroMO().heroId, slot0._onSelectEnd, slot0)
end

function slot0._onSelectEnd(slot0)
	V1a6_CachotController.instance:openV1a6_CachotRoleRecoverResultView({
		slot0._selectedMo
	})
end

function slot0._btncloseOnClick(slot0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventId, slot0.closeThis, slot0)
end

function slot0._editableInitView(slot0)
	V1a6_CachotRoleRecoverPresetListModel.instance:initList()
	V1a6_CachotRoleRecoverPrepareListModel.instance:initList()

	slot0._contentSizeFitter = slot0._gocontent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	slot0._horizontal = slot0._gocontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	slot0._limitedScrollRect = slot0._scrollview:GetComponent(typeof(ZProj.LimitedScrollRect))

	slot0:_initPresetItemList()
end

function slot0._initPresetItemList(slot0)
	if slot0._presetItemList then
		return
	end

	slot0._presetItemList = slot0:getUserDataTb_()

	for slot5 = 1, V1a6_CachotEnum.HeroCountInGroup do
		slot0._presetItemList[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gopresetcontent, "item" .. tostring(slot5)), V1a6_CachotRoleRecoverPresetItem)
	end
end

function slot0._initPrepareItemList(slot0)
	if slot0._prepareItemList then
		return
	end

	slot0._prepareItemList = slot0:getUserDataTb_()

	for slot6, slot7 in ipairs(V1a6_CachotRoleRecoverPrepareListModel.instance:getList()) do
		slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gopreparecontent, "item" .. tostring(slot6)), V1a6_CachotRoleRecoverPrepareItem)
		slot0._prepareItemList[slot6] = slot9

		slot9:hideEquipNone()
		slot9:onUpdateMO(slot7)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_updatePresetItemList()
	slot0:_initPrepareItemList()

	if #V1a6_CachotRoleRecoverPrepareListModel.instance:getList() <= 4 then
		slot0._limitedScrollRect.enabled = false
		slot0._contentSizeFitter.enabled = false

		recthelper.setWidth(slot0._goleft.transform, 800)
		recthelper.setWidth(slot0._goright.transform, 700)
	elseif slot2 <= 8 then
		slot0._limitedScrollRect.enabled = false
		slot0._gocontent.transform.anchorMin = Vector2.New(0.5, 0.5)
		slot0._gocontent.transform.anchorMax = Vector2.New(0.5, 0.5)

		recthelper.setAnchorX(slot0._gocontent.transform, -1206)
	else
		recthelper.setWidth(slot0._goleft.transform, 720)

		slot3 = slot0._horizontal.padding
		slot3.right = 300
		slot0._horizontal.padding = slot3
	end

	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnClickTeamItem, slot0._onClickTeamItem, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._updatePresetItemList(slot0)
	for slot5, slot6 in ipairs(slot0._presetItemList) do
		slot6:onUpdateMO(V1a6_CachotRoleRecoverPresetListModel.instance:getList()[slot5])
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotRoleRecoverResultView then
		slot0:closeThis()
	end
end

function slot0._onClickTeamItem(slot0, slot1)
	slot0._selectedMo = slot1
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
