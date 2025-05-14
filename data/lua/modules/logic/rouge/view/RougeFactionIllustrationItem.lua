module("modules.logic.rouge.view.RougeFactionIllustrationItem", package.seeall)

local var_0_0 = class("RougeFactionIllustrationItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._goBg = gohelper.findChild(arg_1_0.viewGO, "#go_Locked/#go_Bg")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_Locked/#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_name")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_name/#txt_en")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_Locked/#scroll_desc")
	arg_1_0._txtscrollDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#scroll_desc/viewport/content/#txt_scrollDesc")
	arg_1_0._txtlocked = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/bg/#txt_locked")
	arg_1_0._goUnselect = gohelper.findChild(arg_1_0.viewGO, "#go_Unselect")
	arg_1_0._goBg2 = gohelper.findChild(arg_1_0.viewGO, "#go_Unselect/#go_Bg2")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_Unselect/#go_new")
	arg_1_0._imageicon2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_Unselect/#image_icon2")
	arg_1_0._txtname2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Unselect/#txt_name2")
	arg_1_0._txten2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Unselect/#txt_name2/#txt_en2")
	arg_1_0._scrolldesc2 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_Unselect/#scroll_desc2")
	arg_1_0._txtscrollDesc2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Unselect/#scroll_desc2/viewport/content/#txt_scrollDesc2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._click = gohelper.getClickWithDefaultAudio(arg_4_0._goBg2, arg_4_0)
	arg_4_0._clickLocked = gohelper.getClickWithDefaultAudio(arg_4_0._goLocked, arg_4_0)

	arg_4_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, arg_4_0._updateNewFlag, arg_4_0)
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._click:AddClickListener(arg_5_0._onClickHandler, arg_5_0)
	arg_5_0._clickLocked:AddClickListener(arg_5_0._onClickLockedHandler, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._click:RemoveClickListener()
	arg_6_0._clickLocked:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._isUnlocked = arg_7_1.isUnLocked
	arg_7_0._mo = arg_7_1.styleCO

	gohelper.setActive(arg_7_0._goUnselect, arg_7_0._isUnlocked)
	gohelper.setActive(arg_7_0._goLocked, not arg_7_0._isUnlocked)

	if not arg_7_0._isUnlocked then
		local var_7_0 = RougeOutsideModel.instance:config()

		arg_7_0._txtlocked.text = var_7_0:getStyleLockDesc(arg_7_0._mo.id)

		arg_7_0:_updateInfo(arg_7_0._txtname, arg_7_0._txten, arg_7_0._txtscrollDesc, arg_7_0._imageicon)
	else
		arg_7_0:_updateInfo(arg_7_0._txtname2, arg_7_0._txten2, arg_7_0._txtscrollDesc2, arg_7_0._imageicon2)
		arg_7_0:_updateNewFlag()
	end
end

function var_0_0._updateNewFlag(arg_8_0)
	arg_8_0._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Faction, arg_8_0._mo.id) ~= nil

	gohelper.setActive(arg_8_0._gonew, arg_8_0._showNewFlag)
end

function var_0_0._updateInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_1.text = arg_9_0._mo.name
	arg_9_3.text = arg_9_0._mo.desc

	UISpriteSetMgr.instance:setRouge2Sprite(arg_9_4, string.format("%s_light", arg_9_0._mo.icon))
	gohelper.setActive(arg_9_2, false)
end

function var_0_0._onClickLockedHandler(arg_10_0)
	GameFacade.showToast(ToastEnum.RougeFactionLockTip)
end

function var_0_0._onClickHandler(arg_11_0)
	RougeController.instance:openRougeFactionIllustrationDetailView(arg_11_0._mo)
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
