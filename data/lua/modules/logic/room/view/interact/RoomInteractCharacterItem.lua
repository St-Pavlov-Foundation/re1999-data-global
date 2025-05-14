module("modules.logic.room.view.interact.RoomInteractCharacterItem", package.seeall)

local var_0_0 = class("RoomInteractCharacterItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goonbirthdayicon = gohelper.findChild(arg_1_0.viewGO, "#go_onbirthdayicon")

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

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._view and arg_4_0._view.viewContainer and arg_4_0._mo then
		arg_4_0._view.viewContainer:dispatchEvent(RoomEvent.InteractBuildingSelectHero, arg_4_0._mo.heroId)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simageicon = gohelper.findChildSingleImage(arg_5_0.viewGO, "role/heroicon")
	arg_5_0._gobeplaced = gohelper.findChild(arg_5_0.viewGO, "placeicon")
	arg_5_0._goclick = gohelper.findChild(arg_5_0.viewGO, "go_click")
	arg_5_0._goselect = gohelper.findChild(arg_5_0.viewGO, "select")
	arg_5_0._gotrust = gohelper.findChild(arg_5_0.viewGO, "trust")
	arg_5_0._txttrust = gohelper.findChildText(arg_5_0.viewGO, "trust/txt_trust")
	arg_5_0._gorole = gohelper.findChild(arg_5_0.viewGO, "role")
	arg_5_0._imagecareer = gohelper.findChildImage(arg_5_0.viewGO, "role/career")
	arg_5_0._imagerare = gohelper.findChildImage(arg_5_0.viewGO, "role/rare")
	arg_5_0._txtname = gohelper.findChildText(arg_5_0.viewGO, "role/name")
	arg_5_0._txtnameen = gohelper.findChildText(arg_5_0.viewGO, "role/name/nameEn")
	arg_5_0._canvasGroup = arg_5_0._gorole:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.addUIClickAudio(arg_5_0._goclick, AudioEnum.UI.UI_Common_Click)

	arg_5_0._uiclick = SLFramework.UGUI.UIClickListener.Get(arg_5_0._goclick)

	arg_5_0._uiclick:AddClickListener(arg_5_0._btnclickOnClick, arg_5_0)
	gohelper.setActive(arg_5_0._gotrust, false)
	gohelper.setActive(arg_5_0._gobeplaced, false)
	gohelper.setActive(gohelper.findChild(arg_5_0._gobeplaced, "icon"), false)
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:_refreshUI()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._uiclick:RemoveClickListener()
	arg_10_0._simageicon:UnLoadImage()
end

function var_0_0._refreshUI(arg_11_0)
	arg_11_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(arg_11_0._mo.skinConfig.headIcon))
	gohelper.setActive(arg_11_0._gobeplaced, arg_11_0._mo.use)

	local var_11_0 = RoomCharacterModel.instance:isOnBirthday(arg_11_0._mo.heroConfig.id)

	gohelper.setActive(arg_11_0._goonbirthdayicon, var_11_0)

	if arg_11_0._mo.use then
		arg_11_0._canvasGroup.alpha = 0.7
	else
		arg_11_0._canvasGroup.alpha = 1
	end

	gohelper.addUIClickAudio(arg_11_0._goclick, arg_11_0._mo.use and AudioEnum.UI.UI_Common_Click or AudioEnum.UI.Play_UI_Copies)
	UISpriteSetMgr.instance:setCommonSprite(arg_11_0._imagecareer, "lssx_" .. arg_11_0._mo.heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_11_0._imagerare, "bgequip" .. CharacterEnum.Color[arg_11_0._mo.heroConfig.rare])

	arg_11_0._txtname.text = arg_11_0._mo.heroConfig.name
	arg_11_0._txtnameen.text = arg_11_0._mo.heroConfig.nameEng
end

var_0_0.prefabUrl = "ui/viewres/room/roomcharacterplaceitem.prefab"

return var_0_0
