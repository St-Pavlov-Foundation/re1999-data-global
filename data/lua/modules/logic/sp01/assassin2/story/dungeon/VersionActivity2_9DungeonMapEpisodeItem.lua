module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapEpisodeItem", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapEpisodeItem", VersionActivityFixedDungeonMapEpisodeItem)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._goselect1 = gohelper.findChild(arg_1_0.viewGO, "#go_scale/section/#go_bgicon1/#go_select")
	arg_1_0._gounselect1 = gohelper.findChild(arg_1_0.viewGO, "#go_scale/section/#go_bgicon1/#go_unselect")
	arg_1_0._goselect2 = gohelper.findChild(arg_1_0.viewGO, "#go_scale/section/#go_bgicon2/#go_select")
	arg_1_0._gounselect2 = gohelper.findChild(arg_1_0.viewGO, "#go_scale/section/#go_bgicon2/#go_unselect")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_progress")
	arg_1_0._goprogressitem = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_progress/#go_progressitem")
	arg_1_0._txtsection2 = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/section/mask/#txt_section")
	arg_1_0._godnaclickarea = gohelper.findChild(arg_1_0.viewGO, "#go_dnaclickarea")
end

function var_0_0.refreshUI(arg_2_0)
	var_0_0.super.refreshUI(arg_2_0)

	arg_2_0._txtsection2.text = arg_2_0._txtsection.text
end

function var_0_0.refreshFocusStatus(arg_3_0)
	var_0_0.super.refreshFocusStatus(arg_3_0)

	local var_3_0 = arg_3_0._config.id == arg_3_0.activityDungeonMo.episodeId

	gohelper.setActive(arg_3_0._goselect1, var_3_0)
	gohelper.setActive(arg_3_0._gounselect1, not var_3_0)
	gohelper.setActive(arg_3_0._goselect2, var_3_0)
	gohelper.setActive(arg_3_0._gounselect2, not var_3_0)
end

function var_0_0.onClick(arg_4_0)
	if arg_4_0.isLock then
		ViewMgr.instance:openView(ViewName.DungeonMapTaskView, {
			viewParam = arg_4_0._config.preEpisode
		})

		return
	end

	local var_4_0 = ViewName.VersionActivity2_9DungeonMapLevelView
	local var_4_1 = ViewMgr.instance:getContainer(var_4_0)

	if var_4_1 then
		var_4_1:stopCloseViewTask()

		if var_4_1:getOpenedEpisodeId() == arg_4_0._config.id then
			ViewMgr.instance:closeView(var_4_0)

			return
		end
	end

	arg_4_0.activityDungeonMo:changeEpisode(arg_4_0:getEpisodeId())
	arg_4_0._layout:setSelectEpisodeItem(arg_4_0)
	ViewMgr.instance:openView(var_4_0, {
		episodeId = arg_4_0._config.id
	})
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnSelectEpisodeItem, arg_4_0._levelIndex, true)
end

function var_0_0.refreshStar(arg_5_0)
	local var_5_0 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_5_0._config)

	gohelper.CreateObjList(arg_5_0, arg_5_0.refreshEpisodeSingleProgress, var_5_0, arg_5_0._goprogress, arg_5_0._goprogressitem)
end

function var_0_0.refreshEpisodeSingleProgress(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = gohelper.findChildSlider(arg_6_1, "slider_progress")
	local var_6_1 = gohelper.findChildImage(arg_6_1, "slider_progress/Fill Area/Fill")
	local var_6_2 = gohelper.findChildText(arg_6_1, "txt_progress")
	local var_6_3 = arg_6_2.id

	VersionActivity2_9DungeonHelper.setEpisodeProgressBg(var_6_3, var_6_1)

	local var_6_4 = VersionActivity2_9DungeonHelper.calcEpisodeProgress(var_6_3)

	var_6_2.text = VersionActivity2_9DungeonHelper.formatEpisodeProgress(var_6_4)

	var_6_0:SetValue(var_6_4)
	arg_6_0:refreshModeIcon(var_6_3, arg_6_1)
end

function var_0_0.refreshModeIcon(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = VersionActivity2_9DungeonHelper.getEpisodeMode(arg_7_1)

	for iter_7_0, iter_7_1 in pairs(VersionActivityDungeonBaseEnum.DungeonMode) do
		local var_7_1 = gohelper.findChild(arg_7_2, "image_icon" .. iter_7_1)

		if not gohelper.isNil(var_7_1) then
			gohelper.setActive(var_7_1, var_7_0 == iter_7_1)
		end
	end
end

function var_0_0.isScreenPosInDNAClickArea(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	return recthelper.screenPosInRect(arg_8_0._godnaclickarea.transform, nil, arg_8_1.x, arg_8_1.y)
end

return var_0_0
