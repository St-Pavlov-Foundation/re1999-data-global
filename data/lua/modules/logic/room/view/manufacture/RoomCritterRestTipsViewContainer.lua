module("modules.logic.room.view.manufacture.RoomCritterRestTipsViewContainer", package.seeall)

slot0 = class("RoomCritterRestTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterRestTipsView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_righttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.RoomTrade
			})
		}
	end
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(ViewName.RoomCritterRestTipsView, nil, true)
end

return slot0
