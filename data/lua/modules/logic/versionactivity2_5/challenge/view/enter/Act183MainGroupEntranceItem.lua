module("modules.logic.versionactivity2_5.challenge.view.enter.Act183MainGroupEntranceItem", package.seeall)

local var_0_0 = class("Act183MainGroupEntranceItem", Act183BaseGroupEntranceItem)

function var_0_0.Get(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = ""

	if arg_1_1 == Act183Enum.GroupType.NormalMain then
		var_1_0 = "root/middle/#go_main/#go_normal"
	elseif arg_1_1 == Act183Enum.GroupType.HardMain then
		var_1_0 = "root/middle/#go_main/#go_hard"
	end

	local var_1_1 = gohelper.findChild(arg_1_0, var_1_0)
	local var_1_2 = Act183Enum.GroupEntranceItemClsType[arg_1_1]

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_1, var_1_2, arg_1_2)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._goresult = gohelper.findChild(arg_2_1, "go_result")
	arg_2_0._txttitle = gohelper.findChildText(arg_2_1, "txt_title")
	arg_2_0._txttotalprogress = gohelper.findChildText(arg_2_1, "go_result/txt_totalprogress")
	arg_2_0._golock = gohelper.findChild(arg_2_1, "go_lock")
	arg_2_0._animlock = gohelper.onceAddComponent(arg_2_0._golock, gohelper.Type_Animator)
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	var_0_0.super.onUpdateMO(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_1:getStatus() ~= Act183Enum.GroupStatus.Locked

	gohelper.setActive(arg_3_0._golock, not var_3_0)
	gohelper.setActive(arg_3_0._goresult, var_3_0)

	if var_3_0 then
		local var_3_1 = arg_3_1:getGroupId()
		local var_3_2, var_3_3 = Act183Helper.getGroupEpisodeTaskProgress(arg_3_0._actId, var_3_1)

		arg_3_0._txttotalprogress.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_finished"), var_3_3, var_3_2)
	end
end

function var_0_0.startPlayUnlockAnim(arg_4_0)
	if arg_4_0._groupType == Act183Enum.GroupType.NormalMain or arg_4_0._hasPlayUnlockAnim then
		return
	end

	gohelper.setActive(arg_4_0._golock, true)
	arg_4_0._animlock:Play("unlock", 0, 0)

	arg_4_0._hasPlayUnlockAnim = true
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._hasPlayUnlockAnim then
		Act183Helper.savePlayUnlockAnimGroupIdInLocal(arg_5_0._actId, arg_5_0._groupId)

		arg_5_0._waitRecord = false
	end
end

return var_0_0
