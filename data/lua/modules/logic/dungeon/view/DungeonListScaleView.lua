module("modules.logic.dungeon.view.DungeonListScaleView", package.seeall)

local var_0_0 = class("DungeonListScaleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._csScrollScale = SLFramework.UGUI.ListScrollScale.GetWithPath(arg_1_0.viewGO, "chapterlist/#scroll_chapter")
end

function var_0_0.onDestroyView(arg_2_0)
	arg_2_0._csScrollScale = nil
end

return var_0_0
