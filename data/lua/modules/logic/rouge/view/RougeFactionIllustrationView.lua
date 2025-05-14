module("modules.logic.rouge.view.RougeFactionIllustrationView", package.seeall)

local var_0_0 = class("RougeFactionIllustrationView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "Middle/#scroll_view")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Middle/#scroll_view/Viewport/#go_Content")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)

	local var_6_0 = RougeOutsideModel.instance:getSeasonStyleInfoList()
	local var_6_1 = arg_6_0.viewContainer:getSetting().otherRes[1]

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_2 = arg_6_0:getResInst(var_6_1, arg_6_0._goContent)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, RougeFactionIllustrationItem):onUpdateMO(iter_6_1)
	end
end

function var_0_0.onClose(arg_7_0)
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Faction) > 0 then
		local var_7_0 = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(var_7_0, RougeEnum.FavoriteType.Faction, 0)
	end
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
