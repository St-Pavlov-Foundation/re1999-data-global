module("modules.logic.story.view.StorySelectListItem", package.seeall)

slot0 = class("StorySelectListItem")
slot1 = 0.6
slot2 = 0.9
slot3 = 1.25
slot4 = 0.5
slot5 = 300
slot6 = 0.5

function slot0.init(slot0, slot1, slot2)
	slot0.viewGO = gohelper.cloneInPlace(slot1)

	gohelper.setActive(slot0.viewGO, true)

	slot0.viewParam = slot2
	slot0._btnselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnselect")
	slot0._gobgdark = gohelper.findChild(slot0.viewGO, "bgdark")
	slot0._txtcontentdark = gohelper.findChildText(slot0.viewGO, "bgdark/txtcontentdark")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "bgdark/icon")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "bgdark/bg")

	slot0._btnselect:AddClickListener(slot0._btnselectOnClick, slot0)
	slot0:_refreshItem()
end

function slot0.removeEvents(slot0)
	slot0._btnselect:RemoveClickListener()
end

function slot0.getOptionIndex(slot0)
	return slot0.viewParam.index
end

function slot0._btnselectOnClick(slot0)
	StoryModel.instance:addLog({
		stepId = slot0.viewParam.stepId,
		index = slot0.viewParam.index
	})
	StoryController.instance:dispatchEvent(StoryEvent.OnSelectOptionView, slot0.viewParam.index)
end

function slot0.onSelectOptionView(slot0)
	ZProj.TweenHelper.DOFadeCanvasGroup(slot0.viewGO, 1, 0, uv0, slot0._onSelectOption, slot0)
	ZProj.TweenHelper.DOScale(slot0.viewGO.transform, uv1, uv1, 1, uv2)
end

function slot0._onSelectOption(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.FinishSelectOptionView, slot0.viewParam.index)
	StoryController.instance:playStep(slot0.viewParam.id)
	slot0:destroy()
end

function slot0.onSelectOtherOptionView(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._goicon, true)
	ZProj.UGUIHelper.SetGrayscale(slot0._gobg, true)
	ZProj.UGUIHelper.SetGrayscale(slot0._txtcontentdark.gameObject, true)
	ZProj.TweenHelper.DOLocalMoveX(slot0.viewGO.transform, uv0, uv1)
	ZProj.TweenHelper.DOFadeCanvasGroup(slot0.viewGO, 1, 0, uv2, slot0._OnSelectOtherOption, slot0)
end

function slot0._OnSelectOtherOption(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.FinishSelectOptionView, slot0.viewParam.index)
	slot0:destroy()
end

function slot0.reset(slot0, slot1)
	slot0.viewParam = slot1

	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	ZProj.TweenHelper.KillByObj(slot0.viewGO)
	ZProj.TweenHelper.DOFadeCanvasGroup(slot0.viewGO, 0, 1, uv0)

	slot0._txtcontentdark.text = tonumber(slot0.viewParam.name) and luaLang(slot0.viewParam.name) or slot0.viewParam.name
end

function slot0.destroy(slot0)
	slot0:removeEvents()
	ZProj.TweenHelper.KillByObj(slot0.viewGO)
	gohelper.destroy(slot0.viewGO)
end

return slot0
