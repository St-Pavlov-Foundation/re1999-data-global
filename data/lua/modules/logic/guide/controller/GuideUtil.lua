module("modules.logic.guide.controller.GuideUtil", package.seeall)

local var_0_0 = _M
local var_0_1 = typeof(UnityEngine.RectTransform)
local var_0_2 = typeof(UnityEngine.CanvasGroup)
local var_0_3

function var_0_0.isGOShowInScreen(arg_1_0)
	if gohelper.isNil(arg_1_0) or not arg_1_0.activeInHierarchy then
		return false
	end

	local var_1_0 = arg_1_0:GetComponent(var_0_1)

	if var_1_0 then
		var_0_3 = var_0_3 or ViewMgr.instance:getUIRoot().transform

		if ZProj.UGUIHelper.Overlaps(var_1_0, var_0_3, CameraMgr.instance:getUICamera()) then
			while var_1_0 do
				local var_1_1, var_1_2, var_1_3 = transformhelper.getLocalScale(var_1_0, 0, 0, 0)

				if var_1_1 == 0 or var_1_2 == 0 then
					return false
				end

				local var_1_4 = var_1_0:GetComponent(var_0_2)

				if var_1_4 and var_1_4.alpha == 0 then
					return false
				end

				var_1_0 = var_1_0.parent
			end

			return true
		else
			return false
		end
	else
		return true
	end
end

function var_0_0.isGuideViewTarget(arg_2_0)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		local var_2_0 = GuideViewMgr.instance.viewParam
		local var_2_1 = var_2_0 and var_2_0.goPath
		local var_2_2 = gohelper.find(var_2_1)

		if var_2_2 and arg_2_0 == var_2_2 then
			return true
		end
	end

	return false
end

return var_0_0
