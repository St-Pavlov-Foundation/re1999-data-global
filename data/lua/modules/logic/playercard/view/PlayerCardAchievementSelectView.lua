module("modules.logic.playercard.view.PlayerCardAchievementSelectView", package.seeall)

local var_0_0 = class("PlayerCardAchievementSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocategoryitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_category/categorycontent/#go_categoryitem")
	arg_1_0._goselectgroup = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop/#go_selectgroup")
	arg_1_0._goselectsingle = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop/#go_selectsingle")
	arg_1_0._gounselectgroup = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop/#go_unselectgroup")
	arg_1_0._gounselectsingle = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop/#go_unselectsingle")
	arg_1_0._btnswitchgroup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_lefttop/#btn_switchgroup")
	arg_1_0._btnsave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_save")
	arg_1_0._txtselectnum = gohelper.findChildText(arg_1_0.viewGO, "#btn_save/#txt_selectnum")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._btnclear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_clear")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_empty")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_content")
	arg_1_0._goscrollnameplate = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_content_misihai")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simageBottomBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_BottomBG")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnswitchgroup:AddClickListener(arg_2_0._btnswitchgroupOnClick, arg_2_0)
	arg_2_0._btnsave:AddClickListener(arg_2_0._btnsaveOnClick, arg_2_0)
	arg_2_0._btnclear:AddClickListener(arg_2_0._btnclearOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnswitchgroup:RemoveClickListener()
	arg_3_0._btnsave:RemoveClickListener()
	arg_3_0._btnclear:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_editfullbg"))
	arg_4_0._simageBottomBG:LoadImage(ResUrl.getAchievementIcon("achievement_editbottombg"))
	arg_4_0:initCategory()
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._categoryItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._categoryItems) do
			iter_5_1.btnself:RemoveClickListener()
		end

		arg_5_0._categoryItems = nil
	end

	arg_5_0._simagebg:UnLoadImage()
	arg_5_0._simageBottomBG:UnLoadImage()
	PlayerCardAchievementSelectController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = PlayerCardAchievementSelectController.instance:isCurrentShowGroupInPlayerView() and arg_6_0._focusTypes[4] or arg_6_0._focusTypes[1]

	PlayerCardAchievementSelectController.instance:onOpenView(var_6_0)
	arg_6_0:addEventCb(PlayerCardAchievementSelectController.instance, AchievementEvent.SelectViewUpdated, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = PlayerCardAchievementSelectListModel.instance.isGroup
	local var_8_1 = PlayerCardAchievementSelectListModel.instance:getCount()
	local var_8_2 = PlayerCardAchievementSelectListModel.instance:getSelectCount()
	local var_8_3 = PlayerCardAchievementSelectListModel.instance:checkIsNamePlate()
	local var_8_4 = var_8_1 <= 0

	gohelper.setActive(arg_8_0._goselectgroup, var_8_0)
	gohelper.setActive(arg_8_0._gounselectsingle, var_8_0)
	gohelper.setActive(arg_8_0._goselectsingle, not var_8_0)
	gohelper.setActive(arg_8_0._gounselectgroup, not var_8_0)
	gohelper.setActive(arg_8_0._goempty, var_8_4)
	gohelper.setActive(arg_8_0._goscrollcontent, not var_8_4 and not var_8_3)
	gohelper.setActive(arg_8_0._goscrollnameplate, not var_8_4 and var_8_3)
	gohelper.setActive(arg_8_0._btnclear.gameObject, var_8_2 > 0)
	gohelper.setActive(arg_8_0._golefttop, not var_8_3)

	if var_8_3 then
		local var_8_5 = {
			PlayerCardAchievementSelectListModel.instance:getSingleSelectedCount(),
			AchievementEnum.ShowMaxNamePlateCount
		}

		arg_8_0._txtselectnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementselectview_selectsingle"), var_8_5)
	elseif var_8_0 then
		local var_8_6 = {
			PlayerCardAchievementSelectListModel.instance:getGroupSelectedCount(),
			AchievementEnum.ShowMaxGroupCount
		}

		arg_8_0._txtselectnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementselectview_selectgroup"), var_8_6)
	else
		local var_8_7 = {
			PlayerCardAchievementSelectListModel.instance:getSingleSelectedCount(),
			AchievementEnum.ShowMaxSingleCount
		}

		arg_8_0._txtselectnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementselectview_selectsingle"), var_8_7)
	end

	arg_8_0:refreshCategory()
end

function var_0_0.refreshCategory(arg_9_0)
	local var_9_0 = PlayerCardAchievementSelectListModel.instance:getCurrentCategory()

	for iter_9_0, iter_9_1 in pairs(arg_9_0._categoryItems) do
		local var_9_1 = var_9_0 == arg_9_0._focusTypes[iter_9_0]

		gohelper.setActive(iter_9_1.goselected, var_9_1)
		gohelper.setActive(iter_9_1.gounselected, not var_9_1)

		local var_9_2 = PlayerCardAchievementSelectListModel.instance:getSelectCountByCategory(arg_9_0._focusTypes[iter_9_0])

		gohelper.setActive(iter_9_1.goreddot, var_9_2 > 0)

		iter_9_1.txtselectcount.text = var_9_2
	end
end

function var_0_0.initCategory(arg_10_0)
	arg_10_0._focusTypes = {
		AchievementEnum.Type.Story,
		AchievementEnum.Type.Normal,
		AchievementEnum.Type.GamePlay,
		AchievementEnum.Type.Activity,
		AchievementEnum.Type.NamePlate
	}
	arg_10_0._categoryItems = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0._focusTypes) do
		local var_10_0 = arg_10_0:getUserDataTb_()

		var_10_0.go = gohelper.cloneInPlace(arg_10_0._gocategoryitem, "category_" .. tostring(iter_10_0))

		gohelper.setActive(var_10_0.go, true)

		var_10_0.gounselected = gohelper.findChild(var_10_0.go, "go_unselected")
		var_10_0.txtitemcn1 = gohelper.findChildText(var_10_0.go, "go_unselected/txt_itemcn1")
		var_10_0.txtitemen1 = gohelper.findChildText(var_10_0.go, "go_unselected/txt_itemen1")
		var_10_0.goselected = gohelper.findChild(var_10_0.go, "go_selected")
		var_10_0.txtitemcn2 = gohelper.findChildText(var_10_0.go, "go_selected/txt_itemcn2")
		var_10_0.txtitemen2 = gohelper.findChildText(var_10_0.go, "go_selected/txt_itemen2")
		var_10_0.goreddot = gohelper.findChild(var_10_0.go, "go_reddot")
		var_10_0.txtselectcount = gohelper.findChildText(var_10_0.go, "go_reddot/txt_reddot")
		var_10_0.btnself = gohelper.findChildButtonWithAudio(var_10_0.go, "btn_self")

		var_10_0.btnself:AddClickListener(arg_10_0.onClickCategory, arg_10_0, iter_10_0)

		local var_10_1 = AchievementEnum.TypeName[iter_10_1]
		local var_10_2 = AchievementEnum.TypeNameEn[iter_10_1]

		if not string.nilorempty(var_10_1) then
			var_10_0.txtitemcn1.text = luaLang(var_10_1)
			var_10_0.txtitemcn2.text = luaLang(var_10_1)
			var_10_0.txtitemen1.text = tostring(var_10_2)
			var_10_0.txtitemen2.text = tostring(var_10_2)
		end

		arg_10_0._categoryItems[iter_10_0] = var_10_0
	end
