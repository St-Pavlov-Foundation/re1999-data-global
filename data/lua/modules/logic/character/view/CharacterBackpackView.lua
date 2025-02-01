module("modules.logic.character.view.CharacterBackpackView", package.seeall)

slot0 = class("CharacterBackpackView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gorolecategory = gohelper.findChild(slot0.viewGO, "category/#go_rolecategory")
	slot0._goequipcategory = gohelper.findChild(slot0.viewGO, "category/#go_equipcategory")
	slot0._goequipsub = gohelper.findChild(slot0.viewGO, "category/#go_equipsub")
	slot0._goequipsubcategory1 = gohelper.findChild(slot0.viewGO, "category/#go_equipsub/#go_equipsubcategory1")
	slot0._goequipsubcategory2 = gohelper.findChild(slot0.viewGO, "category/#go_equipsub/#go_equipsubcategory2")
	slot0._goequipsubcategory3 = gohelper.findChild(slot0.viewGO, "category/#go_equipsub/#go_equipsubcategory3")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bgimg")

	slot0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))

	slot0._isFirstOpenCharacter = true
	slot0._isFirstOpenEquip = true
end

function slot0.initCategory(slot0)
	slot0._categoryList = slot0:getUserDataTb_()

	slot0:_refreshCategorys()
end

function slot0._refreshCategorys(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._categoryList) do
		slot6:destroyView()
	end

	slot0._categoryList = slot0:getUserDataTb_()
	slot4 = CharacterCategoryItem.New()

	slot4:initView(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gorolecategory), {
		index = 1,
		enName = "CREW",
		name = luaLang("activitynovicesign_character")
	})
	table.insert(slot0._categoryList, slot4)
	slot0:_setCategory(slot1)
end

function slot0._onFuncUnlockRefresh(slot0)
	slot0:_refreshCategorys(slot0.cur_select_tab)
end

function slot0._changeCategory(slot0, slot1)
	if slot1 == 2 and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))

		return
	end

	for slot5, slot6 in ipairs(slot0._categoryList) do
		slot6:updateSeletedStatus(slot1)
	end

	slot2 = slot1 == 2

	slot0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/" .. (slot2 and "zhuangbei_006" or "juesebeibao_005")))
	gohelper.setActive(slot0._goequipsub, slot2)

	if slot2 then
		if slot0._isFirstOpenEquip then
			slot0.viewContainer:playEquipOpenAnimation()

			slot0._isFirstOpenEquip = false
		end
	elseif slot0._isFirstOpenCharacter then
		slot0.viewContainer:playCardOpenAnimation()

		slot0._isFirstOpenCharacter = false
	end

	slot0.viewContainer:switchTab(slot1)

	slot0.cur_select_tab = slot1
end

function slot0.onOpen(slot0)
	slot0:initCategory()
	slot0:_addEvent()
end

function slot0.onUpdateParam(slot0)
	slot0:_setCategory()
end

function slot0._setCategory(slot0, slot1)
	slot0:_changeCategory((slot1 or slot0.viewParam and slot0.viewParam.jumpTab or JumpEnum.CharacterBackpack.Character) == JumpEnum.CharacterBackpack.Equip and 2 or 1)
end

function slot0.onClose(slot0)
	slot0:_removeEvent()
end

function slot0._addEvent(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.BackpackChangeCategory, slot0._changeCategory, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0._onFuncUnlockRefresh, slot0)
end

function slot0._removeEvent(slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.BackpackChangeCategory, slot0._changeCategory, slot0)
	slot0:removeEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0._onFuncUnlockRefresh, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._imgBg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._categoryList) do
		slot5:destroyView()
	end
end

return slot0
