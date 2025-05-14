module("modules.logic.popup.controller.PopupHelper", package.seeall)

local var_0_0 = class("PopupHelper")

function var_0_0.checkInFight()
	return (GameSceneMgr.instance:isFightScene())
end

function var_0_0.checkInGuide()
	local var_2_0 = false
	local var_2_1 = GuideController.instance:isGuiding()
	local var_2_2 = ViewMgr.instance:isOpen(ViewName.GuideView)
	local var_2_3 = GuideModel.instance:lastForceGuideId()
	local var_2_4 = GuideModel.instance:isGuideFinish(var_2_3)

	if var_2_1 or var_2_2 or not var_2_4 then
		var_2_0 = true
	end

	return var_2_0
end

function var_0_0.checkInSummonDrawing()
	return (SummonModel.instance:getIsDrawing())
end

return var_0_0
