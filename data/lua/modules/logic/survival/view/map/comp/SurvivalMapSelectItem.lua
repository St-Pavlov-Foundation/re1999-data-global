module("modules.logic.survival.view.map.comp.SurvivalMapSelectItem", package.seeall)

local var_0_0 = class("SurvivalMapSelectItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._callback = arg_1_1.callback
	arg_1_0._callobj = arg_1_1.callobj
	arg_1_0._mapInfo = arg_1_1.mapInfo
	arg_1_0._index = arg_1_1.index
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._anim = gohelper.findChildAnim(arg_2_1, "")
	arg_2_0._goinfo = gohelper.findChild(arg_2_1, "info")
	arg_2_0._txtname = gohelper.findChildTextMesh(arg_2_1, "info/namebg/txt_map")
	arg_2_0._goselect = gohelper.findChild(arg_2_1, "info/#go_select")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_1, "info/#btn_click")
	arg_2_0._simageBg = gohelper.findChildSingleImage(arg_2_1, "#simage_bg")
	arg_2_0._gohard = gohelper.findChild(arg_2_1, "#simage_bghard")
	arg_2_0._simageIcon = gohelper.findChildSingleImage(arg_2_1, "info/#simage_icon")
	arg_2_0._goempty = gohelper.findChild(arg_2_1, "empty")

	arg_2_0:_refreshView()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._onClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
end

function var_0_0._refreshView(arg_5_0)
	gohelper.setActive(arg_5_0._goempty, not arg_5_0._mapInfo)
	gohelper.setActive(arg_5_0._goinfo, arg_5_0._mapInfo)

	if arg_5_0._mapInfo then
		arg_5_0._txtname.text = GameUtil.setFirstStrSize(arg_5_0._mapInfo.groupCo.name, 56)

		arg_5_0._simageBg:LoadImage(ResUrl.getSurvivalMapIcon(string.format("survival_map_newblock_%d_%d", arg_5_0._index, arg_5_0._mapInfo.level)))
		arg_5_0._simageIcon:LoadImage(ResUrl.getSurvivalMapIcon("survival_map_block0" .. arg_5_0._mapInfo.groupCo.type))
		gohelper.setActive(arg_5_0._gohard, arg_5_0._mapInfo.level == 3)
	else
		arg_5_0._simageBg:LoadImage(ResUrl.getSurvivalMapIcon(string.format("survival_map_newblock_%d_%d", arg_5_0._index, 0)))
		gohelper.setActive(arg_5_0._gohard, false)
	end
end

function var_0_0.playUnlockAnim(arg_6_0)
	arg_6_0._anim:Play("unlock", 0, 0)
end

function var_0_0._onClick(arg_7_0)
	if not arg_7_0._mapInfo then
		return
	end

	arg_7_0._callback(arg_7_0._callobj, arg_7_0._index)
end

function var_0_0.setIsSelect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goselect, arg_8_1)
end

return var_0_0
