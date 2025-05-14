module("modules.logic.player.view.PlayerClothGuideView", package.seeall)

local var_0_0 = class("PlayerClothGuideView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_bg")
	arg_1_0._btnlook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_look")
	arg_1_0._simagedecorate1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_decorate1")
	arg_1_0._simagedecorate3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_decorate3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlook:AddClickListener(arg_2_0._btnlookOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlook:RemoveClickListener()
end

function var_0_0._btnlookOnClick(arg_4_0)
	if Time.realtimeSinceStartup - arg_4_0._startTime <= 3 then
		return
	end

	arg_4_0:closeThis()

	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		return
	end

	local var_4_0 = 10113
	local var_4_1 = DungeonConfig.instance:getEpisodeCO(var_4_0).chapterId
	local var_4_2 = DungeonConfig.instance:getChapterCO(var_4_1)

	arg_4_0._jumpParam = arg_4_0._jumpParam or {}
	arg_4_0._jumpParam.chapterType = var_4_2.type
	arg_4_0._jumpParam.chapterId = var_4_1

	DungeonController.instance:jumpDungeon(arg_4_0._jumpParam)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._startTime = Time.realtimeSinceStartup

	arg_5_0._simagebg:LoadImage(ResUrl.getCommonIcon("yd_yindaodi_2"))
	arg_5_0._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	arg_5_0._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
	arg_9_0._simagedecorate1:UnLoadImage()
	arg_9_0._simagedecorate3:UnLoadImage()
end

return var_0_0
