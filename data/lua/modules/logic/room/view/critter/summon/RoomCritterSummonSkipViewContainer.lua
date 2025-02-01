module("modules.logic.room.view.critter.summon.RoomCritterSummonSkipViewContainer", package.seeall)

slot0 = class("RoomCritterSummonSkipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterSummonSkipView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_content"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			MultiView.New({
				RoomCritterSummonDragView.New()
			})
		}
	end
end

return slot0
