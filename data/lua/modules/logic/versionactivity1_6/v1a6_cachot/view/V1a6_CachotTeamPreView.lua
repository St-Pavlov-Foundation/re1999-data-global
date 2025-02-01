module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreView", package.seeall)

slot0 = class("V1a6_CachotTeamPreView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_left")
	slot0._simageselect = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_left/#simage_select")
	slot0._gopresetcontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_left/scroll_view/Viewport/#go_presetcontent")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_right")
	slot0._gopreparecontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_right/scroll_view/Viewport/#go_preparecontent")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
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
		slot0._presetItemList[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gopresetcontent, "item" .. tostring(slot5)), V1a6_CachotTeamPreviewPresetItem)
	end
end

function slot0._initPrepareItemList(slot0)
	if slot0._prepareItemList then
		return
	end

	slot0._prepareItemList = slot0:getUserDataTb_()

	for slot6, slot7 in ipairs(V1a6_CachotTeamPreviewPrepareListModel.instance:getList()) do
		slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gopreparecontent, "item" .. tostring(slot6)), V1a6_CachotTeamPreviewPrepareItem)
		slot0._prepareItemList[slot6] = slot9

		slot9:hideEquipNone()
		slot9:onUpdateMO(slot7)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	V1a6_CachotTeamModel.instance:clearSeatInfos()
	V1a6_CachotTeamPreviewPrepareListModel.instance:initList()
	slot0:_updatePresetItemList()
	slot0:_initPrepareItemList()

	if #V1a6_CachotTeamPreviewPrepareListModel.instance:getList() <= 4 then
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
end

function slot0._updatePresetItemList(slot0)
	for slot5, slot6 in ipairs(slot0._presetItemList) do
		slot6:onUpdateMO(V1a6_CachotTeamPreviewPresetListModel.instance:initList()[slot5])
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
