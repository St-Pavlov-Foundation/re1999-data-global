module("modules.logic.achievement.view.AchievementSelectView", package.seeall)

slot0 = class("AchievementSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocategoryitem = gohelper.findChild(slot0.viewGO, "#scroll_category/categorycontent/#go_categoryitem")
	slot0._goselectgroup = gohelper.findChild(slot0.viewGO, "#go_lefttop/#go_selectgroup")
	slot0._goselectsingle = gohelper.findChild(slot0.viewGO, "#go_lefttop/#go_selectsingle")
	slot0._gounselectgroup = gohelper.findChild(slot0.viewGO, "#go_lefttop/#go_unselectgroup")
	slot0._gounselectsingle = gohelper.findChild(slot0.viewGO, "#go_lefttop/#go_unselectsingle")
	slot0._btnswitchgroup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_lefttop/#btn_switchgroup")
	slot0._btnsave = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_save")
	slot0._txtselectnum = gohelper.findChildText(slot0.viewGO, "#btn_save/#txt_selectnum")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._btnclear = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_clear")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_container/#go_empty")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._simageBottomBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_BottomBG")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnswitchgroup:AddClickListener(slot0._btnswitchgroupOnClick, slot0)
	slot0._btnsave:AddClickListener(slot0._btnsaveOnClick, slot0)
	slot0._btnclear:AddClickListener(slot0._btnclearOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnswitchgroup:RemoveClickListener()
	slot0._btnsave:RemoveClickListener()
	slot0._btnclear:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_editfullbg"))
	slot0._simageBottomBG:LoadImage(ResUrl.getAchievementIcon("achievement_editbottombg"))
	slot0:initCategory()
end

function slot0.onDestroyView(slot0)
	if slot0._categoryItems then
		for slot4, slot5 in pairs(slot0._categoryItems) do
			slot5.btnself:RemoveClickListener()
		end

		slot0._categoryItems = nil
	end

	slot0._simagebg:UnLoadImage()
	slot0._simageBottomBG:UnLoadImage()
	AchievementSelectController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	if slot0.viewParam then
		slot0.isPlayerCard = slot0.viewParam.isPlayerCard
	end

	AchievementSelectController.instance:onOpenView(AchievementSelectController.instance:isCurrentShowGroupInPlayerView() and slot0._focusTypes[4] or slot0._focusTypes[1])
	slot0:addEventCb(AchievementSelectController.instance, AchievementEvent.SelectViewUpdated, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot1 = AchievementSelectListModel.instance.isGroup

	gohelper.setActive(slot0._goselectgroup, slot1)
	gohelper.setActive(slot0._gounselectsingle, slot1)
	gohelper.setActive(slot0._goselectsingle, not slot1)
	gohelper.setActive(slot0._gounselectgroup, not slot1)
	gohelper.setActive(slot0._goempty, AchievementSelectListModel.instance:getCount() <= 0)
	gohelper.setActive(slot0._btnclear.gameObject, AchievementSelectListModel.instance:getSelectCount() > 0)

	if slot1 then
		slot0._txtselectnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementselectview_selectgroup"), {
			AchievementSelectListModel.instance:getGroupSelectedCount(),
			AchievementEnum.ShowMaxGroupCount
		})
	else
		slot0._txtselectnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementselectview_selectsingle"), {
			AchievementSelectListModel.instance:getSingleSelectedCount(),
			AchievementEnum.ShowMaxSingleCount
		})
	end

	slot0:refreshCategory()
end

function slot0.refreshCategory(slot0)
	for slot5, slot6 in pairs(slot0._categoryItems) do
		slot7 = AchievementSelectListModel.instance:getCurrentCategory() == slot0._focusTypes[slot5]

		gohelper.setActive(slot6.goselected, slot7)
		gohelper.setActive(slot6.gounselected, not slot7)
		gohelper.setActive(slot6.goreddot, AchievementSelectListModel.instance:getSelectCountByCategory(slot0._focusTypes[slot5]) > 0)

		slot6.txtselectcount.text = slot8
	end
end

function slot0.initCategory(slot0)
	slot0._focusTypes = {
		AchievementEnum.Type.Story,
		AchievementEnum.Type.Normal,
		AchievementEnum.Type.GamePlay,
		AchievementEnum.Type.Activity
	}
	slot0._categoryItems = {}

	for slot4, slot5 in pairs(slot0._focusTypes) do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.cloneInPlace(slot0._gocategoryitem, "category_" .. tostring(slot4))

		gohelper.setActive(slot6.go, true)

		slot6.gounselected = gohelper.findChild(slot6.go, "go_unselected")
		slot6.txtitemcn1 = gohelper.findChildText(slot6.go, "go_unselected/txt_itemcn1")
		slot6.txtitemen1 = gohelper.findChildText(slot6.go, "go_unselected/txt_itemen1")
		slot6.goselected = gohelper.findChild(slot6.go, "go_selected")
		slot6.txtitemcn2 = gohelper.findChildText(slot6.go, "go_selected/txt_itemcn2")
		slot6.txtitemen2 = gohelper.findChildText(slot6.go, "go_selected/txt_itemen2")
		slot6.goreddot = gohelper.findChild(slot6.go, "go_reddot")
		slot6.txtselectcount = gohelper.findChildText(slot6.go, "go_reddot/txt_reddot")
		slot6.btnself = gohelper.findChildButtonWithAudio(slot6.go, "btn_self")

		slot6.btnself:AddClickListener(slot0.onClickCategory, slot0, slot4)

		slot8 = AchievementEnum.TypeNameEn[slot5]

		if not string.nilorempty(AchievementEnum.TypeName[slot5]) then
			slot6.txtitemcn1.text = luaLang(slot7)
			slot6.txtitemcn2.text = luaLang(slot7)
			slot6.txtitemen1.text = tostring(slot8)
			slot6.txtitemen2.text = tostring(slot8)
		end

		slot0._categoryItems[slot4] = slot6
	end
end

function slot0.onClickCategory(slot0, slot1)
	if AchievementSelectListModel.instance:getCurrentCategory() == slot0._focusTypes[slot1] then
		return
	end

	slot0.viewContainer._scrollView._csMixScroll:ResetScrollPos()
	AchievementSelectListModel.instance:setItemAniHasShownIndex(0)
	AchievementSelectController.instance:setCategory(slot3)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
end

function slot0._btnswitchgroupOnClick(slot0)
	slot0.viewContainer._scrollView._csMixScroll:ResetScrollPos()
	AchievementSelectListModel.instance:setItemAniHasShownIndex(0)
	AchievementSelectController.instance:switchGroup()
end

function slot0._btnsaveOnClick(slot0)
	if slot0.isPlayerCard then
		PlayerCardController.instance:saveAchievement()
	else
		AchievementSelectController.instance:sendSave()
	end

	slot0:closeThis()
end

function slot0._btnclearOnClick(slot0)
	AchievementSelectController.instance:clearAllSelect()
end

function slot0._btncancelOnClick(slot0)
	AchievementSelectController.instance:popUpMessageBoxIfNeedSave(slot0._jump2AchievementMainView, nil, slot0._jump2AchievementMainView, slot0, nil, slot0)
end

function slot0._jump2AchievementMainView(slot0)
	AchievementSelectController.instance:resumeToOriginSelect()
	ViewMgr.instance:openView(ViewName.AchievementMainView, {
		selectType = AchievementSelectListModel.instance:getCurrentCategory(),
		jumpFrom = ViewName.AchievementSelectView
	})
	slot0:closeThis()
end

return slot0
