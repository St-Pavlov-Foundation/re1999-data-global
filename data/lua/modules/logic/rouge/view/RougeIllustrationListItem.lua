module("modules.logic.rouge.view.RougeIllustrationListItem", package.seeall)

local var_0_0 = class("RougeIllustrationListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0._goUnlocked = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_Unlocked/#go_new")
	arg_1_0._simageItemPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Unlocked/#simage_ItemPic")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/#txt_Name")
	arg_1_0._txtNameEn = gohelper.findChildText(arg_1_0.viewGO, "#go_Unlocked/#txt_Name/#txt_NameEn")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Unlocked/#btn_click")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	RougeController.instance:openRougeIllustrationDetailView(arg_4_0._mo)
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goSelected, false)

	arg_5_0._click = gohelper.getClickWithDefaultAudio(arg_5_0._goLocked, arg_5_0)

	arg_5_0._click:AddClickListener(arg_5_0._onClick, arg_5_0)
	arg_5_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, arg_5_0._updateNewFlag, arg_5_0)
end

function var_0_0._onClick(arg_6_0)
	GameFacade.showToast(ToastEnum.RougeIllustrationLockTip)
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1.config

	arg_9_0._simageItemPic:LoadImage(arg_9_0._mo.image)

	arg_9_0._txtName.text = arg_9_0._mo.name
	arg_9_0._txtNameEn.text = arg_9_0._mo.nameEn

	if UnityEngine.Time.frameCount - RougeIllustrationListModel.instance.startFrameCount < 10 then
		arg_9_0._aniamtor = gohelper.onceAddComponent(arg_9_0.viewGO, gohelper.Type_Animator)

		arg_9_0._aniamtor:Play("open")
	end

	local var_9_0 = RougeOutsideModel.instance:passedAnyEventId(arg_9_1.eventIdList)

	gohelper.setActive(arg_9_0._goUnlocked, var_9_0)
	gohelper.setActive(arg_9_0._goLocked, not var_9_0)

	if var_9_0 then
		arg_9_0:_updateNewFlag()
	end
end

function var_0_0._updateNewFlag(arg_10_0)
	arg_10_0._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Illustration, arg_10_0._mo.id) ~= nil

	gohelper.setActive(arg_10_0._gonew, arg_10_0._showNewFlag)
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._click then
		arg_12_0._click:RemoveClickListener()
	end
end

return var_0_0
