module("modules.logic.rouge.map.view.collectiondrop.RougeCollectionDropViewContainer", package.seeall)

slot0 = class("RougeCollectionDropViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeCollectionDropView.New())
	table.insert(slot1, TabViewGroup.New(2, "layout/#go_rougemapdetailcontainer"))

	return slot1
end

function slot0.playCloseTransition(slot0)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, RougeMapEnum.CollectionChangeAnimDuration)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return slot0
