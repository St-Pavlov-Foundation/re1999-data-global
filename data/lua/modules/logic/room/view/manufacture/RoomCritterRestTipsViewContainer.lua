module("modules.logic.room.view.manufacture.RoomCritterRestTipsViewContainer", package.seeall)

local var_0_0 = class("RoomCritterRestTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCritterRestTipsView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_righttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = {
			CurrencyEnum.CurrencyType.RoomTrade
		}

		return {
			CurrencyView.New(var_2_0)
		}
	end
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	ViewMgr.instance:closeView(ViewName.RoomCritterRestTipsView, nil, true)
end

return var_0_0
