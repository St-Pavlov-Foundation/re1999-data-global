module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderShowView", package.seeall)

local var_0_0 = class("AutoChessLeaderShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goCard = gohelper.findChild(arg_1_0.viewGO, "#go_Card")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0._editableInitView(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	if arg_4_0.viewParam then
		local var_4_0 = arg_4_0:getResInst(AutoChessStrEnum.ResPath.LeaderCard, arg_4_0._goCard)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_4_0, AutoChessLeaderCard):setData(arg_4_0.viewParam)
	end
end

return var_0_0
