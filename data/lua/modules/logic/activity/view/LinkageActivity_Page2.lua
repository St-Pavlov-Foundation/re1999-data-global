module("modules.logic.activity.view.LinkageActivity_Page2", package.seeall)

slot0 = class("LinkageActivity_Page2", LinkageActivity_PageBase)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0._rewardItemList = {}
	slot0._videoItemList = {}
	slot0._curVideoIndex = false
end

function slot0.onDestroyView(slot0)
	slot0._curVideoIndex = false

	GameUtil.onDestroyViewMemberList(slot0, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(slot0, "_videoItemList")
	uv0.super.onDestroyView(slot0)
end

function slot0.addReward(slot0, slot1, slot2, slot3)
	slot4 = slot3.New({
		parent = slot0,
		baseViewContainer = slot0:baseViewContainer()
	})

	slot4:setIndex(slot1)
	slot4:init(slot2)
	table.insert(slot0._rewardItemList, slot4)

	return slot4
end

function slot0.addVideo(slot0, slot1, slot2, slot3)
	slot4 = slot3.New({
		parent = slot0,
		baseViewContainer = slot0:baseViewContainer()
	})

	slot4:setIndex(slot1)
	slot4:init(slot2)
	table.insert(slot0._videoItemList, slot4)

	return slot4
end

function slot0.curVideoIndex(slot0)
	return slot0._curVideoIndex
end

function slot0.getReward(slot0, slot1)
	return slot0._rewardItemList[slot1]
end

function slot0.getVideo(slot0, slot1)
	return slot0._videoItemList[slot1]
end

function slot0.selectedVideo(slot0, slot1)
	if slot0._curVideoIndex == slot1 then
		return
	end

	slot0._curVideoIndex = slot1

	slot0:onSelectedVideo(slot1, slot0._curVideoIndex, slot0._curVideoIndex == false)
end

function slot0.onUpdateMO(slot0)
	slot0:_onUpdateMO_rewardList()
	slot0:_onUpdateMO_videoList()
end

function slot0._onUpdateMO_rewardList(slot0)
	if slot0:getTempDataList() then
		for slot5, slot6 in ipairs(slot0._rewardItemList) do
			slot6:onUpdateMO(slot1[slot5])
		end
	end
end

function slot0._onUpdateMO_videoList(slot0)
	for slot4, slot5 in ipairs(slot0._videoItemList) do
		slot5:onUpdateMO({
			videoName = slot0:getLinkageActivityCO_res_video(slot4)
		})
	end
end

function slot0.onSelectedVideo(slot0, slot1, slot2, slot3)
	assert(false, "please override this function")
end

function slot0.onPostSelectedPage(slot0, slot1, slot2)
	if slot0 == slot1 then
		slot0:_onUpdateMO_videoList()
	end
end

return slot0
