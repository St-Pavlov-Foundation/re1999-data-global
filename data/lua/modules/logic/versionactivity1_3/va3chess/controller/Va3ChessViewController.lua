module("modules.logic.versionactivity1_3.va3chess.controller.Va3ChessViewController", package.seeall)

local var_0_0 = class("Va3ChessViewController", BaseController)

function var_0_0._initResisterFunc(arg_1_0)
	arg_1_0._viewTypeFuncDict = {
		[Va3ChessEnum.ViewType.Reward] = arg_1_0:_registerRewardViewFunc()
	}
end

function var_0_0._registerRewardViewFunc(arg_2_0)
	return {
		[Va3ChessEnum.ActivityId.Act142] = function(arg_3_0, arg_3_1)
			ViewMgr.instance:openView(ViewName.Activity142GetCollectionView, arg_3_1)
		end
	}
end

function var_0_0._openView(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	if not arg_4_0._viewTypeFuncDict then
		arg_4_0:_initResisterFunc()
	end

	local var_4_0 = arg_4_0._viewTypeFuncDict[arg_4_1]

	if var_4_0[arg_4_2] then
		var_4_0[arg_4_2](arg_4_3, arg_4_4, arg_4_5, arg_4_6)

		return true
	end

	return false
end

function var_0_0.openRewardView(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	return arg_5_0:_openView(Va3ChessEnum.ViewType.Reward, arg_5_1, arg_5_2, arg_5_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
