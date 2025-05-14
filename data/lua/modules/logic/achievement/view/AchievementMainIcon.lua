module("modules.logic.achievement.view.AchievementMainIcon", package.seeall)

local var_0_0 = class("AchievementMainIcon", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1

	arg_1_0:initComponents()
end

function var_0_0.initComponents(arg_2_0)
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.viewGO, "#txt_name")
	arg_2_0._simageicon = gohelper.findChildSingleImage(arg_2_0.viewGO, "#image_icon")
	arg_2_0._imageicon = gohelper.findChildImage(arg_2_0.viewGO, "#image_icon")
	arg_2_0._goLocked = gohelper.findChild(arg_2_0.viewGO, "#go_Locked")
	arg_2_0._goselect = gohelper.findChild(arg_2_0.viewGO, "#go_select")
	arg_2_0._index = gohelper.findChildText(arg_2_0.viewGO, "#go_select/#txt_index")
	arg_2_0._goBadgeBG = gohelper.findChild(arg_2_0.viewGO, "#go_BadgeBG")
	arg_2_0._goBadgeGetBG = gohelper.findChild(arg_2_0.viewGO, "#go_BadgeGetBG")
	arg_2_0._animator = gohelper.onceAddComponent(arg_2_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.taskCO = arg_3_1
	arg_3_0._animClipName = nil
	arg_3_0._isBgVisible = true

	arg_3_0:refreshUI()
end

function var_0_0.getTaskCO(arg_4_0)
	return arg_4_0.taskCO
end

function var_0_0.setIsLocked(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goLocked, arg_5_1)
end

function var_0_0.setIconColor(arg_6_0, arg_6_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._imageicon, arg_6_1 or "#FFFFFF")
end

function var_0_0.setIconVisible(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._imageicon.gameObject, arg_7_1)
end

function var_0_0.setBgVisible(arg_8_0, arg_8_1)
	arg_8_0._isBgVisible = arg_8_1

	arg_8_0:refreshBg()
end

function var_0_0.refreshBg(arg_9_0)
	local var_9_0 = false

	if arg_9_0._isBgVisible then
		local var_9_1 = arg_9_0.taskCO and arg_9_0.taskCO.id

		var_9_0 = AchievementModel.instance:isAchievementTaskFinished(var_9_1)
	end

	gohelper.setActive(arg_9_0._goBadgeBG.gameObject, arg_9_0._isBgVisible and not var_9_0)
	gohelper.setActive(arg_9_0._goBadgeGetBG.gameObject, arg_9_0._isBgVisible and var_9_0)
end

function var_0_0.setNameTxtAlpha(arg_10_0, arg_10_1)
	ZProj.UGUIHelper.SetColorAlpha(arg_10_0._txtname, arg_10_1 or 1)
end

function var_0_0.setNameTxtVisible(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._txtname, arg_11_1)
end

function var_0_0.setSelectIconVisible(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goselect, arg_12_1)
end

function var_0_0.setSelectIndex(arg_13_0, arg_13_1)
	arg_13_0._index.text = tostring(arg_13_1)
end

function var_0_0.refreshUI(arg_14_0)
	local var_14_0 = AchievementConfig.instance:getAchievement(arg_14_0.taskCO.achievementId)

	if var_14_0 then
		arg_14_0._txtname.text = var_14_0.name
	end

	arg_14_0._simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. arg_14_0.taskCO.icon))
	arg_14_0:refreshBg()
end

function var_0_0.setClickCall(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0._clickCallback = arg_15_1
	arg_15_0._clickCallbackObj = arg_15_2
	arg_15_0._clickParam = arg_15_3

	if not arg_15_0._btnself then
		arg_15_0._btnself = gohelper.findChildButtonWithAudio(arg_15_0.viewGO, "#btn_self")

		arg_15_0._btnself:AddClickListener(arg_15_0.onClickSelf, arg_15_0)
	end
end

function var_0_0.onClickSelf(arg_16_0)
	if arg_16_0._clickCallback then
		arg_16_0._clickCallback(arg_16_0._clickCallbackObj, arg_16_0._clickParam)
	end
end

var_0_0.AnimClip = {
	New = "unlock",
	Idle = "idle",
	Loop = "loop"
}

function var_0_0.playAnim(arg_17_0, arg_17_1)
	arg_17_0._animator:Play(arg_17_1, 0, 0)
end

function var_0_0.isPlaingAnimClip(arg_18_0, arg_18_1)
	return arg_18_0._animator:GetCurrentAnimatorStateInfo(0):IsName(arg_18_1)
end

function var_0_0.dispose(arg_19_0)
	arg_19_0._clickCallback = nil
	arg_19_0._clickCallbackObj = nil
	arg_19_0._clickParam = nil

	if arg_19_0._btnself then
		arg_19_0._btnself:RemoveClickListener()

		arg_19_0._btnself = nil
	end

	arg_19_0._simageicon:UnLoadImage()
	arg_19_0:__onDispose()
end

return var_0_0
