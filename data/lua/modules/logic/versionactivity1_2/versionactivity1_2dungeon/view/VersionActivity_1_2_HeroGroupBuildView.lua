module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupBuildView", package.seeall)

local var_0_0 = class("VersionActivity_1_2_HeroGroupBuildView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._facilitycontain = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/facilitycontain")
	arg_1_0._txtplacedcount = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/facilitycontain/info/#txt_placedcount")
	arg_1_0._btnfacilitydetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/facilitycontain/info/#txt_placedcount/#btn_facilitydetail", AudioEnum.TeachNote.play_ui_activity_switch)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfacilitydetail:AddClickListener(arg_2_0._onBtnDetail, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfacilitydetail:RemoveClickListener()
end

function var_0_0._onBtnDetail(arg_4_0)
	if #arg_4_0._gainList == 0 then
		GameFacade.showToast(ToastEnum.Act114BuildingIsEmpty)
	else
		ViewMgr.instance:openView(ViewName.VersionActivity_1_2_FacilityTipsView)
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onRefreshViewParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = DungeonModel.instance:hasPassLevelAndStory(1210105)
	local var_7_1 = FightModel.instance:getFightParam()

	if var_7_1 then
		local var_7_2 = DungeonConfig.instance:getEpisodeCO(var_7_1.episodeId)

		if var_7_2 and var_7_2.chapterId == 12102 then
			var_7_0 = false
		end
	end

	gohelper.setActive(arg_7_0._facilitycontain, var_7_0)

	arg_7_0._gainList = VersionActivity1_2DungeonModel.instance:getBuildingGainList()
	arg_7_0._txtplacedcount.text = formatLuaLang("versionactivity_1_2_herogroupview_placedcount", #arg_7_0._gainList)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
