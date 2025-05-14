module("modules.logic.room.view.critter.detail.RoomCriiterDetailSimpleView", package.seeall)

local var_0_0 = class("RoomCriiterDetailSimpleView", RoomCritterDetailView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagecard = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_card")
	arg_1_0._imagesort = gohelper.findChildImage(arg_1_0.viewGO, "#image_sort")
	arg_1_0._txtsort = gohelper.findChildText(arg_1_0.viewGO, "#image_sort/#txt_sort")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._gocrittericon = gohelper.findChild(arg_1_0.viewGO, "critter/#go_crittericon")
	arg_1_0._txttag1 = gohelper.findChildText(arg_1_0.viewGO, "tag/#txt_tag1")
	arg_1_0._txttag2 = gohelper.findChildText(arg_1_0.viewGO, "tag/#txt_tag2")
	arg_1_0._scrolldes = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_des")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_des/viewport/content/#txt_Desc")
	arg_1_0._scrollbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "base/#scroll_base")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "base/#scroll_base/viewport/content/#go_baseitem")
	arg_1_0._scrollskill = gohelper.findChildScrollRect(arg_1_0.viewGO, "skill/#scroll_skill")
	arg_1_0._goskillItem = gohelper.findChild(arg_1_0.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem")
	arg_1_0._txtskillname = gohelper.findChildText(arg_1_0.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname/#image_icon")
	arg_1_0._txtskilldec = gohelper.findChildText(arg_1_0.viewGO, "skill/#scroll_skill/viewport/content/#go_skillItem/#txt_skilldec")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "starList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._critterMo = arg_6_0.viewParam.critterMo

	gohelper.setActive(arg_6_0._gobaseitem.gameObject, false)
	gohelper.setActive(arg_6_0._goskillItem.gameObject, false)
	arg_6_0:showInfo()
	arg_6_0:setCritterIcon()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_ka2)
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0._simagecard then
		arg_7_0._simagecard:UnLoadImage()
	end
end

function var_0_0.getAttrRatioColor(arg_8_0)
	return "#222222", "#222222"
end

function var_0_0.setCritterIcon(arg_9_0)
	if not arg_9_0._critterIcon then
		arg_9_0._critterIcon = IconMgr.instance:getCommonCritterIcon(arg_9_0._gocrittericon)
	end

	arg_9_0._critterIcon:onUpdateMO(arg_9_0._critterMo, true)
	arg_9_0._critterIcon:hideMood()

	local var_9_0 = arg_9_0._critterMo:getDefineCfg().rare

	if arg_9_0._simagecard then
		local var_9_1 = CritterConfig.instance:getCritterRareCfg(var_9_0)
		local var_9_2 = ResUrl.getRoomCritterIcon(var_9_1.cardRes)

		arg_9_0._simagecard:LoadImage(var_9_2)
	end
end

function var_0_0.refrshCritterSpine(arg_10_0)
	return
end

return var_0_0
