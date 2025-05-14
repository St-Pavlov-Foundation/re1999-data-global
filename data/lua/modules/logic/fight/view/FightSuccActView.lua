module("modules.logic.fight.view.FightSuccActView", package.seeall)

local var_0_0 = class("FightSuccActView", BaseView)

function var_0_0.showReward(arg_1_0)
	arg_1_0:_showAstrologyStarReward()
	arg_1_0:_showExchangeList()
end

function var_0_0._showAstrologyStarReward(arg_2_0)
	local var_2_0 = VersionActivity1_3AstrologyModel.instance:getStarReward()

	if var_2_0 then
		VersionActivity1_3AstrologyModel.instance:setStarReward(nil)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_2_0)
	end
end

function var_0_0._showExchangeList(arg_3_0)
	local var_3_0 = VersionActivity1_3AstrologyModel.instance:getExchangeList()

	if var_3_0 then
		VersionActivity1_3AstrologyModel.instance:setExchangeList(nil)
		VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyPropView(var_3_0)
	end
end

function var_0_0.onClose(arg_4_0)
	VersionActivity1_3AstrologyModel.instance:setStarReward(nil)
	VersionActivity1_3AstrologyModel.instance:setExchangeList(nil)
end

return var_0_0
