module("modules.logic.story.view.StorySelectListItem", package.seeall)

local var_0_0 = class("StorySelectListItem")
local var_0_1 = 0.6
local var_0_2 = 0.9
local var_0_3 = 1.25
local var_0_4 = 0.5
local var_0_5 = 300
local var_0_6 = 0.5

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.viewGO = gohelper.cloneInPlace(arg_1_1)

	gohelper.setActive(arg_1_0.viewGO, true)

	arg_1_0.viewParam = arg_1_2
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnselect")
	arg_1_0._gobgdark = gohelper.findChild(arg_1_0.viewGO, "bgdark")
	arg_1_0._txtcontentdark = gohelper.findChildText(arg_1_0.viewGO, "bgdark/txtcontentdark")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "bgdark/icon")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "bgdark/bg")

	arg_1_0._btnselect:AddClickListener(arg_1_0._btnselectOnClick, arg_1_0)
	arg_1_0:_refreshItem()
end

function var_0_0.removeEvents(arg_2_0)
	arg_2_0._btnselect:RemoveClickListener()
end

function var_0_0.getOptionIndex(arg_3_0)
	return arg_3_0.viewParam.index
end

function var_0_0._btnselectOnClick(arg_4_0)
	local var_4_0 = {
		stepId = arg_4_0.viewParam.stepId,
		index = arg_4_0.viewParam.index
	}

	StoryModel.instance:addLog(var_4_0)
	StoryController.instance:dispatchEvent(StoryEvent.OnSelectOptionView, arg_4_0.viewParam.index)
end

function var_0_0.onSelectOptionView(arg_5_0)
	ZProj.TweenHelper.DOFadeCanvasGroup(arg_5_0.viewGO, 1, 0, var_0_2, arg_5_0._onSelectOption, arg_5_0)
	ZProj.TweenHelper.DOScale(arg_5_0.viewGO.transform, var_0_3, var_0_3, 1, var_0_4)
end

function var_0_0._onSelectOption(arg_6_0)
	StoryController.instance:dispatchEvent(StoryEvent.FinishSelectOptionView, arg_6_0.viewParam.index)
	StoryController.instance:playStep(arg_6_0.viewParam.id)
	arg_6_0:destroy()
end

function var_0_0.onSelectOtherOptionView(arg_7_0)
	ZProj.UGUIHelper.SetGrayscale(arg_7_0._goicon, true)
	ZProj.UGUIHelper.SetGrayscale(arg_7_0._gobg, true)
	ZProj.UGUIHelper.SetGrayscale(arg_7_0._txtcontentdark.gameObject, true)
	ZProj.TweenHelper.DOLocalMoveX(arg_7_0.viewGO.transform, var_0_5, var_0_6)
	ZProj.TweenHelper.DOFadeCanvasGroup(arg_7_0.viewGO, 1, 0, var_0_2, arg_7_0._OnSelectOtherOption, arg_7_0)
end

function var_0_0._OnSelectOtherOption(arg_8_0)
	StoryController.instance:dispatchEvent(StoryEvent.FinishSelectOptionView, arg_8_0.viewParam.index)
	arg_8_0:destroy()
end

function var_0_0.reset(arg_9_0, arg_9_1)
	arg_9_0.viewParam = arg_9_1

	arg_9_0:_refreshItem()
end

function var_0_0._refreshItem(arg_10_0)
	ZProj.TweenHelper.KillByObj(arg_10_0.viewGO)
	ZProj.TweenHelper.DOFadeCanvasGroup(arg_10_0.viewGO, 0, 1, var_0_1)

	arg_10_0._txtcontentdark.text = tonumber(arg_10_0.viewParam.name) and luaLang(arg_10_0.viewParam.name) or arg_10_0.viewParam.name
end

function var_0_0.destroy(arg_11_0)
	arg_11_0:removeEvents()
	ZProj.TweenHelper.KillByObj(arg_11_0.viewGO)
	gohelper.destroy(arg_11_0.viewGO)
end

return var_0_0
