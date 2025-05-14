module("modules.logic.dungeon.view.DungeonChangeMapStatusView", package.seeall)

local var_0_0 = class("DungeonChangeMapStatusView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagesun = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_sun")
	arg_1_0._simagemoon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_moon")
	arg_1_0._simagesun1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Sun/ani/#simage_sun1")
	arg_1_0._simagesun2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Sun/ani/#simage_sun2")
	arg_1_0._simagemoon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Moon/ani/#simage_moon1")
	arg_1_0._simagemoon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Moon/ani/#simage_moon2")

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
	arg_4_0._changeAnimatorPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)

	arg_4_0._simagesun:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_sun_3"))
	arg_4_0._simagemoon:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_moon_3"))
	arg_4_0._simagesun1:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_sun_1"))
	arg_4_0._simagesun2:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_sun_2"))
	arg_4_0._simagemoon1:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_moon_1"))
	arg_4_0._simagemoon2:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_moon_2"))
end

function var_0_0._changeTime(arg_5_0, arg_5_1)
	AudioMgr.instance:trigger(arg_5_1 == "moon" and AudioEnum.VersionActivity1_3.play_ui_molu_night_switch or AudioEnum.VersionActivity1_3.play_ui_molu_daytime_switch)
	arg_5_0._changeAnimatorPlayer:Play("to_" .. arg_5_1, arg_5_0._changeDone, arg_5_0)
end

function var_0_0._changeDone(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_changeTime(arg_7_0.viewParam)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:_changeTime(arg_8_0.viewParam)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagesun:UnLoadImage()
	arg_10_0._simagemoon:UnLoadImage()
	arg_10_0._simagesun1:UnLoadImage()
	arg_10_0._simagesun2:UnLoadImage()
	arg_10_0._simagemoon1:UnLoadImage()
	arg_10_0._simagemoon2:UnLoadImage()
end

return var_0_0
