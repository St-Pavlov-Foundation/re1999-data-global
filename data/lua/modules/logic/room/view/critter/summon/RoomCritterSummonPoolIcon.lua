module("modules.logic.room.view.critter.summon.RoomCritterSummonPoolIcon", package.seeall)

local var_0_0 = class("RoomCritterSummonPoolIcon", CommonCritterIcon)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagequality = gohelper.findChildImage(arg_1_0.viewGO, "#simage_quality")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._gomood = gohelper.findChild(arg_1_0.viewGO, "#go_mood")
	arg_1_0._gohasMood = gohelper.findChild(arg_1_0.viewGO, "#go_mood/#go_hasMood")
	arg_1_0._simagemood = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_mood/#go_hasMood/#simage_mood")
	arg_1_0._simageprogress = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_mood/#go_hasMood/#simage_progress")
	arg_1_0._txtmood = gohelper.findChildText(arg_1_0.viewGO, "#go_mood/#go_hasMood/#txt_mood")
	arg_1_0._gonoMood = gohelper.findChild(arg_1_0.viewGO, "#go_mood/#go_noMood")
	arg_1_0._gobuildingIcon = gohelper.findChild(arg_1_0.viewGO, "#go_buildingIcon")
	arg_1_0._simagebuildingIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_buildingIcon/#simage_buildingIcon")
	arg_1_0._goindex = gohelper.findChild(arg_1_0.viewGO, "#go_index")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_index/#txt_index")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "#go_num")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_num/#txt_num")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0.mo = arg_2_1

	arg_2_0:setMOValue()
	arg_2_0:activeGo()
end

function var_0_0.setMOValue(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.critterId = arg_3_0.mo.critterId

	arg_3_0:setSelectUIVisible(arg_3_3)
	arg_3_0:refresh()
end

function var_0_0.refresh(arg_4_0)
	var_0_0.super.refresh(arg_4_0)
	arg_4_0:refrshNum()
	arg_4_0:refrshNull()
end

function var_0_0.refreshIcon(arg_5_0)
	local var_5_0 = arg_5_0.mo:getCritterMo():getSkinId()
	local var_5_1 = CritterConfig.instance:getCritterHeadIcon(var_5_0)

	if not string.nilorempty(var_5_1) then
		local var_5_2 = ResUrl.getCritterHedaIcon(var_5_1)

		arg_5_0:_loadIcon(var_5_2)
	end
end

function var_0_0.activeGo(arg_6_0)
	gohelper.setActive(arg_6_0._gomood, false)
	gohelper.setActive(arg_6_0._goindex, false)
	gohelper.setActive(arg_6_0._gonum, true)
end

function var_0_0.refrshNum(arg_7_0)
	arg_7_0._txtnum.text = arg_7_0.mo:getPoolCount()
end

function var_0_0.refrshNull(arg_8_0)
	local var_8_0 = arg_8_0.mo:getPoolCount() <= 0

	gohelper.setActive(arg_8_0._gofinish, var_8_0)
	ZProj.UGUIHelper.SetGrayscale(arg_8_0._imagequality.gameObject, var_8_0)
	ZProj.UGUIHelper.SetGrayscale(arg_8_0._simageicon.gameObject, var_8_0)
end

return var_0_0
