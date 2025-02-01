module("modules.logic.room.view.building.RoomCommonStrengthViewContainer", package.seeall)

slot0 = class("RoomCommonStrengthViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCommonStrengthView.New())
	table.insert(slot1, RoomViewTopRight.New("#go_topright", slot0._viewSetting.otherRes[1], {
		{
			strengthId = 190007,
			strengthShowType = 0,
			classDefine = RoomViewTopRightStrengthItem
		},
		{
			strengthId = 190008,
			strengthShowType = 1,
			classDefine = RoomViewTopRightStrengthItem
		}
	}))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
end

return slot0
