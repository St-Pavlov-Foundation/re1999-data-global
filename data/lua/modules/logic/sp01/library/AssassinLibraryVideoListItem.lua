module("modules.logic.sp01.library.AssassinLibraryVideoListItem", package.seeall)

local var_0_0 = class("AssassinLibraryVideoListItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goleft = gohelper.findChild(arg_1_0.go, "#go_Odd")
	arg_1_0._goright = gohelper.findChild(arg_1_0.go, "#go_Even")
	arg_1_0._leftInfoIetem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._goleft, AssassinLibraryVideoInfoItem)
	arg_1_0._rightInfoIetem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._goright, AssassinLibraryVideoInfoItem)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._index % 2 == 1
	local var_2_1 = arg_2_0._view._model:getCount()

	if var_2_0 then
		arg_2_0._leftInfoIetem:updateIndex(var_2_1, arg_2_0._index)
		arg_2_0._leftInfoIetem:onUpdateMO(arg_2_1)
		arg_2_0._rightInfoIetem:setIsUsing(false)
	else
		arg_2_0._leftInfoIetem:setIsUsing(false)
		arg_2_0._rightInfoIetem:updateIndex(var_2_1, arg_2_0._index)
		arg_2_0._rightInfoIetem:onUpdateMO(arg_2_1)
	end
end

return var_0_0