end

function var_0_0.onClickCategory(arg_11_0, arg_11_1)
	local var_11_0 = PlayerCardAchievementSelectListModel.instance:getCurrentCategory()
	local var_11_1 = arg_11_0._focusTypes[arg_11_1]

	if var_11_0 == var_11_1 then
		return
	end

	arg_11_0.viewContainer._scrollView._csMixScroll:ResetScrollPos()
	PlayerCardAchievementSelectListModel.instance:setItemAniHasShownIndex(0)
	PlayerCardAchievementSelectController.instance:setCategory(var_11_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
end

function var_0_0._btnswitchgroupOnClick(arg_12_0)
	arg_12_0.viewContainer._scrollView._csMixScroll:ResetScrollPos()
	PlayerCardAchievementSelectListModel.instance:setItemAniHasShownIndex(0)
	PlayerCardAchievementSelectController.instance:switchGroup()
end

function var_0_0._btnsaveOnClick(arg_13_0)
	PlayerCardController.instance:saveAchievement()
	arg_13_0:closeThis()
end

function var_0_0._btnclearOnClick(arg_14_0)
	PlayerCardAchievementSelectController.instance:clearAllSelect()
end

function var_0_0._btncancelOnClick(arg_15_0)
	arg_15_0:closeThis()
end

function var_0_0._jump2AchievementMainView(arg_16_0)
	PlayerCardAchievementSelectController.instance:resumeToOriginSelect()

	local var_16_0 = PlayerCardAchievementSelectListModel.instance:getCurrentCategory()

	ViewMgr.instance:openView(ViewName.PlayerCardAchievementSelectView, {
		selectType = var_16_0,
		jumpFrom = ViewName.PlayerCardAchievementSelectView
	})
	arg_16_0:closeThis()
end

return var_0_0
