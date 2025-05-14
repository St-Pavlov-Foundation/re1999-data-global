module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapViewContainer", package.seeall)

local var_0_0 = class("YaXianMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, YaXianMapView.New())
	table.insert(var_1_0, YaXianMapWindowView.New())
	table.insert(var_1_0, YaXianMapAudioView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				true
			}, HelpEnum.HelpId.YaxianChessHelp)
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0:initViewParam()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.YaXian)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.YaXian
	})
	AudioMgr.instance:trigger(AudioEnum.YaXian.EnterYaXianMap)
end

function var_0_0.initViewParam(arg_4_0)
	arg_4_0.chapterId = arg_4_0.viewParam and arg_4_0.viewParam.chapterId

	if not arg_4_0.chapterId then
		arg_4_0.chapterId = YaXianModel.instance:getLastCanFightEpisodeMo().config.chapterId
	end

	if not YaXianController.instance:checkChapterIsUnlock(arg_4_0.chapterId) then
		arg_4_0.chapterId = YaXianEnum.DefaultChapterId
	end
end

function var_0_0.changeChapterId(arg_5_0, arg_5_1)
	if arg_5_0.chapterId == arg_5_1 then
		return
	end

	arg_5_0.chapterId = arg_5_1

	YaXianController.instance:dispatchEvent(YaXianEvent.OnSelectChapterChange)
end

function var_0_0.setVisibleInternal(arg_6_0, arg_6_1)
	if YaXianModel.instance:checkIsPlayingClickAnimation() then
		return
	end

	var_0_0.super.setVisibleInternal(arg_6_0, arg_6_1)
end

return var_0_0
