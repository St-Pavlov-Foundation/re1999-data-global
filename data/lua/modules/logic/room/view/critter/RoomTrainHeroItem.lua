module("modules.logic.room.view.critter.RoomTrainHeroItem", package.seeall)

local var_0_0 = class("RoomTrainHeroItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_name")
	arg_1_0._txtquailty = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_quailty")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/head/#image_rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/head/#simage_icon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_select")
	arg_1_0._gogroup = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_group")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_group/#go_baseitem")
	arg_1_0._txtpreference = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_group/go_preferenceitem/#txt_preference")
	arg_1_0._simagepreference = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#go_group/go_preferenceitem/#simage_preference")
	arg_1_0._btnclickitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_clickitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclickitem:AddClickListener(arg_2_0._btnclickitemOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclickitem:RemoveClickListener()
end

function var_0_0._btnclickitemOnClick(arg_4_0)
	if arg_4_0._view and arg_4_0._view.viewContainer then
		arg_4_0._view.viewContainer:dispatchEvent(CritterEvent.UITrainSelectHero, arg_4_0:getDataMO())
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._gopreferenceitem = gohelper.findChild(arg_5_0.viewGO, "#go_content/#go_group/go_preferenceitem")
	arg_5_0._referenceCanvasGroup = gohelper.onceAddComponent(arg_5_0._gopreferenceitem, typeof(UnityEngine.CanvasGroup))
	arg_5_0._txtquailty.text = luaLang(CritterEnum.LangKey.HeroTrainLevel)
	arg_5_0._attrComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._gobaseitem, RoomCritterAttrScrollCell)
	arg_5_0._attrComp._view = arg_5_0._view
	arg_5_0._gograyList = {
		arg_5_0._simagepreference.gameObject
	}
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.getDataMO(arg_8_0)
	return arg_8_0._mo
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	arg_9_0:refreshUI()
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselect, arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._attrComp:onDestroy()
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(arg_12_0._mo.skinConfig.headIcon))

	arg_12_0._txtname.text = arg_12_0._mo.heroConfig.name

	UISpriteSetMgr.instance:setCritterSprite(arg_12_0._imagerare, CritterEnum.QualityImageNameMap[arg_12_0._mo.heroConfig.rare])

	arg_12_0._txtpreference.text = arg_12_0._mo:getPrefernectName()

	if arg_12_0._mo.critterHeroConfig then
		arg_12_0._simagepreference:LoadImage(ResUrl.getCritterHedaIcon(arg_12_0._mo.critterHeroConfig.critterIcon))
	end

	arg_12_0._attrComp:onUpdateMO(arg_12_0._mo:getAttributeInfoMO())

	local var_12_0 = arg_12_0:_isPreference() and 1 or 0.5

	arg_12_0._referenceCanvasGroup.alpha = var_12_0
end

function var_0_0._isPreference(arg_13_0)
	if arg_13_0._mo then
		local var_13_0 = RoomTrainCritterListModel.instance:getSelectId()
		local var_13_1 = RoomTrainCritterListModel.instance:getById(var_13_0)

		if var_13_1 and arg_13_0._mo:chcekPrefernectCritterId(var_13_1:getDefineId()) then
			return true
		end
	end

	return false
end

var_0_0.prefabPath = "ui/viewres/room/critter/roomtrainheroitem.prefab"

return var_0_0
