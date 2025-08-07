module("modules.logic.sp01.assassin2.outside.view.AssassinQuestItem", package.seeall)

local var_0_0 = class("AssassinQuestItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_1.transform
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.go, "image_icon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.go, "go_select")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.go, "go_unselect")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.go)
	arg_1_0._questId = nil
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._questId then
		AssassinController.instance:clickQuestItem(arg_4_0._questId, false, true)
	end
end

function var_0_0.setData(arg_5_0, arg_5_1)
	arg_5_0._questId = arg_5_1

	arg_5_0:setIcon()
	arg_5_0:setCfgPos()
	arg_5_0:refreshSelected(false)
	gohelper.setActive(arg_5_0.go, true)
end

function var_0_0.setIcon(arg_6_0)
	local var_6_0 = AssassinConfig.instance:getQuestType(arg_6_0._questId)

	AssassinHelper.setQuestTypeIcon(var_6_0, arg_6_0._imageicon)
end

function var_0_0.setCfgPos(arg_7_0)
	local var_7_0 = AssassinConfig.instance:getQuestPos(arg_7_0._questId)

	if not string.nilorempty(var_7_0) then
		local var_7_1 = string.splitToNumber(var_7_0, "#")

		arg_7_0:setPosition(var_7_1[1], var_7_1[2])
	else
		logError(string.format("AssassinQuestItem:setCfgPos error, pos is nil, questId = %s", arg_7_0._questId))
	end
end

function var_0_0.setPosition(arg_8_0, arg_8_1, arg_8_2)
	recthelper.setAnchor(arg_8_0.trans, arg_8_1 or 0, arg_8_2 or 0)
end

function var_0_0.refreshSelected(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselect, arg_9_1)
	gohelper.setActive(arg_9_0._gounselect, not arg_9_1)
end

function var_0_0.remove(arg_10_0, arg_10_1)
	if arg_10_1 then
		if arg_10_0._animatorPlayer then
			arg_10_0._animatorPlayer:Play(UIAnimationName.Close, arg_10_0.disableItem, arg_10_0)

			local var_10_0 = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.QuestItemFinishAnim, arg_10_0._questId)

			AssassinController.instance:setHasPlayedAnimation(var_10_0)
		end
	else
		arg_10_0:disableItem()
	end

	arg_10_0._questId = nil
end

function var_0_0.disableItem(arg_11_0)
	gohelper.setActive(arg_11_0.go, false)
end

function var_0_0.playOpen(arg_12_0)
	gohelper.setActive(arg_12_0.go, true)

	if arg_12_0._questId and arg_12_0._animatorPlayer then
		arg_12_0._animatorPlayer:Play(UIAnimationName.Open)
	end
end

function var_0_0.getQuestId(arg_13_0)
	return arg_13_0._questId
end

function var_0_0.getPosition(arg_14_0)
	local var_14_0, var_14_1 = recthelper.getAnchor(arg_14_0.trans)

	return var_14_0, var_14_1
end

function var_0_0.getGoPosition(arg_15_0)
	return arg_15_0.trans.position
end

function var_0_0.onDestroy(arg_16_0)
	arg_16_0._questId = nil
end

return var_0_0
