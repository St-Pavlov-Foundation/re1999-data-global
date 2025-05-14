module("modules.logic.character.view.CharacterBackpackView", package.seeall)

local var_0_0 = class("CharacterBackpackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gorolecategory = gohelper.findChild(arg_1_0.viewGO, "category/#go_rolecategory")
	arg_1_0._goequipcategory = gohelper.findChild(arg_1_0.viewGO, "category/#go_equipcategory")
	arg_1_0._goequipsub = gohelper.findChild(arg_1_0.viewGO, "category/#go_equipsub")
	arg_1_0._goequipsubcategory1 = gohelper.findChild(arg_1_0.viewGO, "category/#go_equipsub/#go_equipsubcategory1")
	arg_1_0._goequipsubcategory2 = gohelper.findChild(arg_1_0.viewGO, "category/#go_equipsub/#go_equipsubcategory2")
	arg_1_0._goequipsubcategory3 = gohelper.findChild(arg_1_0.viewGO, "category/#go_equipsub/#go_equipsubcategory3")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")

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
	arg_4_0._imgBg = gohelper.findChildSingleImage(arg_4_0.viewGO, "bg/#simage_bgimg")

	arg_4_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))

	arg_4_0._isFirstOpenCharacter = true
	arg_4_0._isFirstOpenEquip = true
end

function var_0_0.initCategory(arg_5_0)
	arg_5_0._categoryList = arg_5_0:getUserDataTb_()

	arg_5_0:_refreshCategorys()
end

function var_0_0._refreshCategorys(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._categoryList) do
		iter_6_1:destroyView()
	end

	arg_6_0._categoryList = arg_6_0:getUserDataTb_()

	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[2]
	local var_6_1 = arg_6_0:getResInst(var_6_0, arg_6_0._gorolecategory)
	local var_6_2 = CharacterCategoryItem.New()

	var_6_2:initView(var_6_1, {
		index = 1,
		enName = "CREW",
		name = luaLang("activitynovicesign_character")
	})
	table.insert(arg_6_0._categoryList, var_6_2)
	arg_6_0:_setCategory(arg_6_1)
end

function var_0_0._onFuncUnlockRefresh(arg_7_0)
	arg_7_0:_refreshCategorys(arg_7_0.cur_select_tab)
end

function var_0_0._changeCategory(arg_8_0, arg_8_1)
	if arg_8_1 == 2 and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))

		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._categoryList) do
		iter_8_1:updateSeletedStatus(arg_8_1)
	end

	local var_8_0 = arg_8_1 == 2
	local var_8_1 = var_8_0 and "zhuangbei_006" or "juesebeibao_005"

	arg_8_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/" .. var_8_1))
	gohelper.setActive(arg_8_0._goequipsub, var_8_0)

	if var_8_0 then
		if arg_8_0._isFirstOpenEquip then
			arg_8_0.viewContainer:playEquipOpenAnimation()

			arg_8_0._isFirstOpenEquip = false
		end
	elseif arg_8_0._isFirstOpenCharacter then
		arg_8_0.viewContainer:playCardOpenAnimation()

		arg_8_0._isFirstOpenCharacter = false
	end

	arg_8_0.viewContainer:switchTab(arg_8_1)

	arg_8_0.cur_select_tab = arg_8_1
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:initCategory()
	arg_9_0:_addEvent()
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:_setCategory()
end

function var_0_0._setCategory(arg_11_0, arg_11_1)
	local var_11_0 = (arg_11_1 or arg_11_0.viewParam and arg_11_0.viewParam.jumpTab or JumpEnum.CharacterBackpack.Character) == JumpEnum.CharacterBackpack.Equip and 2 or 1

	arg_11_0:_changeCategory(var_11_0)
end

function var_0_0.onClose(arg_12_0)
	arg_12_0:_removeEvent()
end

function var_0_0._addEvent(arg_13_0)
	arg_13_0:addEventCb(CharacterController.instance, CharacterEvent.BackpackChangeCategory, arg_13_0._changeCategory, arg_13_0)
	arg_13_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_13_0._onFuncUnlockRefresh, arg_13_0)
end

function var_0_0._removeEvent(arg_14_0)
	arg_14_0:removeEventCb(CharacterController.instance, CharacterEvent.BackpackChangeCategory, arg_14_0._changeCategory, arg_14_0)
	arg_14_0:removeEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_14_0._onFuncUnlockRefresh, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._imgBg:UnLoadImage()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._categoryList) do
		iter_15_1:destroyView()
	end
end

return var_0_0
