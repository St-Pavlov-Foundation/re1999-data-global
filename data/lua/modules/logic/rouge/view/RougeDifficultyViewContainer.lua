module("modules.logic.rouge.view.RougeDifficultyViewContainer", package.seeall)

slot0 = class("RougeDifficultyViewContainer", BaseViewContainer)
slot1 = 1

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 480
	slot1.cellHeight = 980
	slot1.cellSpaceH = 36
	slot1.cellSpaceV = 0
	slot0._listScrollParam = slot1
	slot0._difficultyView = RougeDifficultyView.New()

	return {
		slot0._difficultyView,
		TabViewGroup.New(uv0, "#go_lefttop")
	}
end

slot2 = HelpEnum.HelpId.RougeDifficultyViewHelp

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				true
			}, uv1)
		}
	end
end

function slot0.getScrollRect(slot0)
	return slot0._difficultyView._scrollViewLimitScrollCmp
end

function slot0.onContainerInit(slot0)
	slot1 = slot0:getScrollRect()
	slot0._scrollViewGo = slot1.gameObject
	slot0._scrollContentTrans = slot1.content
	slot0._scrollContentGo = slot0._scrollContentTrans.gameObject
end

function slot0.getScrollViewGo(slot0)
	return slot0._scrollViewGo
end

function slot0.getScrollContentTranform(slot0)
	return slot0._scrollContentTrans
end

function slot0.getScrollContentGo(slot0)
	return slot0._scrollContentGo
end

function slot0.getListScrollParam(slot0)
	return slot0._listScrollParam
end

function slot0.getListScrollParam_cellSize(slot0)
	slot1 = slot0._listScrollParam

	return slot1.cellWidth, slot1.cellHeight
end

function slot0.getListScrollParamStep(slot0)
	if slot0:getListScrollParam().scrollDir == ScrollEnum.ScrollDirH then
		return slot1.cellWidth + slot1.cellSpaceH
	else
		return slot1.cellHeight + slot1.cellSpaceV
	end
end

function slot0.rebuildLayout(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0:getScrollContentTranform())
end

function slot0.getSumDescIndexList(slot0, ...)
	return slot0._difficultyView:getSumDescIndexList(...)
end

return slot0
