module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapViewContainer", package.seeall)

local var_0_0 = class("EliminateMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, EliminateMapView.New())
	table.insert(var_1_0, EliminateMapWindowView.New())
	table.insert(var_1_0, EliminateMapAudioView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0:initViewParam()
end

function var_0_0.initViewParam(arg_4_0)
	arg_4_0.chapterId = arg_4_0.viewParam and arg_4_0.viewParam.chapterId

	if not arg_4_0.chapterId then
		arg_4_0.chapterId = EliminateMapModel.instance:getLastCanFightChapterId()
	end

	if not EliminateMapModel.instance:checkChapterIsUnlock(arg_4_0.chapterId) then
		arg_4_0.chapterId = EliminateMapEnum.DefaultChapterId
	end
end

function var_0_0.changeChapterId(arg_5_0, arg_5_1)
	if arg_5_0.chapterId == arg_5_1 then
		return
	end

	arg_5_0.chapterId = arg_5_1

	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.OnSelectChapterChange)
end

function var_0_0.setVisibleInternal(arg_6_0, arg_6_1)
	var_0_0.super.setVisibleInternal(arg_6_0, arg_6_1)
end

return var_0_0
