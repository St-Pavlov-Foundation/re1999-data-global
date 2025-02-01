module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueViewContainer", package.seeall)

slot0 = class("AergusiClueViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		AergusiClueMergeView.New(),
		AergusiClueListView.New(),
		AergusiClueDetailView.New(),
		AergusiClueView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot0.viewParam and slot0.viewParam.episodeId then
		NavigateButtonsView.New():setParam({
			true,
			false,
			false
		})
	else
		slot2:setParam({
			true,
			true,
			false
		})
	end

	slot2:setOverrideClose(slot0.overrideOnCloseClick, slot0)

	return {
		slot2
	}
end

function slot0.overrideOnCloseClick(slot0)
	if slot0.viewParam and slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj, -1)
	end

	slot0:closeThis()
end

return slot0
