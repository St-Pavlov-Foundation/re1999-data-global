module("modules.logic.versionactivity1_4.act132.view.Activity132CollectDetailItem", package.seeall)

local var_0_0 = class("Activity132CollectDetailItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._viewGO = arg_1_1
	arg_1_0._goTips = gohelper.findChild(arg_1_1, "tips")
	arg_1_0._txtLock = gohelper.findChildTextMesh(arg_1_0._goTips, "txt_Lock")
	arg_1_0._goDesc = gohelper.findChild(arg_1_1, "txtDesc")
	arg_1_0._txtDesc = arg_1_0._goDesc:GetComponent(gohelper.Type_TextMesh)
	arg_1_0._animTxt = arg_1_0._goDesc:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.data = arg_2_1

	if not arg_2_1 then
		gohelper.setActive(arg_2_0._viewGO, false)

		return
	end

	gohelper.setActive(arg_2_0._viewGO, true)
	arg_2_0:refreshState()
end

function var_0_0.refreshState(arg_3_0)
	if not arg_3_0.data then
		return
	end

	local var_3_0 = Activity132Model.instance:getContentState(arg_3_0.data.activityId, arg_3_0.data.contentId)

	arg_3_0._txtDesc.text = arg_3_0.data:getContent()
	arg_3_0._txtLock.text = arg_3_0.data:getUnlockDesc()

	gohelper.setActive(arg_3_0._goTips, var_3_0 ~= Activity132Enum.ContentState.Unlock)
	gohelper.setActive(arg_3_0._goDesc, var_3_0 == Activity132Enum.ContentState.Unlock)
end

function var_0_0.playUnlock(arg_4_0)
	arg_4_0:refreshState()
	arg_4_0._animTxt:Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
end

function var_0_0.destroy(arg_5_0)
	arg_5_0:__onDispose()
end

return var_0_0
